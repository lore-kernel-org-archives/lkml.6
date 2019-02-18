Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C3EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2B0206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=innovation.ch header.i=@innovation.ch header.b="kqFDMfRN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729463AbfBRJIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 04:08:53 -0500
Received: from chill.innovation.ch ([216.218.245.220]:37376 "EHLO
        chill.innovation.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728823AbfBRJIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 04:08:52 -0500
Date:   Mon, 18 Feb 2019 01:08:51 -0800
DKIM-Filter: OpenDKIM Filter v2.10.3 chill.innovation.ch 96405640144
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innovation.ch;
        s=default; t=1550480931;
        bh=mrP8TRDrz2W7EXbtRP+ONKTyZ3d5ULQTca/nOvAdWVU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kqFDMfRNEADQ1MBKffr4XRV91snFauhAMWuxp1GNlZfGhGxl9CsMeiW/wNm5Ac1rD
         2JYjU9r0dIzHZeY3gAJ1n703pBRNcsfgKuvZulWU4CnMJnI26dIElAB91nYrI1bxKI
         H4WqDsG+76t/S8W4FEHfhe4lnZyJq6nuls3vF+Y86I/K50PAV7mXiMfsiuFgXZcfAH
         xPlaGpc2BEz9s89vE7lrjeCM+2iKJH3ub0jf6Z2MreFxEA1nYcICzkCbqon8e/MgoU
         H0SEOEMK4+y7taFyfb/k7nX/3OXzcl5ucYOmnek5M5qQETZcyXLFoFEGfRo2NiQzcv
         kyuLSLEEWk3oA==
From:   "Life is hard, and then you die" <ronald@innovation.ch>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Lukas Wunner <lukas@wunner.de>,
        Federico Lorenzi <federico@travelground.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Input: add Apple SPI keyboard and trackpad driver.
Message-ID: <20190218090851.GA24261@innovation.ch>
References: <20190204081947.25152-1-ronald@innovation.ch>
 <20190204081947.25152-3-ronald@innovation.ch>
 <20190206202256.GZ9224@smile.fi.intel.com>
 <20190210111834.GA27627@innovation.ch>
 <20190216004426.GE9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190216004426.GE9224@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, Feb 16, 2019 at 02:44:26AM +0200, Andy Shevchenko wrote:
> On Sun, Feb 10, 2019 at 03:18:34AM -0800, Life is hard, and then you die wrote:
> > On Wed, Feb 06, 2019 at 10:22:56PM +0200, Andy Shevchenko wrote:
> > > On Mon, Feb 04, 2019 at 12:19:47AM -0800, Ronald Tschalär wrote:
> 
> > > > +#define	debug_print(mask, fmt, ...) \
> > > > +	do { \
> > > > +		if (debug & mask) \
> > > > +			printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__); \
> > > > +	} while (0)
> > > > +
> > > > +#define	debug_print_header(mask) \
> > > > +	debug_print(mask, "--- %s ---------------------------\n", \
> > > > +		    applespi_debug_facility(mask))
> > > > +
> > > > +#define	debug_print_buffer(mask, fmt, ...) \
> > > > +	do { \
> > > > +		if (debug & mask) \
> > > > +			print_hex_dump(KERN_DEBUG, pr_fmt(fmt), \
> > > > +				       DUMP_PREFIX_NONE, 32, 1, ##__VA_ARGS__, \
> > > > +				       false); \
> > > > +	} while (0)
> > > 
> > > I'm not sure we need all of these... But okay, the driver is
> > > reverse-engineered, perhaps we can drop it later on.
> > 
> > These have been extremely useful for debugging; but yes, they are for
> > debugging only. They also explicitly do not use the dynamic-debug
> > facilities because
> >   1. those can't be enabled at a function or line level on the kernel
> >      command line (the docs indicate this should work, but it doesn't,
> >      or at the very least I've been unable to figure out how, at least
> >      for those drivers built as modules)
> 
> Hmm... Usually you put either module_name.dyndbg into kernel command line to
> enable Dynamic Debug on built-in modules, or modprobe module_name dyndbg if
> it's built as a module.

Right, but while that works with

    applespi.dyndbg=+p

it does not appear to work with

    applespi.dyndbg="func applespi_get_spi_settings +p"

(it is parsed correctly, but it just doesn't get applied when the
module is later loaded - I've not tried to chase this down any further
than that)

[snip]
> > > > +static int touchpad_dimensions[4];
> > > > +module_param_array(touchpad_dimensions, int, NULL, 0444);
> > > > +MODULE_PARM_DESC(touchpad_dimensions, "The pixel dimensions of the touchpad, as x_min,x_max,y_min,y_max .");
> > > 
> > > We have some parsers for similar data as in format
> > > 
> > > %dx%d%+d%+d ?
> > > 
> > > For example, 200x100+20+10.
> > 
> > Maybe it's just my grep-foo that is lacking, but I couldn't find
> > anything useful. There is some stuff for framebuffer video modes, but
> > that is too different and not really amenable for use here. OTOH, a
> > simple sscanf(buf, "%dx%d+%d+%d", ...) would parse this just fine
> > without the need for any fancier parser.
> > 
> > OTOH, I'm not sure this format is any better: internally we need
> > x/y min/max, not x/y/w/h (though obviously the two are trivially
> > convertable); and for the user it doesn't really matter since they would
> > basically be getting the dimensions from running with debug set to
> > 0x10000 and using that output to set this param, i.e. I don't see any
> > inherent advantage of using x/y/w/h.
> 
> I would stick with some more or less standard notation. The XxY+W+H is widely
> used in X11 world.
> 
> If you have better examples for input devices, choose them. My point that it
> would be better to be a standard to some extent.

I couldn't find anything useful (looked in the kernel and libinput),
so going with XxY+W+H.

[snip]
> > > > +	message->counter = applespi->cmd_msg_cntr++ & 0xff;
> > > 
> > > Usual pattern for this kind of entries is
> > > 
> > >       x = ... % 256;
> > > 
> > > Btw, isn't 256 is defined somewhere?
> > 
> > Many things are defined as have a value of 256 :-) But I didn't find any
> > with the intended semantics; could use (U8_MAX+1), though.
> 
> What I meant is that I saw in the same driver definition with value of 256.
> Isn't it about messages?

Ah, right: the packet length is 256 bytes. But the semantics are quite
different, so IMHO it wouldn't be good to use that here. I.e. I think
(U8_MAX+1) is still semantically the best.

[snip]
> > > > +/* lifted from the BCM5974 driver */
> > > > +/* convert 16-bit little endian to signed integer */
> > > > +static inline int raw2int(__le16 x)
> > > > +{
> > > > +	return (signed short)le16_to_cpu(x);
> > > > +}
> > > 
> > > Perhaps it's time to introduce it inside include/linux/input.h ?
> > 
> > Perhaps as
> > 
> >     static inline int le16_to_signed_int(__le16 x)
> > 
> > ? (raw2int seems to ambiguous for a global function)
> 
> I'm fine. It would need a description though.

After looking at this in more detail I don't think that
include/linux/input.h is the proper place for this, because input.h
basically represents the interface to the input core, and as such it
is devoid of helpers like above or any driver specific definitions.
Instead I'd like to suggest a new include file specific to the bcm5974
driver, as follows:

--- /dev/null
+++ b/include/linux/input/bcm5974.h
@@ -0,0 +1,27 @@
+/*
+ * Copyright (C) 2008     Henrik Rydberg (rydberg@euromail.se)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef _BCM5974_H
+#define _BCM5974_H
+
+#include <linux/kernel.h>
+
+/**
+ * raw2int - convert a 16-bit little endian value as received from the device
+ * to a signed integer in cpu endianness.
+ * @x: the received value
+ *
+ * Returns the converted value.
+ */
+static inline int raw2int(__le16 x)
+{
+       return (signed short)le16_to_cpu(x);
+}
+
+#endif

Thoughts?

I'll send out v2 of the patches with all the changes soon.


  Cheers,

  Ronald

