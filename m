Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9A5C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 12:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E2E620870
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 12:28:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E2E620870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbeHMPKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 11:10:40 -0400
Received: from mleia.com ([178.79.152.223]:40366 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728455AbeHMPKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 11:10:39 -0400
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id 8B50540A273;
        Mon, 13 Aug 2018 13:28:34 +0100 (BST)
Subject: Re: [PATCH] arm:pm: Use kmemdup to replace duplicating its
 implementation
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     linux@armlinux.org.uk, slemieux.tyco@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1533868851-316-1-git-send-email-zhongjiang@huawei.com>
From:   Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <37f8ff09-b0c2-5cc6-87d4-8138e7b66b32@mleia.com>
Date:   Mon, 13 Aug 2018 15:28:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1533868851-316-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20180813_132834_592171_CD013FED 
X-CRM114-Status: GOOD (  16.33  )
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi zhong jiang,

On 08/10/2018 05:40 AM, zhong jiang wrote:
> kmemdup is better than kmalloc() + memcpy(), and we do not like
> open code. So just use kmemdup instead.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  arch/arm/mach-lpc32xx/pm.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-lpc32xx/pm.c b/arch/arm/mach-lpc32xx/pm.c
> index 6247157..6eefff8 100644
> --- a/arch/arm/mach-lpc32xx/pm.c
> +++ b/arch/arm/mach-lpc32xx/pm.c
> @@ -86,7 +86,8 @@ static int lpc32xx_pm_enter(suspend_state_t state)
>  	void *iram_swap_area;
>  
>  	/* Allocate some space for temporary IRAM storage */
> -	iram_swap_area = kmalloc(lpc32xx_sys_suspend_sz, GFP_KERNEL);
> +	iram_swap_area = kmemdup((void *)TEMP_IRAM_AREA,
> +				lpc32xx_sys_suspend_sz, GFP_KERNEL);

there is a minor coding style issue, which is reported by checkpatch:

CHECK: Alignment should match open parenthesis
#53: FILE: arch/arm/mach-lpc32xx/pm.c:90:

Other than that the change is valid, I'll fix the indentation issue
myself and apply the change for v4.19.

--
Best wishes,
Vladimir

>  	if (!iram_swap_area) {
>  		printk(KERN_ERR
>  		       "PM Suspend: cannot allocate memory to save portion "
> @@ -94,10 +95,6 @@ static int lpc32xx_pm_enter(suspend_state_t state)
>  		return -ENOMEM;
>  	}
>  
> -	/* Backup a small area of IRAM used for the suspend code */
> -	memcpy(iram_swap_area, (void *) TEMP_IRAM_AREA,
> -		lpc32xx_sys_suspend_sz);
> -
>  	/*
>  	 * Copy code to suspend system into IRAM. The suspend code
>  	 * needs to run from IRAM as DRAM may no longer be available
> 

