Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC987C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1415246E5
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:50:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1415246E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933836AbeFVRuV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 13:50:21 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52948 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932973AbeFVRuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 13:50:20 -0400
Received: by mail-wm0-f65.google.com with SMTP id p126-v6so3020567wmb.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 10:50:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TShafgsBWfn6iGnSCjcwREbbKOPNxuc+JSLFAdF2zMU=;
        b=t2ed7GyaTsm1+E3VGqzPLbtimC4lvmiCel8W5HU7RnJ7yp9tEGK3h9aM5tPVoYaCSQ
         2WtTiVO4I6ldQpydNmupI0yxr8RVv+xSAtf/qgCZ0wFS589EC/2LAL7MDYXMgZIN1eSL
         vBqZLKIMvZXRuL3Jj6pKpYwjIXROhCJZPV4/i4UUbcejb6EBOmKVFpEGHNhLH4PbLmnx
         E2wIFIovvKPqbxBjONSUhfJ3YgTc+Lliethr5OST5xfZFVZHQsmrnXzuTCyQTSkXBOV+
         OLBAfhyHLq7UvaTLnsgLC0zJKWHvkgFX48AkkfNuYvf9MUmWFb2OA5I6VjAiXcFkmjrw
         fDHg==
X-Gm-Message-State: APt69E22Yt3finLMnNYrBdTIs4H8KJxU/lIzTt1ZJhCjjgM0Bo/oa9zg
        dounj7cYc5My+fbbMBRVnYZ5TfnVAjHgIv1aqQ4aswUjpaM=
X-Google-Smtp-Source: ADUXVKJwpchP6KyD33lRgxSLaxymI4KAp16jNa/SCY2QYEN7bVgqsPkKqSRXFanVBezQHnPYJO2RIIySmmCoijcZDlk=
X-Received: by 2002:a1c:8d15:: with SMTP id p21-v6mr2242900wmd.145.1529689819109;
 Fri, 22 Jun 2018 10:50:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:1714:0:0:0:0:0 with HTTP; Fri, 22 Jun 2018 10:50:18
 -0700 (PDT)
In-Reply-To: <20180524172436.GA17738@beast>
References: <20180524172436.GA17738@beast>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Fri, 22 Jun 2018 19:50:18 +0200
Message-ID: <CACO55ttzvFZqUjXNut5n0ENR9e2+N2WfWnKnjfaWgNesspQ9UA@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH] drm/nouveau/secboot/acr: Remove VLA usage
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        nouveau <nouveau@lists.freedesktop.org>,
        Alexandre Courbot <acourbot@nvidia.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 7:24 PM, Kees Cook <keescook@chromium.org> wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this
> allocates the working buffers before starting the writing so it won't
> abort in the middle. This needs an initial walk of the lists to figure
> out how large the buffer should be.
>
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  .../nouveau/nvkm/subdev/secboot/acr_r352.c    | 25 ++++++++++++++++---
>  .../nouveau/nvkm/subdev/secboot/acr_r367.c    | 16 +++++++++++-
>  2 files changed, 37 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c b/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c
> index a721354249ce..d02e183717dc 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c
> @@ -414,6 +414,20 @@ acr_r352_ls_write_wpr(struct acr_r352 *acr, struct list_head *imgs,
>  {
>         struct ls_ucode_img *_img;
>         u32 pos = 0;
> +       u32 max_desc_size = 0;
> +       u8 *gdesc;
> +
> +       /* Figure out how large we need gdesc to be. */
> +       list_for_each_entry(_img, imgs, node) {
> +               const struct acr_r352_ls_func *ls_func =
> +                                           acr->func->ls_func[_img->falcon_id];
> +
> +               max_desc_size = max(max_desc_size, ls_func->bl_desc_size);
> +       }
> +
> +       gdesc = kmalloc(max_desc_size, GFP_KERNEL);
> +       if (!gdesc)
> +               return -ENOMEM;
>
>         nvkm_kmap(wpr_blob);
>
> @@ -421,7 +435,6 @@ acr_r352_ls_write_wpr(struct acr_r352 *acr, struct list_head *imgs,
>                 struct ls_ucode_img_r352 *img = ls_ucode_img_r352(_img);
>                 const struct acr_r352_ls_func *ls_func =
>                                             acr->func->ls_func[_img->falcon_id];
> -               u8 gdesc[ls_func->bl_desc_size];
>

if there are no guarantees that (ls_func->bl_desc_size & 0x4 == 0),
then we need to memset a bit more, because 4 bytes at the time are
actually copied inside nvkm_gpuobj_memcpy_to later in that code, but
the last 4 bytes are only partly memset to 0.

If ls_func->bl_desc_size is always a multiple of 0x4, then it isn't as
important, but still better to be fixed. Or maybe
nvkm_gpuobj_memcpy_to should do that handling and check if the size is
a multiple of 0x4 and otherwise handle that case?

Same is valid for the changes in the r367 file.

>                 nvkm_gpuobj_memcpy_to(wpr_blob, pos, &img->wpr_header,
>                                       sizeof(img->wpr_header));
> @@ -447,6 +460,8 @@ acr_r352_ls_write_wpr(struct acr_r352 *acr, struct list_head *imgs,
>
>         nvkm_done(wpr_blob);
>
> +       kfree(gdesc);
> +
>         return 0;
>  }
>
> @@ -771,7 +786,11 @@ acr_r352_load(struct nvkm_acr *_acr, struct nvkm_falcon *falcon,
>         struct fw_bl_desc *hsbl_desc;
>         void *bl, *blob_data, *hsbl_code, *hsbl_data;
>         u32 code_size;
> -       u8 bl_desc[bl_desc_size];
> +       u8 *bl_desc;
> +
> +       bl_desc = kzalloc(bl_desc_size, GFP_KERNEL);
> +       if (!bl_desc)
> +               return -ENOMEM;
>
>         /* Find the bootloader descriptor for our blob and copy it */
>         if (blob == acr->load_blob) {
> @@ -802,7 +821,6 @@ acr_r352_load(struct nvkm_acr *_acr, struct nvkm_falcon *falcon,
>                               code_size, hsbl_desc->start_tag, 0, false);
>
>         /* Generate the BL header */
> -       memset(bl_desc, 0, bl_desc_size);
>         acr->func->generate_hs_bl_desc(load_hdr, bl_desc, offset);
>
>         /*
> @@ -811,6 +829,7 @@ acr_r352_load(struct nvkm_acr *_acr, struct nvkm_falcon *falcon,
>         nvkm_falcon_load_dmem(falcon, bl_desc, hsbl_desc->dmem_load_off,
>                               bl_desc_size, 0);
>
> +       kfree(bl_desc);
>         return hsbl_desc->start_tag << 8;
>  }
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r367.c b/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r367.c
> index 866877b88797..978ad0790367 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r367.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r367.c
> @@ -265,6 +265,19 @@ acr_r367_ls_write_wpr(struct acr_r352 *acr, struct list_head *imgs,
>  {
>         struct ls_ucode_img *_img;
>         u32 pos = 0;
> +       u32 max_desc_size = 0;
> +       u8 *gdesc;
> +
> +       list_for_each_entry(_img, imgs, node) {
> +               const struct acr_r352_ls_func *ls_func =
> +                                           acr->func->ls_func[_img->falcon_id];
> +
> +               max_desc_size = max(max_desc_size, ls_func->bl_desc_size);
> +       }
> +
> +       gdesc = kmalloc(max_desc_size, GFP_KERNEL);
> +       if (!gdesc)
> +               return -ENOMEM;
>
>         nvkm_kmap(wpr_blob);
>
> @@ -272,7 +285,6 @@ acr_r367_ls_write_wpr(struct acr_r352 *acr, struct list_head *imgs,
>                 struct ls_ucode_img_r367 *img = ls_ucode_img_r367(_img);
>                 const struct acr_r352_ls_func *ls_func =
>                                             acr->func->ls_func[_img->falcon_id];
> -               u8 gdesc[ls_func->bl_desc_size];
>
>                 nvkm_gpuobj_memcpy_to(wpr_blob, pos, &img->wpr_header,
>                                       sizeof(img->wpr_header));
> @@ -298,6 +310,8 @@ acr_r367_ls_write_wpr(struct acr_r352 *acr, struct list_head *imgs,
>
>         nvkm_done(wpr_blob);
>
> +       kfree(gdesc);
> +
>         return 0;
>  }
>
> --
> 2.17.0
>
>
> --
> Kees Cook
> Pixel Security
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau
