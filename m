Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B57C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 20:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0033320657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 20:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gFoPsA7g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0033320657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbeKBGAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 02:00:05 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:44044 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbeKBGAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 02:00:05 -0400
Received: by mail-yw1-f66.google.com with SMTP id k6-v6so4090785ywa.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 13:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1wP/Xfy/XV3ldruX28dzc594xnK+OniBjmyYFbWOPUM=;
        b=gFoPsA7gh/xOIhfq68xltE1tQVijJHtJJZxSfM6eQ9pxFHWGGrEC3ynptixcqExjaF
         Ln8Dgsw+W4FRrBXgmr9rKjl3lUyyIeFFwrQZw5fcX4edorfZcvMUzvsiT4NfAay6NKp9
         RAlmQCFp0OMLCG/6As+GpKXoTSDRjyyUcdz40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1wP/Xfy/XV3ldruX28dzc594xnK+OniBjmyYFbWOPUM=;
        b=GdnmGcIlxavXq2vXcpkvBWXmAtl1n21fzoUgVEWx7t4vzaKQcmKqqF6nDhUPNlrY20
         M1Ibqu0OQ8M6cam5S2cEP1i5RP0cD+aCtULVRmzE6tavOcqfekKvwO1VVrgc9RblbEqL
         yZPAOe4kXBAeaW0khtrZ5Xb8bY59LuKxCbIHTuITVp/cOuqWzf7aeur71PUjfM3vj3OR
         FCcSOhKfMKhFOoomrQFIWMEL+7+wyL6XwBFBRhomdBsRs3TYI7bo1OEUMNFi8+aLxZSi
         BIm4q96W0wZbI/EtbjNs9fyEErJ7dkJ+CvZsExUV6vpOBi3T7FgXw4tf19zlk6xcRCQg
         Rp/g==
X-Gm-Message-State: AGRZ1gJAaKx5D6ReFZo+GUeGo9/SV1uKdtoU+I2mVQvOFcKiis0II5Np
        rDlI/ncHUBTEgGIN0LDyFL2hfGymv+U=
X-Google-Smtp-Source: AJdET5d04kOYgW+kumkoTpFjB8h4xaQcM6LGnlIZc78KeCO1Q+njIIbgGsZcHeEvyHaljOmsa06fMQ==
X-Received: by 2002:a81:e807:: with SMTP id a7-v6mr9295214ywm.9.1541105728820;
        Thu, 01 Nov 2018 13:55:28 -0700 (PDT)
Received: from mail-yw1-f46.google.com (mail-yw1-f46.google.com. [209.85.161.46])
        by smtp.gmail.com with ESMTPSA id v3-v6sm4495663ywd.106.2018.11.01.13.55.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 13:55:27 -0700 (PDT)
Received: by mail-yw1-f46.google.com with SMTP id j75-v6so8468540ywj.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 13:55:27 -0700 (PDT)
X-Received: by 2002:a81:2953:: with SMTP id p80-v6mr9238030ywp.407.1541105726656;
 Thu, 01 Nov 2018 13:55:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3990:0:0:0:0:0 with HTTP; Thu, 1 Nov 2018 13:55:25 -0700 (PDT)
In-Reply-To: <20181101041909.GA3241@jordon-HP-15-Notebook-PC>
References: <20181101041909.GA3241@jordon-HP-15-Notebook-PC>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 1 Nov 2018 13:55:25 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLYaT7LtUS+t98GjMjjzz2kbs6JZ_WJRYnWo7iZ9nOFKQ@mail.gmail.com>
Message-ID: <CAGXu5jLYaT7LtUS+t98GjMjjzz2kbs6JZ_WJRYnWo7iZ9nOFKQ@mail.gmail.com>
Subject: Re: [PATCH] scsi/aic94xx/aic94xx_hwi.c: Use dma_pool_zalloc
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        brajeswar.linux@gmail.com, sabyasachi.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 9:19 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> Replaced dma_pool_alloc + memset with dma_pool_zalloc
>
> Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/scsi/aic94xx/aic94xx_hwi.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/scsi/aic94xx/aic94xx_hwi.c b/drivers/scsi/aic94xx/aic94xx_hwi.c
> index 3b8ad55e59de..2bc7615193bd 100644
> --- a/drivers/scsi/aic94xx/aic94xx_hwi.c
> +++ b/drivers/scsi/aic94xx/aic94xx_hwi.c
> @@ -1057,14 +1057,13 @@ static struct asd_ascb *asd_ascb_alloc(struct asd_ha_struct *asd_ha,
>
>         if (ascb) {
>                 ascb->dma_scb.size = sizeof(struct scb);
> -               ascb->dma_scb.vaddr = dma_pool_alloc(asd_ha->scb_pool,
> +               ascb->dma_scb.vaddr = dma_pool_zalloc(asd_ha->scb_pool,
>                                                      gfp_flags,
>                                                     &ascb->dma_scb.dma_handle);
>                 if (!ascb->dma_scb.vaddr) {
>                         kmem_cache_free(asd_ascb_cache, ascb);
>                         return NULL;
>                 }
> -               memset(ascb->dma_scb.vaddr, 0, sizeof(struct scb));
>                 asd_init_ascb(asd_ha, ascb);
>
>                 spin_lock_irqsave(&seq->tc_index_lock, flags);
> --
> 2.17.1
>



-- 
Kees Cook
