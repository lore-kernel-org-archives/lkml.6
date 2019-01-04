Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68795C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 06:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A4F12070D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 06:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfADGJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 01:09:04 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:17080 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726093AbfADGJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 01:09:04 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 12BB7706BA5B5;
        Fri,  4 Jan 2019 14:09:01 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.408.0; Fri, 4 Jan 2019
 14:08:59 +0800
Subject: Re: [PATCH -next] IB/qib: Add missing err handle for
 qib_user_sdma_rb_insert
To:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20181221021938.13784-1-yuehaibing@huawei.com>
 <20190102171224.GA26765@ziepe.ca> <20190102184050.GI5424@mtr-leonro.mtl.com>
 <20190102190740.GH26211@ziepe.ca> <20190102192211.GJ5424@mtr-leonro.mtl.com>
CC:     <dennis.dalessandro@intel.com>, <mike.marciniszyn@intel.com>,
        <dledford@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <ca55a85f-77d2-fd69-8aaf-d3ada07eed75@huawei.com>
Date:   Fri, 4 Jan 2019 14:08:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190102192211.GJ5424@mtr-leonro.mtl.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/1/3 3:22, Leon Romanovsky wrote:> On Wed, Jan 02, 2019 at 12:07:40PM -0700, Jason Gunthorpe wrote:
>> On Wed, Jan 02, 2019 at 08:40:50PM +0200, Leon Romanovsky wrote:
>>> On Wed, Jan 02, 2019 at 10:12:24AM -0700, Jason Gunthorpe wrote:
>>>> On Fri, Dec 21, 2018 at 10:19:38AM +0800, YueHaibing wrote:
>>>>> It should goto err handle if qib_user_sdma_rb_insert fails,
>>>>> other than success return.
>>>>>
>>>>> Fixes: 67810e8c3c01 ("RDMA/qib: Remove all occurrences of BUG_ON()")
>>>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>>>>>  drivers/infiniband/hw/qib/qib_user_sdma.c | 2 ++
>>>>>  1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/drivers/infiniband/hw/qib/qib_user_sdma.c b/drivers/infiniband/hw/qib/qib_user_sdma.c
>>>>> index 31c523b..e87c0a7 100644
>>>>> +++ b/drivers/infiniband/hw/qib/qib_user_sdma.c
>>>>> @@ -237,6 +237,8 @@ qib_user_sdma_queue_create(struct device *dev, int unit, int ctxt, int sctxt)
>>>>>
>>>>>  		ret = qib_user_sdma_rb_insert(&qib_user_sdma_rb_root,
>>>>>  					sdma_rb_node);
>>>>> +		if (ret == 0)
>>>>> +			goto err_rb;
>>>>>  	}
>>>>
>>>> This doesn't look right, what about undoing the kmalloc directly
>>>> above?
>>>
>>> Back then, I came to conclusion that qib_user_sdma_rb_insert() never
>>> returns 0. Otherwise, Dennis would see that BUG_ON() for a long time
>>> ago.
>>
>> It fails if the index is in the RB tree, which would indicate a
>> programming bug.
> 
> I tried to say that this programming bug doesn't exist in the reality.

In view of this, leave it just as this.
> 
>>
>> The way to replace the BUG_ON is something like:
>>
>> if (WARN_ON(ret == 0)) {
>>     kfree()
>>     goto err_rb;
>> }
>>
>> Jason

