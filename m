Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399D9C282C3
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 01:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11B6D218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 01:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbfAYBkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 20:40:43 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2747 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727983AbfAYBkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 20:40:43 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 27B51122F7A6A8AEA996;
        Fri, 25 Jan 2019 09:40:41 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Fri, 25 Jan 2019
 09:40:38 +0800
Subject: Re: [PATCH v3 -next] mtd: docg3: Fix a possible memory leak of
 mtd->name
To:     Boris Brezillon <bbrezillon@kernel.org>
References: <20190123092819.5020-1-yuehaibing@huawei.com>
 <20190124160047.6091b3e3@bbrezillon>
CC:     <robert.jarzmik@free.fr>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <marek.vasut@gmail.com>,
        <richard@nod.at>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <abf8dafe-f8c5-265f-ff25-a743965ff65a@huawei.com>
Date:   Fri, 25 Jan 2019 09:40:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190124160047.6091b3e3@bbrezillon>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/1/24 23:00, Boris Brezillon wrote:
> On Wed, 23 Jan 2019 17:28:19 +0800
> YueHaibing <yuehaibing@huawei.com> wrote:
> 
>> In case DOC_CHIPID_G3, mtd->name is not freed in err handling path,
>> which is alloced by kasprintf(). Fix this by using devm_kasprintf().
>>
>> Fixes: ae9d4934b2d7 ("mtd: docg3: add multiple floor support")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>> v3: use devm_kasprintf
>> ---
>>  drivers/mtd/devices/docg3.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mtd/devices/docg3.c b/drivers/mtd/devices/docg3.c
>> index 4c94fc0..59ca4f5 100644
>> --- a/drivers/mtd/devices/docg3.c
>> +++ b/drivers/mtd/devices/docg3.c
>> @@ -1767,8 +1767,8 @@ static int __init doc_set_driver_info(int chip_id, struct mtd_info *mtd)
>>  
>>  	switch (chip_id) {
>>  	case DOC_CHIPID_G3:
>> -		mtd->name = kasprintf(GFP_KERNEL, "docg3.%d",
>> -				      docg3->device_id);
>> +		mtd->name = devm_kasprintf(docg3->dev, GFP_KERNEL, "docg3.%d",
>> +					   docg3->device_id);
> 
> You forgot to remove the kfree() in the ->remove() path.

Oops..., I will fix this.

Thanks a lot!

> 
>>  		if (!mtd->name)
>>  			return -ENOMEM;
>>  		docg3->max_block = 2047;
> 
> 
> .
> 

