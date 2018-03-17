Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753528AbeCQRmr (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 13:42:47 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:40059 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752685AbeCQRmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 13:42:43 -0400
X-Google-Smtp-Source: AG47ELtu6pSLRcR7OVRb3FdsALxreLHDdW4niPtAf9lIjnZ6Z11A4vObYnZBSnUA704Y5ioUX2xCpQ==
Date: Sat, 17 Mar 2018 10:42:40 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Nick Dyer <nick@shmanahar.org>
Cc: linux-input@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/14] Input: atmel_mxt_ts - do not pass suspend mode in
 platform data
Message-ID: <20180317174240.GC183240@dtor-ws>
References: <20180312190907.174301-1-dmitry.torokhov@gmail.com>
 <20180312190907.174301-2-dmitry.torokhov@gmail.com>
 <20180314205123.GA26353@lava.h.shmanahar.org>
 <20180315235621.GA60361@dtor-ws>
 <20180316204002.GA24333@bm.shmanahar.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316204002.GA24333@bm.shmanahar.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 08:40:02PM +0000, Nick Dyer wrote:
> On Thu, Mar 15, 2018 at 04:56:21PM -0700, Dmitry Torokhov wrote:
> > On Wed, Mar 14, 2018 at 08:51:24PM +0000, Nick Dyer wrote:
> > > On Mon, Mar 12, 2018 at 12:08:54PM -0700, Dmitry Torokhov wrote:
> > > > The way we are supposed to put controller to sleep and wake it up does not
> > > > depend on the platform, but rather on controller itself. Controllers using
> > > > T9 require manipulating T9 control register, while others, using newer
> > > > T100, should be put to sleep by adjusting T7 power config.
> > > 
> > > I'm afraid this is actually a misconception. If you look at object table
> > > for the older T9 device, you'll find it has the T7 object and it in fact
> > > works exactly the same way as the T100-based device.
> > > 
> > > The MXT_SUSPEND_T9_CTRL is in there because on your older Pixel devices
> > > the config saved into NVRAM on the touch controller has a zero byte in
> > > the T9 CTRL setting, meaning the touch controller will never wake up
> > > unless the driver knows to write 0x83 into it.
> > 
> > Ah, OK, I see. I would really like to drop this pdata->suspend_mode
> > stuff and I do not want to create "pixel-screwed-up" property either...
> > I guess for the time being I'll put a DMI quirk for Link to restore T9
> > control method, and then look into cleaning it all up. We have quite a
> > bit different code in chromeos kernel trees and I'd like to reconcile
> > it.
> 
> Yes, it would be great to get rid of it. The driver does have the
> ability to download configuration via the firmware loader interface. So
> you would be able to grab a copy of the config by saving it with
> mxt-app, tweak it to ensure that the T9 CTRL byte is set correctly, then
> ship it somehow (presumably it could be added to linux-firmware). This
> would override what's currently stored in NVRAM on all those units and
> mean we could remove the T9_CTRL stuff.

We can't really rely on people fetching updated config. Do you think we
could see if the device has only T9 and not T100 and if coming out of
suspend the T9 CTRL byte is 0 we overwrite it with the 0x83?

> 
> I'm happy to talk you through sorting that out in more detail if you
> want to give it a go. I don't have any Pixel 1 hardware available at the
> moment, unfortunately.

Yes, I have several Chromebooks with Atmel so I can try on a few of
them.

Thanks.

-- 
Dmitry
