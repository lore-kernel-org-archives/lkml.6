Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77293C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B892208FA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:18:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B892208FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731220AbeHWMrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:47:25 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11599 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730128AbeHWMrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:47:25 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 35D2DA5FA845B;
        Thu, 23 Aug 2018 17:18:34 +0800 (CST)
Received: from [127.0.0.1] (10.74.219.194) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.399.0; Thu, 23 Aug 2018
 17:18:27 +0800
Subject: Re: [PATCH plinth/topic-sas-4.18] {topost} scsi: hisi_sas: send HARD
 RESET to clear the previous affiliation of STP target port when init device
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
References: <1535011127-110586-1-git-send-email-chenxiang66@hisilicon.com>
CC:     <linuxarm@huawei.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <john.garry@huawei.com>
From:   "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <985900b4-535c-2bb3-65db-033d3b623cbe@hisilicon.com>
Date:   Thu, 23 Aug 2018 17:18:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <1535011127-110586-1-git-send-email-chenxiang66@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.74.219.194]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, sent the wrong mail list and  please ignore the patch.

在 2018/8/23 15:58, c00284940 写道:
> If exchange SAS expander from one SAS controller to other SAS controller
> without power down, the STP target port will maintain previous affiliation and
> reject all subsequent connection requests from other STP initiator ports
> with OPEN_REJECT (STP RESOURCES BUSY).
>
> To solve this issue, send HARD RESET to clear the previous affiliation of
> STP target port according to SPL(chapter 6.19.4).
>
> Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
> ---
>   drivers/scsi/hisi_sas/hisi_sas_main.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
> index bb0fa24..9225138 100644
> --- a/drivers/scsi/hisi_sas/hisi_sas_main.c
> +++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
> @@ -612,6 +612,7 @@ static int hisi_sas_init_device(struct domain_device *device)
>   	struct hisi_sas_tmf_task tmf_task;
>   	int retry = HISI_SAS_SRST_ATA_DISK_CNT;
>   	struct hisi_hba *hisi_hba = dev_to_hisi_hba(device);
> +	struct sas_phy *local_phy;
>   
>   	switch (device->dev_type) {
>   	case SAS_END_DEVICE:
> @@ -627,6 +628,14 @@ static int hisi_sas_init_device(struct domain_device *device)
>   	case SAS_SATA_PM:
>   	case SAS_SATA_PM_PORT:
>   	case SAS_SATA_PENDING:
> +		/*
> +		 * send HARD RESET to clear previous affiliation of
> +		 * STP target port
> +		 */
> +		local_phy = sas_get_local_phy(device);
> +		if (!scsi_is_sas_phy_local(local_phy))
> +			sas_phy_reset(local_phy, 1);
> +		sas_put_local_phy(local_phy);
>   		while (retry-- > 0) {
>   			rc = hisi_sas_softreset_ata_disk(device);
>   			if (!rc)


