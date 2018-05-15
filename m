Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752337AbeEOHkz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 03:40:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:42986 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752196AbeEOHkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 03:40:52 -0400
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Keith Busch <keith.busch@intel.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 4/5] nvmet: use atomic allocations when allocating fc requests
Date: Tue, 15 May 2018 09:40:42 +0200
Message-Id: <20180515074043.22843-5-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180515074043.22843-1-jthumshirn@suse.de>
References: <20180515074043.22843-1-jthumshirn@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fcloop_fcp_req() runs with the hctx_lock (a rcu_read_lock() locked
section) held, so memory allocations done in this context have to be
atomic.

This fixes the follwing lockdep complaint:
[    9.753313] BUG: sleeping function called from invalid context at mm/slab.h:421
[    9.754518] in_atomic(): 1, irqs_disabled(): 0, pid: 1420, name: nvme
[    9.755613] 3 locks held by nvme/1420:
[    9.756221]  #0:         (ptrval) (nvmf_dev_mutex){+.+.}, at: nvmf_dev_write+0x6a/0xb7d [nvme_fabrics]
[    9.757575]  #1:         (ptrval) (nvmf_transports_rwsem){++++}, at: nvmf_dev_write+0x6e5/0xb7d [nvme_fabrics]
[    9.759000]  #2:         (ptrval) (rcu_read_lock){....}, at: hctx_lock+0x56/0xd0
[    9.760141] CPU: 2 PID: 1420 Comm: nvme Not tainted 4.17.0-rc5+ #883
[    9.761078] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.0.0-prebuilt.qemu-project.org 04/01/2014
[    9.762624] Call Trace:
[    9.763021]  dump_stack+0x78/0xb3
[    9.763505]  ___might_sleep+0x227/0x250
[    9.764115]  kmem_cache_alloc_trace+0x1ae/0x270
[    9.764793]  fcloop_fcp_req+0x32/0x1a0 [nvme_fcloop]
[    9.765561]  nvme_fc_start_fcp_op.part.39+0x193/0x4c0 [nvme_fc]
[    9.766480]  blk_mq_dispatch_rq_list+0x7f/0x4a0
[    9.767163]  ? blk_mq_flush_busy_ctxs+0xa8/0xf0
[    9.767871]  blk_mq_sched_dispatch_requests+0x16e/0x170
[    9.768644]  __blk_mq_run_hw_queue+0x79/0xd0
[    9.769294]  __blk_mq_delay_run_hw_queue+0x11c/0x160
[    9.770012]  blk_mq_run_hw_queue+0x63/0xc0
[    9.770667]  blk_mq_sched_insert_request+0xb2/0x140
[    9.771399]  blk_execute_rq+0x64/0xc0
[    9.771990]  __nvme_submit_sync_cmd+0x63/0xd0 [nvme_core]
[    9.772765]  nvmf_connect_admin_queue+0x11e/0x190 [nvme_fabrics]
[    9.773659]  ? mark_held_locks+0x6b/0x90
[    9.774798]  nvme_fc_create_association+0x35b/0x970 [nvme_fc]
[    9.775631]  nvme_fc_create_ctrl+0x5d2/0x830 [nvme_fc]
[    9.776423]  nvmf_dev_write+0x92d/0xb7d [nvme_fabrics]
[    9.777188]  __vfs_write+0x21/0x130
[    9.777725]  ? selinux_file_permission+0xe9/0x140
[    9.778417]  ? security_file_permission+0x2f/0xb0
[    9.779158]  vfs_write+0xbd/0x1c0
[    9.779644]  ksys_write+0x40/0xa0
[    9.780184]  ? do_syscall_64+0xd/0x190
[    9.780736]  do_syscall_64+0x51/0x190
[    9.781281]  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/nvme/target/fcloop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 34712def81b1..d2209c60f95f 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -509,7 +509,7 @@ fcloop_fcp_req(struct nvme_fc_local_port *localport,
 	if (!rport->targetport)
 		return -ECONNREFUSED;
 
-	tfcp_req = kzalloc(sizeof(*tfcp_req), GFP_KERNEL);
+	tfcp_req = kzalloc(sizeof(*tfcp_req), GFP_ATOMIC);
 	if (!tfcp_req)
 		return -ENOMEM;
 
-- 
2.16.3
