Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935700AbeCCAzh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 19:55:37 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59190 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935684AbeCCAzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 19:55:35 -0500
Date: Fri, 2 Mar 2018 16:55:33 -0800
From: Darren Hart <dvhart@infradead.org>
To: Mario Limonciello <mario.limonciello@dell.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, pali.rohar@gmail.com,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v3 3/3] platform/x86: dell-smbios: Link all dell-smbios-*
 modules together
Message-ID: <20180303005533.GE25613@fury>
References: <1519755784-2155-1-git-send-email-mario.limonciello@dell.com>
 <1519755784-2155-3-git-send-email-mario.limonciello@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519755784-2155-3-git-send-email-mario.limonciello@dell.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 12:23:04PM -0600, Mario Limonciello wrote:
> Some race conditions were raised due to dell-smbios and its backends
> not being ready by the time that a consumer would call one of the
> exported methods.
> 
> To avoid this problem, guarantee that all initialization has been
> done by linking them all together and running init for them all.
> 
> As part of this change the Kconfig needs to be adjusted so that
> CONFIG_DELL_SMBIOS_SMM and CONFIG_DELL_SMBIOS_WMI are boolean
> rather than modules.
> 
> CONFIG_DELL_SMBIOS is a visually selectable option again and both
> CONFIG_DELL_SMBIOS_WMI and CONFIG_DELL_SMBIOS_SMM are optional.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> ---
> Changes from v2:
>  * Move rest of #ifdef out of source files
>  * Only compile units as necessary
> 
>  drivers/platform/x86/Kconfig            | 11 ++++++++---
>  drivers/platform/x86/Makefile           |  4 ++--
>  drivers/platform/x86/dell-smbios-base.c | 21 ++++++++++++++++++++-
>  drivers/platform/x86/dell-smbios-smm.c  | 18 ++++--------------
>  drivers/platform/x86/dell-smbios-wmi.c  | 14 ++++----------
>  drivers/platform/x86/dell-smbios.h      | 27 ++++++++++++++++++++++++++-
>  6 files changed, 64 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 9a8f964..0c0897e 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -106,10 +106,15 @@ config ASUS_LAPTOP
>  	  If you have an ACPI-compatible ASUS laptop, say Y or M here.
>  
>  config DELL_SMBIOS
> -	tristate
> +	tristate "Dell SMBIOS driver"
> +	---help---
> +	This provides support for the Dell SMBIOS calling interface.
> +	If you have a Dell computer you should enable this option.
> +
> +	Be sure to select at least one backend for it to work properly.
>  
>  config DELL_SMBIOS_WMI
> -	tristate "Dell SMBIOS calling interface (WMI implementation)"
> +	bool "Dell SMBIOS driver WMI support"

Oops, the help text still says Y or M for this and SMM - I'll correct locally.

-- 
Darren Hart
VMware Open Source Technology Center
