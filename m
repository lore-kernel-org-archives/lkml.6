Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8EBC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 07:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 358AB208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 07:36:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 358AB208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755186AbeFRHgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 03:36:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:49285 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754865AbeFRHgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 03:36:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 966B2AE12;
        Mon, 18 Jun 2018 07:36:41 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc:     boris.ostrovsky@oracle.com, Juergen Gross <jgross@suse.com>
Subject: [PATCH v2] xen: add new hypercall buffer mapping device
Date:   Mon, 18 Jun 2018 09:36:39 +0200
Message-Id: <20180618073639.26066-1-jgross@suse.com>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For passing arbitrary data from user land to the Xen hypervisor the
Xen tools today are using mlock()ed buffers. Unfortunately the kernel
might change access rights of such buffers for brief periods of time
e.g. for page migration or compaction, leading to access faults in the
hypervisor, as the hypervisor can't use the locks of the kernel.

In order to solve this problem add a new device node to the Xen privcmd
driver to easily allocate hypercall buffers via mmap(). The memory is
allocated in the kernel and just mapped into user space. Marked as
VM_IO the user mapping will not be subject to page migration et al.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- don't add new node to xenfs (Andrew Cooper)
- use unsigned long for page count (Andrew Cooper)
- drop DONTDUMP flag from vma (Andrew Cooper)
- rename node to "xen/hypercall" (Andrew Cooper)
- modify limit to unsigned int (Jan Beulich)
- drop error messages (Jan Beulich)
- change errno returned (Boris Ostrovsky)
---
 drivers/xen/Makefile      |   2 +-
 drivers/xen/privcmd-buf.c | 210 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/xen/privcmd.c     |   9 ++
 drivers/xen/privcmd.h     |   3 +
 4 files changed, 223 insertions(+), 1 deletion(-)
 create mode 100644 drivers/xen/privcmd-buf.c

diff --git a/drivers/xen/Makefile b/drivers/xen/Makefile
index 451e833f5931..48b154276179 100644
--- a/drivers/xen/Makefile
+++ b/drivers/xen/Makefile
@@ -41,4 +41,4 @@ obj-$(CONFIG_XEN_PVCALLS_FRONTEND)	+= pvcalls-front.o
 xen-evtchn-y				:= evtchn.o
 xen-gntdev-y				:= gntdev.o
 xen-gntalloc-y				:= gntalloc.o
-xen-privcmd-y				:= privcmd.o
+xen-privcmd-y				:= privcmd.o privcmd-buf.o
diff --git a/drivers/xen/privcmd-buf.c b/drivers/xen/privcmd-buf.c
new file mode 100644
index 000000000000..0f0d5271bd36
--- /dev/null
+++ b/drivers/xen/privcmd-buf.c
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+
+/******************************************************************************
+ * privcmd-buf.c
+ *
+ * Mmap of hypercall buffers.
+ *
+ * Copyright (c) 2018 Juergen Gross
+ */
+
+#define pr_fmt(fmt) "xen:" KBUILD_MODNAME ": " fmt
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/list.h>
+#include <linux/miscdevice.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+
+#include "privcmd.h"
+
+MODULE_LICENSE("GPL");
+
+static unsigned int limit = 64;
+module_param(limit, uint, 0644);
+MODULE_PARM_DESC(limit, "Maximum number of pages that may be allocated by "
+			"the privcmd-buf device per open file");
+
+struct privcmd_buf_private {
+	struct mutex lock;
+	struct list_head list;
+	unsigned int allocated;
+};
+
+struct privcmd_buf_vma_private {
+	struct privcmd_buf_private *file_priv;
+	struct list_head list;
+	unsigned int users;
+	unsigned int n_pages;
+	struct page *pages[];
+};
+
+static int privcmd_buf_open(struct inode *ino, struct file *file)
+{
+	struct privcmd_buf_private *file_priv;
+
+	file_priv = kzalloc(sizeof(*file_priv), GFP_KERNEL);
+	if (!file_priv)
+		return -ENOMEM;
+
+	mutex_init(&file_priv->lock);
+	INIT_LIST_HEAD(&file_priv->list);
+
+	file->private_data = file_priv;
+
+	return 0;
+}
+
+static void privcmd_buf_vmapriv_free(struct privcmd_buf_vma_private *vma_priv)
+{
+	unsigned int i;
+
+	vma_priv->file_priv->allocated -= vma_priv->n_pages;
+
+	list_del(&vma_priv->list);
+
+	for (i = 0; i < vma_priv->n_pages; i++)
+		if (vma_priv->pages[i])
+			__free_page(vma_priv->pages[i]);
+
+	kfree(vma_priv);
+}
+
+static int privcmd_buf_release(struct inode *ino, struct file *file)
+{
+	struct privcmd_buf_private *file_priv = file->private_data;
+	struct privcmd_buf_vma_private *vma_priv;
+
+	mutex_lock(&file_priv->lock);
+
+	while (!list_empty(&file_priv->list)) {
+		vma_priv = list_first_entry(&file_priv->list,
+					    struct privcmd_buf_vma_private,
+					    list);
+		privcmd_buf_vmapriv_free(vma_priv);
+	}
+
+	mutex_unlock(&file_priv->lock);
+
+	kfree(file_priv);
+
+	return 0;
+}
+
+static void privcmd_buf_vma_open(struct vm_area_struct *vma)
+{
+	struct privcmd_buf_vma_private *vma_priv = vma->vm_private_data;
+
+	if (!vma_priv)
+		return;
+
+	mutex_lock(&vma_priv->file_priv->lock);
+	vma_priv->users++;
+	mutex_unlock(&vma_priv->file_priv->lock);
+}
+
+static void privcmd_buf_vma_close(struct vm_area_struct *vma)
+{
+	struct privcmd_buf_vma_private *vma_priv = vma->vm_private_data;
+	struct privcmd_buf_private *file_priv;
+
+	if (!vma_priv)
+		return;
+
+	file_priv = vma_priv->file_priv;
+
+	mutex_lock(&file_priv->lock);
+
+	vma_priv->users--;
+	if (!vma_priv->users)
+		privcmd_buf_vmapriv_free(vma_priv);
+
+	mutex_unlock(&file_priv->lock);
+}
+
+static vm_fault_t privcmd_buf_vma_fault(struct vm_fault *vmf)
+{
+	pr_debug("fault: vma=%p %lx-%lx, pgoff=%lx, uv=%p\n",
+		 vmf->vma, vmf->vma->vm_start, vmf->vma->vm_end,
+		 vmf->pgoff, (void *)vmf->address);
+
+	return VM_FAULT_SIGBUS;
+}
+
+static const struct vm_operations_struct privcmd_buf_vm_ops = {
+	.open = privcmd_buf_vma_open,
+	.close = privcmd_buf_vma_close,
+	.fault = privcmd_buf_vma_fault,
+};
+
+static int privcmd_buf_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct privcmd_buf_private *file_priv = file->private_data;
+	struct privcmd_buf_vma_private *vma_priv;
+	unsigned long count = vma_pages(vma);
+	unsigned int i;
+	int ret = 0;
+
+	if (!(vma->vm_flags & VM_SHARED) || count > (unsigned long)limit ||
+	    file_priv->allocated + count > limit)
+		return -EINVAL;
+
+	vma_priv = kzalloc(sizeof(*vma_priv) + count * sizeof(void *),
+			   GFP_KERNEL);
+	if (!vma_priv)
+		return -ENOMEM;
+
+	vma_priv->n_pages = count;
+	count = 0;
+	for (i = 0; i < vma_priv->n_pages; i++) {
+		vma_priv->pages[i] = alloc_page(GFP_KERNEL | __GFP_ZERO);
+		if (!vma_priv->pages[i])
+			break;
+		count++;
+	}
+
+	mutex_lock(&file_priv->lock);
+
+	file_priv->allocated += count;
+
+	vma_priv->file_priv = file_priv;
+	vma_priv->users = 1;
+
+	vma->vm_flags |= VM_IO | VM_DONTEXPAND;
+	vma->vm_ops = &privcmd_buf_vm_ops;
+	vma->vm_private_data = vma_priv;
+
+	list_add(&vma_priv->list, &file_priv->list);
+
+	if (vma_priv->n_pages != count)
+		ret = -ENOMEM;
+	else
+		for (i = 0; i < vma_priv->n_pages; i++) {
+			ret = vm_insert_page(vma, vma->vm_start + i * PAGE_SIZE,
+					     vma_priv->pages[i]);
+			if (ret)
+				break;
+		}
+
+	if (ret)
+		privcmd_buf_vmapriv_free(vma_priv);
+
+	mutex_unlock(&file_priv->lock);
+
+	return ret;
+}
+
+const struct file_operations xen_privcmdbuf_fops = {
+	.owner = THIS_MODULE,
+	.open = privcmd_buf_open,
+	.release = privcmd_buf_release,
+	.mmap = privcmd_buf_mmap,
+};
+EXPORT_SYMBOL_GPL(xen_privcmdbuf_fops);
+
+struct miscdevice xen_privcmdbuf_dev = {
+	.minor = MISC_DYNAMIC_MINOR,
+	.name = "xen/hypercall",
+	.fops = &xen_privcmdbuf_fops,
+};
diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index 8ae0349d9f0a..7e6e682104dc 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -1007,12 +1007,21 @@ static int __init privcmd_init(void)
 		pr_err("Could not register Xen privcmd device\n");
 		return err;
 	}
+
+	err = misc_register(&xen_privcmdbuf_dev);
+	if (err != 0) {
+		pr_err("Could not register Xen hypercall-buf device\n");
+		misc_deregister(&privcmd_dev);
+		return err;
+	}
+
 	return 0;
 }
 
 static void __exit privcmd_exit(void)
 {
 	misc_deregister(&privcmd_dev);
+	misc_deregister(&xen_privcmdbuf_dev);
 }
 
 module_init(privcmd_init);
diff --git a/drivers/xen/privcmd.h b/drivers/xen/privcmd.h
index 14facaeed36f..0dd9f8f67ee3 100644
--- a/drivers/xen/privcmd.h
+++ b/drivers/xen/privcmd.h
@@ -1,3 +1,6 @@
 #include <linux/fs.h>
 
 extern const struct file_operations xen_privcmd_fops;
+extern const struct file_operations xen_privcmdbuf_fops;
+
+extern struct miscdevice xen_privcmdbuf_dev;
-- 
2.13.7

