Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792C5C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C90725002
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:35:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C90725002
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755314AbeFXPf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:35:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59424 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754259AbeFXPfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:35:23 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A34ED92F;
        Sun, 24 Jun 2018 15:35:21 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.16 39/64] bdi: Move cgroup bdi_writeback to a dedicated low concurrency workqueue
Date:   Sun, 24 Jun 2018 23:22:20 +0800
Message-Id: <20180624142746.252132511@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180624142743.613370789@linuxfoundation.org>
References: <20180624142743.613370789@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tejun Heo <tj@kernel.org>

commit f183464684190bacbfb14623bd3e4e51b7575b4c upstream.

>From 0aa2e9b921d6db71150633ff290199554f0842a8 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Wed, 23 May 2018 10:29:00 -0700

cgwb_release() punts the actual release to cgwb_release_workfn() on
system_wq.  Depending on the number of cgroups or block devices, there
can be a lot of cgwb_release_workfn() in flight at the same time.

We're periodically seeing close to 256 kworkers getting stuck with the
following stack trace and overtime the entire system gets stuck.

  [<ffffffff810ee40c>] _synchronize_rcu_expedited.constprop.72+0x2fc/0x330
  [<ffffffff810ee634>] synchronize_rcu_expedited+0x24/0x30
  [<ffffffff811ccf23>] bdi_unregister+0x53/0x290
  [<ffffffff811cd1e9>] release_bdi+0x89/0xc0
  [<ffffffff811cd645>] wb_exit+0x85/0xa0
  [<ffffffff811cdc84>] cgwb_release_workfn+0x54/0xb0
  [<ffffffff810a68d0>] process_one_work+0x150/0x410
  [<ffffffff810a71fd>] worker_thread+0x6d/0x520
  [<ffffffff810ad3dc>] kthread+0x12c/0x160
  [<ffffffff81969019>] ret_from_fork+0x29/0x40
  [<ffffffffffffffff>] 0xffffffffffffffff

The events leading to the lockup are...

1. A lot of cgwb_release_workfn() is queued at the same time and all
   system_wq kworkers are assigned to execute them.

2. They all end up calling synchronize_rcu_expedited().  One of them
   wins and tries to perform the expedited synchronization.

3. However, that invovles queueing rcu_exp_work to system_wq and
   waiting for it.  Because #1 is holding all available kworkers on
   system_wq, rcu_exp_work can't be executed.  cgwb_release_workfn()
   is waiting for synchronize_rcu_expedited() which in turn is waiting
   for cgwb_release_workfn() to free up some of the kworkers.

We shouldn't be scheduling hundreds of cgwb_release_workfn() at the
same time.  There's nothing to be gained from that.  This patch
updates cgwb release path to use a dedicated percpu workqueue with
@max_active of 1.

While this resolves the problem at hand, it might be a good idea to
isolate rcu_exp_work to its own workqueue too as it can be used from
various paths and is prone to this sort of indirect A-A deadlocks.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/backing-dev.c |   18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -423,6 +423,7 @@ static void wb_exit(struct bdi_writeback
  * protected.
  */
 static DEFINE_SPINLOCK(cgwb_lock);
+static struct workqueue_struct *cgwb_release_wq;
 
 /**
  * wb_congested_get_create - get or create a wb_congested
@@ -533,7 +534,7 @@ static void cgwb_release(struct percpu_r
 {
 	struct bdi_writeback *wb = container_of(refcnt, struct bdi_writeback,
 						refcnt);
-	schedule_work(&wb->release_work);
+	queue_work(cgwb_release_wq, &wb->release_work);
 }
 
 static void cgwb_kill(struct bdi_writeback *wb)
@@ -797,6 +798,21 @@ static void cgwb_bdi_register(struct bac
 	spin_unlock_irq(&cgwb_lock);
 }
 
+static int __init cgwb_init(void)
+{
+	/*
+	 * There can be many concurrent release work items overwhelming
+	 * system_wq.  Put them in a separate wq and limit concurrency.
+	 * There's no point in executing many of these in parallel.
+	 */
+	cgwb_release_wq = alloc_workqueue("cgwb_release", 0, 1);
+	if (!cgwb_release_wq)
+		return -ENOMEM;
+
+	return 0;
+}
+subsys_initcall(cgwb_init);
+
 #else	/* CONFIG_CGROUP_WRITEBACK */
 
 static int cgwb_bdi_init(struct backing_dev_info *bdi)


