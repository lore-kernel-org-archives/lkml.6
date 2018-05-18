Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752174AbeERCcQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 22:32:16 -0400
Received: from imap.thunk.org ([74.207.234.97]:49926 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751815AbeERCcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 22:32:14 -0400
Date: Thu, 17 May 2018 22:32:09 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Trent Piepho <tpiepho@impinj.com>
Cc: "sultanxda@gmail.com" <sultanxda@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Linux messages full of `random: get_random_u32 called from`
Message-ID: <20180518023209.GD15263@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Trent Piepho <tpiepho@impinj.com>,
        "sultanxda@gmail.com" <sultanxda@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180427201036.GL5965@thunk.org>
 <1526606822.30073.64.camel@impinj.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526606822.30073.64.camel@impinj.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 01:27:03AM +0000, Trent Piepho wrote:
> 
> I've hit this on an embedded system.  mke2fs hangs trying to format a
> persistent writable filesystem, which is where the random seed to
> initialize the kernel entropy pool would be stored, because it wants 16
> bytes of non-cryptographic random data for a filesystem UUID, and util-
> linux libuuid calls getrandom(16, 0) - no GRND_RANDOM flag - and this
> hangs for over four minutes.

This is fixed in util-linux 2.32.  It ships with the following commits:

commit edc1c90cb972fdca1f66be5a8e2b0706bd2a4949
Author: Karel Zak <kzak@redhat.com>
Date:   Tue Mar 20 14:17:24 2018 +0100

    lib/randutils: don't break on EAGAIN, use usleep()
    
    The current code uses lose_counter to make more attempts to read
    random numbers. It seems better to wait a moment between attempts to
    avoid busy loop (we do the same in all-io.h).
    
    The worst case is 1 second delay for all random_get_bytes() on systems
    with uninitialized entropy pool -- for example you call sfdisk (MBR Id
    or GPT UUIDs) on very first boot, etc. In this case it will use libc
    rand() as a fallback solution.
    
    Note that we do not use random numbers for security sensitive things
    like keys or so. It's used for random based UUIDs etc.
    
    Addresses: https://github.com/karelzak/util-linux/pull/603
    Signed-off-by: Karel Zak <kzak@redhat.com>

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

Interestingly, these commits in util-linux landed *before* the patches
to address CVE-2018-1108 appeared in the kernel in April 2019.  This
was because the issue of libuuid was blocking on a handful of embedded
systems even for we made this change in Linux's random driver.  (It
just made this problem more likely to be visbile on a larger number of
systems; but it was always there.)

					- Ted
