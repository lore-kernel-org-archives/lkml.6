Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752580AbeBSLDe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 06:03:34 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46980 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752486AbeBSLDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 06:03:32 -0500
Date: Mon, 19 Feb 2018 12:03:28 +0100
From: Karel Zak <kzak@redhat.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Igor Plyatov <plyatov@gmail.com>, linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        rtc-linux@googlegroups.com, util-linux@vger.kernel.org,
        J William Piggott <elseifthen@gmx.com>
Subject: Re: 500 ms delay in time saved into RTC
Message-ID: <20180219110328.n7yjorinjm3xxckr@ws.net.home>
References: <30ae185f-28c9-54f1-2884-4ee7801b130e@gmail.com>
 <34f50661-85f5-eb46-3ff7-45f0c2bb5960@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34f50661-85f5-eb46-3ff7-45f0c2bb5960@prevas.dk>
User-Agent: NeoMutt/20170912-66-504cd9
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 08:11:05AM +0100, Rasmus Villemoes wrote:
> It's because util-linux's hwclock still assumes the world is x86. See
> this comment in the util-linux source code:
> 
>         /*
>          * The Hardware Clock can only be set to any integer time plus one
>          * half second.  The integer time is required because there is no
>          * interface to set or get a fractional second.  The additional half
>          * second is because the Hardware Clock updates to the following
>          * second precisely 500 ms (not 1 second!) after you release the
>          * divider reset (after setting the new time) - see description of
>          * DV2, DV1, DV0 in Register A in the MC146818A data sheet (and note
> 
> So if hwclock is asked to --systohc at time 01:02:03.x, it waits until
> the time is 01:02:03.5 to set the rtc to 01:02:03, or if that has
> already passed, waits until  01:02:04.5 and sets it to 01:02:04.
> 
> On our ARM BSP we patch util-linux to have the "implicit fractional
> part" configurable, and trying to upstream something like that has been
> on my todo-list for quite a while. See
> 
> https://raw.githubusercontent.com/oe-lite/base/master/recipes/util-linux/util-linux-2.29/hwclock-tweak-delay.patch
> 
> for the patch we currently use (on top of that, we change the 0.5
> initializer to 0.0 to avoid having to always pass the --delay argument).
> Incidentally, it seems we're on the same util-linux version, so you
> should be able to try out that patch and see if it works for you.

Would be possible to somehow detect what is the right default setting for
--delay? I mean for example detect architecture / clock HW, etc.

I have no problem with --delay, but it's tuning for advanced users and
HW specific stuff. It would be nice to have something more portable.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
