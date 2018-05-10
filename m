Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966137AbeEJOjd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 10:39:33 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:43729 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935661AbeEJOjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 10:39:31 -0400
X-Google-Smtp-Source: AB8JxZpAjt2LPas3yffbaXzGdHRQkH87AvO8M1e6D7eGqxrz1+WDr3mfeOrB562wOXs4rx4v78YAgA==
Date: Thu, 10 May 2018 20:11:36 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: tytso@mit.edu, adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        willy@infradead.org
Subject: [PATCH v2] fs: ext4: Adding new return type vm_fault_t
Message-ID: <20180510144136.GA26160@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new return type vm_fault_t for fault handler. For now,
this is just documenting that the function returns a
VM_FAULT value rather than an errno. Once all instances are
converted, vm_fault_t will become a distinct type.

commit 1c8f422059ae ("mm: change return type to vm_fault_t")

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
---
v2: Updated the change log

 fs/ext4/file.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index fb6f023..655d1c7 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -277,10 +277,11 @@ static ssize_t ext4_write_checks(struct kiocb *iocb, struct iov_iter *from)
 }
 
 #ifdef CONFIG_FS_DAX
-static int ext4_dax_huge_fault(struct vm_fault *vmf,
+static vm_fault_t ext4_dax_huge_fault(struct vm_fault *vmf,
 		enum page_entry_size pe_size)
 {
-	int result, error = 0;
+	int error = 0;
+	vm_fault_t result;
 	int retries = 0;
 	handle_t *handle = NULL;
 	struct inode *inode = file_inode(vmf->vma->vm_file);
@@ -335,7 +336,7 @@ static int ext4_dax_huge_fault(struct vm_fault *vmf,
 	return result;
 }
 
-static int ext4_dax_fault(struct vm_fault *vmf)
+static vm_fault_t ext4_dax_fault(struct vm_fault *vmf)
 {
 	return ext4_dax_huge_fault(vmf, PE_SIZE_PTE);
 }
-- 
1.9.1
