Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034186AbeEXRYl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 13:24:41 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42459 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031778AbeEXRYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 13:24:39 -0400
X-Google-Smtp-Source: AB8JxZpFZ2Wbp6I7FE8PkE1QGpfpSxBUboxNotEMkdNl6+UpctepuvnBZeWivkffIi4E7Rt4g77jug==
Date: Thu, 24 May 2018 10:24:36 -0700
From: Kees Cook <keescook@chromium.org>
To: linux-kernel@vger.kernel.org
Cc: Alexandre Courbot <acourbot@nvidia.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau/secboot/acr: Remove VLA usage
Message-ID: <20180524172436.GA17738@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this
allocates the working buffers before starting the writing so it won't
abort in the middle. This needs an initial walk of the lists to figure
out how large the buffer should be.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 .../nouveau/nvkm/subdev/secboot/acr_r352.c    | 25 ++++++++++++++++---
 .../nouveau/nvkm/subdev/secboot/acr_r367.c    | 16 +++++++++++-
 2 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c b/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c
index a721354249ce..d02e183717dc 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c
@@ -414,6 +414,20 @@ acr_r352_ls_write_wpr(struct acr_r352 *acr, struct list_head *imgs,
 {
 	struct ls_ucode_img *_img;
 	u32 pos = 0;
+	u32 max_desc_size = 0;
+	u8 *gdesc;
+
+	/* Figure out how large we need gdesc to be. */
+	list_for_each_entry(_img, imgs, node) {
+		const struct acr_r352_ls_func *ls_func =
+					    acr->func->ls_func[_img->falcon_id];
+
+		max_desc_size = max(max_desc_size, ls_func->bl_desc_size);
+	}
+
+	gdesc = kmalloc(max_desc_size, GFP_KERNEL);
+	if (!gdesc)
+		return -ENOMEM;
 
 	nvkm_kmap(wpr_blob);
 
@@ -421,7 +435,6 @@ acr_r352_ls_write_wpr(struct acr_r352 *acr, struct list_head *imgs,
 		struct ls_ucode_img_r352 *img = ls_ucode_img_r352(_img);
 		const struct acr_r352_ls_func *ls_func =
 					    acr->func->ls_func[_img->falcon_id];
-		u8 gdesc[ls_func->bl_desc_size];
 
 		nvkm_gpuobj_memcpy_to(wpr_blob, pos, &img->wpr_header,
 				      sizeof(img->wpr_header));
@@ -447,6 +460,8 @@ acr_r352_ls_write_wpr(struct acr_r352 *acr, struct list_head *imgs,
 
 	nvkm_done(wpr_blob);
 
+	kfree(gdesc);
+
 	return 0;
 }
 
@@ -771,7 +786,11 @@ acr_r352_load(struct nvkm_acr *_acr, struct nvkm_falcon *falcon,
 	struct fw_bl_desc *hsbl_desc;
 	void *bl, *blob_data, *hsbl_code, *hsbl_data;
 	u32 code_size;
-	u8 bl_desc[bl_desc_size];
+	u8 *bl_desc;
+
+	bl_desc = kzalloc(bl_desc_size, GFP_KERNEL);
+	if (!bl_desc)
+		return -ENOMEM;
 
 	/* Find the bootloader descriptor for our blob and copy it */
 	if (blob == acr->load_blob) {
@@ -802,7 +821,6 @@ acr_r352_load(struct nvkm_acr *_acr, struct nvkm_falcon *falcon,
 			      code_size, hsbl_desc->start_tag, 0, false);
 
 	/* Generate the BL header */
-	memset(bl_desc, 0, bl_desc_size);
 	acr->func->generate_hs_bl_desc(load_hdr, bl_desc, offset);
 
 	/*
@@ -811,6 +829,7 @@ acr_r352_load(struct nvkm_acr *_acr, struct nvkm_falcon *falcon,
 	nvkm_falcon_load_dmem(falcon, bl_desc, hsbl_desc->dmem_load_off,
 			      bl_desc_size, 0);
 
+	kfree(bl_desc);
 	return hsbl_desc->start_tag << 8;
 }
 
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r367.c b/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r367.c
index 866877b88797..978ad0790367 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r367.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r367.c
@@ -265,6 +265,19 @@ acr_r367_ls_write_wpr(struct acr_r352 *acr, struct list_head *imgs,
 {
 	struct ls_ucode_img *_img;
 	u32 pos = 0;
+	u32 max_desc_size = 0;
+	u8 *gdesc;
+
+	list_for_each_entry(_img, imgs, node) {
+		const struct acr_r352_ls_func *ls_func =
+					    acr->func->ls_func[_img->falcon_id];
+
+		max_desc_size = max(max_desc_size, ls_func->bl_desc_size);
+	}
+
+	gdesc = kmalloc(max_desc_size, GFP_KERNEL);
+	if (!gdesc)
+		return -ENOMEM;
 
 	nvkm_kmap(wpr_blob);
 
@@ -272,7 +285,6 @@ acr_r367_ls_write_wpr(struct acr_r352 *acr, struct list_head *imgs,
 		struct ls_ucode_img_r367 *img = ls_ucode_img_r367(_img);
 		const struct acr_r352_ls_func *ls_func =
 					    acr->func->ls_func[_img->falcon_id];
-		u8 gdesc[ls_func->bl_desc_size];
 
 		nvkm_gpuobj_memcpy_to(wpr_blob, pos, &img->wpr_header,
 				      sizeof(img->wpr_header));
@@ -298,6 +310,8 @@ acr_r367_ls_write_wpr(struct acr_r352 *acr, struct list_head *imgs,
 
 	nvkm_done(wpr_blob);
 
+	kfree(gdesc);
+
 	return 0;
 }
 
-- 
2.17.0


-- 
Kees Cook
Pixel Security
