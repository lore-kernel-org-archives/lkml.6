Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B27DC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 06:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2083206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 06:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ELhMwX/a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2083206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbeLCGkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 01:40:23 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:38231 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbeLCGkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 01:40:23 -0500
Received: by mail-ed1-f42.google.com with SMTP id h50so9740432ede.5
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 22:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oyfjlwsbUXJvvS1efXF/Ym+ysjrMPchxqkuZ33wJPl4=;
        b=ELhMwX/al/BLeTRruy1/G4yR5Ulvbvr2bNbyIdkLHZwNoi3XKbmAdUXYWPrneBN+fP
         823rV5KtBihjRFhMvuAyLDSUCwVbV6GO4+WMiTBk84XexDN+vNvocOCkqtW9P5CgA3bY
         uyJnNzNTjGekBnqHATHJtQbPrM8HhbZJyEbkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oyfjlwsbUXJvvS1efXF/Ym+ysjrMPchxqkuZ33wJPl4=;
        b=VLhYrS/zdN9e0GPntOjB0Qg71eyZE9/F9Y484r6y23FjUqlMZfp7glJvFzP5yPYwnV
         yB6No+Q0f54loC3K4QmvOsi2wzWeg05qj4dLwnu221naRrQafm1E6/FtUcB445xKKG2W
         jdDSTbgofF93aNn253kTrLsSbIojn7iAmivJKbSVGWY0J0aRcpDufOxuBiLZ6uxykpEB
         ymP5ubx5uPEPNg8i1tvf5ITwJEKeBeEBk3eH35NBOGuZVvv6SBOKmUx2/ppySf+zaJZH
         DCmKHTRX8M0Wmb9TU0ZUbymhaRTVDi1Zh9Cn3SFF0JiUZnYJVHVmpuVXXG+rO+OQRT9V
         ssEQ==
X-Gm-Message-State: AA+aEWboGmx7n7CCyqu+qXfRT7ohMzereFp1cWLGw3Ao8fXaUQgchVhH
        vx/T5J/IsWjeDdGlpCVJoCco4UOkrxB9Li+HJ1Ej2Q==
X-Google-Smtp-Source: AFSGD/V7FGkjaNuF+Df3ZcGlOWvRWMSYDQjVgk47AduxBMEFt62/fRLeGrJ34/2SxZ66hyleYQ6LpcKUCOZY03bdj9Q=
X-Received: by 2002:a17:906:314a:: with SMTP id e10-v6mr11879977eje.227.1543819218179;
 Sun, 02 Dec 2018 22:40:18 -0800 (PST)
MIME-Version: 1.0
References: <1543760930050-1499171309-0-diffsplit-thomas@m3y3r.de> <1543760930052-918941928-10-diffsplit-thomas@m3y3r.de>
In-Reply-To: <1543760930052-918941928-10-diffsplit-thomas@m3y3r.de>
From:   Sumit Saxena <sumit.saxena@broadcom.com>
Date:   Mon, 3 Dec 2018 12:10:07 +0530
Message-ID: <CAL2rwxpYLUWCVSZJNB0_BRh0DXRab9TRVnWsvpkph3GNCOfT7w@mail.gmail.com>
Subject: Re: [PATCH] scsi: megaraid_sas: NULL check before some freeing
 functions is not needed.
To:     thomas@m3y3r.de
Cc:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>,
        "James E. J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        megaraidlinux.pdl@broadcom.com,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 2:25 AM Thomas Meyer <thomas@m3y3r.de> wrote:
>
> NULL check before some freeing functions is not needed.
>
> Signed-off-by: Thomas Meyer <thomas@m3y3r.de>

Acked-by: Sumit Saxena <sumit.saxena@broadcom.com>

> ---
>
> diff -u -p a/drivers/scsi/megaraid/megaraid_mbox.c b/drivers/scsi/megaraid/megaraid_mbox.c
> --- a/drivers/scsi/megaraid/megaraid_mbox.c
> +++ b/drivers/scsi/megaraid/megaraid_mbox.c
> @@ -1243,8 +1243,7 @@ megaraid_mbox_teardown_dma_pools(adapter
>                 dma_pool_free(raid_dev->sg_pool_handle, sg_pci_blk[i].vaddr,
>                         sg_pci_blk[i].dma_addr);
>         }
> -       if (raid_dev->sg_pool_handle)
> -               dma_pool_destroy(raid_dev->sg_pool_handle);
> +       dma_pool_destroy(raid_dev->sg_pool_handle);
>
>
>         epthru_pci_blk = raid_dev->epthru_pool;
> @@ -1252,8 +1251,7 @@ megaraid_mbox_teardown_dma_pools(adapter
>                 dma_pool_free(raid_dev->epthru_pool_handle,
>                         epthru_pci_blk[i].vaddr, epthru_pci_blk[i].dma_addr);
>         }
> -       if (raid_dev->epthru_pool_handle)
> -               dma_pool_destroy(raid_dev->epthru_pool_handle);
> +       dma_pool_destroy(raid_dev->epthru_pool_handle);
>
>
>         mbox_pci_blk = raid_dev->mbox_pool;
> @@ -1261,8 +1259,7 @@ megaraid_mbox_teardown_dma_pools(adapter
>                 dma_pool_free(raid_dev->mbox_pool_handle,
>                         mbox_pci_blk[i].vaddr, mbox_pci_blk[i].dma_addr);
>         }
> -       if (raid_dev->mbox_pool_handle)
> -               dma_pool_destroy(raid_dev->mbox_pool_handle);
> +       dma_pool_destroy(raid_dev->mbox_pool_handle);
>
>         return;
>  }
> diff -u -p a/drivers/scsi/megaraid/megaraid_mm.c b/drivers/scsi/megaraid/megaraid_mm.c
> --- a/drivers/scsi/megaraid/megaraid_mm.c
> +++ b/drivers/scsi/megaraid/megaraid_mm.c
> @@ -1017,8 +1017,7 @@ memalloc_error:
>         kfree(adapter->kioc_list);
>         kfree(adapter->mbox_list);
>
> -       if (adapter->pthru_dma_pool)
> -               dma_pool_destroy(adapter->pthru_dma_pool);
> +       dma_pool_destroy(adapter->pthru_dma_pool);
>
>         kfree(adapter);
>
> diff -u -p a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
> --- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
> +++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
> @@ -807,10 +807,8 @@ megasas_free_rdpq_fusion(struct megasas_
>
>         }
>
> -       if (fusion->reply_frames_desc_pool)
> -               dma_pool_destroy(fusion->reply_frames_desc_pool);
> -       if (fusion->reply_frames_desc_pool_align)
> -               dma_pool_destroy(fusion->reply_frames_desc_pool_align);
> +       dma_pool_destroy(fusion->reply_frames_desc_pool);
> +       dma_pool_destroy(fusion->reply_frames_desc_pool_align);
>
>         if (fusion->rdpq_virt)
>                 dma_free_coherent(&instance->pdev->dev,
> @@ -830,8 +828,7 @@ megasas_free_reply_fusion(struct megasas
>                         fusion->reply_frames_desc[0],
>                         fusion->reply_frames_desc_phys[0]);
>
> -       if (fusion->reply_frames_desc_pool)
> -               dma_pool_destroy(fusion->reply_frames_desc_pool);
> +       dma_pool_destroy(fusion->reply_frames_desc_pool);
>
>  }
>
> @@ -1627,8 +1624,7 @@ static inline void megasas_free_ioc_init
>                                   fusion->ioc_init_cmd->frame,
>                                   fusion->ioc_init_cmd->frame_phys_addr);
>
> -       if (fusion->ioc_init_cmd)
> -               kfree(fusion->ioc_init_cmd);
> +       kfree(fusion->ioc_init_cmd);
>  }
>
>  /**
>
>
