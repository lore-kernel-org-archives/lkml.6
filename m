Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753928AbeCQTHO (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 15:07:14 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:51918 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753633AbeCQTHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 15:07:12 -0400
Date: Sat, 17 Mar 2018 19:07:10 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: what the hell is compat_sys_x86_waitpid() for?
Message-ID: <20180317190710.GP30522@ZenIV.linux.org.uk>
References: <20180317180131.GO30522@ZenIV.linux.org.uk>
 <CA+55aFwdxjCjqSOR92GCz4Au9QLekWL_0zumnOyG-sxayDtfzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFwdxjCjqSOR92GCz4Au9QLekWL_0zumnOyG-sxayDtfzg@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 17, 2018 at 11:19:55AM -0700, Linus Torvalds wrote:
> On Sat, Mar 17, 2018 at 11:01 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > and tell me what is the difference between those.  In other words, the problem
> > with sys32_waitpid() was not that it didn't use proper wrappers - it's that
> > it was (and always had been) 100% pointless.
> 
> That long long predates Dominik's patches, though.

Sure.

> It clearly is worth fixing, but don't blame Dominik for just
> mindlessly converting mindless code.

The thing is, this area probably won't be looked at for many years in the
future, so we'd better take the crap out now.  Same problem as with mindless
checkpatch.pl "fixes" - something unusually-looking obviously has gotten
less attention, so removing the visual indication of that has a good chance
of hiding something dumb.  Not a problem if the code is actually OK, but
that's worth checking.

> I suspect the reason is simply that the *regular* waitpid() was writtn
> in terms of sys_wait4(), and sys_wait4() needed a compat function, so
> then waitpid was basically just carried along.

Probably nobody remembers now...

Another thing touched by the same commit: pread64().  Comparing it with
other biarch architectures shows at least one dubious thing, also there
since way back.  Namely, s390 has
        if ((compat_ssize_t) count < 0)
                return -EINVAL;
IOW, size >= 2G => -EINVAL.  It *does* match the behaviour on 32bit -
on all everything including i386.  rw_verify_area() starts with
        int retval = -EINVAL;

        inode = file_inode(file);
        if (unlikely((ssize_t) count < 0))
                return retval;
64bit read/write variants quietly truncate to 2Gb, so on amd64 a 32bit
binary calling pread() with negative size will do 2Gb read while on
i386 the same binary would've gotten -EINVAL.  I'm not sure if it's
worth bothering with, though - it's not just pread().  read(2)
has exact same issue and yes, s390 does have a separate wrapper for
it, with the same check.  The same goes for write(2) there.

Do we care about that, and if not - does s390 really need to bother?
The rest of biarch wrappers for sys_pread64() is very close to being
unifiable - the only real issue is whether this architecture has
a dummy padding argument between count and (halves of) pos.  arm64,
mips and ppc do; parisc, s390, sparc and x86 do not...
