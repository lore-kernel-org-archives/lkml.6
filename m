Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034564AbeE1Pgf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:36:35 -0400
Received: from mga12.intel.com ([192.55.52.136]:55315 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S969060AbeE1Pgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 11:36:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,453,1520924400";
   d="scan'208";a="62364446"
Message-ID: <0641e04f2d9f4fb0a24201856f4024a8b7a2b29f.camel@linux.intel.com>
Subject: Re: [PATCH] mfd: intel-lpss: Fix Intel Cannon Lake LPSS I2C input
 clock
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc: Lee Jones <lee.jones@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, linux-input@vger.kernel.org,
        Jian-Hong Pan <jian-hong@endlessm.com>, Chris Chiu <chiu@endlessm.com>,
        Daniel Drake <drake@endlessm.com>, stable@vger.kernel.org
Date: Mon, 28 May 2018 18:36:27 +0300
In-Reply-To: <20180518083827.20626-1-jarkko.nikula@linux.intel.com>
References: <20180518083827.20626-1-jarkko.nikula@linux.intel.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-05-18 at 11:38 +0300, Jarkko Nikula wrote:
> Intel Cannon Lake PCH has much higher 216 MHz input clock to LPSS I2C
> than Sunrisepoint which uses 120 MHz. Preliminary information was that
> both share the same clock rate but actual silicon implements elevated
> rate for better support for 3.4 MHz high-speed I2C.
> 
> This incorrect input clock rate results too high I2C bus clock in case
> ACPI doesn't provide tuned I2C timing parameters since I2C host
> controller driver calculates them from input clock rate.
> 
> Fix this by using the correct rate. We still share the same 230 ns SDA
> hold time value than Sunrisepoint.
> 

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

P.S. Documentation we have is not perfect, that's why previously I
though about Broxton/Cannonlake case as single, which is wrong, they are
different in terms of i2c clock organization.

> Cc: stable@vger.kernel.org
> Fixes: b418bbff36dd ("mfd: intel-lpss: Add Intel Cannonlake PCI IDs")
> Reported-by: Jian-Hong Pan <jian-hong@endlessm.com>
> Reported-by: Chris Chiu <chiu@endlessm.com>
> Reported-by: Daniel Drake <drake@endlessm.com>
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> ---
> Hi Jian-Hong, Chris and Daniel. Could you test does this fix your
> touchpad issue?
> ---
>  drivers/mfd/intel-lpss-pci.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-
> pci.c
> index d1c46de89eb4..d9ae983095c5 100644
> --- a/drivers/mfd/intel-lpss-pci.c
> +++ b/drivers/mfd/intel-lpss-pci.c
> @@ -124,6 +124,11 @@ static const struct intel_lpss_platform_info
> apl_i2c_info = {
>  	.properties = apl_i2c_properties,
>  };
>  
> +static const struct intel_lpss_platform_info cnl_i2c_info = {
> +	.clk_rate = 216000000,
> +	.properties = spt_i2c_properties,
> +};
> +
>  static const struct pci_device_id intel_lpss_pci_ids[] = {
>  	/* BXT A-Step */
>  	{ PCI_VDEVICE(INTEL, 0x0aac), (kernel_ulong_t)&bxt_i2c_info
> },
> @@ -207,13 +212,13 @@ static const struct pci_device_id
> intel_lpss_pci_ids[] = {
>  	{ PCI_VDEVICE(INTEL, 0x9daa), (kernel_ulong_t)&spt_info },
>  	{ PCI_VDEVICE(INTEL, 0x9dab), (kernel_ulong_t)&spt_info },
>  	{ PCI_VDEVICE(INTEL, 0x9dfb), (kernel_ulong_t)&spt_info },
> -	{ PCI_VDEVICE(INTEL, 0x9dc5), (kernel_ulong_t)&spt_i2c_info
> },
> -	{ PCI_VDEVICE(INTEL, 0x9dc6), (kernel_ulong_t)&spt_i2c_info
> },
> +	{ PCI_VDEVICE(INTEL, 0x9dc5), (kernel_ulong_t)&cnl_i2c_info
> },
> +	{ PCI_VDEVICE(INTEL, 0x9dc6), (kernel_ulong_t)&cnl_i2c_info
> },
>  	{ PCI_VDEVICE(INTEL, 0x9dc7), (kernel_ulong_t)&spt_uart_info
> },
> -	{ PCI_VDEVICE(INTEL, 0x9de8), (kernel_ulong_t)&spt_i2c_info
> },
> -	{ PCI_VDEVICE(INTEL, 0x9de9), (kernel_ulong_t)&spt_i2c_info
> },
> -	{ PCI_VDEVICE(INTEL, 0x9dea), (kernel_ulong_t)&spt_i2c_info
> },
> -	{ PCI_VDEVICE(INTEL, 0x9deb), (kernel_ulong_t)&spt_i2c_info
> },
> +	{ PCI_VDEVICE(INTEL, 0x9de8), (kernel_ulong_t)&cnl_i2c_info
> },
> +	{ PCI_VDEVICE(INTEL, 0x9de9), (kernel_ulong_t)&cnl_i2c_info
> },
> +	{ PCI_VDEVICE(INTEL, 0x9dea), (kernel_ulong_t)&cnl_i2c_info
> },
> +	{ PCI_VDEVICE(INTEL, 0x9deb), (kernel_ulong_t)&cnl_i2c_info
> },
>  	/* SPT-H */
>  	{ PCI_VDEVICE(INTEL, 0xa127), (kernel_ulong_t)&spt_uart_info
> },
>  	{ PCI_VDEVICE(INTEL, 0xa128), (kernel_ulong_t)&spt_uart_info
> },
> @@ -240,10 +245,10 @@ static const struct pci_device_id
> intel_lpss_pci_ids[] = {
>  	{ PCI_VDEVICE(INTEL, 0xa32b), (kernel_ulong_t)&spt_info },
>  	{ PCI_VDEVICE(INTEL, 0xa37b), (kernel_ulong_t)&spt_info },
>  	{ PCI_VDEVICE(INTEL, 0xa347), (kernel_ulong_t)&spt_uart_info
> },
> -	{ PCI_VDEVICE(INTEL, 0xa368), (kernel_ulong_t)&spt_i2c_info
> },
> -	{ PCI_VDEVICE(INTEL, 0xa369), (kernel_ulong_t)&spt_i2c_info
> },
> -	{ PCI_VDEVICE(INTEL, 0xa36a), (kernel_ulong_t)&spt_i2c_info
> },
> -	{ PCI_VDEVICE(INTEL, 0xa36b), (kernel_ulong_t)&spt_i2c_info
> },
> +	{ PCI_VDEVICE(INTEL, 0xa368), (kernel_ulong_t)&cnl_i2c_info
> },
> +	{ PCI_VDEVICE(INTEL, 0xa369), (kernel_ulong_t)&cnl_i2c_info
> },
> +	{ PCI_VDEVICE(INTEL, 0xa36a), (kernel_ulong_t)&cnl_i2c_info
> },
> +	{ PCI_VDEVICE(INTEL, 0xa36b), (kernel_ulong_t)&cnl_i2c_info
> },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(pci, intel_lpss_pci_ids);

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
