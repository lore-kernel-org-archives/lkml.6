Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD93BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F82F2147C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730013AbfBRMA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 07:00:29 -0500
Received: from mga11.intel.com ([192.55.52.93]:60068 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728394AbfBRMA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 07:00:28 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2019 04:00:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,384,1544515200"; 
   d="scan'208";a="125303446"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga008.fm.intel.com with ESMTP; 18 Feb 2019 04:00:26 -0800
Received: from andy by smile with local (Exim 4.92-RC6)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gvhaz-0001Wf-42; Mon, 18 Feb 2019 14:00:25 +0200
Date:   Mon, 18 Feb 2019 14:00:25 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Life is hard, and then you die" <ronald@innovation.ch>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Lukas Wunner <lukas@wunner.de>,
        Federico Lorenzi <federico@travelground.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Input: add Apple SPI keyboard and trackpad driver.
Message-ID: <20190218120025.GI9224@smile.fi.intel.com>
References: <20190204081947.25152-1-ronald@innovation.ch>
 <20190204081947.25152-3-ronald@innovation.ch>
 <20190206202256.GZ9224@smile.fi.intel.com>
 <20190210111834.GA27627@innovation.ch>
 <20190216004426.GE9224@smile.fi.intel.com>
 <20190218090851.GA24261@innovation.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190218090851.GA24261@innovation.ch>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 01:08:51AM -0800, Life is hard, and then you die wrote:
> On Sat, Feb 16, 2019 at 02:44:26AM +0200, Andy Shevchenko wrote:
> > On Sun, Feb 10, 2019 at 03:18:34AM -0800, Life is hard, and then you die wrote:
> > > On Wed, Feb 06, 2019 at 10:22:56PM +0200, Andy Shevchenko wrote:
> > > > On Mon, Feb 04, 2019 at 12:19:47AM -0800, Ronald Tschalär wrote:

> > Hmm... Usually you put either module_name.dyndbg into kernel command line to
> > enable Dynamic Debug on built-in modules, or modprobe module_name dyndbg if
> > it's built as a module.
> 
> Right, but while that works with
> 
>     applespi.dyndbg=+p
> 
> it does not appear to work with
> 
>     applespi.dyndbg="func applespi_get_spi_settings +p"
> 
> (it is parsed correctly, but it just doesn't get applied when the
> module is later loaded - I've not tried to chase this down any further
> than that)

Of course it wouldn't work that way. If you have compiled driver as a module,
you need to supply the parameters during modprobe. Actually it's kinda luck
that +p works for you.

> > > > > +	message->counter = applespi->cmd_msg_cntr++ & 0xff;
> > > > 
> > > > Usual pattern for this kind of entries is
> > > > 
> > > >       x = ... % 256;
> > > > 
> > > > Btw, isn't 256 is defined somewhere?
> > > 
> > > Many things are defined as have a value of 256 :-) But I didn't find any
> > > with the intended semantics; could use (U8_MAX+1), though.
> > 
> > What I meant is that I saw in the same driver definition with value of 256.
> > Isn't it about messages?
> 
> Ah, right: the packet length is 256 bytes. But the semantics are quite
> different, so IMHO it wouldn't be good to use that here. I.e. I think
> (U8_MAX+1) is still semantically the best.

OK.

> > > > > +/* lifted from the BCM5974 driver */
> > > > > +/* convert 16-bit little endian to signed integer */
> > > > > +static inline int raw2int(__le16 x)
> > > > > +{
> > > > > +	return (signed short)le16_to_cpu(x);
> > > > > +}
> > > > 
> > > > Perhaps it's time to introduce it inside include/linux/input.h ?
> > > 
> > > Perhaps as
> > > 
> > >     static inline int le16_to_signed_int(__le16 x)
> > > 
> > > ? (raw2int seems to ambiguous for a global function)
> > 
> > I'm fine. It would need a description though.
> 
> After looking at this in more detail I don't think that
> include/linux/input.h is the proper place for this, because input.h
> basically represents the interface to the input core, and as such it
> is devoid of helpers like above or any driver specific definitions.
> Instead I'd like to suggest a new include file specific to the bcm5974
> driver, as follows:
> 
> --- /dev/null
> +++ b/include/linux/input/bcm5974.h
> @@ -0,0 +1,27 @@
> +/*
> + * Copyright (C) 2008     Henrik Rydberg (rydberg@euromail.se)
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#ifndef _BCM5974_H
> +#define _BCM5974_H
> +
> +#include <linux/kernel.h>
> +
> +/**
> + * raw2int - convert a 16-bit little endian value as received from the device
> + * to a signed integer in cpu endianness.
> + * @x: the received value
> + *
> + * Returns the converted value.
> + */
> +static inline int raw2int(__le16 x)
> +{
> +       return (signed short)le16_to_cpu(x);
> +}
> +
> +#endif
> 
> Thoughts?

I see. Since there is no comment from input maintainers, let's stick with the
initial approach (copy'n'paste to your code with comment from where). Only one
suggestion is to name function for further use without changing it. So, in the
future we may move it to generic header.

> I'll send out v2 of the patches with all the changes soon.


-- 
With Best Regards,
Andy Shevchenko


