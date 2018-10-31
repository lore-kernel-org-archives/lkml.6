Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA228C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 07:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A0220821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 07:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69A0220821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbeJaQCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 12:02:18 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36482 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbeJaQCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 12:02:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC39180D;
        Wed, 31 Oct 2018 00:05:25 -0700 (PDT)
Received: from salmiak (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 851733F71D;
        Wed, 31 Oct 2018 00:05:23 -0700 (PDT)
Date:   Wed, 31 Oct 2018 07:05:17 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peng Hao <peng.hao2@zte.com.cn>
Cc:     robh+dt@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        andy@infradead.org, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        hutao@cn.fujitsu.com, linux-doc@vger.kernel.org
Subject: Re: [PATCH V4 1/5]  pvpanic: move pvpanic to misc as common driver
Message-ID: <20181031070517.ijplknobd6en4h5g@salmiak>
References: <1540993041-25611-1-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540993041-25611-1-git-send-email-peng.hao2@zte.com.cn>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 09:37:17PM +0800, Peng Hao wrote:
> move pvpanic.c from drivers/platform/x86 to drivers/misc.
> following patches will use pvpanic device in arm64.

FWIW, the series as a whole looks fine to me, so for all patches:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  drivers/misc/Kconfig                     | 7 +++++++
>  drivers/misc/Makefile                    | 1 +
>  drivers/{platform/x86 => misc}/pvpanic.c | 0
>  drivers/platform/Kconfig                 | 3 +++
>  drivers/platform/Makefile                | 1 +
>  drivers/platform/x86/Kconfig             | 8 --------
>  drivers/platform/x86/Makefile            | 1 -
>  7 files changed, 12 insertions(+), 9 deletions(-)
>  rename drivers/{platform/x86 => misc}/pvpanic.c (100%)
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 5d71300..ca55c94 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -499,6 +499,13 @@ config MISC_RTSX
>  	tristate
>  	default MISC_RTSX_PCI || MISC_RTSX_USB
>  
> +config PVPANIC
> +	tristate "pvpanic device support"
> +	help
> +          This driver provides support for the pvpanic device.  pvpanic is
> +          a paravirtualized device provided by QEMU; it lets a virtual machine
> +          (guest) communicate panic events to the host.
> +
>  source "drivers/misc/c2port/Kconfig"
>  source "drivers/misc/eeprom/Kconfig"
>  source "drivers/misc/cb710/Kconfig"
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index 20be70c..39dc005 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -57,3 +57,4 @@ obj-$(CONFIG_ASPEED_LPC_SNOOP)	+= aspeed-lpc-snoop.o
>  obj-$(CONFIG_PCI_ENDPOINT_TEST)	+= pci_endpoint_test.o
>  obj-$(CONFIG_OCXL)		+= ocxl/
>  obj-$(CONFIG_MISC_RTSX)		+= cardreader/
> +obj-$(CONFIG_PVPANIC)  		+= pvpanic.o
> diff --git a/drivers/platform/x86/pvpanic.c b/drivers/misc/pvpanic.c
> similarity index 100%
> rename from drivers/platform/x86/pvpanic.c
> rename to drivers/misc/pvpanic.c
> diff --git a/drivers/platform/Kconfig b/drivers/platform/Kconfig
> index d4c2e42..8b64b78 100644
> --- a/drivers/platform/Kconfig
> +++ b/drivers/platform/Kconfig
> @@ -1,3 +1,6 @@
> +if ARM64
> +source "drivers/platform/arm/Kconfig"
> +endif
>  if X86
>  source "drivers/platform/x86/Kconfig"
>  endif
> diff --git a/drivers/platform/Makefile b/drivers/platform/Makefile
> index 4b2ce58..232231c 100644
> --- a/drivers/platform/Makefile
> +++ b/drivers/platform/Makefile
> @@ -3,6 +3,7 @@
>  # Makefile for linux/drivers/platform
>  #
>  
> +obj-$(CONFIG_ARM64)               += arm/
>  obj-$(CONFIG_X86)		+= x86/
>  obj-$(CONFIG_MELLANOX_PLATFORM)	+= mellanox/
>  obj-$(CONFIG_MIPS)		+= mips/
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index ef016e4..a6b412e 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1119,14 +1119,6 @@ config INTEL_SMARTCONNECT
>  	  This driver checks to determine whether the device has Intel Smart
>  	  Connect enabled, and if so disables it.
>  
> -config PVPANIC
> -	tristate "pvpanic device support"
> -	depends on ACPI
> -	---help---
> -	  This driver provides support for the pvpanic device.  pvpanic is
> -	  a paravirtualized device provided by QEMU; it lets a virtual machine
> -	  (guest) communicate panic events to the host.
> -
>  config INTEL_PMC_IPC
>  	tristate "Intel PMC IPC Driver"
>  	depends on ACPI
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index 2ba6cb7..a4ec299 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -75,7 +75,6 @@ obj-$(CONFIG_APPLE_GMUX)	+= apple-gmux.o
>  obj-$(CONFIG_INTEL_RST)		+= intel-rst.o
>  obj-$(CONFIG_INTEL_SMARTCONNECT)	+= intel-smartconnect.o
>  
> -obj-$(CONFIG_PVPANIC)           += pvpanic.o
>  obj-$(CONFIG_ALIENWARE_WMI)	+= alienware-wmi.o
>  obj-$(CONFIG_INTEL_PMC_IPC)	+= intel_pmc_ipc.o
>  obj-$(CONFIG_SILEAD_DMI)	+= silead_dmi.o
> -- 
> 1.8.3.1
> 
