Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751892AbeCNMse (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 08:48:34 -0400
Received: from mga06.intel.com ([134.134.136.31]:4194 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751279AbeCNMsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 08:48:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,470,1515484800";
   d="scan'208";a="182661854"
Message-ID: <1521031707.10722.632.camel@linux.intel.com>
Subject: Re: [PATCH v2] x86: i8237: Register based on FADT legacy boot flag
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>, x86@kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, rjw@rjwysocki.net,
        anshuman.gupta@intel.com, linux-kernel@vger.kernel.org,
        Alan Cox <alan@linux.intel.com>
Date: Wed, 14 Mar 2018 14:48:27 +0200
In-Reply-To: <1521004627-30329-1-git-send-email-rajneesh.bhardwaj@intel.com>
References: <1521004627-30329-1-git-send-email-rajneesh.bhardwaj@intel.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-03-14 at 10:47 +0530, Rajneesh Bhardwaj wrote:
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
> Cc: Alan Cox <alan@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
> ---
> Changes in v2:
>  * changed to dma_inb()
> 
> This depends on recently introduced dmi_get_bios_year() helper.
> https://patchwork.kernel.org/patch/10252151/
>  arch/x86/kernel/i8237.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/x86/kernel/i8237.c b/arch/x86/kernel/i8237.c
> index 8eeaa81de066..bf5d8104e17b 100644
> --- a/arch/x86/kernel/i8237.c
> +++ b/arch/x86/kernel/i8237.c
> @@ -9,6 +9,7 @@
>   * your option) any later version.
>   */
>  
> +#include <linux/dmi.h>
>  #include <linux/init.h>
>  #include <linux/syscore_ops.h>

As kbuild bot rightfully noticed, you need to add
x86_init.h inclusion to the driver.

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
> +	if (dma_inb(DMA_PAGE_0) == 0xFF)
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
