Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751575AbeBYAfC (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 19:35:02 -0500
Received: from mail.bootlin.com ([62.4.15.54]:51317 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751500AbeBYAfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 19:35:00 -0500
Date: Sun, 25 Feb 2018 01:34:58 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Karel Zak <kzak@redhat.com>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Igor Plyatov <plyatov@gmail.com>, linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
        util-linux@vger.kernel.org, J William Piggott <elseifthen@gmx.com>
Subject: Re: 500 ms delay in time saved into RTC
Message-ID: <20180225003458.GB19904@piout.net>
References: <30ae185f-28c9-54f1-2884-4ee7801b130e@gmail.com>
 <34f50661-85f5-eb46-3ff7-45f0c2bb5960@prevas.dk>
 <20180219110328.n7yjorinjm3xxckr@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180219110328.n7yjorinjm3xxckr@ws.net.home>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19/02/2018 at 12:03:28 +0100, Karel Zak wrote:
> On Mon, Feb 19, 2018 at 08:11:05AM +0100, Rasmus Villemoes wrote:
> > It's because util-linux's hwclock still assumes the world is x86. See
> > this comment in the util-linux source code:
> > 
> >         /*
> >          * The Hardware Clock can only be set to any integer time plus one
> >          * half second.  The integer time is required because there is no
> >          * interface to set or get a fractional second.  The additional half
> >          * second is because the Hardware Clock updates to the following
> >          * second precisely 500 ms (not 1 second!) after you release the
> >          * divider reset (after setting the new time) - see description of
> >          * DV2, DV1, DV0 in Register A in the MC146818A data sheet (and note
> > 
> > So if hwclock is asked to --systohc at time 01:02:03.x, it waits until
> > the time is 01:02:03.5 to set the rtc to 01:02:03, or if that has
> > already passed, waits until  01:02:04.5 and sets it to 01:02:04.
> > 
> > On our ARM BSP we patch util-linux to have the "implicit fractional
> > part" configurable, and trying to upstream something like that has been
> > on my todo-list for quite a while. See
> > 
> > https://raw.githubusercontent.com/oe-lite/base/master/recipes/util-linux/util-linux-2.29/hwclock-tweak-delay.patch
> > 
> > for the patch we currently use (on top of that, we change the 0.5
> > initializer to 0.0 to avoid having to always pass the --delay argument).
> > Incidentally, it seems we're on the same util-linux version, so you
> > should be able to try out that patch and see if it works for you.
> 
> Would be possible to somehow detect what is the right default setting for
> --delay? I mean for example detect architecture / clock HW, etc.
> 
> I have no problem with --delay, but it's tuning for advanced users and
> HW specific stuff. It would be nice to have something more portable.
> 

This is what I'm using to synchronize the RTC to the system time:

https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/rtc-tools.git/tree/rtc-sync.c

With sane RTCs, it manages to do so with a good precision, 10µs on a
pcf85363 connected to a sama5d4 xplained, 96µs on my PC.

It can still be improved and doesn't handle RTCs in localtime.

I'm planning to integrate that in hwclock at some point i(hopefully
soon) but I didn't have the time to dive too much in the code yet.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
