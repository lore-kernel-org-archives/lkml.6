Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750970AbeBPXqU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 18:46:20 -0500
Received: from g2t2353.austin.hpe.com ([15.233.44.26]:44875 "EHLO
        g2t2353.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750727AbeBPXqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 18:46:19 -0500
Date: Fri, 16 Feb 2018 16:46:17 -0700
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, rwright@hpe.com,
        maurice.a.saldivar@hpe.com, mingo@kernel.org,
        marcus.folkesson@gmail.com
Subject: Re: [PATCH v3 08/11] watchdog/hpwdt: Programable Pretimeout NMI
Message-ID: <20180216234617.GA675@anatevka.americas.hpqcorp.net>
Reply-To: Jerry.Hoemann@hpe.com
References: <20180215234400.5022-1-jerry.hoemann@hpe.com>
 <20180215234400.5022-9-jerry.hoemann@hpe.com>
 <20180216203440.GA31849@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216203440.GA31849@roeck-us.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 12:34:40PM -0800, Guenter Roeck wrote:
> On Thu, Feb 15, 2018 at 04:43:57PM -0700, Jerry Hoemann wrote:
> > Make whether or not the hpwdt watchdog delivers a pretimeout NMI
> > programable by the user.
> > 
> > The underlying iLO hardware is programmable as to whether or not
> > a pre-timeout NMI is delivered to the system before the iLO resets
> > the system.  However, the iLO does not allow for programming the
> > length of time that NMI is delivered before the system is reset.
> > 
> > Hence, in hpwdt_set_pretimeout, val == 0 disables the NMI. Any
> > non-zero value sets the pretimeout length to what the hardware
> > supports.
> > 
> > Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
> > ---
> >  drivers/watchdog/hpwdt.c | 42 ++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 36 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> > index da9a04101814..dc0ad20738ed 100644
> > --- a/drivers/watchdog/hpwdt.c
> > +++ b/drivers/watchdog/hpwdt.c
> > @@ -28,12 +28,15 @@
> >  #define TICKS_TO_SECS(ticks)		((ticks) * 128 / 1000)
> >  #define HPWDT_MAX_TIMER			TICKS_TO_SECS(65535)
> >  #define DEFAULT_MARGIN			30
> > +#define PRETIMEOUT_SEC			9
> >  
> >  static unsigned int soft_margin = DEFAULT_MARGIN;	/* in seconds */
> > -static unsigned int reload;			/* the computed soft_margin */
> >  static bool nowayout = WATCHDOG_NOWAYOUT;
> >  #ifdef CONFIG_HPWDT_NMI_DECODING
> >  static unsigned int allow_kdump = 1;
> > +static bool pretimeout = 1;
> > +#else
> > +static bool pretimeout;
> >  #endif
> >  
> static bool pretimeout = IS_ENABLED(CONFIG_HPWDT_NMI_DECODING);

ack. will do.

> 
> >  static void __iomem *pci_mem_addr;		/* the PCI-memory address */
> > @@ -55,10 +58,12 @@ static struct watchdog_device hpwdt_dev;
> >   */
> >  static int hpwdt_start(struct watchdog_device *dev)
> >  {
> > -	reload = SECS_TO_TICKS(dev->timeout);
> > +	int control = 0x81 | (pretimeout ? 0x4 : 0);
> > +	int reload = SECS_TO_TICKS(dev->timeout);
> >  
> > +	dev_dbg(dev->parent, "start watchdog 0x%08x:0x%02x\n", reload, control);
> >  	iowrite16(reload, hpwdt_timer_reg);
> > -	iowrite8(0x85, hpwdt_timer_con);
> > +	iowrite8(control, hpwdt_timer_con);
> >  
> >  	return 0;
> >  }
> > @@ -67,6 +72,8 @@ static int hpwdt_stop(struct watchdog_device *dev)
> >  {
> >  	unsigned long data;
> >  
> > +	dev_dbg(dev->parent, "stop  watchdog\n");
> > +
> Unrelated.
> 
> >  	data = ioread8(hpwdt_timer_con);
> >  	data &= 0xFE;
> >  	iowrite8(data, hpwdt_timer_con);
> > @@ -75,8 +82,9 @@ static int hpwdt_stop(struct watchdog_device *dev)
> >  
> >  static int hpwdt_ping(struct watchdog_device *dev)
> >  {
> > -	reload = SECS_TO_TICKS(dev->timeout);
> > +	int reload = SECS_TO_TICKS(dev->timeout);
> >  
> > +	dev_dbg(dev->parent, "ping  watchdog 0x%08x\n", reload);
> 
> Unrelated. If you want to add debug messages, please do it
> in a separate patch.


Different patch, but same set?  I'll move these (and ones from earlier
patch to a new separate patch later in set.)

> 
> >  	iowrite16(reload, hpwdt_timer_reg);
> >  
> >  	return 0;
> > @@ -98,12 +106,21 @@ static int hpwdt_settimeout(struct watchdog_device *dev, unsigned int val)
> >  }
> >  
> >  #ifdef CONFIG_HPWDT_NMI_DECODING	/* { */
> > +static int hpwdt_set_pretimeout(struct watchdog_device *dev, unsigned int val)
> > +{
> > +	if (val && (val != PRETIMEOUT_SEC)) {
> 
> Unnecessary ( )


There are several things going on here. I'm not sure which one the above
comment is intended.

While a pretimeout NMI isn't required by the HW to be enabled, if enabled the
length of pretimeout is fixed by HW.

I didn't see anything in the API that would allow us to communicate to
the user this "feature."  timeout at leasst has both min_timeout and max_timeout, but
I didn't see similar for pretimeout.  I also don't think its reasonable to fail
here if the requested value is not 9 as the user really has no way of knowing what
the valid range of pretimeout values are.  So I accept, any non-zero value
for pretimeout, but then set pretimeout to be 9.

But at the same time, I don't like to siliently change a human request
w/o at least warning.



> 
> The actual timeout can be a value smaller than 9 seconds.
> Minimum is 1 second. What happens if the user configures
> a timeout of less than 9 seconds as well as a pretimeout ?
> Will it fire immediately ? 

The architecture is silient on this issue.  My experience with
this is that if timeout < 9 seconds, the NMI is not issued.
System resets when the timeout expires.  This could be implementation
dependent.

Note, this is not a new issue.

I thought about setting the min timeout to ten seconds to avoid this situation.

I haven't dug into the various user level clients of watchdog so I'm not sure 
what the impact of making this change would be to them.


> 
> > +		dev_info(dev->parent, "Setting pretimeout to %d\n", PRETIMEOUT_SEC);
> 
> Please no ongoing logging noise. This can easily be abused to clog
> the kernel log.

Good point.  I will look at WARN_ONCE or something similar.

> 
> > +		val = PRETIMEOUT_SEC;
> > +	}
> > +	dev->pretimeout = val;
> > +	pretimeout = val ? 1 : 0;
> 
> 	pretimeout = !!val;
> 

-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
