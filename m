Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22651C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8A082077C
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:12:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8A082077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733287AbeKOBQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:16:03 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:14661 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732485AbeKOBQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 20:16:03 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BFD3F13864A30;
        Wed, 14 Nov 2018 23:12:17 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.408.0; Wed, 14 Nov 2018
 23:12:11 +0800
Subject: Re: [PATCH 4/5] scsi: libsas: Drop SAS_DPRINTK() and revise logs
 levels
To:     Joe Perches <joe@perches.com>, <jejb@linux.vnet.ibm.com>,
        <martin.petersen@oracle.com>
References: <1542203269-174932-1-git-send-email-john.garry@huawei.com>
 <1542203269-174932-5-git-send-email-john.garry@huawei.com>
 <132ba0c903b36d85db30cfebf58fe1f4c3a7c05b.camel@perches.com>
CC:     <hare@suse.com>, <yanaijie@huawei.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <6c453baa-71bb-5fe0-28a1-5af097f2e9ae@huawei.com>
Date:   Wed, 14 Nov 2018 15:12:06 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <132ba0c903b36d85db30cfebf58fe1f4c3a7c05b.camel@perches.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/11/2018 14:53, Joe Perches wrote:
> On Wed, 2018-11-14 at 21:47 +0800, John Garry wrote:
>> Like sas_printk() did previously, SAS_DPRINTK() offers little value now
>> that libsas logs already have the "sas" prefix through pr_fmt(fmt). So it
>> can be dropped.
>>
>> However, after reviewing some logs in libsas, it is noticed that debug
>> level is too low in many instances.
>>
>> So this change drops SAS_DPRINTK() and revises some logs to a more
>> appropriate level. However many stay at debug level, although some
>> are significantly promoted.
> []
>> All the pre-existing checkpatch errors for spanning messages across
>> multiple lines are untouched.
>
> I think coalescing would be useful.

Sorry, I missed that. Do you mean that we stop spanning strings over 
multiple lines?

If yes, I tend to agree. It means we can grep for full strings vs just a 
different checkpatch issue (>80 lines or spanning multiple lines)

>
> Where there are already embedded "sas: "
> prefixes, those should be removed too.

Ah, I missed that guy. File sas_ata.c may also have some.

>
> You could verify this by using
>
> 	$ strings drivers/scsi/libsas/*.o | grep "^[0-7]"
>
>> @@ -186,10 +186,10 @@ int sas_notify_lldd_dev_found(struct domain_device *dev)
>>
>>  	res = i->dft->lldd_dev_found(dev);
>>  	if (res) {
>> -		printk("sas: driver on pcidev %s cannot handle "
>> -		       "device %llx, error:%d\n",
>> -		       dev_name(sas_ha->dev),
>> -		       SAS_ADDR(dev->sas_addr), res);
>> +		pr_warn("sas: driver on pcidev %s cannot handle "
>> +			"device %llx, error:%d\n",
>> +			dev_name(sas_ha->dev),
>> +			SAS_ADDR(dev->sas_addr), res);
>
> e.g.: this now emits "sas: sas: driver etc..."
>
>

Cheers,
John

>
> .
>


