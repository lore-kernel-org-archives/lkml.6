Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751947AbeEMVqY convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 17:46:24 -0400
Received: from static-87-79-237-121.netcologne.de ([87.79.237.121]:14806 "EHLO
        herc.mirbsd.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751099AbeEMVqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 17:46:23 -0400
Date: Sun, 13 May 2018 21:23:39 +0000 (UTC)
From: Thorsten Glaser <tg@mirbsd.de>
X-X-Sender: tg@herc.mirbsd.org
To: Adrian Bunk <bunk@debian.org>
cc: Ben Hutchings <ben@decadent.org.uk>,
        Debian release team <debian-release@lists.debian.org>,
        Debian kernel maintainers <debian-kernel@lists.debian.org>,
        krb5@packages.debian.org, libbsd@packages.debian.org,
        systemd@packages.debian.org, Michael Kerrisk <mtk.manpages@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: Fixing Linux getrandom() in stable
In-Reply-To: <20180513204828.GI10643@localhost>
Message-ID: <Pine.BSM.4.64L.1805132113450.15657@herc.mirbsd.org>
References: <75577b3d2efd01aaf563f1a1400a2c655556b258.camel@decadent.org.uk>
 <20180513204828.GI10643@localhost>
Content-Language: de-DE-1901, en-GB
X-Message-Flag: Your mailer is broken. Get an update at http://www.washington.edu/pine/getpine/pcpine.html for free.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk dixit:

>As an example, what happens if I debootstrap and deploy the resulting
>filesytem to a large number of identical embedded systems without
>entropy sources?

Just get into a habit of not doing so, for example by modifying the
image during each writing process.

Having the bootloader inject entropy into the kernel would of course
help (something OpenBSD actually did, which I’d dreamt of only until).
Reuse is only problematic then if the system actually booted, i.e. an
early userspace thing reading and immediately writing to a file will
stave off the remaining issues.

>As far as I can see, any solution above would either give me boot hangs
>or might result in nasty security issues due to the same (known) entropy
>being fed to /dev/random on many machines.
>
>Similar problems for cases like live CDs and installers.

And CPUs, and architectures, without usable boot entropy.

For the “CD image” case, though, adding stuff like the MAC addresses
of the onboard NICs and the current time would at least shuffle the
existing (albeit known) entropy around enough for it to begin to differ.

A web service for getting random bits sounds like an idea, until you
get to the privacy implications of that (as well as reliability). But
if it’s inhouse, it’s doable.

>I wonder whether the current issue is just the tip of the iceberg,
>and usage of /dev/urandom is a gazillion CVEs waiting to be reported.

Did you see the fallback code for Linux in OpenBSD’s code for libbsd?
It’s… like trying to find randomly-looking things on an 1990s Unix.

This is best fixed in the kernel and earlier, plus an extra read/write
in early userspace. Of course, embedding some entropy into the kernel
image itself will make the reproducible-builds people entirely unhappy…
(this one *is* implemented in MirBSD, complete with a tool to update
it).

>Due to the gdm bugs mentioned above we know that there are real-life
>situations where gdm currently uses "random" data that might be
>predictable.

The question is which uses actually need entropy estimated good enough?

>>    b. Tolerate a longer wait for getrandom() to return
>
>I suspect there might be no guaranteed upper bound for the waiting time.

On a discless system with no hardware sources (possibly no network)
and no keyboard interaction? Infinite.

Of course, if early userspace could reliably update a file, then the
file’s content could be estimated as good enough and be credited to
the RNG, at least for non-identical/readonly-/shared-media systems.

>never block but might return predictable data in some cases.

“What level of predictability?”

>It would then be up to the application to decide whether predictable
>data is acceptable, and what to do in entropy-starved situations.

I guess most application authors have no answer for you here.

It’s also no solution for the arc4random API… seems like a cultural
clash (BSD expectations vs. what Linux can actually deliver).

bye,
//mirabilos
-- 
  “Having a smoking section in a restaurant is like having
          a peeing section in a swimming pool.”
						-- Edward Burr
