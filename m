Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D6CC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 07:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CC5420841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 07:26:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CC5420841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387499AbeHAJLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 05:11:06 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10164 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733219AbeHAJLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 05:11:06 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6E5139E745CAD;
        Wed,  1 Aug 2018 15:26:44 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.399.0; Wed, 1 Aug 2018
 15:26:42 +0800
Message-ID: <5B6160B0.1020403@huawei.com>
Date:   Wed, 1 Aug 2018 15:26:40 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] driver/scsi/pmcraid: Use pci_zalloc_consistent instead
 of pci_alloc_consistent+memset
References: <1533107309-7073-1-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1533107309-7073-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ignore this ,  Will repost.
On 2018/8/1 15:08, zhong jiang wrote:
> Pci_alloc_consistent+memset is better than pci_alloc_consistent+memset,
> and it make the code concise
>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/scsi/pmcraid.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/scsi/pmcraid.c b/drivers/scsi/pmcraid.c
> index 4e86994..8a6facc 100644
> --- a/drivers/scsi/pmcraid.c
> +++ b/drivers/scsi/pmcraid.c
> @@ -4736,11 +4736,9 @@ static int pmcraid_allocate_host_rrqs(struct pmcraid_instance *pinstance)
>  	buffer_size = HRRQ_ENTRY_SIZE * PMCRAID_MAX_CMD;
>  
>  	for (i = 0; i < pinstance->num_hrrq; i++) {
> -		pinstance->hrrq_start[i] =
> -			pci_alloc_consistent(
> -					pinstance->pdev,
> -					buffer_size,
> -					&(pinstance->hrrq_start_bus_addr[i]));
> +		pinstance->hrrq_start[i] = pci_zalloc_consistent(pinstance->pdev,
> +								buffer_size,
> +								&(pinstance->hrrq_start_bus_addr[i]));
>  
>  		if (!pinstance->hrrq_start[i]) {
>  			pmcraid_err("pci_alloc failed for hrrq vector : %d\n",
> @@ -4749,7 +4747,6 @@ static int pmcraid_allocate_host_rrqs(struct pmcraid_instance *pinstance)
>  			return -ENOMEM;
>  		}
>  
> -		memset(pinstance->hrrq_start[i], 0, buffer_size);
>  		pinstance->hrrq_curr[i] = pinstance->hrrq_start[i];
>  		pinstance->hrrq_end[i] =
>  			pinstance->hrrq_start[i] + PMCRAID_MAX_CMD - 1;


