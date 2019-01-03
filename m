Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50085C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 02:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15FB320836
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 02:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbfACCFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 21:05:51 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:39479 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726071AbfACCFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 21:05:51 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C904E5351B4D9;
        Thu,  3 Jan 2019 10:05:46 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Thu, 3 Jan 2019
 10:05:48 +0800
Subject: Re: [PATCH -next] IB/qib: Add missing err handle for
 qib_user_sdma_rb_insert
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
References: <20181221021938.13784-1-yuehaibing@huawei.com>
 <20190102171224.GA26765@ziepe.ca> <20190102184050.GI5424@mtr-leonro.mtl.com>
 <20190102190740.GH26211@ziepe.ca>
CC:     <dennis.dalessandro@intel.com>, <mike.marciniszyn@intel.com>,
        <dledford@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <cef0e281-1d93-a0cf-03f1-b96622970567@huawei.com>
Date:   Thu, 3 Jan 2019 10:05:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190102190740.GH26211@ziepe.ca>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/1/3 3:07, Jason Gunthorpe wrote:
> On Wed, Jan 02, 2019 at 08:40:50PM +0200, Leon Romanovsky wrote:
>> On Wed, Jan 02, 2019 at 10:12:24AM -0700, Jason Gunthorpe wrote:
>>> On Fri, Dec 21, 2018 at 10:19:38AM +0800, YueHaibing wrote:
>>>> It should goto err handle if qib_user_sdma_rb_insert fails,
>>>> other than success return.
>>>>
>>>> Fixes: 67810e8c3c01 ("RDMA/qib: Remove all occurrences of BUG_ON()")
>>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>>>>  drivers/infiniband/hw/qib/qib_user_sdma.c | 2 ++
>>>>  1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/drivers/infiniband/hw/qib/qib_user_sdma.c b/drivers/infiniband/hw/qib/qib_user_sdma.c
>>>> index 31c523b..e87c0a7 100644
>>>> +++ b/drivers/infiniband/hw/qib/qib_user_sdma.c
>>>> @@ -237,6 +237,8 @@ qib_user_sdma_queue_create(struct device *dev, int unit, int ctxt, int sctxt)
>>>>
>>>>  		ret = qib_user_sdma_rb_insert(&qib_user_sdma_rb_root,
>>>>  					sdma_rb_node);
>>>> +		if (ret == 0)
>>>> +			goto err_rb;
>>>>  	}
>>>
>>> This doesn't look right, what about undoing the kmalloc directly
>>> above?
>>
>> Back then, I came to conclusion that qib_user_sdma_rb_insert() never
>> returns 0. Otherwise, Dennis would see that BUG_ON() for a long time
>> ago.
> 
> It fails if the index is in the RB tree, which would indicate a
> programming bug.
> 
> The way to replace the BUG_ON is something like:
> 

Oh, yes,  I forget kfree this mem.

> if (WARN_ON(ret == 0)) {
>     kfree()
>     goto err_rb;
> }
> 
> Jason
> 
> .
> 

