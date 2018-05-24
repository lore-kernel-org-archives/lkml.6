Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034247AbeEXSQz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 14:16:55 -0400
Received: from mga07.intel.com ([134.134.136.100]:12412 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032509AbeEXSQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 14:16:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,436,1520924400";
   d="scan'208";a="42563555"
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v3 4/4] usb: roles: intel_xhci: Enable runtime PM
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20180524081827.37861-1-heikki.krogerus@linux.intel.com>
 <20180524081827.37861-5-heikki.krogerus@linux.intel.com>
From: sathyanarayanan kuppuswamy
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <fbc90f91-1965-d612-ae33-ac1fa450ea47@linux.intel.com>
Date: Thu, 24 May 2018 11:16:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180524081827.37861-5-heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 05/24/2018 01:18 AM, Heikki Krogerus wrote:
> This fixes an issue where the mux does not get configured
> when the parent device is suspended. The registers for this
> mux are mapped to the parent device MMIO (usually xHCI PCI
> device), so in order for the driver to be able to program
> the registers, the parent device must be resumed.
>
> Reported-by: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>
> Fixes: f6fb9ec02be1 ("usb: roles: Add Intel xHCI USB role switch driver")
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Tested-by: Kuppuswamy Sathyanarayanan 
<sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>   drivers/usb/roles/intel-xhci-usb-role-switch.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/roles/intel-xhci-usb-role-switch.c b/drivers/usb/roles/intel-xhci-usb-role-switch.c
> index 6e922b50b674..1fb3dd0f1dfa 100644
> --- a/drivers/usb/roles/intel-xhci-usb-role-switch.c
> +++ b/drivers/usb/roles/intel-xhci-usb-role-switch.c
> @@ -18,6 +18,7 @@
>   #include <linux/kernel.h>
>   #include <linux/module.h>
>   #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>   #include <linux/usb/role.h>
>   
>   /* register definition */
> @@ -56,6 +57,8 @@ static int intel_xhci_usb_set_role(struct device *dev, enum usb_role role)
>   		return -EIO;
>   	}
>   
> +	pm_runtime_get_sync(dev);
> +
>   	/* Set idpin value as requested */
>   	val = readl(data->base + DUAL_ROLE_CFG0);
>   	switch (role) {
> @@ -84,13 +87,17 @@ static int intel_xhci_usb_set_role(struct device *dev, enum usb_role role)
>   	/* Polling on CFG1 register to confirm mode switch.*/
>   	do {
>   		val = readl(data->base + DUAL_ROLE_CFG1);
> -		if (!!(val & HOST_MODE) == (role == USB_ROLE_HOST))
> +		if (!!(val & HOST_MODE) == (role == USB_ROLE_HOST)) {
> +			pm_runtime_put(dev);
>   			return 0;
> +		}
>   
>   		/* Interval for polling is set to about 5 - 10 ms */
>   		usleep_range(5000, 10000);
>   	} while (time_before(jiffies, timeout));
>   
> +	pm_runtime_put(dev);
> +
>   	dev_warn(dev, "Timeout waiting for role-switch\n");
>   	return -ETIMEDOUT;
>   }
> @@ -101,7 +108,9 @@ static enum usb_role intel_xhci_usb_get_role(struct device *dev)
>   	enum usb_role role;
>   	u32 val;
>   
> +	pm_runtime_get_sync(dev);
>   	val = readl(data->base + DUAL_ROLE_CFG0);
> +	pm_runtime_put(dev);
>   
>   	if (!(val & SW_IDPIN))
>   		role = USB_ROLE_HOST;
> @@ -142,6 +151,9 @@ static int intel_xhci_usb_probe(struct platform_device *pdev)
>   	if (IS_ERR(data->role_sw))
>   		return PTR_ERR(data->role_sw);
>   
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +
>   	return 0;
>   }
>   

-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer
