Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F29C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D7B20864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:33:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87D7B20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936785AbeFRJdf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:33:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56030 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936118AbeFRIY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:24:28 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D654FBAD;
        Mon, 18 Jun 2018 08:24:27 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianchao Wang <jianchao.w.wang@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 197/279] nvme: fix use-after-free in nvme_free_ns_head
Date:   Mon, 18 Jun 2018 10:13:02 +0200
Message-Id: <20180618080617.064604999@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
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

From: Jianchao Wang <jianchao.w.wang@oracle.com>

[ Upstream commit 12d9f07022dcde261ad16e9a11f45096dc68b03c ]

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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <keith.busch@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/host/core.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -99,6 +99,7 @@ static struct class *nvme_subsys_class;
 
 static void nvme_ns_remove(struct nvme_ns *ns);
 static int nvme_revalidate_disk(struct gendisk *disk);
+static void nvme_put_subsystem(struct nvme_subsystem *subsys);
 
 static __le32 nvme_get_log_dw10(u8 lid, size_t size)
 {
@@ -353,6 +354,7 @@ static void nvme_free_ns_head(struct kre
 	ida_simple_remove(&head->subsys->ns_ida, head->instance);
 	list_del_init(&head->entry);
 	cleanup_srcu_struct(&head->srcu);
+	nvme_put_subsystem(head->subsys);
 	kfree(head);
 }
 
@@ -2843,6 +2845,9 @@ static struct nvme_ns_head *nvme_alloc_n
 		goto out_cleanup_srcu;
 
 	list_add_tail(&head->entry, &ctrl->subsys->nsheads);
+
+	kref_get(&ctrl->subsys->ref);
+
 	return head;
 out_cleanup_srcu:
 	cleanup_srcu_struct(&head->srcu);


