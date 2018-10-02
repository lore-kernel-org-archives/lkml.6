Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1FFC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E0272064A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:13:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E0272064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbeJBU4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:56:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60170 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728067AbeJBUKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:10:34 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 191EAA67;
        Tue,  2 Oct 2018 13:27:12 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bart Van Assche <bart.vanassche@wdc.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 047/228] scsi: klist: Make it safe to use klists in atomic context
Date:   Tue,  2 Oct 2018 06:22:24 -0700
Message-Id: <20181002132502.344665888@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bart.vanassche@wdc.com>

[ Upstream commit 624fa7790f80575a4ec28fbdb2034097dc18d051 ]

In the scsi_transport_srp implementation it cannot be avoided to
iterate over a klist from atomic context when using the legacy block
layer instead of blk-mq. Hence this patch that makes it safe to use
klists in atomic context. This patch avoids that lockdep reports the
following:

WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&(&k->k_lock)->rlock);
                               local_irq_disable();
                               lock(&(&q->__queue_lock)->rlock);
                               lock(&(&k->k_lock)->rlock);
  <Interrupt>
    lock(&(&q->__queue_lock)->rlock);

stack backtrace:
Workqueue: kblockd blk_timeout_work
Call Trace:
 dump_stack+0xa4/0xf5
 check_usage+0x6e6/0x700
 __lock_acquire+0x185d/0x1b50
 lock_acquire+0xd2/0x260
 _raw_spin_lock+0x32/0x50
 klist_next+0x47/0x190
 device_for_each_child+0x8e/0x100
 srp_timed_out+0xaf/0x1d0 [scsi_transport_srp]
 scsi_times_out+0xd4/0x410 [scsi_mod]
 blk_rq_timed_out+0x36/0x70
 blk_timeout_work+0x1b5/0x220
 process_one_work+0x4fe/0xad0
 worker_thread+0x63/0x5a0
 kthread+0x1c1/0x1e0
 ret_from_fork+0x24/0x30

See also commit c9ddf73476ff ("scsi: scsi_transport_srp: Fix shost to
rport translation").

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: James Bottomley <jejb@linux.vnet.ibm.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/klist.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/lib/klist.c
+++ b/lib/klist.c
@@ -336,8 +336,9 @@ struct klist_node *klist_prev(struct kli
 	void (*put)(struct klist_node *) = i->i_klist->put;
 	struct klist_node *last = i->i_cur;
 	struct klist_node *prev;
+	unsigned long flags;
 
-	spin_lock(&i->i_klist->k_lock);
+	spin_lock_irqsave(&i->i_klist->k_lock, flags);
 
 	if (last) {
 		prev = to_klist_node(last->n_node.prev);
@@ -356,7 +357,7 @@ struct klist_node *klist_prev(struct kli
 		prev = to_klist_node(prev->n_node.prev);
 	}
 
-	spin_unlock(&i->i_klist->k_lock);
+	spin_unlock_irqrestore(&i->i_klist->k_lock, flags);
 
 	if (put && last)
 		put(last);
@@ -377,8 +378,9 @@ struct klist_node *klist_next(struct kli
 	void (*put)(struct klist_node *) = i->i_klist->put;
 	struct klist_node *last = i->i_cur;
 	struct klist_node *next;
+	unsigned long flags;
 
-	spin_lock(&i->i_klist->k_lock);
+	spin_lock_irqsave(&i->i_klist->k_lock, flags);
 
 	if (last) {
 		next = to_klist_node(last->n_node.next);
@@ -397,7 +399,7 @@ struct klist_node *klist_next(struct kli
 		next = to_klist_node(next->n_node.next);
 	}
 
-	spin_unlock(&i->i_klist->k_lock);
+	spin_unlock_irqrestore(&i->i_klist->k_lock, flags);
 
 	if (put && last)
 		put(last);


