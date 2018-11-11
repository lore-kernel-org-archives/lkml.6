Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC23C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5542220871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fX1uxdRZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5542220871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732889AbeKLISc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:18:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:37238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732843AbeKLISa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:18:30 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E5A82154B;
        Sun, 11 Nov 2018 22:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975314;
        bh=wSNryVa/beN+aE7zJ4zRTED0OjDw/qD5YJAgLic6CF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fX1uxdRZP8CKiRyWkJJPBiNYGAi7BlNI8RxbUBbh/Z68+ZC1wR2FgHzYtgtZE8439
         AWciJ/VWjyxyL8g5y/fWXCZdS1VhRXZ/JL6Orjzj00DQDxwP8vQMFcN63SHE182pxD
         DFxg3OZzTKhDLp2+ualFuXKmVzqgLCIb81dCuk5I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCH 4.19 300/361] xen: remove size limit of privcmd-buf mapping interface
Date:   Sun, 11 Nov 2018 14:20:47 -0800
Message-Id: <20181111221657.421811314@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Juergen Gross <jgross@suse.com>

commit 3941552aec1e04d63999988a057ae09a1c56ebeb upstream.

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
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/xen/privcmd-buf.c |   22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

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
@@ -60,13 +54,10 @@ static void privcmd_buf_vmapriv_free(str
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
@@ -146,8 +137,7 @@ static int privcmd_buf_mmap(struct file
 	unsigned int i;
 	int ret = 0;
 
-	if (!(vma->vm_flags & VM_SHARED) || count > limit ||
-	    file_priv->allocated + count > limit)
+	if (!(vma->vm_flags & VM_SHARED))
 		return -EINVAL;
 
 	vma_priv = kzalloc(sizeof(*vma_priv) + count * sizeof(void *),
@@ -155,19 +145,15 @@ static int privcmd_buf_mmap(struct file
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
 


