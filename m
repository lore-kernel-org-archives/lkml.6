Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DB0ECDFAA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 22:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7BCB20C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 22:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="PrSn5i92"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7BCB20C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387616AbeGLXLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 19:11:34 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:34894 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387603AbeGLXLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 19:11:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VHONv6U8fGQKLruZ8kRqZGVnFMu3Wm2ig91I96sthsk=; b=PrSn5i92wG7H/PUbH8em5Ge8o
        b8U6w5j9uilygYOhOxHKYZ/ieD4CcJjMpQOXy+kglGMhI4ED9SZ/dwvFUYV6cTTejHith6kD9o3Nd
        ntm9YBpIRdm371QKhzE806p4PHGT4g7m3Qw60GM1mAam5VIEtMjFFqcDjvSpqzz+F0U/o=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:52411)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1fdkYj-0000iy-8I; Thu, 12 Jul 2018 23:59:37 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1fdkYg-0008P5-Fi; Thu, 12 Jul 2018 23:59:34 +0100
Date:   Thu, 12 Jul 2018 23:59:33 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Stefan Agner <stefan@agner.ch>
Cc:     ard.biesheuvel@linaro.org, arnd@arndb.de, robin.murphy@arm.com,
        nicolas.pitre@linaro.org, marc.zyngier@arm.com,
        behanw@converseincode.com, keescook@chromium.org,
        Bernhard.Rosenkranzer@linaro.org, mka@chromium.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>,
        Stephen Warren <swarren@nvidia.com>,
        Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v2 3/6] ARM: trusted_foundations: do not use naked
 function
Message-ID: <20180712225933.GX17271@n2100.armlinux.org.uk>
References: <20180325180959.28008-1-stefan@agner.ch>
 <20180325180959.28008-4-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180325180959.28008-4-stefan@agner.ch>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 25, 2018 at 08:09:56PM +0200, Stefan Agner wrote:
> As documented in GCC naked functions should only use Basic asm
> syntax. The Extended asm or mixture of Basic asm and "C" code is
> not guaranteed. Currently this works because it was hard coded
> to follow and check GCC behavior for arguments and register
> placement.
> 
> Furthermore with clang using parameters in Extended asm in a
> naked function is not supported:
>   arch/arm/firmware/trusted_foundations.c:47:10: error: parameter
>           references not allowed in naked functions
>                 : "r" (type), "r" (arg1), "r" (arg2)
>                        ^
> 
> Use a regular function to be more portable. This aligns also with
> the other smc call implementations e.g. in qcom_scm-32.c and
> bcm_kona_smc.c.
> 
> Cc: Dmitry Osipenko <digetx@gmail.com>
> Cc: Stephen Warren <swarren@nvidia.com>
> Cc: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> Changes in v2:
> - Keep stmfd/ldmfd to avoid potential ABI issues
> 
>  arch/arm/firmware/trusted_foundations.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/firmware/trusted_foundations.c b/arch/arm/firmware/trusted_foundations.c
> index 3fb1b5a1dce9..689e6565abfc 100644
> --- a/arch/arm/firmware/trusted_foundations.c
> +++ b/arch/arm/firmware/trusted_foundations.c
> @@ -31,21 +31,25 @@
>  
>  static unsigned long cpu_boot_addr;
>  
> -static void __naked tf_generic_smc(u32 type, u32 arg1, u32 arg2)
> +static void tf_generic_smc(u32 type, u32 arg1, u32 arg2)
>  {
> +	register u32 r0 asm("r0") = type;
> +	register u32 r1 asm("r1") = arg1;
> +	register u32 r2 asm("r2") = arg2;
> +
>  	asm volatile(
>  		".arch_extension	sec\n\t"
> -		"stmfd	sp!, {r4 - r11, lr}\n\t"
> +		"stmfd	sp!, {r4 - r11}\n\t"
>  		__asmeq("%0", "r0")
>  		__asmeq("%1", "r1")
>  		__asmeq("%2", "r2")
>  		"mov	r3, #0\n\t"
>  		"mov	r4, #0\n\t"
>  		"smc	#0\n\t"
> -		"ldmfd	sp!, {r4 - r11, pc}"
> +		"ldmfd	sp!, {r4 - r11}\n\t"
>  		:
> -		: "r" (type), "r" (arg1), "r" (arg2)
> -		: "memory");
> +		: "r" (r0), "r" (r1), "r" (r2)
> +		: "memory", "r3", "r12", "lr");
>  }

Does GCC try to inline this?

It may just be better to switch to basic asm.  We know that a naked
function won't be inlined, and we already know (because we need the
prologue/epilogue) what registers the 32-bit arguments will be in.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
