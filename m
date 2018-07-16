Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0E4ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8F11206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:42:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8F11206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388753AbeGPII1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:08:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47762 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730161AbeGPII0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:08:26 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7E91CCA0;
        Mon, 16 Jul 2018 07:42:23 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Scott Bauer <scott.bauer@intel.com>,
        Christoph Hellwig <hch@lst.de>, Simon Veith <sveith@amazon.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Amit Shah <aams@amazon.com>
Subject: [PATCH 4.9 01/32] nvme: validate admin queue before unquiesce
Date:   Mon, 16 Jul 2018 09:36:09 +0200
Message-Id: <20180716073504.573716820@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716073504.433996952@linuxfoundation.org>
References: <20180716073504.433996952@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Scott Bauer <scott.bauer@intel.com>

commit 7dd1ab163c17e11473a65b11f7e748db30618ebb upstream.

With a misbehaving controller it's possible we'll never
enter the live state and create an admin queue. When we
fail out of reset work it's possible we failed out early
enough without setting up the admin queue. We tear down
queues after a failed reset, but needed to do some more
sanitization.

Fixes 443bd90f2cca: "nvme: host: unquiesce queue in nvme_kill_queues()"

[  189.650995] nvme nvme1: pci function 0000:0b:00.0
[  317.680055] nvme nvme0: Device not ready; aborting reset
[  317.680183] nvme nvme0: Removing after probe failure status: -19
[  317.681258] kasan: GPF could be caused by NULL-ptr deref or user memory access
[  317.681397] general protection fault: 0000 [#1] SMP KASAN
[  317.682984] CPU: 3 PID: 477 Comm: kworker/3:2 Not tainted 4.13.0-rc1+ #5
[  317.683112] Hardware name: Gigabyte Technology Co., Ltd. Z170X-UD5/Z170X-UD5-CF, BIOS F5 03/07/2016
[  317.683284] Workqueue: events nvme_remove_dead_ctrl_work [nvme]
[  317.683398] task: ffff8803b0990000 task.stack: ffff8803c2ef0000
[  317.683516] RIP: 0010:blk_mq_unquiesce_queue+0x2b/0xa0
[  317.683614] RSP: 0018:ffff8803c2ef7d40 EFLAGS: 00010282
[  317.683716] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 1ffff1006fbdcde3
[  317.683847] RDX: 0000000000000038 RSI: 1ffff1006f5a9245 RDI: 0000000000000000
[  317.683978] RBP: ffff8803c2ef7d58 R08: 1ffff1007bcdc974 R09: 0000000000000000
[  317.684108] R10: 1ffff1007bcdc975 R11: 0000000000000000 R12: 00000000000001c0
[  317.684239] R13: ffff88037ad49228 R14: ffff88037ad492d0 R15: ffff88037ad492e0
[  317.684371] FS:  0000000000000000(0000) GS:ffff8803de6c0000(0000) knlGS:0000000000000000
[  317.684519] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  317.684627] CR2: 0000002d1860c000 CR3: 000000045b40d000 CR4: 00000000003406e0
[  317.684758] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  317.684888] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  317.685018] Call Trace:
[  317.685084]  nvme_kill_queues+0x4d/0x170 [nvme_core]
[  317.685185]  nvme_remove_dead_ctrl_work+0x3a/0x90 [nvme]
[  317.685289]  process_one_work+0x771/0x1170
[  317.685372]  worker_thread+0xde/0x11e0
[  317.685452]  ? pci_mmcfg_check_reserved+0x110/0x110
[  317.685550]  kthread+0x2d3/0x3d0
[  317.685617]  ? process_one_work+0x1170/0x1170
[  317.685704]  ? kthread_create_on_node+0xc0/0xc0
[  317.685785]  ret_from_fork+0x25/0x30
[  317.685798] Code: 0f 1f 44 00 00 55 48 b8 00 00 00 00 00 fc ff df 48 89 e5 41 54 4c 8d a7 c0 01 00 00 53 48 89 fb 4c 89 e2 48 c1 ea 03 48 83 ec 08 <80> 3c 02 00 75 50 48 8b bb c0 01 00 00 e8 33 8a f9 00 0f ba b3
[  317.685872] RIP: blk_mq_unquiesce_queue+0x2b/0xa0 RSP: ffff8803c2ef7d40
[  317.685908] ---[ end trace a3f8704150b1e8b4 ]---

Signed-off-by: Scott Bauer <scott.bauer@intel.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
[ adapted for 4.9: added check around blk_mq_start_hw_queues() call
  instead of upstream blk_mq_unquiesce_queue() ]
Fixes: 4aae4388165a2611fa42 ("nvme: fix hang in remove path")
Signed-off-by: Simon Veith <sveith@amazon.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Amit Shah <aams@amazon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/host/core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2042,7 +2042,8 @@ void nvme_kill_queues(struct nvme_ctrl *
 	mutex_lock(&ctrl->namespaces_mutex);
 
 	/* Forcibly start all queues to avoid having stuck requests */
-	blk_mq_start_hw_queues(ctrl->admin_q);
+	if (ctrl->admin_q)
+		blk_mq_start_hw_queues(ctrl->admin_q);
 
 	list_for_each_entry(ns, &ctrl->namespaces, list) {
 		/*


