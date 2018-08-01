Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6B3C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 758142083E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:28:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 758142083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388570AbeHAKMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 06:12:34 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33438 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387672AbeHAKMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 06:12:33 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2A5B3CFB3F049;
        Wed,  1 Aug 2018 16:27:57 +0800 (CST)
Received: from [127.0.0.1] (10.74.223.225) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.399.0; Wed, 1 Aug 2018
 16:27:51 +0800
Subject: Re: [PATCH v2] driver/scsi/pmcraid: Use pci_zalloc_consistent instead
 of pci_alloc_consistent+memset
To:     zhong jiang <zhongjiang@huawei.com>, <jejb@linux.vnet.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1533107805-7545-1-git-send-email-zhongjiang@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <eb0a5e82-a67d-4176-12e6-607fb17a4e5d@huawei.com>
Date:   Wed, 1 Aug 2018 16:27:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1533107805-7545-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.74.223.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2018/8/1 15:16, zhong jiang Ð´µÀ:
> Pci_zalloc_consistent is better than pci_alloc_consistent+memset,
> and it make the code concise

Aren't these APIs deprecated:
https://lkml.org/lkml/2018/6/5/381

> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>   drivers/scsi/pmcraid.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/scsi/pmcraid.c b/drivers/scsi/pmcraid.c
> index 4e86994..8a6facc 100644
> --- a/drivers/scsi/pmcraid.c
> +++ b/drivers/scsi/pmcraid.c
> @@ -4736,11 +4736,9 @@ static int pmcraid_allocate_host_rrqs(struct pmcraid_instance *pinstance)
>   	buffer_size = HRRQ_ENTRY_SIZE * PMCRAID_MAX_CMD;
>   
>   	for (i = 0; i < pinstance->num_hrrq; i++) {
> -		pinstance->hrrq_start[i] =
> -			pci_alloc_consistent(
> -					pinstance->pdev,
> -					buffer_size,
> -					&(pinstance->hrrq_start_bus_addr[i]));
> +		pinstance->hrrq_start[i] = pci_zalloc_consistent(pinstance->pdev,
> +								buffer_size,
> +								&(pinstance->hrrq_start_bus_addr[i]));
>   
>   		if (!pinstance->hrrq_start[i]) {
>   			pmcraid_err("pci_alloc failed for hrrq vector : %d\n",
> @@ -4749,7 +4747,6 @@ static int pmcraid_allocate_host_rrqs(struct pmcraid_instance *pinstance)
>   			return -ENOMEM;
>   		}
>   
> -		memset(pinstance->hrrq_start[i], 0, buffer_size);
>   		pinstance->hrrq_curr[i] = pinstance->hrrq_start[i];
>   		pinstance->hrrq_end[i] =
>   			pinstance->hrrq_start[i] + PMCRAID_MAX_CMD - 1;
> 


