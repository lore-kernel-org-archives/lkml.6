Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752516AbeEOHl4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 03:41:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:42960 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752054AbeEOHku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 03:40:50 -0400
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Keith Busch <keith.busch@intel.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 2/5] nvme: don't hold nvmf_transports_rwsem for more than transport lookups
Date: Tue, 15 May 2018 09:40:40 +0200
Message-Id: <20180515074043.22843-3-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180515074043.22843-1-jthumshirn@suse.de>
References: <20180515074043.22843-1-jthumshirn@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only take nvmf_transports_rwsem when doing a lookup of regitered
transports, as subsequent actions may take the hctx_lock which is an
rcu_read_lock and thus lockdep complains about suspicious rcu usage.

[    9.703333] =============================
[    9.704797] WARNING: suspicious RCU usage
[    9.706250] 4.17.0-rc5+ #883 Not tainted
[    9.708146] -----------------------------
[    9.708868] ./include/linux/rcupdate.h:304 Illegal context switch in RCU read-side critical section!
[    9.710511]
[    9.710511] other info that might help us debug this:
[    9.710511]
[    9.711959]
[    9.711959] rcu_scheduler_active = 2, debug_locks = 1
[    9.713142] 3 locks held by nvme/1420:
[    9.713800]  #0:         (ptrval) (nvmf_dev_mutex){+.+.}, at: nvmf_dev_write+0x6a/0xb7d [nvme_fabrics]
[    9.715471]  #1:         (ptrval) (nvmf_transports_rwsem){++++}, at: nvmf_dev_write+0x6e5/0xb7d [nvme_fabrics]
[    9.717279]  #2:         (ptrval) (rcu_read_lock){....}, at: hctx_lock+0x56/0xd0
[    9.718636]
[    9.718636] stack backtrace:
[    9.720266] CPU: 2 PID: 1420 Comm: nvme Not tainted 4.17.0-rc5+ #883
[    9.721446] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.0.0-prebuilt.qemu-project.org 04/01/2014
[    9.723003] Call Trace:
[    9.723453]  dump_stack+0x78/0xb3
[    9.724059]  ___might_sleep+0xde/0x250
[    9.724749]  kmem_cache_alloc_trace+0x1ae/0x270
[    9.725565]  fcloop_fcp_req+0x32/0x1a0 [nvme_fcloop]
[    9.726428]  nvme_fc_start_fcp_op.part.39+0x193/0x4c0 [nvme_fc]
[    9.727425]  blk_mq_dispatch_rq_list+0x7f/0x4a0
[    9.728219]  ? blk_mq_flush_busy_ctxs+0xa8/0xf0
[    9.729035]  blk_mq_sched_dispatch_requests+0x16e/0x170
[    9.729984]  __blk_mq_run_hw_queue+0x79/0xd0
[    9.730737]  __blk_mq_delay_run_hw_queue+0x11c/0x160
[    9.731647]  blk_mq_run_hw_queue+0x63/0xc0
[    9.732357]  blk_mq_sched_insert_request+0xb2/0x140
[    9.733204]  blk_execute_rq+0x64/0xc0
[    9.733840]  __nvme_submit_sync_cmd+0x63/0xd0 [nvme_core]
[    9.734772]  nvmf_connect_admin_queue+0x11e/0x190 [nvme_fabrics]
[    9.735815]  ? mark_held_locks+0x6b/0x90
[    9.736504]  nvme_fc_create_association+0x35b/0x970 [nvme_fc]
[    9.737489]  nvme_fc_create_ctrl+0x5d2/0x830 [nvme_fc]
[    9.738379]  nvmf_dev_write+0x92d/0xb7d [nvme_fabrics]
[    9.739253]  __vfs_write+0x21/0x130
[    9.739895]  ? selinux_file_permission+0xe9/0x140
[    9.740698]  ? security_file_permission+0x2f/0xb0
[    9.741526]  vfs_write+0xbd/0x1c0
[    9.742095]  ksys_write+0x40/0xa0
[    9.742681]  ? do_syscall_64+0xd/0x190
[    9.743335]  do_syscall_64+0x51/0x190
[    9.744415]  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/nvme/host/fabrics.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 7ae732a77fe8..febf82639b40 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -957,16 +957,17 @@ nvmf_create_ctrl(struct device *dev, const char *buf, size_t count)
 
 	down_read(&nvmf_transports_rwsem);
 	ops = nvmf_lookup_transport(opts);
+	up_read(&nvmf_transports_rwsem);
 	if (!ops) {
 		pr_info("no handler found for transport %s.\n",
 			opts->transport);
 		ret = -EINVAL;
-		goto out_unlock;
+		goto out_free_opts;
 	}
 
 	if (!try_module_get(ops->module)) {
 		ret = -EBUSY;
-		goto out_unlock;
+		goto out_free_opts;
 	}
 
 	ret = nvmf_check_required_opts(opts, ops->required_opts);
@@ -988,19 +989,15 @@ nvmf_create_ctrl(struct device *dev, const char *buf, size_t count)
 			"controller returned incorrect NQN: \"%s\".\n",
 			ctrl->subsys->subnqn);
 		module_put(ops->module);
-		up_read(&nvmf_transports_rwsem);
 		nvme_delete_ctrl_sync(ctrl);
 		return ERR_PTR(-EINVAL);
 	}
 
 	module_put(ops->module);
-	up_read(&nvmf_transports_rwsem);
 	return ctrl;
 
 out_module_put:
 	module_put(ops->module);
-out_unlock:
-	up_read(&nvmf_transports_rwsem);
 out_free_opts:
 	nvmf_free_options(opts);
 	return ERR_PTR(ret);
-- 
2.16.3
