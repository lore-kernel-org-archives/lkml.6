Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754462AbeD2WFZ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 18:05:25 -0400
Received: from imap.thunk.org ([74.207.234.97]:43378 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754338AbeD2WFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 18:05:23 -0400
Date: Sun, 29 Apr 2018 18:05:19 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Sultan Alsawaf <sultanxda@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>
Subject: Re: Linux messages full of `random: get_random_u32 called from`
Message-ID: <20180429220519.GQ5965@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Sultan Alsawaf <sultanxda@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
References: <b6aa3fac-a768-e27d-3070-00d929ebc245@gmail.com>
 <20180426192524.GD5965@thunk.org>
 <2add15cb-2113-0504-a732-81255ea61bf5@gmail.com>
 <20180426235630.GG5965@thunk.org>
 <3eb5761e-7b25-4178-0560-fba5eb43ce6a@gmail.com>
 <20180427201036.GL5965@thunk.org>
 <20180429143205.GD13475@amd>
 <20180429170541.lrzwyihrd6d75rql@sultan-box>
 <20180429184101.GA31156@amd>
 <20180429202033.ysmc42mj2rrk3h7p@sultan-box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180429202033.ysmc42mj2rrk3h7p@sultan-box>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 29, 2018 at 01:20:33PM -0700, Sultan Alsawaf wrote:
> On Sun, Apr 29, 2018 at 08:41:01PM +0200, Pavel Machek wrote:
> > Umm. No. https://www.youtube.com/watch?v=xneBjc8z0DE
> 
> Okay, but /dev/urandom isn't a solution to this problem because it isn't usable
> until crng init is complete, so it suffers from the same init lag as
> /dev/random.

It's more accurate to say that using /dev/urandom is no worse than
before (from a few years ago).  There are, alas, plenty of
distributions and user space application programmers that basically
got lazy using /dev/urandom, and assumed that there would be plenty of
entropy during early system startup.

When they switched over the getrandom(2), the most egregious examples
of this caused pain (and they got fixed), but due to a bug in
drivers/char/random.c, if getrandom(2) was called after the entropy
pool was "half initialized", it would not block, but proceed.

Is that exploitable?  Well, Jann and I didn't find an _obvious_ way to
exploit the short coming, which is this wasn't treated like an
emergency situation ala the embarassing situation we had five years
ago[1].

[1] https://factorable.net/paper.html

However, it was enough to make us be uncomfortable, which is why I
pushed the changes that I did.  At least on the devices we had at
hand, using the distributions that we typically use, the impact seemed
minimal.  Unfortuantely, there is no way to know for sure without
rolling out change and seeing who screams.  In the ideal world,
software would not require cryptographic randomness immediately after
boot, before the user logs in.  And ***really***, as in [1], softwaret
should not be generating long-term public keys that are essential to
the security of the box a few seconds immediately after the device is
first unboxed and plugged in.i

What would be useful is if people gave reports that listed exactly
what laptop and distributions they are using.  Just "a high spec x86
laptop" isn't terribly useful, because *my* brand-new Dell XPS 13
running Debian testing is working just fine.  The year, model, make,
and CPU type plus what distribution (and distro version number) you
are running is useful, so I can assess how wide spread the unhappiness
is going to be, and what mitigation steps make sense.


What mitigations steps can be taken?

If you believe in security-through-complexity (the cache architecture
of x86 is *sooooo* complicated no one can understand it, so
Jitterentropy / Haveged *must* be secure), or security-through-secrecy
(the cache architecture of x86 is only avilable to internal architects
inside Intel, so Jitterentropy / Haveged *must* be secure, never mind
that the Intel CPU architects who were asked about it were "nervous"),
then wiring up CONFIG_JITTERENTROPY or using haveged might be one
approach.

If you believe that Intel hasn't backdoored RDRAND, then installing
rng-tools and running rngd with --enable-drng will enable RDRAND.
That seems to be popular with various defense contractors, perhaps on
the assumption that if it _was_ backdoored (no one knows for sure), it
was probably with the connivance or request of the US government, who
doesn't need to worry about spying on itself.

Or you can use some kind of open hardware design RNG, such as
ChoasKey[2] from Altus Metrum.  But that requires using specially
ordered hardware plugged into a USB slot, and it's probably not a mass
solution.

[2] https://altusmetrum.org/ChaosKey/


Personally, I prefer fixing the software to simply not require
cryptographic grade entropy before the user has logged in.  Because
it's better than the alternatives.

					- Ted
