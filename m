Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A97C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A807C208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:33:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A807C208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389155AbeGJSeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:34:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47936 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387589AbeGJSeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:34:05 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 311D0E6B;
        Tue, 10 Jul 2018 18:33:52 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Steven J. Hill" <steven.hill@cavium.com>,
        Tejun Heo <htejun@gmail.com>, Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 53/53] Revert mm/vmstat.c: fix vmstat_update() preemption BUG
Date:   Tue, 10 Jul 2018 20:25:29 +0200
Message-Id: <20180710182501.761133548@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182458.736721865@linuxfoundation.org>
References: <20180710182458.736721865@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

commit 28557cc106e6d2aa8b8c5c7687ea9f8055ff3911 upstream.

Revert commit c7f26ccfb2c3 ("mm/vmstat.c: fix vmstat_update() preemption
BUG").  Steven saw a "using smp_processor_id() in preemptible" message
and added a preempt_disable() section around it to keep it quiet.  This
is not the right thing to do it does not fix the real problem.

vmstat_update() is invoked by a kworker on a specific CPU.  This worker
it bound to this CPU.  The name of the worker was "kworker/1:1" so it
should have been a worker which was bound to CPU1.  A worker which can
run on any CPU would have a `u' before the first digit.

smp_processor_id() can be used in a preempt-enabled region as long as
the task is bound to a single CPU which is the case here.  If it could
run on an arbitrary CPU then this is the problem we have an should seek
to resolve.

Not only this smp_processor_id() must not be migrated to another CPU but
also refresh_cpu_vm_stats() which might access wrong per-CPU variables.
Not to mention that other code relies on the fact that such a worker
runs on one specific CPU only.

Therefore revert that commit and we should look instead what broke the
affinity mask of the kworker.

Link: http://lkml.kernel.org/r/20180504104451.20278-1-bigeasy@linutronix.de
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Steven J. Hill <steven.hill@cavium.com>
Cc: Tejun Heo <htejun@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/vmstat.c |    2 --
 1 file changed, 2 deletions(-)

--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1770,11 +1770,9 @@ static void vmstat_update(struct work_st
 		 * to occur in the future. Keep on running the
 		 * update worker thread.
 		 */
-		preempt_disable();
 		queue_delayed_work_on(smp_processor_id(), mm_percpu_wq,
 				this_cpu_ptr(&vmstat_work),
 				round_jiffies_relative(sysctl_stat_interval));
-		preempt_enable();
 	}
 }
 


