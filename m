Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D049C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 11:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E631E20831
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 11:45:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E631E20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729757AbeKUWTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 17:19:35 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:52387 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727874AbeKUWTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 17:19:35 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DCB43DEDD72F2;
        Wed, 21 Nov 2018 19:45:23 +0800 (CST)
Received: from [127.0.0.1] (10.210.167.253) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Wed, 21 Nov 2018
 19:45:17 +0800
Subject: Re: [PATCH 3/4] scsi: hisi_sas: Make sg_tablesize consistent value
To:     Steffen Maier <maier@linux.ibm.com>, <jejb@linux.vnet.ibm.com>,
        <martin.petersen@oracle.com>
References: <1542725944-244183-1-git-send-email-john.garry@huawei.com>
 <1542725944-244183-4-git-send-email-john.garry@huawei.com>
 <146f7c38-0cd7-a664-31d6-30a27b7a182b@linux.ibm.com>
 <64113584-d9cc-6662-bcde-852ec7957517@linux.ibm.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>,
        Xiang Chen <chenxiang66@hisilicon.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <b4411de6-aba0-4398-e9c0-1c3698ffe1fd@huawei.com>
Date:   Wed, 21 Nov 2018 11:45:10 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <64113584-d9cc-6662-bcde-852ec7957517@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.167.253]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2018 11:08, Steffen Maier wrote:
> On 11/21/2018 12:02 PM, Steffen Maier wrote:
>> On 11/20/2018 03:59 PM, John Garry wrote:
>>> From: Xiang Chen <chenxiang66@hisilicon.com>
>>>
>>> Sht->sg_tablesize is set in the driver, and it will be assigned to
>>> shost->sg_tablesize in SCSI mid-layer. So it is not necessary to
>>> assign shost->sg_table one more time in the driver.
>>>
>>> In addition to the change, change each scsi_host_template.sg_tablesize
>>> to HISI_SAS_SGE_PAGE_CNT instead of SG_ALL.
>>
>> Might be completely irrelevant, so just as information: I once had
>> problems due to changing (reducing) SHT.sg_tablesize because block
>> queue limits of BSG devices of Scsi_Host and fc_host (not sure if you
>> have an equivalent bsg device for your transport(s)) inherit from SHT,
>> but don't update (automatically) on later updates of
>> shost->sg_tablesize, which in turn affect scsi_devices allocated after
>> the shost update.
>> Cf.
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/s390/scsi?id=5fea4291deacd80188b996d2f555fc6a1940e5d4
>
>
> Figured, your new constant seems to have the same value so no problem.
>

Right, so previously we were doing similar to what you describe - 
setting the value in the SHT and then setting shost->sg_tablesize after 
the host is allocated.

However the values were the same, so in this patch we're just removing 
setting shost->sg_tablesize (again).

Thanks,
John

> #define SG_CHUNK_SIZE    128
> #define SG_ALL    SG_CHUNK_SIZE
> #define HISI_SAS_SGE_PAGE_CNT SG_CHUNK_SIZE
>
>> ("[SCSI] zfcp: block queue limits with data router")
>> if you need more details.
>>
>>> Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
>>> Signed-off-by: John Garry <john.garry@huawei.com>
>>> ---
>>>   drivers/scsi/hisi_sas/hisi_sas_main.c  | 1 -
>>>   drivers/scsi/hisi_sas/hisi_sas_v1_hw.c | 2 +-
>>>   drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 2 +-
>>>   drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 3 +--
>>>   4 files changed, 3 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c
>>> b/drivers/scsi/hisi_sas/hisi_sas_main.c
>>> index d13a662..cbda48e 100644
>>> --- a/drivers/scsi/hisi_sas/hisi_sas_main.c
>>> +++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
>>> @@ -2410,7 +2410,6 @@ int hisi_sas_probe(struct platform_device *pdev,
>>>       shost->max_lun = ~0;
>>>       shost->max_channel = 1;
>>>       shost->max_cmd_len = 16;
>>> -    shost->sg_tablesize = min_t(u16, SG_ALL, HISI_SAS_SGE_PAGE_CNT);
>>>       if (hisi_hba->hw->slot_index_alloc) {
>>>           shost->can_queue = hisi_hba->hw->max_command_entries;
>>>           shost->cmd_per_lun = hisi_hba->hw->max_command_entries;
>>> diff --git a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
>>> b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
>>> index d24342b..2d035cc 100644
>>> --- a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
>>> +++ b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
>>> @@ -1815,7 +1815,7 @@ static int hisi_sas_v1_init(struct hisi_hba
>>> *hisi_hba)
>>>       .change_queue_depth    = sas_change_queue_depth,
>>>       .bios_param        = sas_bios_param,
>>>       .this_id        = -1,
>>> -    .sg_tablesize        = SG_ALL,
>>> +    .sg_tablesize        = HISI_SAS_SGE_PAGE_CNT,
>>>       .max_sectors        = SCSI_DEFAULT_MAX_SECTORS,
>>>       .use_clustering        = ENABLE_CLUSTERING,
>>>       .eh_device_reset_handler = sas_eh_device_reset_handler,
>>> diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
>>> b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
>>> index e78a97e..79e58a7 100644
>>> --- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
>>> +++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
>>> @@ -3570,7 +3570,7 @@ struct device_attribute *host_attrs_v2_hw[] = {
>>>       .change_queue_depth    = sas_change_queue_depth,
>>>       .bios_param        = sas_bios_param,
>>>       .this_id        = -1,
>>> -    .sg_tablesize        = SG_ALL,
>>> +    .sg_tablesize        = HISI_SAS_SGE_PAGE_CNT,
>>>       .max_sectors        = SCSI_DEFAULT_MAX_SECTORS,
>>>       .use_clustering        = ENABLE_CLUSTERING,
>>>       .eh_device_reset_handler = sas_eh_device_reset_handler,
>>> diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
>>> b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
>>> index 7e2b020..8a08078 100644
>>> --- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
>>> +++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
>>> @@ -2224,7 +2224,7 @@ struct device_attribute *host_attrs_v3_hw[] = {
>>>       .change_queue_depth    = sas_change_queue_depth,
>>>       .bios_param        = sas_bios_param,
>>>       .this_id        = -1,
>>> -    .sg_tablesize        = SG_ALL,
>>> +    .sg_tablesize        = HISI_SAS_SGE_PAGE_CNT,
>>>       .max_sectors        = SCSI_DEFAULT_MAX_SECTORS,
>>>       .use_clustering        = ENABLE_CLUSTERING,
>>>       .eh_device_reset_handler = sas_eh_device_reset_handler,
>>> @@ -2366,7 +2366,6 @@ struct device_attribute *host_attrs_v3_hw[] = {
>>>       shost->max_lun = ~0;
>>>       shost->max_channel = 1;
>>>       shost->max_cmd_len = 16;
>>> -    shost->sg_tablesize = min_t(u16, SG_ALL, HISI_SAS_SGE_PAGE_CNT);
>>>       shost->can_queue = hisi_hba->hw->max_command_entries -
>>>           HISI_SAS_RESERVED_IPTT_CNT;
>>>       shost->cmd_per_lun = hisi_hba->hw->max_command_entries -
>>>
>>
>>
>
>


