Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932864AbeCMMQm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 08:16:42 -0400
Received: from mga17.intel.com ([192.55.52.151]:35051 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752390AbeCMMQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 08:16:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,464,1515484800";
   d="scan'208";a="37766580"
Message-ID: <1520943394.10722.610.camel@linux.intel.com>
Subject: Re: [PATCH] x86: i8237: Register based on FADT legacy boot flag
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>, x86@kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, rjw@rjwysocki.net,
        anshuman.gupta@intel.com, linux-kernel@vger.kernel.org,
        Alan Cox <alan@linux.intel.com>
Date: Tue, 13 Mar 2018 14:16:34 +0200
In-Reply-To: <1520938787-14861-1-git-send-email-rajneesh.bhardwaj@intel.com>
References: <1520938787-14861-1-git-send-email-rajneesh.bhardwaj@intel.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-03-13 at 16:29 +0530, Rajneesh Bhardwaj wrote:
> From Skylake onwards, the platform controller hub (Sunrisepoint PCH)
> does
> not support legacy DMA operations to IO ports 81h-83h, 87h, 89h-8Bh,
> 8Fh.
> Currently this driver registers as syscore ops and its resume function
> is
> called on every resume from S3. On Skylake and Kabylake, this causes a
> resume delay of around 100ms due to port IO operations, which is a
> problem.
> 
> This change allows to load the driver only when the platform bios
> explicitly supports such devices or has a cut-off date earlier than
> 2017.
> 
> Please refer to chapter 21 of 6th Generation Intel® Core™ Processor
> Platform Controller Hub Family: BIOS Specification.
> 
> https://www.intel.in/content/www/in/en/embedded/products/skylake/u-mob
> ile/software-and-drivers.html
> 

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

One comment below.

> Cc: Alan Cox <alan@linux.intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
> ---
> 
> This depends on recently introduced dmi_get_bios_year() helper.
> https://patchwork.kernel.org/patch/10252151/
> 
>  arch/x86/kernel/i8237.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/x86/kernel/i8237.c b/arch/x86/kernel/i8237.c
> index 8eeaa81de066..5c7a0dea7e19 100644
> --- a/arch/x86/kernel/i8237.c
> +++ b/arch/x86/kernel/i8237.c
> @@ -9,6 +9,7 @@
>   * your option) any later version.
>   */
>  
> +#include <linux/dmi.h>
>  #include <linux/init.h>
>  #include <linux/syscore_ops.h>
>  
> @@ -49,6 +50,30 @@ static struct syscore_ops i8237_syscore_ops = {
>  
>  static int __init i8237A_init_ops(void)
>  {
> +	/*
> +	 * From SKL PCH onwards, the port 0x61 bit 4 would stop
> toggle and
> +	 * the legacy DMA device is removed in which the I/O ports
> (81h-83h,
> +	 * 87h, 89h-8Bh, 8Fh)  related to it are removed as well. All
> +	 * removed ports must return 0xff for a inb() request.
> +	 *
> +	 * Note: DMA_PAGE_2 (port 0x81) should not be checked for
> detecting
> +	 * the presence of DMA device since it may be used by BIOS to
> decode
> +	 * LPC traffic for POST codes. Original LPC only decodes one
> byte of
> +	 * port 0x80 but some BIOS may choose to enhance PCH LPC port
> 0x8x
> +	 * decoding.
> +	 */

> +	if (inb(DMA_PAGE_0) == 0xFF)

To be consistent with the rest of the code, this should be dma_inb().

> +		return -ENODEV;
> +
> +	/*
> +	 * It should be OK to not load this driver as newer SoC may
> not
> +	 * support 8237 DMA or bus mastering from LPC. Platform
> firmware
> +	 * must announce the support for such legacy devices via
> +	 * ACPI_FADT_LEGACY_DEVICES field in FADT table.
> +	 */
> +	if (!x86_platform.legacy.devices.pnpbios &&
> dmi_get_bios_year() >= 2017)
> +		return -ENODEV;
> +
>  	register_syscore_ops(&i8237_syscore_ops);
>  	return 0;
>  }

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
