Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751926AbeEMU5N (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 16:57:13 -0400
Received: from mail.stustanet.de ([141.84.69.5]:58241 "EHLO mail.stusta.mhn.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751362AbeEMU5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 16:57:11 -0400
Date: Sun, 13 May 2018 23:48:28 +0300
From: Adrian Bunk <bunk@debian.org>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Debian release team <debian-release@lists.debian.org>,
        Debian kernel maintainers <debian-kernel@lists.debian.org>,
        krb5@packages.debian.org, libbsd@packages.debian.org,
        systemd@packages.debian.org, Michael Kerrisk <mtk.manpages@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: Fixing Linux getrandom() in stable
Message-ID: <20180513204828.GI10643@localhost>
References: <75577b3d2efd01aaf563f1a1400a2c655556b258.camel@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <75577b3d2efd01aaf563f1a1400a2c655556b258.camel@decadent.org.uk>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2018 at 11:46:00PM +0100, Ben Hutchings wrote:
>...
> # Security flaw and initial fix
> 
> Recently it was discovered that getrandom() could return successfully
> before the RNG was really ready to produce unpredictable data.  This
> issue was designated as CVE-2018-1108, and was fixed in Linux 4.17-rc2 
> and various stable updates.
> 
> We fixed CVE-2018-1108 with an update to stretch last week
> (DSA-4188-1).  The kernel versions in wheezy and jessie do not provide
> getrandom().
> 
> # Regression
> 
> The version of glibc in stretch does not provide access to getrandom(),
> but some packages in stable use syscall() to call it anyway, including:
> 
> * krb5: k5_get_os_entropy()
> * libbsd: arc4_random_buf().  This is used by many other packages
>   including libICE, and so indirectly by gnome-session.
> 
> Following DSA-4188-1, it turned out that the RNG did not become ready
> on some systems until several minutes after boot, causing severe
> regressions for GNOME/gdm (#897631, #897632) and Kerberos (#897599,
> #897917).  We therefore reverted the fix in yesterday's update
> (DSA-4196-1).
> 
> # Options for a new fix
> 
> It is unlikely that any further fix will be forthcoming on the kernel
> side, so I believe that we need to do one of:
> 
> 1. Add entropy to the kernel during boot; either:
>    a. Improve systemd-random-seed
>    b. Recommend use of haveged

I don't see any solution above that both always works and never results
in new CVEs.

As an example, what happens if I debootstrap and deploy the resulting
filesytem to a large number of identical embedded systems without
entropy sources?

As far as I can see, any solution above would either give me boot hangs
or might result in nasty security issues due to the same (known) entropy
being fed to /dev/random on many machines.

Similar problems for cases like live CDs and installers.

> 2. For each affected userland package, either:
>    a. Revert to using /dev/urandom

I wonder whether the current issue is just the tip of the iceberg,
and usage of /dev/urandom is a gazillion CVEs waiting to be reported.

In that case the CVE-2018-1108 fix only revealed a long existing 
vulnerability in some packages that already switched to getrandom().

/dev/urandom is documented in a very misleading way, quoting random(4):
   When read during early boot time, /dev/urandom may return data prior to
   the entropy pool being initialized.  If this  is  of  concern  in  your
   application, use getrandom(2) or /dev/random instead.

What is the worst case for "early boot time" here? "always"?

Due to the gdm bugs mentioned above we know that there are real-life 
situations where gdm currently uses "random" data that might be 
predictable.

grep tells me:
daemon/gdm-x-session.c:        auth_entry.data = gdm_generate_random_bytes (auth_entry.data_length, &error);
daemon/gdm-display-access-file.c:        *cookie = gdm_generate_random_bytes (GDM_DISPLAY_ACCESS_COOKIE_SIZE,

Repeat the same for every package that uses /dev/urandom.

>    b. Tolerate a longer wait for getrandom() to return

I suspect there might be no guaranteed upper bound for the waiting time.

>...
> The libbsd maintainer (Guillem Jover) favours option 2a.
> 
> One of the krb5 maintainers (Benjamin Kaduk) favours option 2b, and
> also proposed that systemd could provide a wait-for-rng-ready unit to
> support this.

I don't see any general solution that is both correct and easy.

The proper way forward might be to deprecate /dev/urandom and add a 
third option GRND_UNSAFE_RANDOM to getrandom() that is documented to 
never block but might return predictable data in some cases.

It would then be up to the application to decide whether predictable
data is acceptable, and what to do in entropy-starved situations.

Regarding the suggested wait-for-rng-ready systemd unit for others to 
wait on, this only makes sense for cases where "do not start at all"
is the best handling for a "no entropy" situation.

> Ben.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
