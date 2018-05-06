Date: Sat, 5 May 2018 21:55:30 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nubus: Unconditionally register bus type
Message-ID: <20180506045530.GA5328@kroah.com>
References: <5aee5ed3.1c69fb81.19d98.ef06SMTPIN_ADDED_MISSING@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5aee5ed3.1c69fb81.19d98.ef06SMTPIN_ADDED_MISSING@mx.google.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, May 06, 2018 at 11:47:52AM +1000, Finn Thain wrote:
> Loading a NuBus driver module on a non-NuBus machine triggers the
> BUG_ON(!drv->bus->p) in driver_register() because the bus does not get
> registered unless MACH_IS_MAC(). Avoid this by registering the bus
> unconditionally using postcore_initcall().
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reported-by: Michael Schmitz <schmitzmic@gmail.com>
> Tested-by: Stan Johnson <userm57@yahoo.com>
> Fixes: 7f86c765a6a2 ("nubus: Add support for the driver model")
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> ---
>  drivers/nubus/bus.c   | 3 ++-
>  drivers/nubus/nubus.c | 5 -----
>  include/linux/nubus.h | 1 -
>  3 files changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/nubus/bus.c b/drivers/nubus/bus.c
> index d306c348c857..27ca9f1a281b 100644
> --- a/drivers/nubus/bus.c
> +++ b/drivers/nubus/bus.c
> @@ -63,7 +63,7 @@ static struct device nubus_parent = {
>  	.init_name	= "nubus",
>  };
>  
> -int __init nubus_bus_register(void)
> +static int __init nubus_bus_register(void)
>  {
>  	int err;
>  
> @@ -78,6 +78,7 @@ int __init nubus_bus_register(void)
>  	device_unregister(&nubus_parent);
>  	return err;
>  }
> +postcore_initcall(nubus_bus_register);

Why not just have an "bus is registered" flag in your driver register
function that refuses to let drivers register with the driver core if it
isn't set?  And then fix your linking error, the bus should come first
in link order, before your drivers :)

thanks,

greg k-h
