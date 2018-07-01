Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEC1C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B697621A79
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:48:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B697621A79
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933989AbeGAQsl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:48:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38558 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032388AbeGAQqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:46:52 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DA56EA73;
        Sun,  1 Jul 2018 16:46:51 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 4.17 189/220] rbd: flush rbd_dev->watch_dwork after watch is unregistered
Date:   Sun,  1 Jul 2018 18:23:33 +0200
Message-Id: <20180701160916.097423160@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dongsheng Yang <dongsheng.yang@easystack.cn>

commit 23edca864951250af845a11da86bb3ea63522ed2 upstream.

There is a problem if we are going to unmap a rbd device and the
watch_dwork is going to queue delayed work for watch:

unmap Thread                    watch Thread                  timer
do_rbd_remove
  cancel_tasks_sync(rbd_dev)
                                queue_delayed_work for watch
  destroy_workqueue(rbd_dev->task_wq)
    drain_workqueue(wq)
    destroy other resources in wq
                                                              call_timer_fn
                                                                __queue_work()

Then the delayed work escape the cancel_tasks_sync() and
destroy_workqueue() and we will get an user-after-free call trace:

  BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
  PGD 0 P4D 0
  Oops: 0000 [#1] SMP PTI
  Modules linked in:
  CPU: 7 PID: 0 Comm: swapper/7 Tainted: G           OE     4.17.0-rc6+ #13
  Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
  RIP: 0010:__queue_work+0x6a/0x3b0
  RSP: 0018:ffff9427df1c3e90 EFLAGS: 00010086
  RAX: ffff9427deca8400 RBX: 0000000000000000 RCX: 0000000000000000
  RDX: ffff9427deca8400 RSI: ffff9427df1c3e50 RDI: 0000000000000000
  RBP: ffff942783e39e00 R08: ffff9427deca8400 R09: ffff9427df1c3f00
  R10: 0000000000000004 R11: 0000000000000005 R12: ffff9427cfb85970
  R13: 0000000000002000 R14: 000000000001eca0 R15: 0000000000000007
  FS:  0000000000000000(0000) GS:ffff9427df1c0000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000000000000 CR3: 00000004c900a005 CR4: 00000000000206e0
  Call Trace:
   <IRQ>
   ? __queue_work+0x3b0/0x3b0
   call_timer_fn+0x2d/0x130
   run_timer_softirq+0x16e/0x430
   ? tick_sched_timer+0x37/0x70
   __do_softirq+0xd2/0x280
   irq_exit+0xd5/0xe0
   smp_apic_timer_interrupt+0x6c/0x130
   apic_timer_interrupt+0xf/0x20

[ Move rbd_dev->watch_dwork cancellation so that rbd_reregister_watch()
  either bails out early because the watch is UNREGISTERED at that point
  or just gets cancelled. ]

Cc: stable@vger.kernel.org
Fixes: 99d1694310df ("rbd: retry watch re-registration periodically")
Signed-off-by: Dongsheng Yang <dongsheng.yang@easystack.cn>
Reviewed-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/rbd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3397,7 +3397,6 @@ static void cancel_tasks_sync(struct rbd
 {
 	dout("%s rbd_dev %p\n", __func__, rbd_dev);
 
-	cancel_delayed_work_sync(&rbd_dev->watch_dwork);
 	cancel_work_sync(&rbd_dev->acquired_lock_work);
 	cancel_work_sync(&rbd_dev->released_lock_work);
 	cancel_delayed_work_sync(&rbd_dev->lock_dwork);
@@ -3415,6 +3414,7 @@ static void rbd_unregister_watch(struct
 	rbd_dev->watch_state = RBD_WATCH_STATE_UNREGISTERED;
 	mutex_unlock(&rbd_dev->watch_mutex);
 
+	cancel_delayed_work_sync(&rbd_dev->watch_dwork);
 	ceph_osdc_flush_notifies(&rbd_dev->rbd_client->client->osdc);
 }
 


