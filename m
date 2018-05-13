Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751295AbeEMLMw (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 07:12:52 -0400
Received: from mail.skyhub.de ([5.9.137.197]:40646 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750941AbeEMLMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 07:12:51 -0400
Date: Sun, 13 May 2018 13:12:24 +0200
From: Borislav Petkov <bp@alien8.de>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Tony Luck <tony.luck@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Edac Mailing List <linux-edac@vger.kernel.org>
Subject: Re: [PATCH] edac: fix skx_edac build error when ACPI_NFIT=m
Message-ID: <20180513111224.GA16568@pd.tnic>
References: <2a09f7f3-c129-d4c4-76cc-223550601bdb@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2a09f7f3-c129-d4c4-76cc-223550601bdb@infradead.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 12, 2018 at 06:02:12PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Prevent build error when CONFIG_ACPI_NFIT=m and CONFIG_EDAC_SKX=y
> by limiting EDAC_SKX based on how ACPI_NFIT is set.
> 
> Fixes this build error:
> drivers/edac/skx_edac.o: In function `get_nvdimm_info':
> ../drivers/edac/skx_edac.c:399: undefined reference to `nfit_get_smbios_id'
> 
> Fixes: 58ca9ac1463d ("EDAC, skx_edac: Detect non-volatile DIMMs")
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: stable@vger.kernel.org
> ---
>  drivers/edac/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- lnx-417-rc4.orig/drivers/edac/Kconfig
> +++ lnx-417-rc4/drivers/edac/Kconfig
> @@ -232,6 +232,7 @@ config EDAC_SBRIDGE
>  config EDAC_SKX
>  	tristate "Intel Skylake server Integrated MC"
>  	depends on PCI && X86_64 && X86_MCE_INTEL && PCI_MMCONFIG
> +	depends on ACPI_NFIT || !ACPI_NFIT

I guess...

Although this reads really non-sensical. But it looks like enforcing the
state of the dependent symbol is being done in other places so please
add a comment similar to like it is done in those other places so that
it is clear:

drivers/usb/phy/Kconfig:25:     depends on USB_GADGET || !USB_GADGET # if USB_GADGET=m, this can't be 'y'
drivers/usb/phy/Kconfig:34:     depends on USB_GADGET || !USB_GADGET # if USB_GADGET=m, this can't be 'y'
drivers/usb/phy/Kconfig:57:     depends on USB_GADGET || !USB_GADGET # if USB_GADGET=m, NOP can't be built-in
drivers/usb/phy/Kconfig:93:     depends on USB_GADGET || !USB_GADGET # if USB_GADGET=m, this can't be 'y'
...

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
