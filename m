Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752129AbeERXXD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 19:23:03 -0400
Received: from imap.thunk.org ([74.207.234.97]:48110 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751722AbeERXXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 19:23:00 -0400
Date: Fri, 18 May 2018 19:22:56 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Trent Piepho <tpiepho@impinj.com>
Cc: "jannh@google.com" <jannh@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sultanxda@gmail.com" <sultanxda@gmail.com>
Subject: Re: Linux messages full of `random: get_random_u32 called from`
Message-ID: <20180518232256.GA23628@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Trent Piepho <tpiepho@impinj.com>,
        "jannh@google.com" <jannh@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sultanxda@gmail.com" <sultanxda@gmail.com>
References: <20180427201036.GL5965@thunk.org>
 <1526606822.30073.64.camel@impinj.com>
 <20180518023209.GD15263@thunk.org>
 <1526684178.31570.26.camel@impinj.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526684178.31570.26.camel@impinj.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 10:56:18PM +0000, Trent Piepho wrote:
> 
> I feel like "fix" might overstate the result a bit.
> 
> This ends up taking a full second to make each UUID.  Having gone to
> great effort to make an iMX25 complete userspace startup in 250 ms, a
> full second, per UUID, in early startup is pretty appalling.
> 
> Let's look at what we're doing after this fix:
> Want non-cryptographic random data for UUID, ask kernel for it.
> Kernel has non-cryptographic random data, won't give it to us.
> Wait one second for cryptographic random data, which we didn't need.
> Give up and create our own random data, which is non-cryptographic and
> even worse than what the kernel could have given us from the start.
> 
> util-linux falls back to rand() seeded with the pid, uid, tv_sec, and
> tv_usec from gettimeofday().  Pretty bad on an embedded system with no
> RTC and worse than what the kernel in crng_init 1 state can give us.

So what util-linux's libuuid could do is fall back to using
/dev/urandom instead.  Whether or not you retry for a second before
you fall back to /dev/urandom really depends on how important the
second U in UUID ("unique") is to you.  If you use lower quality
randomness, you can potentially risk getting non-unique UUID's.

If you don't worry leaking your computer's identity and the time when
the UUID was generated, the application could also use the time-based
UUID's.  There are privacy implications for doing so, it's not
something we can do automatically (or at least I can't recommend it).
Also, if you don't have the clock sequence file and/or you don't have
a writable root, you might need some randomness anyway to protect
against non-monotonically increasing system time.

> It would seem to be a fact that there will be users of non-
> cryptographic random data in early boot.  What is the best practice for
> that?  To fall back to each user trying "to find randomly-looking
> things on an 1990s Unix."  That doesn't seem good to me.  But what's
> the better way?

We could add a new flag to getrandom(2), but application authors can
just as easily fall back to using /dev/urandom.  The real concern I
have is application authors that actually *really* need cryptographic
randomness, but they're too lazy to figure out a way to defer key
generation until the last possible moment.

There are other things we can do to add support in the bootloader to
read an entropy state file and inject it into the kernel alongside the
initrd and boot command line.  But that doesn't completely solve the
problem; you still have to deal with the "frest from the factory,
first time out of box" experience.  And if you have trusted random
number generation hardware, and are reasonably certain you don't have
to worry about a state-sponsored agency from intercepting hardware
shipments and gimmicking your hardware, that can be a solution as
well.

So there are things we can do to improve some of the scenarios.
Unfortunately, there is no silver bullet that will address all of
them.

					- Ted
