Date: Tue, 20 Mar 2018 10:20:04 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Darren Hart <dvhart@infradead.org>,
	Andy Shevchenko <andy@infradead.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Guenter Roeck <linux@roeck-us.net>, Jun Li <jun.li@nxp.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH v8 01/12] drivers: base: Unified device connection lookup
Message-ID: <20180320092004.GA21081@kroah.com>
References: <20180314131215.70833-1-heikki.krogerus@linux.intel.com>
 <20180314131215.70833-2-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314131215.70833-2-heikki.krogerus@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 04:12:04PM +0300, Heikki Krogerus wrote:
> Several frameworks - clk, gpio, phy, pmw, etc. - maintain
> lookup tables for describing connections and provide custom
> API for handling them. This introduces a single generic
> lookup table and API for the connections.
> 
> The motivation for this commit is centralizing the
> connection lookup, but the goal is to ultimately extract the
> connection descriptions also from firmware by using the
> fwnode_graph_* functions and other mechanisms that are
> available.
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
> Changes in v8:
> - No longer using rcu.

Ok, but then:

> +void *device_connection_find_match(struct device *dev, const char *con_id,
> +			       void *data,
> +			       void *(*match)(struct device_connection *con,
> +					      int ep, void *data))
> +{
> +	const char *devname = dev_name(dev);
> +	struct device_connection *con;
> +	void *ret = NULL;
> +	int ep;
> +
> +	if (!match)
> +		return NULL;
> +
> +	mutex_lock(&devcon_lock);
> +
> +	list_for_each_entry_rcu(con, &devcon_list, list) {

_rcu calls everywhere :(

Did you send out the right version of this patch?

Also, further down you do:

> +#include <linux/platform_device.h>
> +#include <linux/spi/spi.h>
> +#include <linux/i2c.h>
> +#include <linux/pci.h>

Eeek, #include in the middle of a file, not good.

> +
> +static struct bus_type *generic_match_buses[] = {
> +	&platform_bus_type,
> +#ifdef CONFIG_PCI
> +	&pci_bus_type,
> +#endif
> +#ifdef CONFIG_I2C
> +	&i2c_bus_type,
> +#endif
> +#ifdef CONFIG_SPI_MASTER
> +	&spi_bus_type,
> +#endif
> +	NULL,
> +};

Can't you just declare the above as "extern" variables and not need the
#include?  Yeah, checkpatch will complain, but it should be fine here as
we really don't want the full .h files here (or need them.)

> +void device_connection_remove(struct device_connection *con)
> +{
> +	mutex_lock(&devcon_lock);
> +	list_del_rcu(&con->list);

See, rcu?

thanks,

greg k-h
