Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20779C282D7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 02:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAEAD20881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 02:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729937AbfAaCNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 21:13:19 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:58112 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725535AbfAaCNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 21:13:19 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C77A5ABD00C1C6F8D9BB;
        Thu, 31 Jan 2019 10:13:16 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.203) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.408.0; Thu, 31 Jan 2019
 10:13:10 +0800
Subject: Re: [PATCH v2 6/7] scsi: libsas: reset the phy address if discover
 failed
To:     John Garry <john.garry@huawei.com>, <martin.petersen@oracle.com>,
        <jejb@linux.vnet.ibm.com>
References: <20190130082412.9357-1-yanaijie@huawei.com>
 <20190130082412.9357-7-yanaijie@huawei.com>
 <e6bb5696-b2ad-d546-5571-1e2fe39edb61@huawei.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zhaohongjiang@huawei.com>, <hare@suse.com>,
        <dan.j.williams@intel.com>, <jthumshirn@suse.de>, <hch@lst.de>,
        <huangdaode@hisilicon.com>, <chenxiang66@hisilicon.com>,
        <xiexiuqi@huawei.com>, <tj@kernel.org>, <miaoxie@huawei.com>,
        Xiaofei Tan <tanxiaofei@huawei.com>,
        Ewan Milne <emilne@redhat.com>, Tomas Henzl <thenzl@redhat.com>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <5C5259B4.10005@huawei.com>
Date:   Thu, 31 Jan 2019 10:13:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <e6bb5696-b2ad-d546-5571-1e2fe39edb61@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.96.203]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/1/31 1:36, John Garry wrote:
> On 30/01/2019 08:24, Jason Yan wrote:
>> When we failed to discover the device, the phy address is still kept
>> in ex_phy. So when the next time we revalidate this phy the
>> address and device type is the same, it will be considered as flutter
>> and will not be discovered again. So the device will not be brought up.
>>
>> Fix this by reset the phy address to the initial value. Then
>> in the next revalidation the device will be discovered agian.
>
> Why fail to discover the device? I wonder in which scenario you have
> seen this, such that it is worth rediscovery.
>

The test guys have seen this for several times, especially after LLDD 
changed the logic of lldd_dev_found and may return error now.


>>
>> Tested-by: Chen Liangfei <chenliangfei1@huawei.com>
>> Signed-off-by: Jason Yan <yanaijie@huawei.com>
>> CC: Xiaofei Tan <tanxiaofei@huawei.com>
>> CC: John Garry <john.garry@huawei.com>
>> CC: Johannes Thumshirn <jthumshirn@suse.de>
>> CC: Ewan Milne <emilne@redhat.com>
>> CC: Christoph Hellwig <hch@lst.de>
>> CC: Tomas Henzl <thenzl@redhat.com>
>> CC: Dan Williams <dan.j.williams@intel.com>
>> CC: Hannes Reinecke <hare@suse.com>
>> ---
>>  drivers/scsi/libsas/sas_expander.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/scsi/libsas/sas_expander.c
>> b/drivers/scsi/libsas/sas_expander.c
>> index 6e56ebdc2148..e781941a7088 100644
>> --- a/drivers/scsi/libsas/sas_expander.c
>> +++ b/drivers/scsi/libsas/sas_expander.c
>> @@ -1100,6 +1100,13 @@ static int sas_ex_discover_dev(struct
>> domain_device *dev, int phy_id)
>>                           i, SAS_ADDR(ex->ex_phy[i].attached_sas_addr));
>>              }
>>          }
>> +    } else {
>> +        /* if we failed to discover this device, we have to
>> +         * reset the expander phy attached address so that we
>> +         * will not treat the phy as flutter in the next
>> +         * revalidation
>> +         */
>> +        memset(ex_phy->attached_sas_addr, 0, SAS_ADDR_SIZE);
>>      }
>>
>>      return res;
>>
>
>
>
> .
>

