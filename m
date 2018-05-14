Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753047AbeENMN1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 08:13:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:45603 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752870AbeENMNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 08:13:25 -0400
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Keith Busch <keith.busch@intel.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH] nvme: fix lockdep warning in nvme_mpath_clear_current_path
Date: Mon, 14 May 2018 14:13:12 +0200
Message-Id: <20180514121312.13624-1-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running blktest's nvme/005 with a lockdep enabled kernel the test
case fails due to the following lockdep splat in dmesg:

[   18.206166] =============================
[   18.207286] WARNING: suspicious RCU usage
[   18.208417] 4.17.0-rc5 #881 Not tainted
[   18.209487] -----------------------------
[   18.210612] drivers/nvme/host/nvme.h:457 suspicious rcu_dereference_check() usage!
[   18.213486]
[   18.213486] other info that might help us debug this:
[   18.213486]
[   18.214745]
[   18.214745] rcu_scheduler_active = 2, debug_locks = 1
[   18.215798] 3 locks held by kworker/u32:5/1102:
[   18.216535]  #0:         (ptrval) ((wq_completion)"nvme-wq"){+.+.}, at: process_one_work+0x152/0x5c0
[   18.217983]  #1:         (ptrval) ((work_completion)(&ctrl->scan_work)){+.+.}, at: process_one_work+0x152/0x5c0
[   18.219584]  #2:         (ptrval) (&subsys->lock#2){+.+.}, at: nvme_ns_remove+0x43/0x1c0 [nvme_core]
[   18.221037]
[   18.221037] stack backtrace:
[   18.221721] CPU: 12 PID: 1102 Comm: kworker/u32:5 Not tainted 4.17.0-rc5 #881
[   18.222830] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.0.0-prebuilt.qemu-project.org 04/01/2014
[   18.224451] Workqueue: nvme-wq nvme_scan_work [nvme_core]
[   18.225308] Call Trace:
[   18.225704]  dump_stack+0x78/0xb3
[   18.226224]  nvme_ns_remove+0x1a3/0x1c0 [nvme_core]
[   18.226975]  nvme_validate_ns+0x87/0x850 [nvme_core]
[   18.227749]  ? blk_queue_exit+0x69/0x110
[   18.228358]  ? blk_queue_exit+0x81/0x110
[   18.228960]  ? direct_make_request+0x1a0/0x1a0
[   18.229649]  nvme_scan_work+0x212/0x2d0 [nvme_core]
[   18.230411]  process_one_work+0x1d8/0x5c0
[   18.231037]  ? process_one_work+0x152/0x5c0
[   18.231705]  worker_thread+0x45/0x3e0
[   18.232282]  kthread+0x101/0x140
[   18.232788]  ? process_one_work+0x5c0/0x5c0

The only caller of nvme_mpath_clear_current_path() is nvme_ns_remove()
which holds the subsys lock so it's likely a false positive, but using
rcu_dereference_protected() tells lockdep we're holding the lock.

Fixes: 32acab3181c7 ("nvme: implement multipath access to nvme subsystems")
Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/nvme/host/nvme.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 17d2f7cf3fed..ca034434ebb9 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -22,6 +22,7 @@
 #include <linux/lightnvm.h>
 #include <linux/sed-opal.h>
 #include <linux/fault-inject.h>
+#include <linux/rcupdate.h>
 
 extern unsigned int nvme_io_timeout;
 #define NVME_IO_TIMEOUT	(nvme_io_timeout * HZ)
@@ -454,7 +455,9 @@ static inline void nvme_mpath_clear_current_path(struct nvme_ns *ns)
 {
 	struct nvme_ns_head *head = ns->head;
 
-	if (head && ns == srcu_dereference(head->current_path, &head->srcu))
+	if (head &&
+	    ns == rcu_dereference_protected(head->current_path,
+				lockdep_is_held(&ns->ctrl->subsys->lock)))
 		rcu_assign_pointer(head->current_path, NULL);
 }
 struct nvme_ns *nvme_find_path(struct nvme_ns_head *head);
-- 
2.16.3
