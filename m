Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0211C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 12:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5457F204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 12:33:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5457F204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbeKAVgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 17:36:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:49860 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728326AbeKAVgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 17:36:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3CB6CAC11;
        Thu,  1 Nov 2018 12:33:13 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc:     boris.ostrovsky@oracle.com, sstabellini@kernel.org,
        Juergen Gross <jgross@suse.com>, stable@vger.kernel.org
Subject: [PATCH] xen: remove size limit of privcmd-buf mapping interface
Date:   Thu,  1 Nov 2018 13:33:07 +0100
Message-Id: <20181101123307.8424-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the size of hypercall buffers allocated via
/dev/xen/hypercall is limited to a default of 64 memory pages. For live
migration of guests this might be too small as the page dirty bitmask
needs to be sized according to the size of the guest. This means
migrating a 8GB sized guest is already exhausting the default buffer
size for the dirty bitmap.

There is no sensible way to set a sane limit, so just remove it
completely. The device node's usage is limited to root anyway, so there
is no additional DOS scenario added by allowing unlimited buffers.

While at it make the error path for the -ENOMEM case a little bit
cleaner by setting n_pages to the number of successfully allocated
pages instead of the target size.

Fixes: c51b3c639e01f2 ("xen: add new hypercall buffer mapping device")
Cc: <stable@vger.kernel.org> #4.18
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/xen/privcmd-buf.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/xen/privcmd-buf.c b/drivers/xen/privcmd-buf.c
index df1ed37c3269..de01a6d0059d 100644
--- a/drivers/xen/privcmd-buf.c
+++ b/drivers/xen/privcmd-buf.c
@@ -21,15 +21,9 @@
 
 MODULE_LICENSE("GPL");
 
-static unsigned int limit = 64;
-module_param(limit, uint, 0644);
-MODULE_PARM_DESC(limit, "Maximum number of pages that may be allocated by "
-			"the privcmd-buf device per open file");
-
 struct privcmd_buf_private {
 	struct mutex lock;
 	struct list_head list;
-	unsigned int allocated;
 };
 
 struct privcmd_buf_vma_private {
@@ -60,13 +54,10 @@ static void privcmd_buf_vmapriv_free(struct privcmd_buf_vma_private *vma_priv)
 {
 	unsigned int i;
 
-	vma_priv->file_priv->allocated -= vma_priv->n_pages;
-
 	list_del(&vma_priv->list);
 
 	for (i = 0; i < vma_priv->n_pages; i++)
-		if (vma_priv->pages[i])
-			__free_page(vma_priv->pages[i]);
+		__free_page(vma_priv->pages[i]);
 
 	kfree(vma_priv);
 }
@@ -146,8 +137,7 @@ static int privcmd_buf_mmap(struct file *file, struct vm_area_struct *vma)
 	unsigned int i;
 	int ret = 0;
 
-	if (!(vma->vm_flags & VM_SHARED) || count > limit ||
-	    file_priv->allocated + count > limit)
+	if (!(vma->vm_flags & VM_SHARED))
 		return -EINVAL;
 
 	vma_priv = kzalloc(sizeof(*vma_priv) + count * sizeof(void *),
@@ -155,19 +145,15 @@ static int privcmd_buf_mmap(struct file *file, struct vm_area_struct *vma)
 	if (!vma_priv)
 		return -ENOMEM;
 
-	vma_priv->n_pages = count;
-	count = 0;
-	for (i = 0; i < vma_priv->n_pages; i++) {
+	for (i = 0; i < count; i++) {
 		vma_priv->pages[i] = alloc_page(GFP_KERNEL | __GFP_ZERO);
 		if (!vma_priv->pages[i])
 			break;
-		count++;
+		vma_priv->n_pages++;
 	}
 
 	mutex_lock(&file_priv->lock);
 
-	file_priv->allocated += count;
-
 	vma_priv->file_priv = file_priv;
 	vma_priv->users = 1;
 
-- 
2.16.4

