Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E42C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C124920673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iC5C+1n0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C124920673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730640AbeGZQAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 12:00:18 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:45985 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729511AbeGZQAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 12:00:18 -0400
Received: by mail-pg1-f173.google.com with SMTP id f1-v6so1296408pgq.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 07:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=gaRxWTaM+/B1bndN88ySOF59LMcH/P+2+1B2IyLMpx4=;
        b=iC5C+1n00sq8WbDmeFnc5rcMYr7n0+5BlHw+fUMrdC1O+PO0vNMuT/BWo1RMwjyr0I
         QTeffw55c41QR6O9yco3Ph3HyvKDt/ecsiiKf9LDXtY5IWCfll4Yw+gvxW9FNhzoUqb9
         GSnBETKtPOxGpcT/TSOGkQwo9/Ae3XZV9c4SYrBddV3QGcby/PWs7pqsisse6y724/Kw
         P5oy/3Y14pk3VYJU1f5CLjjXj8zgryKGsX1aqZbzXLmwu0KNB74MGRT+0ZUYIyjRfWp7
         waQ9703ANrgn2ctXFOLiebz7xvXQG0xg4cugq472sslW+wWOFhe1HWNLG62PbhyAZsz2
         ZeRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=gaRxWTaM+/B1bndN88ySOF59LMcH/P+2+1B2IyLMpx4=;
        b=ANSYcEeEZdFUG10TpQ4OPvJyRhZziKdGBNAitilFaygYq3YK/0inwC2SyqwezNwY6W
         G+ZifQiam3Bm+w64S50/G+PopxSemBDphgtVIqyO5xOO446Znh65pXwEem/WCMt5wyk6
         WCgCwxdVxq8SI001/3TuQChH0JKzL8GN3sTxTZ71/Xat9yX7xORTLJp+5KKyMMQsRHX3
         s7ElEE3kZivYOD4FfM1xoNxNszfUs+TaZwBkgrubv+tIz5Qmutl4JfUyg1arHQcMF6KB
         ARporweuc1jKl5SRRjggQq3FdHLuG8GeM8FwCvk2/2L91dS8CFRLrsupMnDbzQTwxe5/
         mXhw==
X-Gm-Message-State: AOUpUlGBCET3xETXLWE1PSk+ptrSQ/dKwjSGX98bPKYWD4nvDAcBEe1a
        1G2qm3VGSgG8ECixtot6Ij50yUUX
X-Google-Smtp-Source: AAOMgpf2rpBfHgn/X+IQumUUBz9DqtwtipeZZ/4yOEOpUA8l4fzxrS8Kh5pWNsImAt609Py1lN/w+Q==
X-Received: by 2002:a65:48cd:: with SMTP id o13-v6mr2153536pgs.99.1532616186791;
        Thu, 26 Jul 2018 07:43:06 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([49.205.219.162])
        by smtp.gmail.com with ESMTPSA id k26-v6sm6988100pfb.167.2018.07.26.07.43.05
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 Jul 2018 07:43:05 -0700 (PDT)
Date:   Thu, 26 Jul 2018 20:15:49 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     willy@infradead.org, airlied@linux.ie, daniel.vetter@ffwll.ch,
        rodrigosiqueiramelo@gmail.com, gustavo.padovan@collabora.com,
        hamohammed.sa@gmail.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/vkms: Use new return type vm_fault_t
Message-ID: <20180726144549.GA9434@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new return type vm_fault_t for fault handler.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
v2: Updated patch title

 drivers/gpu/drm/vkms/vkms_drv.h | 2 +-
 drivers/gpu/drm/vkms/vkms_gem.c | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index 07be29f..d5d04a8 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -65,7 +65,7 @@ struct drm_gem_object *vkms_gem_create(struct drm_device *dev,
 				       u32 *handle,
 				       u64 size);
 
-int vkms_gem_fault(struct vm_fault *vmf);
+vm_fault_t vkms_gem_fault(struct vm_fault *vmf);
 
 int vkms_dumb_create(struct drm_file *file, struct drm_device *dev,
 		     struct drm_mode_create_dumb *args);
diff --git a/drivers/gpu/drm/vkms/vkms_gem.c b/drivers/gpu/drm/vkms/vkms_gem.c
index c7e3836..62e05dc 100644
--- a/drivers/gpu/drm/vkms/vkms_gem.c
+++ b/drivers/gpu/drm/vkms/vkms_gem.c
@@ -43,14 +43,14 @@ void vkms_gem_free_object(struct drm_gem_object *obj)
 	kfree(gem);
 }
 
-int vkms_gem_fault(struct vm_fault *vmf)
+vm_fault_t vkms_gem_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct vkms_gem_object *obj = vma->vm_private_data;
 	unsigned long vaddr = vmf->address;
 	pgoff_t page_offset;
 	loff_t num_pages;
-	int ret;
+	vm_fault_t ret = VM_FAULT_SIGBUS;
 
 	page_offset = (vaddr - vma->vm_start) >> PAGE_SHIFT;
 	num_pages = DIV_ROUND_UP(obj->gem.size, PAGE_SIZE);
@@ -58,7 +58,6 @@ int vkms_gem_fault(struct vm_fault *vmf)
 	if (page_offset > num_pages)
 		return VM_FAULT_SIGBUS;
 
-	ret = -ENOENT;
 	mutex_lock(&obj->pages_lock);
 	if (obj->pages) {
 		get_page(obj->pages[page_offset]);
-- 
1.9.1

