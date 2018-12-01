Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359D8C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 13:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B9620867
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 13:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pCPWJIJe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1B9620867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbeLBAWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 19:22:43 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33997 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726570AbeLBAWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 19:22:43 -0500
Received: by mail-pl1-f193.google.com with SMTP id w4so4190707plz.1;
        Sat, 01 Dec 2018 05:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TS08+4Db/JdeYMoXNsmYFKyUqNDDPA97R96Y4c/J4zQ=;
        b=pCPWJIJeyYWjk5yH3ETHnUUvM0ueYMbWu7ysPqDCTmOhDqZhldpnW84wQX/aniCpu9
         /atIzrNYAPCO3J2jf6KW3xOUrGaXr3uitSVcbaVqpfv2VN+Fc11aStIju18thuBV8Jx8
         38twF/QjItRptQuOUK7IERypGJ+9EA2I+y0j+gEJflHPDhKNhKMVjtglRlkyvdPmgdrR
         mQrkaBpC/WVW6lqz8njBjv3mOAmcQyqdVG4728oDTdiaP+91EYEXzNqH54Kcjq3q1Fbz
         qmgQiioJULO0yhnhCcpCRyH4io+L7IF7Atqvw66gqFQNvZjIY3zNLK5HDyU1Ri1tPuUR
         OFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TS08+4Db/JdeYMoXNsmYFKyUqNDDPA97R96Y4c/J4zQ=;
        b=gLQAj+tCD7s1dv0mnNMCsZtpKomTwHRZjSjV+6kGMa2B6QrAf8gHJP1iFLHt4ngrNu
         HAizvx+eZQtK+xzR+hU3oTNdMVDJRTlhIdYDa/NixI+O9YBVqcdwOIVYCQwWS7a/3tpC
         kkvRpt/1lhFJX50T1feud2tFZK+wRYIXdqcniiN+O97w4I1c+IyT2oNVo7sJB8EPrGzZ
         JjDaZoB2eLc72Qb/hbk+gpP3MKLGSSVFkQZvurbkduHCeeF1ZOL1cc2+umJiTxUw2Gs/
         Qsar/Pyk5zb7qCQ3HNnWfVAqEDOpD0XEuPc8IX3GpBpqyl+7gnz6i9+h6TKoouyiGf++
         SQ2w==
X-Gm-Message-State: AA+aEWbpmiP6kM4Jw76GB4ZyBbasFgQ4aU1TlRUqLXWmPJy75WscEu02
        thJ3v3s+XBbqEmdvOofsnPFYnwK5kceUJxUpObc=
X-Google-Smtp-Source: AFSGD/V37ONNG3MsSOKQ7ME71mA8AipKPheUsBf2b4aZlEgciyh56UvOEccBfXDXY/C2uAIF8JrspR+XN4FyxjJ67bs=
X-Received: by 2002:a17:902:9f89:: with SMTP id g9mr9392302plq.214.1543669813849;
 Sat, 01 Dec 2018 05:10:13 -0800 (PST)
MIME-Version: 1.0
References: <5bf56248.1c69fb81.21a6e.5a72@mx.google.com>
In-Reply-To: <5bf56248.1c69fb81.21a6e.5a72@mx.google.com>
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Date:   Sat, 1 Dec 2018 18:40:02 +0530
Message-ID: <CAJr6mf11gp9iV=NiFEFyo7kSZfCfMsEySdijem_PhMFEAwqucA@mail.gmail.com>
Subject: Re: [PATCH] scsi/mvsas/mv_init.c: Use dma_zalloc_coherent
To:     jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        jthumshirn@suse.de
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 7:18 PM Sabyasachi Gupta
<sabyasachi.linux@gmail.com> wrote:
>
> Replace dma_alloc_coherent + memset with dma_zalloc_coherent
>
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>

Any comment on this patch?

> ---
>  drivers/scsi/mvsas/mv_init.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
> index 3ac3437..495bddb 100644
> --- a/drivers/scsi/mvsas/mv_init.c
> +++ b/drivers/scsi/mvsas/mv_init.c
> @@ -253,33 +253,29 @@ static int mvs_alloc(struct mvs_info *mvi, struct Scsi_Host *shost)
>         /*
>          * alloc and init our DMA areas
>          */
> -       mvi->tx = dma_alloc_coherent(mvi->dev,
> +       mvi->tx = dma_zalloc_coherent(mvi->dev,
>                                      sizeof(*mvi->tx) * MVS_CHIP_SLOT_SZ,
>                                      &mvi->tx_dma, GFP_KERNEL);
>         if (!mvi->tx)
>                 goto err_out;
> -       memset(mvi->tx, 0, sizeof(*mvi->tx) * MVS_CHIP_SLOT_SZ);
> -       mvi->rx_fis = dma_alloc_coherent(mvi->dev, MVS_RX_FISL_SZ,
> +       mvi->rx_fis = dma_zalloc_coherent(mvi->dev, MVS_RX_FISL_SZ,
>                                          &mvi->rx_fis_dma, GFP_KERNEL);
>         if (!mvi->rx_fis)
>                 goto err_out;
> -       memset(mvi->rx_fis, 0, MVS_RX_FISL_SZ);
>
> -       mvi->rx = dma_alloc_coherent(mvi->dev,
> +       mvi->rx = dma_zalloc_coherent(mvi->dev,
>                                      sizeof(*mvi->rx) * (MVS_RX_RING_SZ + 1),
>                                      &mvi->rx_dma, GFP_KERNEL);
>         if (!mvi->rx)
>                 goto err_out;
> -       memset(mvi->rx, 0, sizeof(*mvi->rx) * (MVS_RX_RING_SZ + 1));
>         mvi->rx[0] = cpu_to_le32(0xfff);
>         mvi->rx_cons = 0xfff;
>
> -       mvi->slot = dma_alloc_coherent(mvi->dev,
> +       mvi->slot = dma_zalloc_coherent(mvi->dev,
>                                        sizeof(*mvi->slot) * slot_nr,
>                                        &mvi->slot_dma, GFP_KERNEL);
>         if (!mvi->slot)
>                 goto err_out;
> -       memset(mvi->slot, 0, sizeof(*mvi->slot) * slot_nr);
>
>         mvi->bulk_buffer = dma_alloc_coherent(mvi->dev,
>                                        TRASH_BUCKET_SIZE,
> --
> 2.7.4
>
