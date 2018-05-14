Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751903AbeENAbz (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 20:31:55 -0400
Received: from imap.thunk.org ([74.207.234.97]:48654 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751037AbeENAbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 20:31:53 -0400
Date: Sun, 13 May 2018 20:30:34 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Thorsten Glaser <tg@mirbsd.de>
Cc: Adrian Bunk <bunk@debian.org>, Ben Hutchings <ben@decadent.org.uk>,
        Debian release team <debian-release@lists.debian.org>,
        Debian kernel maintainers <debian-kernel@lists.debian.org>,
        krb5@packages.debian.org, libbsd@packages.debian.org,
        systemd@packages.debian.org, Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Fixing Linux getrandom() in stable
Message-ID: <20180514003034.GI14763@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Thorsten Glaser <tg@mirbsd.de>, Adrian Bunk <bunk@debian.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Debian release team <debian-release@lists.debian.org>,
        Debian kernel maintainers <debian-kernel@lists.debian.org>,
        krb5@packages.debian.org, libbsd@packages.debian.org,
        systemd@packages.debian.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-kernel@vger.kernel.org
References: <75577b3d2efd01aaf563f1a1400a2c655556b258.camel@decadent.org.uk>
 <20180513204828.GI10643@localhost>
 <Pine.BSM.4.64L.1805132113450.15657@herc.mirbsd.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.BSM.4.64L.1805132113450.15657@herc.mirbsd.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Quoting somewhat out of order)

On Sun, May 13, 2018 at 09:23:39PM +0000, Thorsten Glaser wrote:
>
> It’s also no solution for the arc4random API… seems like a cultural
> clash (BSD expectations vs. what Linux can actually deliver).

It's instructive to look how OpenBSD solves this problem.  OpenBSD
supports a much smaller set of architectures than linux, and a very
small set of bootloaders (which are part of the OpenBSD sources).  So
what OpenBSD is make the bootloader responsible for reading in the
random seed file from persistent storage.  Therefore OpenBSD doesn't
wait for the RNG to be initialized, because it assumes that this never
happens.  (Hand-waving what happens during the install, but presumably
harvesting entropy from the CD installer is not a problem, and OpenBSD
doesn't support debootstrap.  :-)

So the first thing is that we *really* should get folks working on
adding support to the x86 boot protocol so that in addition to passing
a pointer to the loaded kernel, the inital ramdisk, and the boot
command line, there should also be a pointer passed to the kernel
containing a pointer to X bytes of seed entropy.  This begs the
question of how do we trust that the bootloader as actually gotten an
effective source of seed entropy.  Unlike OpenBSD, there are at least
five or six different bootloaders which implement the x86 boot loader
protocol for Linux (probably more), and can we trust that they are all
implemented correctly?  And of course, this is an x86-only solution.
What about all of the other architectures supported by Debian?

Still, the vast majority of Debian users are using x86, so solving
that problems helps most of our users, and we shouldn't let the
perfect be the enemy of the good.

Also note that the bootloader has depend on userspace to refresh the
seed entropy, both in early boot (in case the syscrashes), and at
shutdown (so the entropy captured while the system is running can be
saved as seed entropy).  And this is trickier in Linux because the
bootloader lives in a different source tree, and is maintained by
different people from the systemd and/or initscripts people, and for
that matter the bootloader doesn't know which distribution it is
booting.  (This is one of places where having a single source tree ala
the *BSD's has its advantages.  And this is where perhaps Debian as a
distribution can solve this problem by coordinating action across
multiple Debian packages.)

> >Due to the gdm bugs mentioned above we know that there are real-life
> >situations where gdm currently uses "random" data that might be
> >predictable.

When does gdm need true cryptographic randomness?  We should take a
step back and take look at the big picture.  The only uses I can think
of involving using XDMCP or some other Remote Desktop Protocol.  But
that protocol was invented in the days pre-SSH, and it is about as
secure as telnet --- which is to say, not at all.  So picking a
randomly generated password for networked X or MIT Magic Cookie is
something where I'd argue if you're worried about the quality of
/dev/urandom, you're not worried about the your biggest security
vulnerability.  (Think bank vault doors attached to Papier mâché
walls....)

The util-linux-ng package made a similar calculation in v2.32
(interestingly, *before* the changes to address CVE-2018-1108 were
made):

commit a9cf659e0508c1f56813a7d74c64f67bbc962538
Author: Carlo Caione <carlo@endlessm.com>
Date:   Mon Mar 19 10:31:07 2018 +0000

    lib/randutils: Do not block on getrandom()
    
    In Endless we have hit a problem when using 'sfdisk' on the really first
    boot to automatically expand the rootfs partition. On this platform
    'sfdisk' is blocking on getrandom() because not enough random bytes are
    available. This is an ARM platform without a hwrng.
    
    We fix this passing GRND_NONBLOCK to getrandom(). 'sfdisk' will use the
    best entropy it has available and fallback only as necessary.
    
    Signed-off-by: Carlo Caione <carlo@endlessm.com>

commit edc1c90cb972fdca1f66be5a8e2b0706bd2a4949
Author: Karel Zak <kzak@redhat.com>
Date:   Tue Mar 20 14:17:24 2018 +0100

    lib/randutils: don't break on EAGAIN, use usleep()
    
    ....

    Note that we do not use random numbers for security sensitive things
    like keys or so. It's used for random based UUIDs etc.
    
    Addresses: https://github.com/karelzak/util-linux/pull/603
    Signed-off-by: Karel Zak <kzak@redhat.com>

> >>    b. Tolerate a longer wait for getrandom() to return
> >
> >I suspect there might be no guaranteed upper bound for the waiting time.
> 
> On a discless system with no hardware sources (possibly no network)
> and no keyboard interaction? Infinite.
> 
> Of course, if early userspace could reliably update a file, then the
> file’s content could be estimated as good enough and be credited to
> the RNG, at least for non-identical/readonly-/shared-media systems.

... and ultimately, this is the problem.  Having an initialized RNG is
ultimately, a system design issue that has to be considered
holistically.  If you have special hardware that you trust, it's easy.
Or in a VM environment, where you have to implicitly trust the host
*anyway* you could just use Virtio-rng and be done with it.

Or it might depend on your workload.  The security requirements of a
information kiosk system will be quite different from a Kerberos KDC
server.

Or it might depend on who you are.  If you're Intel or the US
government, maybe you're willing to trust RDRAND, either because you
know that it's secure because you've laid eyes on the internal CPU
chip designs (or perhaps, maybe, you put the back door in yourself,
and you've decided you don't need to worry about own goals :-).

The *point* is that we can't really make a turn-key solution which
will work for everyone.  For as much we have the desire for a
"Universal OS", something that works for all hardware, all users, and
all workloads, is probably just not attainable here.

(It never was a complete solution, BTW; even before the patches to
address CVE-2018-1108, there were already hardware systems where you
couldn't count on the RNG being initialized in time and getrandom(2)
would block.  It's just that they were few in number, and they tended
to very niche systems for the tiniest of IOT devices, where you
wouldn't be using gdm, or for that matter, systemd, because they
simply wouldn't fit.)

						- Ted
