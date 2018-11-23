Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AAF3C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 00:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 593BF20824
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 00:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="AIVfmzwa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 593BF20824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407928AbeKWKqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 05:46:40 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:42552 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733280AbeKWKqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 05:46:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Gyya1XWck+HLsBIxKN5yHrHX/lK5p2ZIfNKTA+zmLfg=; b=AIVfmzwaAfjKcPAGpjEUJ2QR0
        QUBnfSkERXgIwjMhJnoDf6HwjdZRSk0uo50n9Gl60cKp995ms/ty65pgeCsaAoPTrk//xbV9f5u+J
        m2/lA2WtPBKl8BHuaKC4FH4mYu0mJg5UIqZ5lRY7O3H4helfglZxvmoQ8Wf8DcOphN5KQ=;
Received: from n2100.armlinux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:40490)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gPyxi-0004oD-Kt; Fri, 23 Nov 2018 00:04:46 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gPyxg-0007mo-9R; Fri, 23 Nov 2018 00:04:44 +0000
Date:   Fri, 23 Nov 2018 00:04:42 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Sasha Levin <sashal@kernel.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.9 10/15] ARM: split out processor lookup
Message-ID: <20181123000442.GO30658@n2100.armlinux.org.uk>
References: <20181122195621.13776-1-sashal@kernel.org>
 <20181122195621.13776-10-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122195621.13776-10-sashal@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I meant this patch, not patch 11.

On Thu, Nov 22, 2018 at 02:56:16PM -0500, Sasha Levin wrote:
> From: Russell King <rmk+kernel@armlinux.org.uk>
> 
> [ Upstream commit 65987a8553061515b5851b472081aedb9837a391 ]
> 
> Split out the lookup of the processor type and associated error handling
> from the rest of setup_processor() - we will need to use this in the
> secondary CPU bringup path for big.Little Spectre variant 2 mitigation.
> 
> Reviewed-by: Julien Thierry <julien.thierry@arm.com>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  arch/arm/include/asm/cputype.h |  1 +
>  arch/arm/kernel/setup.c        | 31 +++++++++++++++++++------------
>  2 files changed, 20 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
> index b62eaeb147aa..65db1376f09a 100644
> --- a/arch/arm/include/asm/cputype.h
> +++ b/arch/arm/include/asm/cputype.h
> @@ -98,6 +98,7 @@
>  #define ARM_CPU_PART_SCORPION		0x510002d0
>  
>  extern unsigned int processor_id;
> +struct proc_info_list *lookup_processor(u32 midr);
>  
>  #ifdef CONFIG_CPU_CP15
>  #define read_cpuid(reg)							\
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index f4e54503afa9..8d5c3a118abe 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -667,22 +667,29 @@ static void __init smp_build_mpidr_hash(void)
>  }
>  #endif
>  
> -static void __init setup_processor(void)
> +/*
> + * locate processor in the list of supported processor types.  The linker
> + * builds this table for us from the entries in arch/arm/mm/proc-*.S
> + */
> +struct proc_info_list *lookup_processor(u32 midr)
>  {
> -	struct proc_info_list *list;
> +	struct proc_info_list *list = lookup_processor_type(midr);
>  
> -	/*
> -	 * locate processor in the list of supported processor
> -	 * types.  The linker builds this table for us from the
> -	 * entries in arch/arm/mm/proc-*.S
> -	 */
> -	list = lookup_processor_type(read_cpuid_id());
>  	if (!list) {
> -		pr_err("CPU configuration botched (ID %08x), unable to continue.\n",
> -		       read_cpuid_id());
> -		while (1);
> +		pr_err("CPU%u: configuration botched (ID %08x), CPU halted\n",
> +		       smp_processor_id(), midr);
> +		while (1)
> +		/* can't use cpu_relax() here as it may require MMU setup */;
>  	}
>  
> +	return list;
> +}
> +
> +static void __init setup_processor(void)
> +{
> +	unsigned int midr = read_cpuid_id();
> +	struct proc_info_list *list = lookup_processor(midr);
> +
>  	cpu_name = list->cpu_name;
>  	__cpu_architecture = __get_cpu_architecture();
>  
> @@ -700,7 +707,7 @@ static void __init setup_processor(void)
>  #endif
>  
>  	pr_info("CPU: %s [%08x] revision %d (ARMv%s), cr=%08lx\n",
> -		cpu_name, read_cpuid_id(), read_cpuid_id() & 15,
> +		list->cpu_name, midr, midr & 15,
>  		proc_arch[cpu_architecture()], get_cr());
>  
>  	snprintf(init_utsname()->machine, __NEW_UTS_LEN + 1, "%s%c",
> -- 
> 2.17.1
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
