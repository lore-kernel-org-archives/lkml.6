Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDF1C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 822A620870
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbfAaJBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 04:01:06 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3254 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725787AbfAaJBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 04:01:06 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C3373141C5C0E960690E;
        Thu, 31 Jan 2019 17:01:03 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.43) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.408.0; Thu, 31 Jan 2019
 17:00:57 +0800
Subject: Re: [PATCH v2 1/7] scsi: libsas: reset the negotiated_linkrate when
 phy is down
To:     Jason Yan <yanaijie@huawei.com>, <martin.petersen@oracle.com>,
        <jejb@linux.vnet.ibm.com>
References: <20190130082412.9357-1-yanaijie@huawei.com>
 <20190130082412.9357-2-yanaijie@huawei.com>
 <6b06f81e-9ede-014d-b678-1996044106e3@huawei.com>
 <5C524B3B.5030007@huawei.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zhaohongjiang@huawei.com>, <hare@suse.com>,
        <dan.j.williams@intel.com>, <jthumshirn@suse.de>, <hch@lst.de>,
        <huangdaode@hisilicon.com>, <chenxiang66@hisilicon.com>,
        <xiexiuqi@huawei.com>, <tj@kernel.org>, <miaoxie@huawei.com>,
        Ewan Milne <emilne@redhat.com>, Tomas Henzl <thenzl@redhat.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <21c9fcdb-b0ce-6205-d53a-12ff68b0a5f7@huawei.com>
Date:   Thu, 31 Jan 2019 09:00:47 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <5C524B3B.5030007@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.43]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/01/2019 01:11, Jason Yan wrote:
>
>
> On 2019/1/30 21:08, John Garry wrote:
>> On 30/01/2019 08:24, Jason Yan wrote:
>>> If the device is unplugged or disconnected, the negotiated_linkrate
>>> still can be seen from the userspace by sysfs. This makes people
>>> confused and leaks information of the device last used. So let's reset
>>> the negotiated_linkrate after the phy is down.
>>>
>>> Signed-off-by: Jason Yan <yanaijie@huawei.com>
>>> CC: John Garry <john.garry@huawei.com>
>>> CC: Johannes Thumshirn <jthumshirn@suse.de>
>>> CC: Ewan Milne <emilne@redhat.com>
>>> CC: Christoph Hellwig <hch@lst.de>
>>> CC: Tomas Henzl <thenzl@redhat.com>
>>> CC: Dan Williams <dan.j.williams@intel.com>
>>> CC: Hannes Reinecke <hare@suse.com>
>>> ---
>>>  drivers/scsi/libsas/sas_expander.c | 2 ++
>>>  include/scsi/libsas.h              | 3 +++
>>>  2 files changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/scsi/libsas/sas_expander.c
>>> b/drivers/scsi/libsas/sas_expander.c
>>> index 17eb4185f29d..7b0e6dcef6e6 100644
>>> --- a/drivers/scsi/libsas/sas_expander.c
>>> +++ b/drivers/scsi/libsas/sas_expander.c
>>> @@ -1904,6 +1904,8 @@ static void sas_unregister_devs_sas_addr(struct
>>> domain_device *parent,
>>>                  &parent->port->sas_port_del_list);
>>>          phy->port = NULL;
>>>      }
>>> +    if (phy->phy)
>>> +        phy->phy->negotiated_linkrate = SAS_LINK_RATE_UNKNOWN;
>>
>> Does this work for both PHYs which were either directly attached or just
>> forming part of a wideport?
>>
>> Please also note that the expander PHY which was previously attached may
>> also show the incorrect value.
>
> Good catch, all PHYs need to do this, not only the last PHY of the
> wideport.

Please also consider this:
- For the expander host PHY, it will also go down. I find however on my 
system that this generates no broadcast event, but the I find that the 
event count has changed for that PHY. So the expander PHY's state would 
also be wrong.  So maybe we need to yet again inject a broadcast.

- we should update PHY sysfs entries for device_type, sas_addr, and 
target protocols

>
>>
>>>  }
>>>
>>>  static int sas_discover_bfs_by_root_level(struct domain_device *root,
>>> diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
>>> index 3de3b10da19a..420156cea3ee 100644
>>> --- a/include/scsi/libsas.h
>>> +++ b/include/scsi/libsas.h
>>> @@ -448,6 +448,9 @@ static inline void sas_phy_disconnected(struct
>>> asd_sas_phy *phy)
>>>  {
>>>      phy->oob_mode = OOB_NOT_CONNECTED;
>>>      phy->linkrate = SAS_LINK_RATE_UNKNOWN;
>>> +
>>
>> Then idea behind sas_phy_disconnected() was to set root PHY values only:
>>
>> /* Before calling a notify event, LLDD should use this function
>>   * when the link is severed (possibly from its tasklet).
>>   * The idea is that the Class only reads those, while the LLDD,
>>   * can R/W these (thus avoiding a race)
>>
>> libsas does set sas_phy negotiated_linkrate (but only for expander
>> PHYs), so not the perfect place to set this. I'm nitpicking a bit here.
>>
>
> I don't want to put it here. I asked chenxiang to fix this in LLDD, but
> he insist libsas to do this. Would you please discuss with chenxiang and
> come to an agreement?

I'm ok with the LLDD.

For sure, adding it here is convenient and would resolve the issue for 
other LLDDs using libsas, but setting it directly in the LLDD seems like 
the right thing to do, since this is what we do for other sas_phy rates.

>
>>
>>> +    if (phy->phy)
>>> +        phy->phy->negotiated_linkrate = SAS_LINK_RATE_UNKNOWN;
>>>  }
>>>
>>>  static inline unsigned int to_sas_gpio_od(int device, int bit)
>>
>> Thanks,
>>
>>>
>>
>>
>>
>>
>>
>> .
>>
>
>
> .
>


