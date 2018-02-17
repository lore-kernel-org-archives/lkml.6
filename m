Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751059AbeBQB5A (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 20:57:00 -0500
Received: from g9t5009.houston.hpe.com ([15.241.48.73]:54896 "EHLO
        g9t5009.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750937AbeBQB47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 20:56:59 -0500
Date: Fri, 16 Feb 2018 18:56:57 -0700
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, rwright@hpe.com,
        maurice.a.saldivar@hpe.com, mingo@kernel.org,
        marcus.folkesson@gmail.com
Subject: Re: [PATCH v3 08/11] watchdog/hpwdt: Programable Pretimeout NMI
Message-ID: <20180217015657.GC675@anatevka.americas.hpqcorp.net>
Reply-To: Jerry.Hoemann@hpe.com
References: <20180215234400.5022-1-jerry.hoemann@hpe.com>
 <20180215234400.5022-9-jerry.hoemann@hpe.com>
 <20180216203440.GA31849@roeck-us.net>
 <20180216234617.GA675@anatevka.americas.hpqcorp.net>
 <20180216235506.GA26546@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216235506.GA26546@roeck-us.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 03:55:06PM -0800, Guenter Roeck wrote:
> On Fri, Feb 16, 2018 at 04:46:17PM -0700, Jerry Hoemann wrote:
> > On Fri, Feb 16, 2018 at 12:34:40PM -0800, Guenter Roeck wrote:
> > > On Thu, Feb 15, 2018 at 04:43:57PM -0700, Jerry Hoemann wrote:

...

> > > > @@ -98,12 +106,21 @@ static int hpwdt_settimeout(struct watchdog_device *dev, unsigned int val)
> > > >  }
> > > >  
> > > >  #ifdef CONFIG_HPWDT_NMI_DECODING	/* { */
> > > > +static int hpwdt_set_pretimeout(struct watchdog_device *dev, unsigned int val)
> > > > +{
> > > > +	if (val && (val != PRETIMEOUT_SEC)) {
> > > 
> > > Unnecessary ( )
> > 
> > 
> > There are several things going on here. I'm not sure which one the above
> > comment is intended.
> > 
> The "Unnecessary" refers to the ( ) around the second part of the expression
> above. While there may be valid reasons to include extra ( ), I think we
> can trust the C compiler to get it right here.

Okay, wasn't sure what you were getting at here.

I trust the C compiler, I don't trust humans.  In compound conditionals,
I'll add parens so that the meaning is clear.


> > While a pretimeout NMI isn't required by the HW to be enabled, if enabled the
> > length of pretimeout is fixed by HW.
> > 
> > I didn't see anything in the API that would allow us to communicate to
> > the user this "feature."  timeout at leasst has both min_timeout and max_timeout, but
> > I didn't see similar for pretimeout.  I also don't think its reasonable to fail
> > here if the requested value is not 9 as the user really has no way of knowing what
> > the valid range of pretimeout values are.  So I accept, any non-zero value
> > for pretimeout, but then set pretimeout to be 9.
> > 
> > But at the same time, I don't like to silently change a human request
> > w/o at least warning.
> > 
> Sorry, I lost you here.

I wasn't sure to what you were objecting to.  I thought you might
not have understood why I was converting non-zero values of
"pretimeout" to 9.  Was trying to explain the reasoning.

A problem I see with the watchdog API is that users don't know
what is an acceptable range of values for pretimeout.

For HPE proliant systems, one cannot just choose an arbitrary
value for pretimeout.

I don't see a reasonable way that a user can determine the valid range
for pretimeout for HPE systems given our hardware restrictions.


> 
> > > 
> > > The actual timeout can be a value smaller than 9 seconds.
> > > Minimum is 1 second. What happens if the user configures
> > > a timeout of less than 9 seconds as well as a pretimeout ?
> > > Will it fire immediately ? 
> > 
> > The architecture is silent on this issue.  My experience with
> > this is that if timeout < 9 seconds, the NMI is not issued.
> > System resets when the timeout expires.  This could be implementation
> > dependent.
> > 
> > Note, this is not a new issue.
> > 
> Bad argument.

Not sure exactly to what your objections are.  I'll point out that:

1) hpwdt has been using pretimeout NMI for watchdog for > 10 years.
2) For 8 years, its been possible to have a timeout < 9 seconds.
3) AFAIK this hasn't proven to be a big issue.
4) I have real questions as to how (or if) to address the issue.

I am perfectly willing to discuss the problem, but I don't think
it is a requirement for this patch set.


> 
> > I thought about setting the min timeout to ten seconds to avoid this situation.
> > 
> You could reject reject request to set the pretimeout to a value <= the
> timeout.

I think you mis-communicated here.

It is perfectly fine to have a timeout of 30 seconds with the pretimeout of 9 seconds.

> 
> > I haven't dug into the various user level clients of watchdog so I'm not sure 
> > what the impact of making this change would be to them.
> > 
> > 
> > > 
> > > > +		dev_info(dev->parent, "Setting pretimeout to %d\n", PRETIMEOUT_SEC);
> > > 
> > > Please no ongoing logging noise. This can easily be abused to clog
> > > the kernel log.
> > 
> > Good point.  I will look at WARN_ONCE or something similar.
> > 
> A traceback if someone sets a bad timeout ? That would be even worse.


I am thinking something more in line with setting a static variable if
the message had already been printed and not reprinting it.




-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
