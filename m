Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752664AbeEVTrJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 15:47:09 -0400
Received: from mail.stusta.mhn.de ([141.84.69.5]:37611 "EHLO
        mail.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752016AbeEVTrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 15:47:07 -0400
Date: Tue, 22 May 2018 22:47:02 +0300
From: Adrian Bunk <bunk@debian.org>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Debian release team <debian-release@lists.debian.org>,
        Debian kernel maintainers <debian-kernel@lists.debian.org>,
        krb5@packages.debian.org, libbsd@packages.debian.org,
        systemd@packages.debian.org, Michael Kerrisk <mtk.manpages@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: Fixing Linux getrandom() in stable
Message-ID: <20180522194702.GA2213@localhost>
References: <75577b3d2efd01aaf563f1a1400a2c655556b258.camel@decadent.org.uk>
 <20180513204828.GI10643@localhost>
 <71fc1f9e921f2a755e79563903ddf676de128478.camel@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <71fc1f9e921f2a755e79563903ddf676de128478.camel@decadent.org.uk>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 03:11:30AM +0100, Ben Hutchings wrote:
> On Sun, 2018-05-13 at 23:48 +0300, Adrian Bunk wrote:
>...
> > Due to the gdm bugs mentioned above we know that there are real-life 
> > situations where gdm currently uses "random" data that might be 
> > predictable.
> > 
> > grep tells me:
> > daemon/gdm-x-session.c:        auth_entry.data = gdm_generate_random_bytes (auth_entry.data_length, &error);
> > daemon/gdm-display-access-file.c:        *cookie = gdm_generate_random_bytes (GDM_DISPLAY_ACCESS_COOKIE_SIZE,
> > 
> > Repeat the same for every package that uses /dev/urandom.
> 
> This is certain undesirable, but it's exploitable only by local users. 
> (If you let the X server listen to the network, all authentication
> cookies are sent in the clear so you've already lost.  If you use ssh X
> forwarding, it generates a new authentication cookie for use with the X
> proxy on the remote machine.)

It is possible that this specific case is not a problem.

There was a certain "never use /dev/random, /dev/urandom is always good
enough" push that started several years before getrandom() became 
available, and I'd bet someone will find exploitable cases due to
that somewhere.

The documented behaviour is that it is safe to use /dev/urandom except
during "early boot", and this is not always true in practice.

>...
> > The proper way forward might be to deprecate /dev/urandom and add a 
> > third option GRND_UNSAFE_RANDOM to getrandom() that is documented to 
> > never block but might return predictable data in some cases.
> 
> This doesn't solve anything for us.  (It does help with the original
> problem of device nodes possibly being absent from a minimal container
> or chroot.)
>...

I am less worried about device nodes possibly being absent, and more 
worried about 3 different cases splintered over 2 completely different
APIs.

Ignoring any security implications, "workaround by switching from 
getrandom() to /dev/urandom" sounds wrong since you shouldn't be
forced to a different API for that - getrandom() is what people
should use, therefore it should offer all 3 options.

> Ben.
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
