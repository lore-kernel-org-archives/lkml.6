Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932934AbeCJSVt (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 13:21:49 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:40668 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932071AbeCJSVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 13:21:46 -0500
X-Google-Smtp-Source: AG47ELu8lJaGyE06A4cwh6akC+kFJn0VtXqYXkA7kPb8mL3lmxCdIxb/TPLL4jHScxPPhnijwZWIPw==
From: Andiry Xu <jix024@eng.ucsd.edu>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Cc: dan.j.williams@intel.com, andy.rudoff@intel.com, coughlan@redhat.com,
        swanson@cs.ucsd.edu, david@fromorbit.com, jack@suse.com,
        swhiteho@redhat.com, miklos@szeredi.hu, andiry.xu@gmail.com,
        Andiry Xu <jix024@cs.ucsd.edu>
Subject: [RFC v2 74/83] File operation: Mmap.
Date: Sat, 10 Mar 2018 10:18:55 -0800
Message-Id: <1520705944-6723-75-git-send-email-jix024@eng.ucsd.edu>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
References: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andiry Xu <jix024@cs.ucsd.edu>

NOVA uses the iomap framework to support mmap operation.
Currently it does not support huge page mmap.

Signed-off-by: Andiry Xu <jix024@cs.ucsd.edu>
---
 fs/nova/dax.c  | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nova/file.c | 25 +++++++++++++++++++++++++
 fs/nova/nova.h |  1 +
 3 files changed, 79 insertions(+)

diff --git a/fs/nova/dax.c b/fs/nova/dax.c
index e639b23..fa424b1 100644
--- a/fs/nova/dax.c
+++ b/fs/nova/dax.c
@@ -915,3 +915,56 @@ const struct iomap_ops nova_iomap_ops = {
 	.iomap_begin	= nova_iomap_begin,
 	.iomap_end	= nova_iomap_end,
 };
+
+
+/* TODO: Hugemap mmap */
+static int nova_dax_huge_fault(struct vm_fault *vmf,
+	enum page_entry_size pe_size)
+{
+	int ret = 0;
+	timing_t fault_time;
+	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
+	struct inode *inode = mapping->host;
+
+	NOVA_START_TIMING(pmd_fault_t, fault_time);
+
+	nova_dbgv("%s: inode %lu, pgoff %lu\n",
+		  __func__, inode->i_ino, vmf->pgoff);
+
+	if (vmf->flags & FAULT_FLAG_WRITE)
+		file_update_time(vmf->vma->vm_file);
+
+	ret = dax_iomap_fault(vmf, pe_size, NULL, NULL, &nova_iomap_ops);
+
+	NOVA_END_TIMING(pmd_fault_t, fault_time);
+	return ret;
+}
+
+static int nova_dax_fault(struct vm_fault *vmf)
+{
+	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
+	struct inode *inode = mapping->host;
+
+	nova_dbgv("%s: inode %lu, pgoff %lu, flags 0x%x\n",
+		  __func__, inode->i_ino, vmf->pgoff, vmf->flags);
+
+	return nova_dax_huge_fault(vmf, PE_SIZE_PTE);
+}
+
+static int nova_dax_pfn_mkwrite(struct vm_fault *vmf)
+{
+	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
+	struct inode *inode = mapping->host;
+
+	nova_dbgv("%s: inode %lu, pgoff %lu, flags 0x%x\n",
+		  __func__, inode->i_ino, vmf->pgoff, vmf->flags);
+
+	return nova_dax_huge_fault(vmf, PE_SIZE_PTE);
+}
+
+const struct vm_operations_struct nova_dax_vm_ops = {
+	.fault	= nova_dax_fault,
+	.huge_fault = nova_dax_huge_fault,
+	.page_mkwrite = nova_dax_fault,
+	.pfn_mkwrite = nova_dax_pfn_mkwrite,
+};
diff --git a/fs/nova/file.c b/fs/nova/file.c
index a6b5bd3..0ae0333 100644
--- a/fs/nova/file.c
+++ b/fs/nova/file.c
@@ -617,10 +617,35 @@ static ssize_t nova_dax_file_write(struct file *filp, const char __user *buf,
 }
 
 
+static int nova_dax_file_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct inode *inode = file->f_mapping->host;
+
+	file_accessed(file);
+
+	vma->vm_flags |= VM_MIXEDMAP;
+
+	vma->vm_ops = &nova_dax_vm_ops;
+
+	nova_dbg_mmap4k("[%s:%d] inode %lu, MMAP 4KPAGE vm_start(0x%lx), "
+			"vm_end(0x%lx), vm pgoff %lu, %lu blocks, "
+			"vm_flags(0x%lx), vm_page_prot(0x%lx)\n",
+			__func__, __LINE__,
+			inode->i_ino, vma->vm_start, vma->vm_end,
+			vma->vm_pgoff,
+			(vma->vm_end - vma->vm_start) >> PAGE_SHIFT,
+			vma->vm_flags,
+			pgprot_val(vma->vm_page_prot));
+
+	return 0;
+}
+
+
 const struct file_operations nova_dax_file_operations = {
 	.llseek		= nova_llseek,
 	.read		= nova_dax_file_read,
 	.write		= nova_dax_file_write,
+	.mmap		= nova_dax_file_mmap,
 	.open		= nova_open,
 	.fsync		= nova_fsync,
 	.flush		= nova_flush,
diff --git a/fs/nova/nova.h b/fs/nova/nova.h
index 0d62c47..d209cfc 100644
--- a/fs/nova/nova.h
+++ b/fs/nova/nova.h
@@ -488,6 +488,7 @@ ssize_t do_nova_inplace_file_write(struct file *filp, const char __user *buf,
 	size_t len, loff_t *ppos);
 
 extern const struct iomap_ops nova_iomap_ops;
+extern const struct vm_operations_struct nova_dax_vm_ops;
 
 
 /* dir.c */
-- 
2.7.4
