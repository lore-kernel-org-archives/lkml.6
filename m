Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965879AbeBMVgw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 16:36:52 -0500
Received: from g4t3427.houston.hpe.com ([15.241.140.73]:22154 "EHLO
        g4t3427.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965749AbeBMVgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 16:36:50 -0500
Date: Tue, 13 Feb 2018 14:36:48 -0700
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: wim@linux-watchdog.org, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        rwright@hpe.com, maurice.a.saldivar@hpe.com
Subject: Re: [PATCH v2 06/11] watchdog/hpwdt: Modify to use watchdog core.
Message-ID: <20180213213648.GB22295@anatevka.americas.hpqcorp.net>
Reply-To: Jerry.Hoemann@hpe.com
References: <20180212052111.12010-1-jerry.hoemann@hpe.com>
 <20180212052111.12010-7-jerry.hoemann@hpe.com>
 <20180212090621.GA4513@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180212090621.GA4513@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Thanks for the review. Comments inline.

On Mon, Feb 12, 2018 at 10:06:21AM +0100, Marcus Folkesson wrote:
> Hi Jerry,
> 
> On Sun, Feb 11, 2018 at 10:21:06PM -0700, Jerry Hoemann wrote:
> > Follow Documentation/watchdog/convert_drivers_to_kernel_api.txt to
> > convert hpwdt from legacy watchdog driver to use the watchdog core.
> > 
> > Removed functions: hpwdt_open, hpwdt_release, hpwdt_write, hpwdt_ioctl
> > Removed data structures: hpwdt_fops, hpwdt_miscdev, watchdog_device
> > Modified functions: hpwdt_start, hpwdt_stop, hpwdt_ping, hpwdt_gettimeleft
> > Added functions: hpwdt_settimeout
> > Added structures: watchdog_device
> > 
> > Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
> 
> I think it would be better to use
>     dev_emerg()
>     dev_crit()
>     dev_alert()
>     dev_err()
>     dev_warn()
>     dev_notice()
> 
> instead of pr_* functions now when we have a device to use.

In general, is there something bad with using pr_debug, etc.,?

When converting the driver over, I had many more debug messages being
printed from locations where I didn't have a valid device handle and
those needed to be done w/ the pr_.* functions.  So, I just uniformally
used pr_.*.


> > -static int hpwdt_time_left(void)
> > +static unsigned int hpwdt_gettimeleft(struct watchdog_device *dev)
> >  {
> >  	return TICKS_TO_SECS(ioread16(hpwdt_timer_reg));
> >  }
> >  
> > +static int hpwdt_settimeout(struct watchdog_device *dev, unsigned int val)
> > +{
> > +	pr_debug("settimeout = %d\n", val);
> 
> dev_dbg()

I think you are proposing I do:

	dev_dbg(dev->parent, "settimeout = %d\n", val);

This raises the issue that I didn't set parent and I believe I should have.


> 
> 
> > +
> > +	soft_margin = dev->timeout = val;
> 
> No need to update soft_margin

I'd made the permission on the module parameters 0444 so that they
would show up in sysfs.  I updated this value so that I could see
current value of timeout in sysfs.  But, as Guenter points out in a
later review, these values are available in under CONFIG_WATCHDOG_SYSFS.
So, I'll remove.


> > +	pr_debug("nmi: ulReason=%d, mynmi=0x%0x\n", ulReason, mynmi);
> 
> dev_dbg()

See above.

> 
> >  	retval = hpwdt_init_nmi_decoding(dev);
> >  	if (retval != 0)
> >  		goto error_init_nmi_decoding;
> >  
> > -	retval = misc_register(&hpwdt_miscdev);
> > +	retval = watchdog_register_device(&hpwdt_dev);
> >  	if (retval < 0) {
> > -		dev_warn(&dev->dev,
> > -			"Unable to register miscdev on minor=%d (err=%d).\n",
> > -			WATCHDOG_MINOR, retval);
> > -		goto error_misc_register;
> > +		dev_warn(&dev->dev, "Unable to register hpe watchdog (err=%d).\n", retval);
> > +		goto error_wd_register;
> > +	}
> > +
> > +	watchdog_set_nowayout(&hpwdt_dev, nowayout);
> > +	if (watchdog_init_timeout(&hpwdt_dev, soft_margin, NULL)) {
> > +		dev_warn(&dev->dev, "Invalid soft_margin: %d. Using default\n", soft_margin);
> > +		soft_margin = DEFAULT_MARGIN;
> >  	}
> 
> In this case watchdog_init_timout() will:
> 1) Check if soft_margin is valid
> 2) if not, keep hpwdt_dev.timout intact (which is already set in
> declaration of hpwdt_dev)
> 
> So we could remove the condition and only keep
> watchdog_init_timeout(&hpwdt_dev, soft_margin, NULL);
> 
> 
> Also, we need to set an invalid initial value for soft_margin to make
> the logic for watchdog_init_timeout work. 
> 
> i.e
> - static unsigned int soft_margin = DEFAULT_MARGIN;	/* in seconds */
> + static unsigned int soft_margin;


I don't see the core printing a warning message if an invalid value
is specified for soft_margin when loading the module.

I don't mind the hpwdt module correcting an out of range parameter, but I
don't think it should do so siliently.


> 
> >  
> >  	dev_info(&dev->dev, "HPE Watchdog Timer Driver: %s"
> >  			", timer margin: %d seconds (nowayout=%d).\n",
> > -			HPWDT_VERSION, soft_margin, nowayout);
> 
> print hpwdt_dev.timeout instead of soft_margin
> 


Will do.



-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
