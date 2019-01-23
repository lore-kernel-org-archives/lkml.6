Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A03C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30F42217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfAWIyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 03:54:08 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2217 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726322AbfAWIyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 03:54:08 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 69830D656A2878CC6A8C;
        Wed, 23 Jan 2019 16:54:06 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.408.0; Wed, 23 Jan 2019
 16:54:05 +0800
Subject: Re: [PATCH -next] mtd: docg3: Fix a possible memory leak of mtd->name
To:     Boris Brezillon <bbrezillon@kernel.org>
References: <20190123065943.5868-1-yuehaibing@huawei.com>
 <20190123094644.23f27c3e@bbrezillon>
CC:     <robert.jarzmik@free.fr>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <marek.vasut@gmail.com>,
        <richard@nod.at>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <ba7a5252-893c-6fb5-84b4-1ab482738afd@huawei.com>
Date:   Wed, 23 Jan 2019 16:54:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190123094644.23f27c3e@bbrezillon>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/1/23 16:46, Boris Brezillon wrote:
> On Wed, 23 Jan 2019 14:59:43 +0800
> YueHaibing <yuehaibing@huawei.com> wrote:
> 
>> In case DOC_CHIPID_G3, mtd->name should be freed in the
>> err handling path, which is alloced by kasprintf.
>>
>> Fixes: ae9d4934b2d7 ("mtd: docg3: add multiple floor support")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  drivers/mtd/devices/docg3.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/mtd/devices/docg3.c b/drivers/mtd/devices/docg3.c
>> index 60ddc38..cbd25f9 100644
>> --- a/drivers/mtd/devices/docg3.c
>> +++ b/drivers/mtd/devices/docg3.c
>> @@ -1867,6 +1867,7 @@ doc_probe_device(struct docg3_cascade *cascade, int floor, struct device *dev)
>>  
>>  nomem4:
>>  	kfree(docg3->bbt);
>> +	kfree(mtd->name);
> 
> Please use devm_kasprintf() instead.

Ok, will do it in v2.

> 
>>  nomem3:
>>  	kfree(mtd);
>>  nomem2:
> 
> 
> .
> 

