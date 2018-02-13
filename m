Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966324AbeBMXy6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 18:54:58 -0500
Received: from g2t2352.austin.hpe.com ([15.233.44.25]:45370 "EHLO
        g2t2352.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966199AbeBMXy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 18:54:56 -0500
Date: Tue, 13 Feb 2018 16:54:55 -0700
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>, wim@linux-watchdog.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        rwright@hpe.com, maurice.a.saldivar@hpe.com
Subject: Re: [PATCH v2 06/11] watchdog/hpwdt: Modify to use watchdog core.
Message-ID: <20180213235455.GE22295@anatevka.americas.hpqcorp.net>
Reply-To: Jerry.Hoemann@hpe.com
References: <20180212052111.12010-1-jerry.hoemann@hpe.com>
 <20180212052111.12010-7-jerry.hoemann@hpe.com>
 <20180212090621.GA4513@gmail.com>
 <20180213213648.GB22295@anatevka.americas.hpqcorp.net>
 <20180213215549.GA5241@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213215549.GA5241@roeck-us.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 01:55:49PM -0800, Guenter Roeck wrote:
> On Tue, Feb 13, 2018 at 02:36:48PM -0700, Jerry Hoemann wrote:
> > 
> > 
> > > 
> > > dev_dbg()
> > 
> > I think you are proposing I do:
> > 
> > 	dev_dbg(dev->parent, "settimeout = %d\n", val);
> > 
> > This raises the issue that I didn't set parent and I believe I should have.
> > 
> Correct.

Will fix.


> > > >  	retval = hpwdt_init_nmi_decoding(dev);
> > > >  	if (retval != 0)
> > > >  		goto error_init_nmi_decoding;
> > > >  
> > > > -	retval = misc_register(&hpwdt_miscdev);
> > > > +	retval = watchdog_register_device(&hpwdt_dev);
> > > >  	if (retval < 0) {
> > > > -		dev_warn(&dev->dev,
> > > > -			"Unable to register miscdev on minor=%d (err=%d).\n",
> > > > -			WATCHDOG_MINOR, retval);
> > > > -		goto error_misc_register;
> > > > +		dev_warn(&dev->dev, "Unable to register hpe watchdog (err=%d).\n", retval);
> > > > +		goto error_wd_register;
> > > > +	}
> > > > +
> > > > +	watchdog_set_nowayout(&hpwdt_dev, nowayout);
> > > > +	if (watchdog_init_timeout(&hpwdt_dev, soft_margin, NULL)) {
> > > > +		dev_warn(&dev->dev, "Invalid soft_margin: %d. Using default\n", soft_margin);
> > > > +		soft_margin = DEFAULT_MARGIN;
> > > >  	}
> > > 
> > > In this case watchdog_init_timout() will:
> > > 1) Check if soft_margin is valid
> > > 2) if not, keep hpwdt_dev.timout intact (which is already set in
> > > declaration of hpwdt_dev)
> > > 
> > > So we could remove the condition and only keep
> > > watchdog_init_timeout(&hpwdt_dev, soft_margin, NULL);
> > > 
> > > 
> > > Also, we need to set an invalid initial value for soft_margin to make
> > > the logic for watchdog_init_timeout work. 
> > > 
> > > i.e
> > > - static unsigned int soft_margin = DEFAULT_MARGIN;	/* in seconds */
> > > + static unsigned int soft_margin;
> > 
> > 
> > I don't see the core printing a warning message if an invalid value
> > is specified for soft_margin when loading the module.
> > 
> > I don't mind the hpwdt module correcting an out of range parameter, but I
> > don't think it should do so siliently.
> > 
> 
> The point here is that setting soft_margin to 0 and setting the
> timeout in the watchdog_device structure to DEFAULT_MARGIN
> means that it is not necessary to override it on error.

Yes, I don't need to set soft_margin = DEFAULT_MARGIN inside the
conditional on watchdog_init_timeout.  I was doing that to keep
the value of soft_margin consistent with the value of hpwdt_dev.timeout
so that it would show the current timeout value in sysfs.  But, as
you pointed out, the watchdog sysfs displays timeout.  So, i don't
need that asignment anymore.

But, I want to keep the initialization:
static unsigned int soft_margin = DEFAULT_MARGIN;


Reasoning: I want soft_margin to be an optional parameter that
defaults to DEFAULT_MARGIN without warning.  If soft_margin is initialized
to a value outside of the valid range, say N, the code can't tell the
difference between the static value of N or if the module was loaded with the
soft_margin=N.  I only want to warn on the latter.


> If you want to be verbose, you can still log a warning message
> if the timeout provided by the module parameter is wrong.
> 
> Anyway, this driver will presumably never support devicetree,
> so the watchdog core will never read the timeout from there,
> and this is not a showstopper.
> 



-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
