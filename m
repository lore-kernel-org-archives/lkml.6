Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC72C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D3E821871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="q2Rtemo1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbeLRPwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 10:52:51 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:43926 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbeLRPwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 10:52:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dBK+IsDwvD0APuwJEBoETZXit8t11uO3W9B/NyNLjAY=; b=q2Rtemo1b3oPBh9akJjwO5cGo
        LuW2di/6rJTNyhjUwEljyKnzf08A/ofnUNs3xCXfOxfKHEzyxYZL50OhqoyJnlBeK/4EYrQ/e4sRx
        Su2PqTn6jPKd5w5Uv28MXKj2AxrXT68Jc3pe1ZD9szH/tjQBFzPO963RnuzSeqDN5eElQ=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:59967)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gZHfo-0006y4-My; Tue, 18 Dec 2018 15:52:44 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gZHfl-0001CT-VT; Tue, 18 Dec 2018 15:52:42 +0000
Date:   Tue, 18 Dec 2018 15:52:40 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     patrice.chotard@st.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] ARM: STi: Restore secondary CPU's bringup
Message-ID: <20181218155239.GP26090@n2100.armlinux.org.uk>
References: <1545144493-11600-1-git-send-email-patrice.chotard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545144493-11600-1-git-send-email-patrice.chotard@st.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 03:48:13PM +0100, patrice.chotard@st.com wrote:
> From: Patrice Chotard <patrice.chotard@st.com>
> 
> Due to pen_release and boot_lock removal, secondary CPU's bringup
> was broken. Restore CPU's bringup by reworking properly
> .smp_prepare_cpus and .smp_boot_secondary STi callbacks.

Sorry, maybe I don't understand your commit message, but you seem to be
saying that removal of the pen_release and boot_lock broke STi's secondary
CPU bring up?  Please clarify, and explain how that happened.

Thanks.

> 
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
> ---
>  arch/arm/mach-sti/platsmp.c | 31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm/mach-sti/platsmp.c b/arch/arm/mach-sti/platsmp.c
> index 2166850..9bfc93a 100644
> --- a/arch/arm/mach-sti/platsmp.c
> +++ b/arch/arm/mach-sti/platsmp.c
> @@ -28,8 +28,21 @@
>  
>  #include "smp.h"
>  
> +static u32 __iomem *cpu_strt_ptr;
> +
>  static int sti_boot_secondary(unsigned int cpu, struct task_struct *idle)
>  {
> +	unsigned long entry_pa = __pa_symbol(secondary_startup);
> +
> +	__raw_writel(entry_pa, cpu_strt_ptr);
> +
> +	/*
> +	 * wmb so that data is actually written
> +	 * before cache flush is done
> +	 */
> +	smp_wmb();
> +	sync_cache_w(cpu_strt_ptr);
> +
>  	/*
>  	 * Send the secondary CPU a soft interrupt, thereby causing
>  	 * it to jump to the secondary entrypoint.
> @@ -43,10 +56,8 @@ static void __init sti_smp_prepare_cpus(unsigned int max_cpus)
>  {
>  	struct device_node *np;
>  	void __iomem *scu_base;
> -	u32 __iomem *cpu_strt_ptr;
>  	u32 release_phys;
>  	int cpu;
> -	unsigned long entry_pa = __pa_symbol(secondary_startup);
>  
>  	np = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-scu");
>  
> @@ -74,8 +85,8 @@ static void __init sti_smp_prepare_cpus(unsigned int max_cpus)
>  		}
>  
>  		/*
> -		 * holding pen is usually configured in SBC DMEM but can also be
> -		 * in RAM.
> +		 * cpu-release-addr is usually configured in SBC DMEM but can
> +		 * also be in RAM.
>  		 */
>  
>  		if (!memblock_is_memory(release_phys))
> @@ -85,17 +96,7 @@ static void __init sti_smp_prepare_cpus(unsigned int max_cpus)
>  			cpu_strt_ptr =
>  				(u32 __iomem *)phys_to_virt(release_phys);
>  
> -		__raw_writel(entry_pa, cpu_strt_ptr);
> -
> -		/*
> -		 * wmb so that data is actually written
> -		 * before cache flush is done
> -		 */
> -		smp_wmb();
> -		sync_cache_w(cpu_strt_ptr);
> -
> -		if (!memblock_is_memory(release_phys))
> -			iounmap(cpu_strt_ptr);
> +		set_cpu_possible(cpu, true);
>  	}
>  }
>  
> -- 
> 1.9.1
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
