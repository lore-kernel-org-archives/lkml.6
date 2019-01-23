Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B34FC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6225621726
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfAWJoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 04:44:07 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:46882 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726804AbfAWJoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 04:44:07 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 06CF6FDCA6B3A4A995E3;
        Wed, 23 Jan 2019 17:44:05 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.408.0; Wed, 23 Jan 2019
 17:43:59 +0800
Subject: Re: [PATCH -next] mtd: docg3: Fix passing zero to 'PTR_ERR' warning
 in doc_probe_device
To:     Boris Brezillon <bbrezillon@kernel.org>
References: <20190123065827.16748-1-yuehaibing@huawei.com>
 <20190123101253.243add9d@bbrezillon>
CC:     <robert.jarzmik@free.fr>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <marek.vasut@gmail.com>,
        <richard@nod.at>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <86533285-e800-5cc0-f495-88fff8326b5a@huawei.com>
Date:   Wed, 23 Jan 2019 17:43:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190123101253.243add9d@bbrezillon>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/1/23 17:12, Boris Brezillon wrote:
> On Wed, 23 Jan 2019 14:58:27 +0800
> YueHaibing <yuehaibing@huawei.com> wrote:
> 
>> Fix a static code checker warning:
>> drivers/mtd/devices/docg3.c:1875
>>  doc_probe_device() warn: passing zero to 'ERR_PTR'
>>
>> Fixes: ae9d4934b2d7 ("mtd: docg3: add multiple floor support")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  drivers/mtd/devices/docg3.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mtd/devices/docg3.c b/drivers/mtd/devices/docg3.c
>> index 4c94fc0..60ddc38 100644
>> --- a/drivers/mtd/devices/docg3.c
>> +++ b/drivers/mtd/devices/docg3.c
>> @@ -1872,7 +1872,7 @@ doc_probe_device(struct docg3_cascade *cascade, int floor, struct device *dev)
>>  nomem2:
>>  	kfree(docg3);
>>  nomem1:
>> -	return ERR_PTR(ret);
>> +	return ret ? ERR_PTR(ret) : NULL;
>>  }
>>  
> 
> This is not the right fix, you should instead set ret to -EINVAL:

Thanks , will fix it in v2.

And seems doc_probe_device cannot return NULL. The NULL check of doc_probe_device
in docg3_probe also can been removed, right?

> 
> --->8---
> diff --git a/drivers/mtd/devices/docg3.c b/drivers/mtd/devices/docg3.c
> index 4c94fc096696..6b84db411232 100644
> --- a/drivers/mtd/devices/docg3.c
> +++ b/drivers/mtd/devices/docg3.c
> @@ -1842,7 +1842,7 @@ doc_probe_device(struct docg3_cascade *cascade, int floor, struct device *dev)
>         chip_id = doc_register_readw(docg3, DOC_CHIPID);
>         chip_id_inv = doc_register_readw(docg3, DOC_CHIPID_INV);
>  
> -       ret = 0;
> +       ret = -ENOMEM;
>         if (chip_id != (u16)(~chip_id_inv)) {
>                 goto nomem4;
>         }
> 
> .
> 

