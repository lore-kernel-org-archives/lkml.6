Date: Fri, 23 Mar 2018 14:17:12 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	Mark Rutland <mark.rutland@arm.com>, Nandor Han <nandor.han@ge.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	kernel@collabora.com
Subject: Re: [PATCH 1/2] misc: ezport-firmware: new driver
Message-ID: <20180323131712.GA32169@kroah.com>
References: <20180320172201.2065-1-sebastian.reichel@collabora.co.uk>
 <20180320172201.2065-2-sebastian.reichel@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320172201.2065-2-sebastian.reichel@collabora.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 20, 2018 at 06:22:00PM +0100, Sebastian Reichel wrote:
> General Electric Healthcare's PPD has a secondary processor from
> NXP's Kinetis K20 series. It's firmware can be updated from Linux
> using the EzPort interface. This driver implements the firmware
> updating process.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> ---
>  Documentation/devicetree/bindings/misc/ge-achc.txt |  19 +-

Bindings should be in a separate patch, right?

> +static int ezport_read_data(struct spi_device *spi, u32 address,
> +			    u8 *buffer, size_t size)
> +{
> +	struct spi_transfer xfers[2] = {};

You can send SPI data from the stack?

> +	u8 *query = kmalloc(EZPORT_FAST_READ_SIZE, GFP_KERNEL);
> +	int ret;
> +
> +	if (!query)
> +		return -ENOMEM;
> +
> +	query[0] = EZPORT_CMD_FAST_READ;
> +	query[1] = address >> 16;
> +	query[2] = address >> 8;
> +	query[3] = address >> 0;
> +	query[4] = EZPORT_DUMMY;
> +
> +	xfers[0].len = EZPORT_FAST_READ_SIZE;
> +	xfers[0].tx_buf = query;
> +
> +	xfers[1].len = size;
> +	xfers[1].rx_buf = buffer;
> +
> +	ret = spi_sync_transfer(spi, xfers, 2);
> +
> +	kfree(query);
> +
> +	return ret;
> +}
> +static DEVICE_ATTR_WO(update_fw);
> +static DEVICE_ATTR_RO(verify_fw);

New sysfs attributes need Documentation/ABI updates please.

Also please fix up the kbuild-reported build errors.

thanks,

greg k-h
