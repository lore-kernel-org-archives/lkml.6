Date: Fri, 4 May 2018 10:38:50 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Florian Schmaus <flo@geekplace.eu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] driver-core: Return EBUSY error instead of BUG_ON()
Message-ID: <20180504173850.GD4649@kroah.com>
References: <20180307094902.20316-1-flo@geekplace.eu>
 <20180504132357.31771-1-flo@geekplace.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180504132357.31771-1-flo@geekplace.eu>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 04, 2018 at 03:23:57PM +0200, Florian Schmaus wrote:
> I triggerd the BUG_ON() in driver_register(), which was added in
> f48f3febb2cbfd0f2ecee7690835ba745c1034a4, when booting a domU Xen
> domain. Since there was no contextual information logged, I needed to
> attach kgdb to determine the culprit (the wmi-bmof driver in my case).
> 
> Instead of running into a BUG_ON() we print an error message
> identifying the driver but continue booting.
> 
> Signed-off-by: Florian Schmaus <flo@geekplace.eu>
> ---
>  drivers/base/driver.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/driver.c b/drivers/base/driver.c
> index ba912558a510..63baec586eba 100644
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
> +		return -EBUSY;
> +	}

In looking at this code, that's a real bug somewhere in the logic of the
bus subsystem.  BUG_ON() is a pretty big hammer, I agree, but your error
message should be a lot more descriptive, and the error value should not
be BUSY, as something went wrong, it's not just a "come back later" type
of thing.

thanks,

greg k-h
