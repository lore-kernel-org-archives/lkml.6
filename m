Date: Fri, 9 Mar 2018 09:53:47 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>,
	Andy Shevchenko <andy@infradead.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Guenter Roeck <linux@roeck-us.net>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH v6 01/12] drivers: base: Unified device connection lookup
Message-ID: <20180309175347.GA12150@kroah.com>
References: <20180302102057.8917-1-hdegoede@redhat.com>
 <20180302102057.8917-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180302102057.8917-2-hdegoede@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 02, 2018 at 11:20:46AM +0100, Hans de Goede wrote:
> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 
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
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Sorry for the delay, just now reviewing this patch...

The content is fine (if not scary for the obvious reason of passing
around 'struct device' of different bus types, but ok...), but the api
naming is "rough":

> --- /dev/null
> +++ b/include/linux/connection.h

"connection.h" is vague, why not just put this in device.h?

> @@ -0,0 +1,34 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#ifndef _LINUX_CONNECTION_H_
> +#define _LINUX_CONNECTION_H_
> +
> +#include <linux/list.h>
> +
> +struct device;
> +
> +/**
> + * struct devcon - Device Connection Descriptor
> + * @endpoint: The names of the two devices connected together
> + * @id: Unique identifier for the connection
> + * @list: List head, private for devcon internal use only
> + */
> +struct devcon {

'struct device_connection'?  Spell it out please, people might think
this is a "developer conference" :)

> +	const char		*endpoint[2];
> +	const char		*id;
> +	struct list_head	list;
> +};
> +
> +void *__device_find_connection(struct device *dev, const char *con_id,
> +			       void *data,
> +			       void *(*match)(struct devcon *con, int ep,
> +					      void *data));

Ick, __* functions are usually "no lock needed", but here you are doing
a lot "more" than the normal device_find_connection() call.  Why not
make this:
	device_connection_find_match()?

> +
> +struct device *device_find_connection(struct device *dev, const char *con_id);

device_connection_find()?

> +
> +#define DEVCON(_ep0, _ep1, _id)    (struct devcon) { { _ep0, _ep1 }, _id, }

Can you use named identifiers here?

> +
> +void add_device_connection(struct devcon *con);
> +void remove_device_connection(struct devcon *con);

device_connection_add() and device_connection_remove()?

I can make the api name changes in an add-on patch.

thanks,

greg k-h
