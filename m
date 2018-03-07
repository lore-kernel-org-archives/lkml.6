Date: Wed, 7 Mar 2018 07:13:51 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Florian Schmaus <flo@geekplace.eu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver-core: Log the BUG() causing driver
Message-ID: <20180307151351.GA1598@kroah.com>
References: <20180307094902.20316-1-flo@geekplace.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180307094902.20316-1-flo@geekplace.eu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 07, 2018 at 10:49:02AM +0100, Florian Schmaus wrote:
> I triggerd the BUG_ON(), which was added in
> f48f3febb2cbfd0f2ecee7690835ba745c1034a4, when booting a domU Xen
> domain.

How?

> Since there was no contextual information logged, I needed to
> attach kgdb to determine the culprit (the wmi-bmof driver in my case).
> 
> Signed-off-by: Florian Schmaus <flo@geekplace.eu>
> ---
>  drivers/base/driver.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/driver.c b/drivers/base/driver.c
> index ba912558a510..55f8db41df2b 100644
> --- a/drivers/base/driver.c
> +++ b/drivers/base/driver.c
> @@ -148,7 +148,11 @@ int driver_register(struct device_driver *drv)
>  	int ret;
>  	struct device_driver *other;
>  
> -	BUG_ON(!drv->bus->p);
> +	if (!drv->bus->p) {
> +		printk(KERN_ERR "Driver '%s' was unable to register bus_type\n",
> +			   drv->name);
> +		BUG();
> +	}

We could just log the error and return with an error, that would be
nicer, right?  Crashing the system isn't usually a good idea, even at
boot time :)

thanks,

greg k-h
