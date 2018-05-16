Date: Wed, 16 May 2018 17:39:04 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Florian Schmaus <flo@geekplace.eu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] driver-core: return EINVAL error instead of
 BUG_ON()
Message-ID: <20180516153904.GD23725@kroah.com>
References: <20180515135114.31939-1-flo@geekplace.eu>
 <20180516120527.29403-2-flo@geekplace.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516120527.29403-2-flo@geekplace.eu>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 16, 2018 at 02:05:25PM +0200, Florian Schmaus wrote:
> I triggerd the BUG_ON() in driver_register() when booting a domU Xen
> domain. Since there was no contextual information logged, I needed to
> attach kgdb to determine the culprit (the wmi-bmof driver in my
> case). The BUG_ON() was added in commit f48f3febb2cb ("driver-core: do
> not register a driver with bus_type not registered").
> 
> Instead of running into a BUG_ON() we print an error message
> identifying the, likely faulty, driver but continue booting.
> 
> Signed-off-by: Florian Schmaus <flo@geekplace.eu>
> ---
> 
> Notes:
>     - Also print out the bus name
>     - Use pr_err() instead of printk()
> 
>  drivers/base/driver.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/driver.c b/drivers/base/driver.c
> index ba912558a510..203fa731e3ee 100644
> --- a/drivers/base/driver.c
> +++ b/drivers/base/driver.c
> @@ -148,7 +148,12 @@ int driver_register(struct device_driver *drv)
>  	int ret;
>  	struct device_driver *other;
>  
> -	BUG_ON(!drv->bus->p);
> +	if (!drv->bus->p) {
> +		pr_err("Driver '%s' was unable to register with bus_type '%s'"
> +			   " because it was not initialized.\n",

Are you using checkpatch.pl?

Anyway, long strings should never be split across lines.  This needs to
be one line.

Sometimes making small changes is hard :)

thanks,

greg k-h
