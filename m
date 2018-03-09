Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751389AbeCIGus (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 01:50:48 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40578 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750970AbeCIGuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 01:50:46 -0500
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: glider@google.com, dvyukov@google.com
Subject: [PATCH net 1/3] vhost_net: initialize rx_ring in vhost_net_open()
Date: Fri,  9 Mar 2018 14:50:32 +0800
Message-Id: <1520578234-5565-2-git-send-email-jasowang@redhat.com>
In-Reply-To: <1520578234-5565-1-git-send-email-jasowang@redhat.com>
References: <1520578234-5565-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Potapenko <glider@google.com>

KMSAN reported a use of uninit memory in vhost_net_buf_unproduce()
while trying to access n->vqs[VHOST_NET_VQ_TX].rx_ring:

==================================================================
BUG: KMSAN: use of uninitialized memory in vhost_net_buf_unproduce+0x7bb/0x9a0 drivers/vho
et.c:170
CPU: 0 PID: 3021 Comm: syz-fuzzer Not tainted 4.16.0-rc4+ #3853
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:17 [inline]
 dump_stack+0x185/0x1d0 lib/dump_stack.c:53
 kmsan_report+0x142/0x1f0 mm/kmsan/kmsan.c:1093
 __msan_warning_32+0x6c/0xb0 mm/kmsan/kmsan_instr.c:676
 vhost_net_buf_unproduce+0x7bb/0x9a0 drivers/vhost/net.c:170
 vhost_net_stop_vq drivers/vhost/net.c:974 [inline]
 vhost_net_stop+0x146/0x380 drivers/vhost/net.c:982
 vhost_net_release+0xb1/0x4f0 drivers/vhost/net.c:1015
 __fput+0x49f/0xa00 fs/file_table.c:209
 ____fput+0x37/0x40 fs/file_table.c:243
 task_work_run+0x243/0x2c0 kernel/task_work.c:113
 tracehook_notify_resume include/linux/tracehook.h:191 [inline]
 exit_to_usermode_loop arch/x86/entry/common.c:166 [inline]
 prepare_exit_to_usermode+0x349/0x3b0 arch/x86/entry/common.c:196
 syscall_return_slowpath+0xf3/0x6d0 arch/x86/entry/common.c:265
 do_syscall_64+0x34d/0x450 arch/x86/entry/common.c:292
...
origin:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:303 [inline]
 kmsan_internal_poison_shadow+0xb8/0x1b0 mm/kmsan/kmsan.c:213
 kmsan_kmalloc_large+0x6f/0xd0 mm/kmsan/kmsan.c:392
 kmalloc_large_node_hook mm/slub.c:1366 [inline]
 kmalloc_large_node mm/slub.c:3808 [inline]
 __kmalloc_node+0x100e/0x1290 mm/slub.c:3818
 kmalloc_node include/linux/slab.h:554 [inline]
 kvmalloc_node+0x1a5/0x2e0 mm/util.c:419
 kvmalloc include/linux/mm.h:541 [inline]
 vhost_net_open+0x64/0x5f0 drivers/vhost/net.c:921
 misc_open+0x7b5/0x8b0 drivers/char/misc.c:154
 chrdev_open+0xc28/0xd90 fs/char_dev.c:417
 do_dentry_open+0xccb/0x1430 fs/open.c:752
 vfs_open+0x272/0x2e0 fs/open.c:866
 do_last fs/namei.c:3378 [inline]
 path_openat+0x49ad/0x6580 fs/namei.c:3519
 do_filp_open+0x267/0x640 fs/namei.c:3553
 do_sys_open+0x6ad/0x9c0 fs/open.c:1059
 SYSC_openat+0xc7/0xe0 fs/open.c:1086
 SyS_openat+0x63/0x90 fs/open.c:1080
 do_syscall_64+0x2f1/0x450 arch/x86/entry/common.c:287
==================================================================

Fixes: c67df11f6e480 ("vhost_net: try batch dequing from skb array")
Signed-off-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/net.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 610cba2..60f1080 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -948,6 +948,7 @@ static int vhost_net_open(struct inode *inode, struct file *f)
 		n->vqs[i].done_idx = 0;
 		n->vqs[i].vhost_hlen = 0;
 		n->vqs[i].sock_hlen = 0;
+		n->vqs[i].rx_ring = NULL;
 		vhost_net_buf_init(&n->vqs[i].rxq);
 	}
 	vhost_dev_init(dev, vqs, VHOST_NET_VQ_MAX);
-- 
2.7.4
