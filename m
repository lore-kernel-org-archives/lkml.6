Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752671AbeCQUma (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 16:42:30 -0400
Received: from avasout06.plus.net ([212.159.14.18]:49500 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750919AbeCQUm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 16:42:26 -0400
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=fL8XI6Se c=1 sm=1 tr=0
 a=o7Djd4SkmPXITDn8qH+ssQ==:117 a=o7Djd4SkmPXITDn8qH+ssQ==:17
 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10 a=3Jcvt-MjSSlznhQHo1oA:9 a=CjuIK1q_8ugA:10
Date: Sat, 17 Mar 2018 20:42:22 +0000
From: Nick Dyer <nick@shmanahar.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/14] Input: atmel_mxt_ts - do not pass suspend mode in
 platform data
Message-ID: <20180317204222.th54qyuajgam7iek@hairyalien>
References: <20180312190907.174301-1-dmitry.torokhov@gmail.com>
 <20180312190907.174301-2-dmitry.torokhov@gmail.com>
 <20180314205123.GA26353@lava.h.shmanahar.org>
 <20180315235621.GA60361@dtor-ws>
 <20180316204002.GA24333@bm.shmanahar.org>
 <20180317174240.GC183240@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180317174240.GC183240@dtor-ws>
User-Agent: NeoMutt/20170609 (1.8.3)
X-CMAE-Envelope: MS4wfPlBT0LDdb+3CCCmvlgs0+ZyK0+YoN30TusnsB8EU0Z+Ctnd+FDo1G8PH4PhhUYpnwIyl757iWYtdkUKKb822cP19Mw0D9zCCszX0VrVGLiusWCirq8p
 U2N0+FdR6COqxCsK+6/b3kcVcm0M1k5/p1M=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 17, 2018 at 10:42:40AM -0700, Dmitry Torokhov wrote:
> On Fri, Mar 16, 2018 at 08:40:02PM +0000, Nick Dyer wrote:
> > On Thu, Mar 15, 2018 at 04:56:21PM -0700, Dmitry Torokhov wrote:
> > > Ah, OK, I see. I would really like to drop this
> > > pdata->suspend_mode stuff and I do not want to create
> > > "pixel-screwed-up" property either...  I guess for the time being
> > > I'll put a DMI quirk for Link to restore T9 control method, and
> > > then look into cleaning it all up. We have quite a bit different
> > > code in chromeos kernel trees and I'd like to reconcile
> > > it.
> > 
> > Yes, it would be great to get rid of it. The driver does have the
> > ability to download configuration via the firmware loader interface.
> > So you would be able to grab a copy of the config by saving it with
> > mxt-app, tweak it to ensure that the T9 CTRL byte is set correctly,
> > then ship it somehow (presumably it could be added to
> > linux-firmware). This would override what's currently stored in
> > NVRAM on all those units and mean we could remove the T9_CTRL stuff.
> 
> We can't really rely on people fetching updated config. Do you think we
> could see if the device has only T9 and not T100 and if coming out of
> suspend the T9 CTRL byte is 0 we overwrite it with the 0x83?

I think that all we need to do is add something to
mxt_read_t9_resolution (and probably rename it to mxt_init_t9_config)
that reads the 1st (CTRL) byte, and if it's zero, writes 0x83 (and
probably a dev_dbg() wouldn't go amiss)

Also call the same logic on reset (look for "Detect reset"), because
that wipes out the config.

Once we've done that, we can get rid of the MXT_SUSPEND_T9_CTRL and use
the normal T7 power up/down logic for suspend/resume on all devices.

FWIW there may be two instances of T9, but I've never seen a device that
actually had two screens and it's not supported really anyway with this
driver.

N
