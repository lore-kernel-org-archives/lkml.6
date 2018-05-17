Date: Thu, 17 May 2018 08:51:17 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Valentina Manea <valentina.manea.m@gmail.com>,
	Shuah Khan <shuah@kernel.org>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usbip: vhci_sysfs: fix potential Spectre v1
Message-ID: <20180517065117.GA12910@kroah.com>
References: <20180516222200.GA14733@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516222200.GA14733@embeddedor.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 16, 2018 at 05:22:00PM -0500, Gustavo A. R. Silva wrote:
> pdev_nr and rhport can be controlled by user-space, hence leading to
> a potential exploitation of the Spectre variant 1 vulnerability.
> 
> This issue was detected with the help of Smatch:
> drivers/usb/usbip/vhci_sysfs.c:238 detach_store() warn: potential
> spectre issue 'vhcis'
> drivers/usb/usbip/vhci_sysfs.c:328 attach_store() warn: potential
> spectre issue 'vhcis'
> drivers/usb/usbip/vhci_sysfs.c:338 attach_store() warn: potential
> spectre issue 'vhci->vhci_hcd_ss->vdev'
> drivers/usb/usbip/vhci_sysfs.c:340 attach_store() warn: potential
> spectre issue 'vhci->vhci_hcd_hs->vdev'

Nit, no need to line-wrap long error messages from tools :)

> Fix this by sanitizing pdev_nr and rhport before using them to index
> vhcis and vhci->vhci_hcd_ss->vdev respectively.
> 
> Notice that given that speculation windows are large, the policy is
> to kill the speculation on the first load and not worry if it can be
> completed with a dependent load/store [1].
> 
> [1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/usb/usbip/vhci_sysfs.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/usb/usbip/vhci_sysfs.c b/drivers/usb/usbip/vhci_sysfs.c
> index 4880838..9045888 100644
> --- a/drivers/usb/usbip/vhci_sysfs.c
> +++ b/drivers/usb/usbip/vhci_sysfs.c
> @@ -10,6 +10,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  
> +#include <linux/nospec.h>
> +
>  #include "usbip_common.h"
>  #include "vhci.h"
>  
> @@ -235,6 +237,8 @@ static ssize_t detach_store(struct device *dev, struct device_attribute *attr,
>  	if (!valid_port(pdev_nr, rhport))
>  		return -EINVAL;
>  
> +	pdev_nr = array_index_nospec(pdev_nr, vhci_num_controllers);
> +	rhport = array_index_nospec(rhport, VHCI_HC_PORTS);

Shouldn't we just do this in one place, in the valid_port() function?

That way it keeps the range checking logic in one place (now it is in 3
places in the function), which should make maintenance much simpler.

thanks,

greg k-h
