Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A7BC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D584E2082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:54:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D584E2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbeJ3Anw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 20:43:52 -0400
Received: from foss.arm.com ([217.140.101.70]:42582 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727085AbeJ3Anw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 20:43:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A298341;
        Mon, 29 Oct 2018 08:54:40 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 01F3A3F71D;
        Mon, 29 Oct 2018 08:54:38 -0700 (PDT)
Date:   Mon, 29 Oct 2018 15:54:36 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     "Wiebe, Wladislav (Nokia - DE/Ulm)" <wladislav.wiebe@nokia.com>
Cc:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "tony@atomide.com" <tony@atomide.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "jrdr.linux@gmail.com" <jrdr.linux@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm: mm: fault: check ADFSR in case of abort
Message-ID: <20181029155435.prz2htt4ktte7pxb@lakrids.cambridge.arm.com>
References: <HE1PR0702MB37567D530C1C1D45949C164BFAF30@HE1PR0702MB3756.eurprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HE1PR0702MB37567D530C1C1D45949C164BFAF30@HE1PR0702MB3756.eurprd07.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 02:20:51PM +0000, Wiebe, Wladislav (Nokia - DE/Ulm) wrote:
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
> 
> Signed-off-by: Wladislav Wiebe <wladislav.wiebe@nokia.com>
> ---
>  arch/arm/mm/fault.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> index 3232afb6fdc0..5e240deb6ed6 100644
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@ -547,6 +547,22 @@ hook_fault_code(int nr, int (*fn)(unsigned long, unsigned int, struct pt_regs *)
>  	fsr_info[nr].name = name;
>  }
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
>  /*
>   * Dispatch a data abort to the relevant handler.
>   */
> @@ -559,6 +575,7 @@ do_DataAbort(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
>  	if (!inf->fn(addr, fsr & ~FSR_LNX_PF, regs))
>  		return;
>  
> +	check_adfsr_for_ecc();
>  	pr_alert("Unhandled fault: %s (0x%03x) at 0x%08lx\n",
>  		inf->name, fsr, addr);
>  	show_pte(current->mm, addr);
> @@ -593,6 +610,7 @@ do_PrefetchAbort(unsigned long addr, unsigned int ifsr, struct pt_regs *regs)
>  	if (!inf->fn(addr, ifsr | FSR_LNX_PF, regs))
>  		return;
>  
> +	check_adfsr_for_ecc();
>  	pr_alert("Unhandled prefetch abort: %s (0x%03x) at 0x%08lx\n",
>  		inf->name, ifsr, addr);

IIUC at this point the task is preemptible (and interruptible), so I
believe this is too late to snapshot the ADFSR. The task could have been
migrated to a different core, with an irrelavant ADFSR, or a fault could
have occured within an interrupt handler, etc.

Thanks,
Mark.
