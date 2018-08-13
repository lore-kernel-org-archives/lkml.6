Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94E6C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 13:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA782217FE
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 13:07:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA782217FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbeHMPuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 11:50:01 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40742 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728610AbeHMPuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 11:50:01 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2ECFBF5132114;
        Mon, 13 Aug 2018 21:07:35 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.399.0; Mon, 13 Aug 2018
 21:07:31 +0800
Message-ID: <5B718290.4010302@huawei.com>
Date:   Mon, 13 Aug 2018 21:07:28 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Vladimir Zapolskiy <vz@mleia.com>
CC:     <linux@armlinux.org.uk>, <slemieux.tyco@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm:pm: Use kmemdup to replace duplicating its implementation
References: <1533868851-316-1-git-send-email-zhongjiang@huawei.com> <37f8ff09-b0c2-5cc6-87d4-8138e7b66b32@mleia.com>
In-Reply-To: <37f8ff09-b0c2-5cc6-87d4-8138e7b66b32@mleia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/13 20:28, Vladimir Zapolskiy wrote:
> Hi zhong jiang,
>
> On 08/10/2018 05:40 AM, zhong jiang wrote:
>> kmemdup is better than kmalloc() + memcpy(), and we do not like
>> open code. So just use kmemdup instead.
>>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>> ---
>>  arch/arm/mach-lpc32xx/pm.c | 7 ++-----
>>  1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/mach-lpc32xx/pm.c b/arch/arm/mach-lpc32xx/pm.c
>> index 6247157..6eefff8 100644
>> --- a/arch/arm/mach-lpc32xx/pm.c
>> +++ b/arch/arm/mach-lpc32xx/pm.c
>> @@ -86,7 +86,8 @@ static int lpc32xx_pm_enter(suspend_state_t state)
>>  	void *iram_swap_area;
>>  
>>  	/* Allocate some space for temporary IRAM storage */
>> -	iram_swap_area = kmalloc(lpc32xx_sys_suspend_sz, GFP_KERNEL);
>> +	iram_swap_area = kmemdup((void *)TEMP_IRAM_AREA,
>> +				lpc32xx_sys_suspend_sz, GFP_KERNEL);
> there is a minor coding style issue, which is reported by checkpatch:
>
> CHECK: Alignment should match open parenthesis
> #53: FILE: arch/arm/mach-lpc32xx/pm.c:90:
>
> Other than that the change is valid, I'll fix the indentation issue
> myself and apply the change for v4.19.
 Thank you for doing this. I will notice that for next time.

 Sincerely,
 zhong jiang
> --
> Best wishes,
> Vladimir
>
>>  	if (!iram_swap_area) {
>>  		printk(KERN_ERR
>>  		       "PM Suspend: cannot allocate memory to save portion "
>> @@ -94,10 +95,6 @@ static int lpc32xx_pm_enter(suspend_state_t state)
>>  		return -ENOMEM;
>>  	}
>>  
>> -	/* Backup a small area of IRAM used for the suspend code */
>> -	memcpy(iram_swap_area, (void *) TEMP_IRAM_AREA,
>> -		lpc32xx_sys_suspend_sz);
>> -
>>  	/*
>>  	 * Copy code to suspend system into IRAM. The suspend code
>>  	 * needs to run from IRAM as DRAM may no longer be available
>>
>
> .
>


