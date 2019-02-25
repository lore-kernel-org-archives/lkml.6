Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2239C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A2B20842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EcT92FU/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbfBYPSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 10:18:38 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:48872 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727467AbfBYPSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 10:18:38 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1PFHvvb074698;
        Mon, 25 Feb 2019 09:17:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1551107877;
        bh=z7qYdyUgcM8oI4fbVoZxsZD1hbs2v/OAoV/UeB4WxXs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=EcT92FU/4QWYPGg0STgrHERhppwrwnrA4tdgBm2SnXLjMZ+v1+v8EhOCKu3JGRce9
         hRCcnoK3sYQOB/NcvpXm6bgfrh2cgkAJbKhyKRTet5NribTZ/54VnynQrCNhUNpM7x
         SZQJNJfsabZ+wuUl96CHxpu+ITFQxFFyF4iq15gA=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1PFHvcr027391
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Feb 2019 09:17:57 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 25
 Feb 2019 09:17:57 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 25 Feb 2019 09:17:57 -0600
Received: from [172.22.217.116] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1PFHqoA015613;
        Mon, 25 Feb 2019 09:17:53 -0600
Subject: Re: [PATCH v2] cfi: fix deadloop in cfi_cmdset_0002.c do_write_buffer
To:     "liujian (CE)" <liujian56@huawei.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "joakim.tjernlund@infinera.com" <joakim.tjernlund@infinera.com>,
        "ikegami@allied-telesis.co.jp" <ikegami@allied-telesis.co.jp>,
        "keescook@chromium.org" <keescook@chromium.org>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1550609234-40861-1-git-send-email-liujian56@huawei.com>
 <e9923a1f-aefc-fdd9-97d8-5c0012f09726@ti.com>
 <4F88C5DDA1E80143B232E89585ACE27D0263D40B@DGGEMM528-MBX.china.huawei.com>
From:   Vignesh R <vigneshr@ti.com>
Message-ID: <f838cc47-abe6-cc81-e75f-61b2be6e97fe@ti.com>
Date:   Mon, 25 Feb 2019 20:47:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <4F88C5DDA1E80143B232E89585ACE27D0263D40B@DGGEMM528-MBX.china.huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22-Feb-19 8:20 PM, liujian (CE) wrote:
> 
>> -----Original Message-----
>> From: Vignesh R [mailto:vigneshr@ti.com]
>> Sent: Friday, February 22, 2019 1:59 PM
>> To: liujian (CE) <liujian56@huawei.com>; dwmw2@infradead.org;
>> computersforpeace@gmail.com; bbrezillon@kernel.org;
>> marek.vasut@gmail.com; richard@nod.at; joakim.tjernlund@infinera.com;
>> ikegami@allied-telesis.co.jp; keescook@chromium.org
>> Cc: linux-mtd@lists.infradead.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH v2] cfi: fix deadloop in cfi_cmdset_0002.c do_write_buffer
>>
>>
>>
>> On 20/02/19 2:17 AM, Liu Jian wrote:
>>> In function do_write_buffer(), in the for loop, there is a case
>>> chip_ready() returns 1 while chip_good() returns 0, so it never break
>>> the loop.
>>> To fix this, chip_good() is enough and it should timeout if it stay
>>> bad for a while.
>>>
>>> Fixes: dfeae1073583 ("mtd: cfi_cmdset_0002: Change write buffer to
>>> check correct value")
>>> Signed-off-by: Yi Huaijie <yihuaijie@huawei.com>
>>> Signed-off-by: Liu Jian <liujian56@huawei.com>
>>> Reviewed-by: Tokunori Ikegami <ikegami_to@yahoo.co.jp>
>>> ---
>>> v1->v2:
>>> change git log, put the Fixes tag on a single line
>>>
>>>  drivers/mtd/chips/cfi_cmdset_0002.c | 6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/mtd/chips/cfi_cmdset_0002.c
>>> b/drivers/mtd/chips/cfi_cmdset_0002.c
>>> index 72428b6..818e94b 100644
>>> --- a/drivers/mtd/chips/cfi_cmdset_0002.c
>>> +++ b/drivers/mtd/chips/cfi_cmdset_0002.c
>>> @@ -1876,14 +1876,14 @@ static int __xipram do_write_buffer(struct
>> map_info *map, struct flchip *chip,
>>>  			continue;
>>>  		}
>>>
>>> -		if (time_after(jiffies, timeo) && !chip_ready(map, adr))
>>> -			break;
>>> -
>>>  		if (chip_good(map, adr, datum)) {
>>>  			xip_enable(map, chip, adr);
>>>  			goto op_done;
>>>  		}
>>>
>>> +		if (time_after(jiffies, timeo))
>>> +			break;
>>> +
>>
>> It is quite possible that this thread might be pre-empted just after
>> chip_good() check but before before time_after(). If the thread, then resumes
>> execution after timeo has elasped then, this code will wrongly indicate write
>> failure.
>>
>> To avoid this case, you should add one more check for check_good() even when
>> time_after() returns true. Something like:
>>
>> 	if (time_after(jiffies, timeo)) {
>> 		if (chip_good(map, adr, datum)) {
>> 			xip_enable(map, chip, adr);
>> 			goto op_done;
>> 		}
>> 		break;
>> 	}
>>
> So,  the patch should like this ?
> 
> diff --git a/drivers/mtd/chips/cfi_cmdset_0002.c b/drivers/mtd/chips/cfi_cmdset_0002.c
> index 72428b6..3da2376 100644
> --- a/drivers/mtd/chips/cfi_cmdset_0002.c
> +++ b/drivers/mtd/chips/cfi_cmdset_0002.c
> @@ -1876,7 +1876,7 @@ static int __xipram do_write_buffer(struct map_info *map, struct flchip *chip,
>                         continue;
>                 }
> 
> -               if (time_after(jiffies, timeo) && !chip_ready(map, adr))
> +               if (time_after(jiffies, timeo) && !chip_good(map, adr, datum))
>                         break;
> 
>                 if (chip_good(map, adr, datum)) {
> 
> 
> 
> Any other opinions?
> If there are no other comments, I will send a patch again

Looks fine to me.. Please submit a new version. Thanks!

Regards
Vignesh
