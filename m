Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41658C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7B4120879
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:36:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7B4120879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbeLMNgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 08:36:17 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:16564 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729281AbeLMNgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 08:36:17 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 374E3E39FCCA8;
        Thu, 13 Dec 2018 21:36:09 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Thu, 13 Dec 2018
 21:36:00 +0800
Subject: Re: [PATCH v4 4/5] scsi: hisi_sas: Add support for DIF feature for v3
 hw
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1544103284-100497-1-git-send-email-john.garry@huawei.com>
 <1544103284-100497-5-git-send-email-john.garry@huawei.com>
 <yq1o99qgobi.fsf@oracle.com>
CC:     <jejb@linux.vnet.ibm.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        Xiang Chen <chenxiang66@hisilicon.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <4752be71-f39c-ac55-0e51-36c146108a38@huawei.com>
Date:   Thu, 13 Dec 2018 13:35:56 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <yq1o99qgobi.fsf@oracle.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/12/2018 02:20, Martin K. Petersen wrote:
>
> John,

Hi Martin,

>
>> +static void fill_prot_v3_hw(struct scsi_cmnd *scsi_cmnd,
>> +			    struct hisi_sas_protect_iu_v3_hw *prot)
>> +{
>> +	u8 prot_type = scsi_get_prot_type(scsi_cmnd);
>> +	u8 prot_op = scsi_get_prot_op(scsi_cmnd);
>> +	unsigned int interval = scsi_prot_interval(scsi_cmnd);
>> +	u32 lbrt_chk_val;
>> +
>> +	if (interval == 4096)
>> +		lbrt_chk_val = (u32)(scsi_get_lba(scsi_cmnd) >> 3);
>> +	else
>> +		lbrt_chk_val = (u32)scsi_get_lba(scsi_cmnd);
>
> lbrt_chk_val = t10_pi_ref_tag(scmd->request);
>

ok

> +
>> +	switch (prot_op) {
>> +	case SCSI_PROT_READ_STRIP:
>> +		prot->dw0 |= (T10_RMV_EN_MSK | T10_CHK_EN_MSK);
>> +		prot->lbrtcv = lbrt_chk_val;
>> +		if (prot_type == SCSI_PROT_DIF_TYPE1)
>> +			prot->dw4 |= (0xc << 16);
>> +		else if (prot_type == SCSI_PROT_DIF_TYPE3)
>> +			prot->dw4 |= (0xfc << 16);
>
> We're moving away from prot_type. You should use:
>
> enum scsi_prot_flags {
>         SCSI_PROT_TRANSFER_PI           = 1 << 0,
>         SCSI_PROT_GUARD_CHECK           = 1 << 1,
>         SCSI_PROT_REF_CHECK             = 1 << 2,
>         SCSI_PROT_REF_INCREMENT         = 1 << 3,
>         SCSI_PROT_IP_CHECKSUM           = 1 << 4,
> };

ok

>
> to set your controller flags.
>
> +		if (prot_op == SCSI_PROT_WRITE_INSERT) {
> +			unsigned int interval = scsi_prot_interval(scsi_cmnd);
> +			unsigned int ilog2_interval = ilog2(interval);
> +
> +			len = (task->total_xfer_len >> ilog2_interval) * 8;
>
> scsi_transfer_length(struct scsi_cmnd *scmd)

ok

>
>> +	if (hisi_hba->enable_dif) {
>> +		dev_info(dev, "Registering for DIF type 1/2/3 protection.\n");
>> +		prot |=	SHOST_DIF_TYPE1_PROTECTION |
>> +			SHOST_DIF_TYPE2_PROTECTION |
>> +			SHOST_DIF_TYPE3_PROTECTION;
>> +	}
>> +
>> +	scsi_host_set_prot(hisi_hba->shost, prot);
>
> I'm not so keen on this enable_dif/enable_dix business in module
> parameters. I suggest you just allow the user to specify the host
> protection mask instead of having a layer of indirection.
>

Fine, we can let the user select the mask. However, for now, I would 
like to keep default at off. When soaks a bit, we can make default on @ 0x7.

Cheers,
John


