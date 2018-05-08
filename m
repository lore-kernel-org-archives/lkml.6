Date: Tue, 8 May 2018 09:01:29 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nubus: Unconditionally register bus type
Message-ID: <20180508070129.GB4792@kroah.com>
References: <5aee5ed3.1c69fb81.19d98.ef06SMTPIN_ADDED_MISSING@mx.google.com>
 <20180506045530.GA5328@kroah.com>
 <alpine.LNX.2.21.1805061544550.8@nippy.intranet>
 <20180506202018.GC8924@kroah.com>
 <alpine.LNX.2.21.1805070930240.8@nippy.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.21.1805070930240.8@nippy.intranet>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 07, 2018 at 09:57:22AM +1000, Finn Thain wrote:
> On Sun, 6 May 2018, Greg Kroah-Hartman wrote:
> 
> > > > Why not just have an "bus is registered" flag in your driver 
> > > > register function that refuses to let drivers register with the 
> > > > driver core if it isn't set?
> > > 
> > > Perhaps that should happen in the core driver_register() function. 
> > > BUG_ON is frowned upon, after all. Would that be acceptable?
> > 
> > I don't understand what you mean here, perhaps make a patch to show it?
> > 
> 
> As an alternative to your suggestion (add flag to avoid the BUG_ON):
> 
> --- a/drivers/base/driver.c
> +++ b/drivers/base/driver.c
> @@ -148,7 +148,10 @@ int driver_register(struct device_driver *drv)
>  	int ret;
>  	struct device_driver *other;
>  
> -	BUG_ON(!drv->bus->p);
> +	if (!drv->bus->p) {
> +		WARN_ONCE(1, "Cannot register driver with invalid bus\n");
> +		return -EPROBE_DEFER;
> +	}
>  
>  	if ((drv->bus->probe && drv->probe) ||
>  	    (drv->bus->remove && drv->remove) ||
> 
> I'm not actually proposing this change; just responding to your question.
> 
> For the bug at hand, I still prefer the patch at the beginning of this 
> thread, because it seems to follow the conventional pattern.
> 
> > > I found a few drivers that set a flag the way you describe, which 
> > > could then be simplified.
> > > 
> > > But that pattern is rare. Most buses use the postcore_initcall() 
> > > pattern, and so my patch took the conventional approach.
> > 
> > It all depends on link order, not necessarily the postcore stuff.
> > 
> > > > And then fix your linking error, the bus should come first in link 
> > > > order, before your drivers :)
> > > > 
> > > 
> > > I didn't encounter any errors. How shall I reproduce this?
> > 
> > If you have not seen this error, then why change the code at all if it 
> > is working properly?
> 
> I never saw the link error you mentioned.
> 
> Please see this thread for one example of how to hit the BUG_ON.
> https://marc.info/?l=linux-m68k&m=152522162801182&w=2
> 
> Another way to trigger the BUG_ON is to set,
> CONFIG_ATARI=y
> CONFIG_MAC=y
> CONFIG_NUBUS=y
> CONFIG_MAC8390=y
> and try to boot the result on aranym.

See my other response in this thread describing the link order problem.
But if you can't resolve this that way, then yes, your original patch
should be fine.

thanks,

greg k-h
