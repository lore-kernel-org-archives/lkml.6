Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0029ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 12:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69E112150D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 12:49:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69E112150D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbeJQUp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 16:45:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:34078 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726936AbeJQUp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 16:45:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 872D9ACBC;
        Wed, 17 Oct 2018 12:49:51 +0000 (UTC)
Subject: Re: [PATCH -next] advansys: remove set but not used variable
 'srb_tag' in adv_isr_callback
To:     YueHaibing <yuehaibing@huawei.com>, willy@infradead.org,
        hare@suse.com, jejb@linux.vnet.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20181017123432.18304-1-yuehaibing@huawei.com>
From:   Johannes Thumshirn <jthumshirn@suse.de>
Message-ID: <4950b4fe-61b5-e1c3-9d16-7643107857a5@suse.de>
Date:   Wed, 17 Oct 2018 14:49:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181017123432.18304-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/10/18 14:34, YueHaibing wrote:
> drivers/scsi/advansys.c: In function 'adv_isr_callback':
> drivers/scsi/advansys.c:5952:6: warning:
>  variable 'srb_tag' set but not used [-Wunused-but-set-variable]
> 
> It never used since introduction in
> commit 9c17c62aedb0 ("advansys: use shared host tag map for command lookup")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/scsi/advansys.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/scsi/advansys.c b/drivers/scsi/advansys.c
> index 44c9619..223ef6f 100644
> --- a/drivers/scsi/advansys.c
> +++ b/drivers/scsi/advansys.c
> @@ -5949,7 +5949,6 @@ static void adv_async_callback(ADV_DVC_VAR *adv_dvc_varp, uchar code)
>  static void adv_isr_callback(ADV_DVC_VAR *adv_dvc_varp, ADV_SCSI_REQ_Q *scsiqp)
>  {
>  	struct asc_board *boardp = adv_dvc_varp->drv_ptr;
> -	u32 srb_tag;
>  	adv_req_t *reqp;
>  	adv_sgblk_t *sgblkp;
>  	struct scsi_cmnd *scp;
> @@ -5965,7 +5964,6 @@ static void adv_isr_callback(ADV_DVC_VAR *adv_dvc_varp, ADV_SCSI_REQ_Q *scsiqp)
>  	 * completed. The adv_req_t structure actually contains the
>  	 * completed ADV_SCSI_REQ_Q structure.
>  	 */
> -	srb_tag = le32_to_cpu(scsiqp->srb_tag);
>  	scp = scsi_host_find_tag(boardp->shost, scsiqp->srb_tag);

Shouldn't this be:
	scp = scsi_host_find_tag(boardp->shost,
					le32_to_cpu(scsiqp->srb_tag));


-- 
Johannes Thumshirn                                        SUSE Labs
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
