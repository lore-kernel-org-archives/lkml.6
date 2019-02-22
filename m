Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD99C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 05:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 371CE20823
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 05:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EonOr0sj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbfBVF6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 00:58:33 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:32918 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfBVF6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 00:58:32 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1M5vo3m111502;
        Thu, 21 Feb 2019 23:57:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550815070;
        bh=NoppK0cXQU2yGt/UWUVX9GymC+SOG6254eUSduksSxs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=EonOr0sjdtil7a4hR2AsUEyHlnTs5zhDXoOCqBp/dwzFL21GVBcsprNIT/LJs8PwB
         sufWpDyOwPyjdVaWyvccRF5WJB8Yz4EYm+80LxDMZuoS4Ol/Dc0g2nORQbUgrdzFvR
         1rf1O76WJCAm+SDuJ7dTcvCA2exHH20hROKxk0xM=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1M5voVh053593
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Feb 2019 23:57:50 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 21
 Feb 2019 23:57:49 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 21 Feb 2019 23:57:49 -0600
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1M5vjBe032262;
        Thu, 21 Feb 2019 23:57:46 -0600
Subject: Re: [PATCH v2] cfi: fix deadloop in cfi_cmdset_0002.c do_write_buffer
To:     Liu Jian <liujian56@huawei.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <bbrezillon@kernel.org>,
        <marek.vasut@gmail.com>, <richard@nod.at>,
        <joakim.tjernlund@infinera.com>, <ikegami@allied-telesis.co.jp>,
        <keescook@chromium.org>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <1550609234-40861-1-git-send-email-liujian56@huawei.com>
From:   Vignesh R <vigneshr@ti.com>
Message-ID: <e9923a1f-aefc-fdd9-97d8-5c0012f09726@ti.com>
Date:   Fri, 22 Feb 2019 11:28:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1550609234-40861-1-git-send-email-liujian56@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/02/19 2:17 AM, Liu Jian wrote:
> In function do_write_buffer(), in the for loop, there is a case
> chip_ready() returns 1 while chip_good() returns 0, so it never
> break the loop.
> To fix this, chip_good() is enough and it should timeout if it stay
> bad for a while.
> 
> Fixes: dfeae1073583 ("mtd: cfi_cmdset_0002: Change write buffer to check correct value")
> Signed-off-by: Yi Huaijie <yihuaijie@huawei.com>
> Signed-off-by: Liu Jian <liujian56@huawei.com>
> Reviewed-by: Tokunori Ikegami <ikegami_to@yahoo.co.jp>
> ---
> v1->v2:
> change git log, put the Fixes tag on a single line
> 
>  drivers/mtd/chips/cfi_cmdset_0002.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/chips/cfi_cmdset_0002.c b/drivers/mtd/chips/cfi_cmdset_0002.c
> index 72428b6..818e94b 100644
> --- a/drivers/mtd/chips/cfi_cmdset_0002.c
> +++ b/drivers/mtd/chips/cfi_cmdset_0002.c
> @@ -1876,14 +1876,14 @@ static int __xipram do_write_buffer(struct map_info *map, struct flchip *chip,
>  			continue;
>  		}
>  
> -		if (time_after(jiffies, timeo) && !chip_ready(map, adr))
> -			break;
> -
>  		if (chip_good(map, adr, datum)) {
>  			xip_enable(map, chip, adr);
>  			goto op_done;
>  		}
>  
> +		if (time_after(jiffies, timeo))
> +			break;
> +

It is quite possible that this thread might be pre-empted just after
chip_good() check but before before time_after(). If the thread, then
resumes execution after timeo has elasped then, this code will wrongly
indicate write failure.

To avoid this case, you should add one more check for check_good() even
when time_after() returns true. Something like:

	if (time_after(jiffies, timeo)) {
		if (chip_good(map, adr, datum)) {
			xip_enable(map, chip, adr);
			goto op_done;
		}
		break;
	}



>  		/* Latency issues. Drop the lock, wait a while and retry */
>  		UDELAY(map, chip, adr, 1);
>  	}
> 

-- 
Regards
Vignesh
