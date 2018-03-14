Date: Wed, 14 Mar 2018 12:54:17 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ooi, Joyce" <joyce.ooi@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	Ong Hean Loong <hean.loong.ong@intel.com>,
	Yves Vandervennet <yves.vandervennet@intel.com>
Subject: Re: [PATCH] drivers/misc: Add Intel interrupt latency counter driver
Message-ID: <20180314115417.GB25368@kroah.com>
References: <1521026710-24811-1-git-send-email-joyce.ooi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521026710-24811-1-git-send-email-joyce.ooi@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 07:25:10PM +0800, Ooi, Joyce wrote:
> Adding Intel interrupt latency counter driver support. This driver works
> together with the Intel interrupt latency driver soft IP to measure the
> time from the interrupt being asserted to the execution of the interrupt
> service routine. This driver and soft ip supports for both edge and level
> interrupt.
> 
> Signed-off-by: Ooi, Joyce <joyce.ooi@intel.com>

Why has no one else from Intel reviewed this and signed-off on the
patch?  Please always do that, don't make me do Intel-internal-review :)

> ---
>  .../misc/intel-interrupt-latency-counter.txt       |   49 ++++
>  drivers/misc/intel_ilc.c                           |  299 ++++++++++++++++++++
>  2 files changed, 348 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/misc/intel-interrupt-latency-counter.txt
>  create mode 100644 drivers/misc/intel_ilc.c
> 
> diff --git a/Documentation/devicetree/bindings/misc/intel-interrupt-latency-counter.txt b/Documentation/devicetree/bindings/misc/intel-interrupt-latency-counter.txt
> new file mode 100644
> index 0000000..9955550
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/intel-interrupt-latency-counter.txt

You forgot to cc: the correct device tree people :(

> --- /dev/null
> +++ b/drivers/misc/intel_ilc.c
> @@ -0,0 +1,299 @@
> +/*
> + * Copyright (C) 2018 Intel Corporation. All rights reserved
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */

Please just use the SPDX single line for this, as documented in the
kernel Documentation/ directory.

> +
> +#include <linux/device.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/kfifo.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/sysfs.h>
> +
> +#define DRV_NAME			"intel_ilc"
> +#define	CTRL_REG			0x80
> +#define FREQ_REG			0x84
> +#define	STP_REG				0x88
> +#define VLD_REG				0x8C
> +#define	ILC_MAX_PORTS		32
> +#define ILC_FIFO_DEFAULT	32
> +#define ILC_ENABLE			0x01
> +#define	CHAR_SIZE			10
> +#define POLL_INTERVAL		1
> +#define GET_PORT_COUNT(_val)		((_val & 0x7C) >> 2)
> +#define GET_VLD_BIT(_val, _offset)	(((_val) >> _offset) & 0x1)
> +
> +struct intel_ilc {
> +	struct platform_device	*pdev;
> +	void __iomem			*regs;
> +	unsigned int			port_count;
> +	unsigned int			irq;
> +	unsigned int			channel_offset;
> +	unsigned int			interrupt_channels[ILC_MAX_PORTS];
> +	struct kfifo			kfifos[ILC_MAX_PORTS];
> +	struct device_attribute dev_attr[ILC_MAX_PORTS];
> +	struct delayed_work     ilc_work;
> +	char					sysfs[ILC_MAX_PORTS][CHAR_SIZE];
> +	u32						fifo_depth;
> +};
> +
> +static int ilc_irq_lookup(struct intel_ilc *ilc, int irq)
> +{
> +	int i;
> +	for (i = 0; i < ilc->port_count; i++) {
> +		if (irq == platform_get_irq(ilc->pdev, i))
> +			return i;
> +	}
> +	return -EPERM;
> +}
> +
> +static ssize_t ilc_show_counter(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	int ret, i, id, fifo_len;
> +	unsigned int fifo_buf[ILC_MAX_PORTS];
> +	char	temp[10];
> +	struct  intel_ilc *ilc = dev_get_drvdata(dev);
> +
> +	fifo_len = 0;
> +	ret = kstrtouint(attr->attr.name, 0, &id);
> +
> +	for (i = 0; i < ilc->port_count; i++) {
> +		if (id == (ilc->interrupt_channels[i])) {
> +			/*Check for kfifo length*/
> +			fifo_len = kfifo_len(&ilc->kfifos[i])
> +				/sizeof(unsigned int);
> +			if (fifo_len <= 0) {
> +				dev_info(&ilc->pdev->dev, "Fifo for interrupt %s is empty\n",
> +					attr->attr.name);

dev_err()?  What can someone do with this information?

> +			return 0;
> +			}

Are you sure you ran checkpatch.pl on this code before sending it out?
Please do so.

> +			/*Read from kfifo*/
> +			ret = kfifo_out(&ilc->kfifos[i], &fifo_buf,
> +				kfifo_len(&ilc->kfifos[i]));
> +		}
> +	}
> +
> +	for (i = 0; i < fifo_len; i++) {
> +		sprintf(temp, "%u\n", fifo_buf[i]);
> +		strcat(buf, temp);
> +	}

sysfs is "one value per file", which I don't think you are doing here :(

Again, go get internal review of your code, this just makes me really
grumpy as you have access to resources that not many others do, yet you
do not take advantage of it and force the community to do their work for
them :(

Also, you forgot Documentation/ABI/ entries for all of your new sysfs
files, which are requried.

Please do all of this and then resend, and I'm going to require multiple
signed-off-by: lines from other Intel developers before I will accept
this.

thanks,

greg k-h
