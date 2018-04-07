Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752316AbeDGXCh (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 19:02:37 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:36920 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752147AbeDGXCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 19:02:36 -0400
Date: Sun, 8 Apr 2018 00:02:34 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        sparclinux@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [git pull] sparc syscall stuff
Message-ID: <20180407230234.GE30522@ZenIV.linux.org.uk>
References: <20180407204414.GC30522@ZenIV.linux.org.uk>
 <CA+55aFyzdWyGZoczjCQE0rK1Bp9fq54DHNv-TqEeBvZ-C00VtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFyzdWyGZoczjCQE0rK1Bp9fq54DHNv-TqEeBvZ-C00VtQ@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 07, 2018 at 02:37:24PM -0700, Linus Torvalds wrote:
> On Sat, Apr 7, 2018 at 1:44 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> >         Conflicts in arch/sparc/kernel/sys_sparc32.c are not hard to resolve,
> > but keep in mind that casts to u64 are needed there.  I'd pushed a variant of
> > resolution into #test-merge.
> 
> You say "keep in mind that casts to u64 are needed there", but then
> you seem to be missing them yourself in your test merge (see
> [f]truncate64).
> 
> I only noticed because I decided to check my merge against yours. I
> strive to always do the merge resolution, but if people give me a test
> merge, I then double-check against it after-the-fack.
> 
> Hmm?

Merge fuckup; mine ;-/  FWIW, the corresponding part in my branch (in 3d0e354e4e51) is

-asmlinkage long sys32_truncate64(const char __user * path, unsigned long high, unsigned long low)
+COMPAT_SYSCALL_DEFINE3(truncate64, const char __user *, path, u32, high, u32, low)
 {
-       if ((int)high < 0)
-               return -EINVAL;
-       else
-               return sys_truncate(path, (high << 32) | low);
+       return sys_truncate(path, ((u64)high << 32) | low);
 }

linux-next resolution is the right one -
git diff v4.16..HEAD -- arch/sparc/kernel/sys_sparc32.c
gives
-asmlinkage long sys32_truncate64(const char __user * path, unsigned long high, unsigned long low)
+COMPAT_SYSCALL_DEFINE3(truncate64, const char __user *, path, u32, high, u32, low)
 {
-       if ((int)high < 0)
-               return -EINVAL;
-       else
-               return sys_truncate(path, (high << 32) | low);
+       return ksys_truncate(path, ((u64)high << 32) | low);
 }
etc. in there.  Again, my apologies.
