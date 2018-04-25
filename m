Date: Wed, 25 Apr 2018 18:06:45 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Russell King <linux@armlinux.org.uk>,
	Adrian Salido <salidoa@google.com>,
	Nicolai Stange <nstange@suse.de>,
	Sasha Levin <Alexander.Levin@microsoft.com>,
	Todd Kjos <tkjos@android.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] ARM: amba: Fix race condition with driver_override
Message-ID: <20180425160645.GA16732@kroah.com>
References: <1523366506-19832-1-git-send-email-geert+renesas@glider.be>
 <1523366506-19832-3-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523366506-19832-3-git-send-email-geert+renesas@glider.be>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 10, 2018 at 03:21:44PM +0200, Geert Uytterhoeven wrote:
> The driver_override implementation is susceptible to a race condition
> when different threads are reading vs storing a different driver
> override.  Add locking to avoid this race condition.
> 
> Cfr. commits 6265539776a0810b ("driver core: platform: fix race
> condition with driver_override") and 9561475db680f714 ("PCI: Fix race
> condition with driver_override").
> 
> Fixes: 3cf385713460eb2b ("ARM: 8256/1: driver coamba: add device binding path 'driver_override'")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Todd Kjos <tkjos@google.com>
> Cc: stable <stable@vger.kernel.org>
> ---
>  drivers/amba/bus.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> index 6ffd778352e6d953..36c5653ced5742b7 100644
> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -69,8 +69,12 @@ static ssize_t driver_override_show(struct device *_dev,
>  				    struct device_attribute *attr, char *buf)
>  {
>  	struct amba_device *dev = to_amba_device(_dev);
> +	ssize_t len;
>  
> -	return sprintf(buf, "%s\n", dev->driver_override);
> +	device_lock(_dev);
> +	len = sprintf(buf, "%s\n", dev->driver_override);
> +	device_unlock(_dev);
> +	return len;
>  }
>  
>  static ssize_t driver_override_store(struct device *_dev,
> @@ -78,7 +82,7 @@ static ssize_t driver_override_store(struct device *_dev,
>  				     const char *buf, size_t count)
>  {
>  	struct amba_device *dev = to_amba_device(_dev);
> -	char *driver_override, *old = dev->driver_override, *cp;
> +	char *driver_override, *old, *cp;
>  
>  	if (count > PATH_MAX)
>  		return -EINVAL;
> @@ -91,12 +95,15 @@ static ssize_t driver_override_store(struct device *_dev,
>  	if (cp)
>  		*cp = '\0';
>  
> +	device_lock(_dev);
> +	old = dev->driver_override;
>  	if (strlen(driver_override)) {
>  		dev->driver_override = driver_override;
>  	} else {
>  	       kfree(driver_override);
>  	       dev->driver_override = NULL;
>  	}
> +	device_unlock(_dev);
>  
>  	kfree(old);
>  
> -- 
> 2.7.4

As this should go to stable kernels, I've fixed it up to apply without
patch 1 as that's not a real "fix" that anyone needs...

Please try to remember to put fixes first, and then "trivial" things
later on in a series.

thanks,

greg k-h
