Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C1EECE561
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02D332151D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:54:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02D332151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730580AbeISIaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 04:30:24 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12615 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725778AbeISIaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 04:30:24 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [10.3.19.211])
        by Forcepoint Email with ESMTP id 1ED6A7257FD8A;
        Wed, 19 Sep 2018 10:54:38 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.203) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.399.0; Wed, 19 Sep 2018
 10:54:33 +0800
Subject: Re: [PATCH 4/5] scsi: libsas: check the ata device status by
 ata_dev_enabled()
To:     John Garry <john.garry@huawei.com>, <martin.petersen@oracle.com>,
        <jejb@linux.vnet.ibm.com>
References: <20180912082946.34814-1-yanaijie@huawei.com>
 <20180912082946.34814-5-yanaijie@huawei.com>
 <57f8b9fb-3a5b-fda6-5e3c-af23524431f4@huawei.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zhaohongjiang@huawei.com>, <hare@suse.com>,
        <dan.j.williams@intel.com>, <jthumshirn@suse.de>, <hch@lst.de>,
        <huangdaode@hisilicon.com>, <chenxiang66@hisilicon.com>,
        <miaoxie@huawei.com>, Ewan Milne <emilne@redhat.com>,
        Tomas Henzl <thenzl@redhat.com>, <linux-ide@vger.kernel.org>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <5BA1BA68.2050900@huawei.com>
Date:   Wed, 19 Sep 2018 10:54:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <57f8b9fb-3a5b-fda6-5e3c-af23524431f4@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.96.203]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/9/18 21:54, John Garry wrote:
> +
>
> On 12/09/2018 09:29, Jason Yan wrote:
>> When ata device IDENTIFY failed, the ata device status is
>> ATA_DEV_UNKNOWN. The libata reported like:
>>
>> [113518.620433] ata5.00: qc timeout (cmd 0xec)
>> [113518.653646] ata5.00: failed to IDENTIFY (I/O error, err_mask=0x4)
>>
>> But libsas verifies the device status by ata_dev_disabled(), which
>> skiped ATA_DEV_UNKNOWN. This will make libsas think the ata device
>
> /s/skiped/skipped/
>

OK, thanks.

>> probing succeed the device cannot be actually brought up. And even the
>> new bcast of this device will be considered as flutter and will not
>> probe this device again.
>>
>> Change ata_dev_disabled() to !ata_dev_enabled() so that libsas can
>> deal with this if the ata device probe failed. New bcasts can let us
>> try to probe the device again and bring it up if it is fine to
>> IDENTIFY.
>>
>> Tested-by: Zhou Yupeng <zhouyupeng1@huawei.com>
>> Signed-off-by: Jason Yan <yanaijie@huawei.com>
>
> Reviewed-by: John Garry <john.garry@huawei.com>
>
>> CC: John Garry <john.garry@huawei.com>
>> CC: Johannes Thumshirn <jthumshirn@suse.de>
>> CC: Ewan Milne <emilne@redhat.com>
>> CC: Christoph Hellwig <hch@lst.de>
>> CC: Tomas Henzl <thenzl@redhat.com>
>> CC: Dan Williams <dan.j.williams@intel.com>
>> CC: Hannes Reinecke <hare@suse.com>
>> ---
>>  drivers/scsi/libsas/sas_ata.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/scsi/libsas/sas_ata.c
>> b/drivers/scsi/libsas/sas_ata.c
>> index 64a958a99f6a..4f6cdf53e913 100644
>> --- a/drivers/scsi/libsas/sas_ata.c
>> +++ b/drivers/scsi/libsas/sas_ata.c
>> @@ -654,7 +654,7 @@ void sas_probe_sata(struct asd_sas_port *port)
>>          /* if libata could not bring the link up, don't surface
>>           * the device
>>           */
>> -        if (ata_dev_disabled(sas_to_ata_dev(dev)))
>> +        if (!ata_dev_enabled(sas_to_ata_dev(dev)))
>
> I do wonder if ata_dev_disabled() needs to be updated to cover
> ATA_DEV_UNKNOWN also or even instead of this change?
>

We cannot do this now because this will make the ata eh process wrong.

>>              sas_fail_probe(dev, __func__, -ENODEV);
>>      }
>>
>>
>
>
>
> .
>

