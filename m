Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755406AbeEaOhN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 10:37:13 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:44976 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755302AbeEaOhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 10:37:08 -0400
X-Google-Smtp-Source: ADUXVKLNtvqKR5D1UcJ8pOR36URKtuNBzoOI2erVkrTQSde7B9J1WQL0EN47mN25q/jbdTiTjj3Iyw==
Date: Thu, 31 May 2018 16:37:03 +0200
From: Johan Hovold <johan@kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Johan Hovold <johan@kernel.org>, Roger Quadros <rogerq@ti.com>,
        balbi@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] usb: dwc3: of_simple: don't call
 pm_runtime_set_active()
Message-ID: <20180531143703.GL3259@localhost>
References: <20180531132538.GH3259@localhost>
 <Pine.LNX.4.44L0.1805311004260.1607-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1805311004260.1607-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 10:07:05AM -0400, Alan Stern wrote:
> On Thu, 31 May 2018, Johan Hovold wrote:
> 
> > > This breaks runtime pm as you now get a second round of clock enables
> > > which are never balanced on runtime suspend (the clocks are first
> > > enabled in dwc3_of_simple_clk_init() above and with your change again in
> > > dwc3_of_simple_runtime_resume()).
> > > 
> > > On the other hand, we currently return from probe() with a positive RPM
> > > count so perhaps the RPM callbacks can just be removed altogether (i.e.
> > > unless some other entity drops that count at some point before
> > > remove()).
> > > 
> > > >  	ret = of_platform_populate(np, NULL, NULL, dev);
> > > >  	if (ret) {
> > > >  		for (i = 0; i < simple->num_clocks; i++) {
> > > > @@ -131,10 +134,6 @@ static int dwc3_of_simple_probe(struct platform_device *pdev)
> > > >  		goto err_resetc_assert;
> > > >  	}
> > > >  
> > > > -	pm_runtime_set_active(dev);
> > > > -	pm_runtime_enable(dev);
> > > > -	pm_runtime_get_sync(dev);
> > > > -
> > > >  	return 0;
> > > >  
> > > >  err_resetc_assert:
> > > 
> > > Also note that there's currently a use-after-free in remove(), where
> > > pm_runtime_put_sync() is called after the clocks have been put.
> > > Something like the below (untested) patch should fix it.
> > 
> > What about the use-after-free in remove? Shall I resubmit the fix below
> > separately?
> > 
> > Thanks,
> > Johan
> > 
> > > From 35c384c31010c344d403c26fc0a1dde0fd68ef4a Mon Sep 17 00:00:00 2001
> > > From: Johan Hovold <johan@kernel.org>
> > > Date: Mon, 28 May 2018 17:31:45 +0200
> > > Subject: [PATCH] usb: dwc3: of-simple: fix use-after-free on remove
> > > 
> > > The clocks have already been explicitly disabled and put as part of
> > > remove() so the runtime suspend callback must not be run when balancing
> > > the runtime PM usage count before returning.
> > > 
> > > Fixes: 16adc674d0d6 ("usb: dwc3: add generic OF glue layer")
> > > Signed-off-by: Johan Hovold <johan@kernel.org>
> > > ---
> > >  drivers/usb/dwc3/dwc3-of-simple.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
> > > index cb2ee96fd3e8..b9c869cd6585 100644
> > > --- a/drivers/usb/dwc3/dwc3-of-simple.c
> > > +++ b/drivers/usb/dwc3/dwc3-of-simple.c
> > > @@ -165,8 +165,9 @@ static int dwc3_of_simple_remove(struct platform_device *pdev)
> > >  
> > >  	reset_control_put(simple->resets);
> > >  
> > > -	pm_runtime_put_sync(dev);
> > > +	pm_runtime_put_noidle(dev);
> > >  	pm_runtime_disable(dev);
> > > +	pm_runtime_set_suspended(dev);
> > >  
> > >  	return 0;
> > >  }
> 
> This is a little racy -- there might be a runtime-suspend callback
> between the put_noidle and the disable.  (The put_noidle itself won't
> cause a callback to happen, but something else could.)
> 
> It would be better to do the disable first and then the put_noidle.

Good point. I'll send a v2 for Felipe to consider.

Thanks,
Johan
