Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16EDC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 06:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44BF8213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 06:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JAx69Uxv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44BF8213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbeJINR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 09:17:29 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37941 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbeJINR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 09:17:28 -0400
Received: by mail-qk1-f194.google.com with SMTP id 204-v6so224989qkd.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 23:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3SLIBPQsVlrbvwJAtFMOmHoQs2/gPevoFLwyhcp/6ww=;
        b=JAx69Uxv7esMTA79ZYuDC1RNJWX8vMmRWHhZEhG+hoEurMIvw5NqJt5xgACAKi8JDU
         9zgGXVayQBup283+E5/9m5o67kXBkaQ5no/2RcWDzvQNkA4XDl+j905OhA532L3FItWk
         65C/hAYcu1ZUl+vjppwrhzlVdvppod2G4gtyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3SLIBPQsVlrbvwJAtFMOmHoQs2/gPevoFLwyhcp/6ww=;
        b=rt5sEptSGP9CuQ7uTlNsjsiha7KWyPiioPh6ePnlTnNk1RPg+jBf9z9TtyXCpu84TG
         nLQTqfy5VW2lPjY6ExzH2oZND9R3TwL706LqAnfZJGKWVLHWxgEl2gfygJlBkEWhN8T2
         hXOEhfzz3rjd5McNCaBrmshvOVDd53GpwZNWew1NRCdU/KpAZFlL60cC1/rynhwLYyW3
         y0loSGEYZeMFXWd8UoQ051X5qBaPLDWyeKOQ0/GMWtqPJSddpDkPb/rko1aeWzy2XAub
         Kbz7lGe+zcY2eNb6R2sXNG3HDGIhZonlAXBML+KBqcrHkY6m0GCCyfqDgoAFCoFfgjaH
         MV+Q==
X-Gm-Message-State: ABuFfog1alXhFkSkXYMG6bN8UOeLog302o8jd/YU6t78/LbJjYbq3NND
        3cVzMB05w1hEDRneyGuFnOI3lTL2DQ3FKde04Da6Tg==
X-Google-Smtp-Source: ACcGV61+GwHZZJQkeTsPNv+v2JJWesw3vDfQ5glYG+G/9VwO4ow7wYRCL/ZA8D7l/vEVJ9/UuCi4KEuwVCQGTfrgd8I=
X-Received: by 2002:ae9:ed82:: with SMTP id c124-v6mr20970620qkg.264.1539064932371;
 Mon, 08 Oct 2018 23:02:12 -0700 (PDT)
MIME-Version: 1.0
References: <20181002054804.GA11315@jordon-HP-15-Notebook-PC>
In-Reply-To: <20181002054804.GA11315@jordon-HP-15-Notebook-PC>
From:   Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Date:   Tue, 9 Oct 2018 11:32:45 +0530
Message-ID: <CA+RiK643GtCGGgivSZbS=DxU7DveqHjZFhZh9+PNoVUAyFmOLQ@mail.gmail.com>
Subject: Re: [PATCH] scsi/mpt3sas: Use dma_pool_zalloc
To:     jrdr.linux@gmail.com
Cc:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra Basappa <chaitra.basappa@broadcom.com>,
        jejb@linux.vnet.ibm.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        brajeswar.linux@gmail.com,
        PDL-MPT-FUSIONLINUX <MPT-FusionLinux.pdl@broadcom.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,
Please consider this patch as Acked-by: Suganath Prabu
<suganath-prabu.subramani@broadcom.com>

Thanks

On Tue, Oct 2, 2018 at 11:14 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> Replaced dma_pool_alloc + memset with dma_pool_zalloc.
>
> Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
>  drivers/scsi/mpt3sas/mpt3sas_base.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
> index 59d7844..d7ef671 100644
> --- a/drivers/scsi/mpt3sas/mpt3sas_base.c
> +++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
> @@ -4516,7 +4516,7 @@ void mpt3sas_base_clear_st(struct MPT3SAS_ADAPTER *ioc,
>         i = 0;
>         do {
>                 ioc->reply_post[i].reply_post_free =
> -                   dma_pool_alloc(ioc->reply_post_free_dma_pool,
> +                   dma_pool_zalloc(ioc->reply_post_free_dma_pool,
>                     GFP_KERNEL,
>                     &ioc->reply_post[i].reply_post_free_dma);
>                 if (!ioc->reply_post[i].reply_post_free) {
> @@ -4525,7 +4525,6 @@ void mpt3sas_base_clear_st(struct MPT3SAS_ADAPTER *ioc,
>                         ioc->name);
>                         goto out;
>                 }
> -               memset(ioc->reply_post[i].reply_post_free, 0, sz);
>                 dinitprintk(ioc, pr_info(MPT3SAS_FMT
>                     "reply post free pool (0x%p): depth(%d),"
>                     "element_size(%d), pool_size(%d kB)\n", ioc->name,
> @@ -4852,14 +4851,13 @@ void mpt3sas_base_clear_st(struct MPT3SAS_ADAPTER *ioc,
>                         ioc->name);
>                 goto out;
>         }
> -       ioc->reply_free = dma_pool_alloc(ioc->reply_free_dma_pool, GFP_KERNEL,
> +       ioc->reply_free = dma_pool_zalloc(ioc->reply_free_dma_pool, GFP_KERNEL,
>             &ioc->reply_free_dma);
>         if (!ioc->reply_free) {
>                 pr_err(MPT3SAS_FMT "reply_free pool: dma_pool_alloc failed\n",
>                         ioc->name);
>                 goto out;
>         }
> -       memset(ioc->reply_free, 0, sz);
>         dinitprintk(ioc, pr_info(MPT3SAS_FMT "reply_free pool(0x%p): " \
>             "depth(%d), element_size(%d), pool_size(%d kB)\n", ioc->name,
>             ioc->reply_free, ioc->reply_free_queue_depth, 4, sz/1024));
> --
> 1.9.1
>
