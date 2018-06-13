Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id CEC5BC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 10:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC6C2086A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 10:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="e8kYPwbe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BC6C2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935170AbeFMKMJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 06:12:09 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:37542 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934947AbeFMKMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 06:12:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AuJMW7geXS1MqetzLfPGQiVUPZLGffzl0DDau0f9xiY=; b=e8kYPwbelR+uPnndd7fViMkwZ
        tYHVxJtt1kYEsPMyrctmkFCzOVvZp3Ssxx0Gm8VTqveWMPOaiEznc8BlpLh8TiisvP9mir0SfaH8M
        8IcqTrcC5+QgrCOPWVQ56ABDP1OC+VS34O8MotUhM0W53R5ot3nDOie4XSPHJfnR7pmtQ=;
Received: from n2100.armlinux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:42931)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1fT2ky-0000Xn-Cb; Wed, 13 Jun 2018 11:12:00 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1fT2kv-0004s6-Bm; Wed, 13 Jun 2018 11:11:57 +0100
Date:   Wed, 13 Jun 2018 11:11:54 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Nishanth Menon <nm@ti.com>
Cc:     Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: DRA7/OMAP5: Enable ACTLR[0] (Enable invalidates of
 BTB) for secondary cores
Message-ID: <20180613101153.GD6920@n2100.armlinux.org.uk>
References: <20180612213611.2484-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612213611.2484-1-nm@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 04:36:11PM -0500, Nishanth Menon wrote:
> Call secure services to enable ACTLR[0] (Enable invalidates of BTB with
> ICIALLU) when branch hardening is enabled for kernel.

As mentioned elsewhere, I don't think this is a good idea - if the secure
world is not implementing the Spectre workarounds, then the _system_ is
exploitable.

If the secure world is implementing the spectre workarounds, it will
already have enabled the IBE bit (which is r/w from secure, read only
from non-secure.)

So, basically, lack of the IBE bit being set is basically telling the
kernel that it's running on a vulnerable platform _even if the kernel
were to set it through some means_.

> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> 
> Based on: next-20180612 +
> Uboot series posted:  https://marc.info/?l=u-boot&m=152883522011042&w=2
> 
> With Just u-boot changes alone: OMAP5-uevm: https://pastebin.ubuntu.com/p/9yDM22bJ6n/
> with kernel changes added on: https://pastebin.ubuntu.com/p/gXPBGGYRPX/
> 
>  arch/arm/mach-omap2/omap-smp.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
> index 69df3620eca5..28fc80ea675b 100644
> --- a/arch/arm/mach-omap2/omap-smp.c
> +++ b/arch/arm/mach-omap2/omap-smp.c
> @@ -109,6 +109,32 @@ void omap5_erratum_workaround_801819(void)
>  static inline void omap5_erratum_workaround_801819(void) { }
>  #endif
>  
> +#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
> +static void omap5_harden_predictor(void)
> +{
> +	u32 acr, acr_mask;
> +
> +	asm volatile ("mrc p15, 0, %0, c1, c0, 1" : "=r" (acr));
> +
> +	/*
> +	 * BIT(0) - Disables streaming. All write-allocate lines allocate in
> +	 */
> +	acr_mask = BIT(0);
> +
> +	/* do we already have it done.. if yes, skip expensive smc */
> +	if ((acr & acr_mask) == acr_mask)
> +		return;
> +
> +	acr |= acr_mask;
> +	omap_smc1(OMAP5_DRA7_MON_SET_ACR_INDEX, acr);
> +
> +	pr_debug("%s: ARM ACR setup for CVE_2017_5715 applied on CPU%d\n",
> +		 __func__, smp_processor_id());
> +}
> +#else
> +static inline void omap5_harden_predictor(void) { }
> +#endif
> +
>  static void omap4_secondary_init(unsigned int cpu)
>  {
>  	/*
> @@ -131,6 +157,8 @@ static void omap4_secondary_init(unsigned int cpu)
>  		set_cntfreq();
>  		/* Configure ACR to disable streaming WA for 801819 */
>  		omap5_erratum_workaround_801819();
> +		/* Enable ACR to allow for ICUALLU workaround */
> +		omap5_harden_predictor();
>  	}
>  
>  	/*
> -- 
> 2.15.1
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
