Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6F3C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34E7E2098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:33:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34E7E2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbeJSAe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 20:34:56 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57992 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727473AbeJSAe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 20:34:56 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DD066445471F1;
        Fri, 19 Oct 2018 00:33:05 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.399.0; Fri, 19 Oct 2018
 00:33:05 +0800
Subject: Re: [PATCH] scsi/mvsas/mv_sas.c: Use dma_pool_zalloc
To:     Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>,
        <keescook@chromium.org>, <jinpu.wang@profitbricks.com>
References: <5bc8af85.1c69fb81.3eebc.a22b@mx.google.com>
CC:     <jrdr.linux@gmail.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <brajeswar.linux@gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <28cb824f-28b9-8144-4bea-c4dd33b3b80b@huawei.com>
Date:   Thu, 18 Oct 2018 17:32:59 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <5bc8af85.1c69fb81.3eebc.a22b@mx.google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/10/2018 17:06, Sabyasachi Gupta wrote:
> Replaced dma_pool_alloc + memset with dma_pool_zalloc
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> ---
>  drivers/scsi/mvsas/mv_sas.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/scsi/mvsas/mv_sas.c b/drivers/scsi/mvsas/mv_sas.c
> index cff43bd..d00d37d 100644
> --- a/drivers/scsi/mvsas/mv_sas.c
> +++ b/drivers/scsi/mvsas/mv_sas.c
> @@ -790,12 +790,11 @@ static int mvs_task_prep(struct sas_task *task, struct mvs_info *mvi, int is_tmf
>  	slot->n_elem = n_elem;
>  	slot->slot_tag = tag;
>
> -	slot->buf = dma_pool_alloc(mvi->dma_pool, GFP_ATOMIC, &slot->buf_dma);
> +	slot->buf = dma_pool_zalloc(mvi->dma_pool, GFP_ATOMIC, &slot->buf_dma);
>  	if (!slot->buf) {
>  		rc = -ENOMEM;
>  		goto err_out_tag;
>  	}
> -	memset(slot->buf, 0, MVS_SLOT_BUF_SZ);
>

How about also fixing these, below, up to use dma_zalloc_coherent() or 
even dmam_alloc_coherent() [as they're manually free'd at removal]:

static int mvs_alloc(struct mvs_info *mvi, struct Scsi_Host *shost)
{
     int i = 0, slot_nr;
     char pool_name[32];
...
     /*
      * alloc and init our DMA areas
      */
     mvi->tx = dma_alloc_coherent(mvi->dev,
                      sizeof(*mvi->tx) * MVS_CHIP_SLOT_SZ,
                      &mvi->tx_dma, GFP_KERNEL);
     if (!mvi->tx)
         goto err_out;
     memset(mvi->tx, 0, sizeof(*mvi->tx) * MVS_CHIP_SLOT_SZ);

...

Thanks,
John

>  	tei.task = task;
>  	tei.hdr = &mvi->slot[tag];
>


