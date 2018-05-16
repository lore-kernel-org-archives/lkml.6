Date: Wed, 16 May 2018 18:37:07 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Florian Schmaus <flo@geekplace.eu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] driver-core: print bus registration error value
Message-ID: <20180516163707.GD20425@kroah.com>
References: <20180516120527.29403-1-flo@geekplace.eu>
 <20180516160816.20251-4-flo@geekplace.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516160816.20251-4-flo@geekplace.eu>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 16, 2018 at 06:08:16PM +0200, Florian Schmaus wrote:
> If driver_register() is called with an device driver which previously
> called bus_register() but failed, then print out the bus_register()
> error code.
> 
> Signed-off-by: Florian Schmaus <flo@geekplace.eu>
> ---
> 
> Notes:
>     - Do not split long strings across lines.
> 
>  drivers/base/driver.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/driver.c b/drivers/base/driver.c
> index 16b81d1c6cb7..a1fe7cb43c7e 100644
> --- a/drivers/base/driver.c
> +++ b/drivers/base/driver.c
> @@ -149,8 +149,14 @@ int driver_register(struct device_driver *drv)
>  	struct device_driver *other;
>  
>  	if (!drv->bus->p) {
> -		pr_err("Driver '%s' was unable to register with bus_type '%s' because it was not initialized.\n",
> -			   drv->name, drv->bus->name);
> +		if (drv->bus->bus_register_error) {
> +			pr_err("Driver '%s' was unable to register with bus_type '%s' because of error: %d.\n",
> +				   drv->name, drv->bus->name,
> +				   drv->bus->bus_register_error);

The error was with the bus registration, not the driver registration.

And really, when has this ever happened?  Why would a bus registration
fail and later allow a driver to be registered?  The bus registration
error would have shown up somewhere, no need to keep it around for no
real good reason.

So I don't think that patches 2 and 3 are needed at all here, sorry.

thanks,

greg k-h
