Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52676C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1856526BF4
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:07:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1856526BF4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965838AbeFZOH5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 10:07:57 -0400
Received: from mail.bootlin.com ([62.4.15.54]:37265 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965260AbeFZOHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 10:07:55 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id DDBF120775; Tue, 26 Jun 2018 16:07:53 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8C273206D8;
        Tue, 26 Jun 2018 16:07:43 +0200 (CEST)
Date:   Tue, 26 Jun 2018 16:07:43 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
Cc:     Paul Burton <paul.burton@mips.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mips: generic: allow not building DTB in
Message-ID: <20180626140743.GE4207@piout.net>
References: <20180626115712.11643-1-alexandre.belloni@bootlin.com>
 <20180626115712.11643-2-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626115712.11643-2-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/06/2018 13:57:12+0200, Alexandre Belloni wrote:
> Allow not building any DTB in the generic kernel so it gets smaller. This
> is necessary for ocelot because it can be built as a legacy platform that
> needs a built-in DTB and it can also handle a separate DTB once it is
> updated with a more modern bootloader. In the latter case, it is preferable
> to not include any DTB in the kernel image so it is smaller.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
> Changes in v2:
>  - rebased on v4.18-rc1
> 

Note that while the first patch can probably be applied as-is (it only
affects Ocelot). this one still needs to be refined. It seems to be
causing build issues with some defconfig.

>  arch/mips/Kconfig               | 1 -
>  arch/mips/Makefile              | 2 +-
>  arch/mips/generic/Kconfig       | 1 +
>  arch/mips/generic/vmlinux.its.S | 2 ++
>  4 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 3f9deec70b92..2cc43f51fa6f 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -85,7 +85,6 @@ choice
>  config MIPS_GENERIC
>  	bool "Generic board-agnostic MIPS kernel"
>  	select BOOT_RAW
> -	select BUILTIN_DTB
>  	select CEVT_R4K
>  	select CLKSRC_MIPS_GIC
>  	select COMMON_CLK
> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> index e2122cca4ae2..5c5d491d736e 100644
> --- a/arch/mips/Makefile
> +++ b/arch/mips/Makefile
> @@ -401,7 +401,7 @@ endif
>  CLEAN_FILES += vmlinux.32 vmlinux.64
>  
>  # device-trees
> -core-$(CONFIG_BUILTIN_DTB) += arch/mips/boot/dts/
> +core-y += arch/mips/boot/dts/
>  
>  %.dtb %.dtb.S %.dtb.o: | scripts
>  	$(Q)$(MAKE) $(build)=arch/mips/boot/dts arch/mips/boot/dts/$@
> diff --git a/arch/mips/generic/Kconfig b/arch/mips/generic/Kconfig
> index 08e33c6b2539..13692b84928e 100644
> --- a/arch/mips/generic/Kconfig
> +++ b/arch/mips/generic/Kconfig
> @@ -3,6 +3,7 @@ if MIPS_GENERIC
>  
>  config LEGACY_BOARDS
>  	bool
> +	select BUILTIN_DTB
>  	help
>  	  Select this from your board if the board must use a legacy, non-UHI,
>  	  boot protocol. This will cause the kernel to scan through the list of
> diff --git a/arch/mips/generic/vmlinux.its.S b/arch/mips/generic/vmlinux.its.S
> index 1a08438fd893..9c954f2ae561 100644
> --- a/arch/mips/generic/vmlinux.its.S
> +++ b/arch/mips/generic/vmlinux.its.S
> @@ -21,6 +21,7 @@
>  		};
>  	};
>  
> +#if IS_ENABLED(CONFIG_BUILTIN_DTB)

Thinking more about that, the conf@default configuration should probably
not be removed if the platform is not using DT at all. Are there still
MIPS platforms without DT support?

>  	configurations {
>  		default = "conf@default";
>  
> @@ -29,4 +30,5 @@
>  			kernel = "kernel@0";
>  		};
>  	};
> +#endif
>  };
> -- 
> 2.18.0
> 

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
