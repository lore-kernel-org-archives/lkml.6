Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556D7C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24D6D20657
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:52:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24D6D20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbeJ2XlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 19:41:02 -0400
Received: from foss.arm.com ([217.140.101.70]:41706 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726035AbeJ2XlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 19:41:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71103341;
        Mon, 29 Oct 2018 07:52:04 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1896D3F71D;
        Mon, 29 Oct 2018 07:52:02 -0700 (PDT)
Subject: Re: [PATCH] arm: mm: fault: check ADFSR in case of abort
To:     "Wiebe, Wladislav (Nokia - DE/Ulm)" <wladislav.wiebe@nokia.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "tony@atomide.com" <tony@atomide.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "jrdr.linux@gmail.com" <jrdr.linux@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <HE1PR0702MB37567D530C1C1D45949C164BFAF30@HE1PR0702MB3756.eurprd07.prod.outlook.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <d9195ffb-f766-363e-21f3-e3737526c7de@arm.com>
Date:   Mon, 29 Oct 2018 14:52:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <HE1PR0702MB37567D530C1C1D45949C164BFAF30@HE1PR0702MB3756.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/10/2018 14:20, Wiebe, Wladislav (Nokia - DE/Ulm) wrote:
> When running into situations like:
> "Unhandled fault: synchronous external abort (0x210) at 0xXXX"
> or
> "Unhandled prefetch abort: synchronous external abort (0x210) at 0xXXX"
> it is useful to know the content of ADFSR (Auxiliary Data Fault Status
> Register) to indicate an ECC double-bit error in L1 or L2 cache.
> 
> Refer to:
> Cortex-A15 Technical Reference Manual, Revision: r2p1
> [6.4.8. Error Correction Code]

The contents of ADFSR are implementation-defined, though, so this 
interpretation is *only* valid on Cortex-A15. Other processors may use 
those bit positions to report something else, at which point printing a 
message about ECC errors would be totally misleading.

Robin.

> Signed-off-by: Wladislav Wiebe <wladislav.wiebe@nokia.com>
> ---
>   arch/arm/mm/fault.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> index 3232afb6fdc0..5e240deb6ed6 100644
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@ -547,6 +547,22 @@ hook_fault_code(int nr, int (*fn)(unsigned long, unsigned int, struct pt_regs *)
>   	fsr_info[nr].name = name;
>   }
>   
> +/*
> + * Check for ECC double-bit errors in Auxiliary Data Fault Status Register
> + */
> +static void check_adfsr_for_ecc(void)
> +{
> +	u32 adfsr = 0;
> +
> +	asm("mrc p15, 0, %0, c5, c1, 0" : "=r" (adfsr));
> +
> +	if (adfsr & (BIT(31) | BIT(23))) {
> +		pr_alert("ADFSR status 0x%x indicates that an L1 or L2 cache\n"
> +			 "ECC double-bit error occurred at some time.\n",
> +			  adfsr);
> +	}
> +}
> +
>   /*
>    * Dispatch a data abort to the relevant handler.
>    */
> @@ -559,6 +575,7 @@ do_DataAbort(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
>   	if (!inf->fn(addr, fsr & ~FSR_LNX_PF, regs))
>   		return;
>   
> +	check_adfsr_for_ecc();
>   	pr_alert("Unhandled fault: %s (0x%03x) at 0x%08lx\n",
>   		inf->name, fsr, addr);
>   	show_pte(current->mm, addr);
> @@ -593,6 +610,7 @@ do_PrefetchAbort(unsigned long addr, unsigned int ifsr, struct pt_regs *regs)
>   	if (!inf->fn(addr, ifsr | FSR_LNX_PF, regs))
>   		return;
>   
> +	check_adfsr_for_ecc();
>   	pr_alert("Unhandled prefetch abort: %s (0x%03x) at 0x%08lx\n",
>   		inf->name, ifsr, addr);
>   
> 
