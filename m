Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751495AbeEDIBy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 04:01:54 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43900 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750733AbeEDIBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 04:01:52 -0400
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nvme: fix use-after-free in nvme_free_ns_head
Date: Fri,  4 May 2018 16:01:57 +0800
Message-Id: <1525420917-9448-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8882 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=853
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805040075
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently only nvme_ctrl will take a reference counter of
nvme_subsystem, nvme_ns_head also needs it. Otherwise
nvme_free_ns_head will access the nvme_subsystem.ns_ida
which has been freed by __nvme_release_subsystem after all the
reference of nvme_subsystem have been released by nvme_free_ctrl.
This could cause memory corruption.

 BUG: KASAN: use-after-free in radix_tree_next_chunk+0x9f/0x4b0
 Read of size 8 at addr ffff88036494d2e8 by task fio/1815

 CPU: 1 PID: 1815 Comm: fio Kdump: loaded Tainted: G        W         4.17.0-rc1+ #18
 Hardware name: LENOVO 10MLS0E339/3106, BIOS M1AKT22A 06/27/2017
 Call Trace:
  dump_stack+0x91/0xeb
  print_address_description+0x6b/0x290
  kasan_report+0x261/0x360
  radix_tree_next_chunk+0x9f/0x4b0
  ida_remove+0x8b/0x180
  ida_simple_remove+0x26/0x40
  nvme_free_ns_head+0x58/0xc0
  __blkdev_put+0x30a/0x3a0
  blkdev_close+0x44/0x50
  __fput+0x184/0x380
  task_work_run+0xaf/0xe0
  do_exit+0x501/0x1440
  do_group_exit+0x89/0x140
  __x64_sys_exit_group+0x28/0x30
  do_syscall_64+0x72/0x230

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 drivers/nvme/host/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0e95082..6ef2915 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -99,6 +99,7 @@ static struct class *nvme_subsys_class;
 
 static void nvme_ns_remove(struct nvme_ns *ns);
 static int nvme_revalidate_disk(struct gendisk *disk);
+static void nvme_put_subsystem(struct nvme_subsystem *subsys);
 
 int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
 {
@@ -350,6 +351,7 @@ static void nvme_free_ns_head(struct kref *ref)
 	ida_simple_remove(&head->subsys->ns_ida, head->instance);
 	list_del_init(&head->entry);
 	cleanup_srcu_struct(&head->srcu);
+	nvme_put_subsystem(head->subsys);
 	kfree(head);
 }
 
@@ -2860,6 +2862,9 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 		goto out_cleanup_srcu;
 
 	list_add_tail(&head->entry, &ctrl->subsys->nsheads);
+
+	kref_get(&ctrl->subsys->ref);
+
 	return head;
 out_cleanup_srcu:
 	cleanup_srcu_struct(&head->srcu);
-- 
2.7.4
