Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751769AbeCMFsS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 01:48:18 -0400
Received: from mail-wr0-f181.google.com ([209.85.128.181]:44494 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751385AbeCMFsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 01:48:16 -0400
X-Google-Smtp-Source: AG47ELstIh4ktnD8pyWkMHr/7T+5ou9hb+HjBNpC36rQqIPbAW+Yh8NW18/EqWrlxA7P8RQjlhffdg==
Date: Tue, 13 Mar 2018 06:48:13 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-kernel@vger.kernel.org, luto@kernel.org,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 00/35] remove in-kernel syscall invocations
Message-ID: <20180313054813.osrqeymqqupjuirv@gmail.com>
References: <20180311105557.20807-1-linux@dominikbrodowski.net>
 <20180312073256.xo5vdh4ss7g32yma@gmail.com>
 <20180312193054.GD16666@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312193054.GD16666@light.dominikbrodowski.net>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Dominik Brodowski <linux@dominikbrodowski.net> wrote:

> On Mon, Mar 12, 2018 at 08:32:56AM +0100, Ingo Molnar wrote:
> > 
> > * Dominik Brodowski <linux@dominikbrodowski.net> wrote:
> > 
> > > I'm a bit more unsure about these remaining patches. They use inline stubs
> > > named ksys_xyzzy() which (mostly) call fs-internal functions. Another
> > > alternative would be to define these in fs/*, but then we'd get more and
> > > more indirections.
> > > 
> > > 	syscalls: do not call sys_unlink() within the kernel
> > > 	syscalls: do not call sys_rmdir() within the kernel
> > > 	syscalls: do not call sys_mkdir{,at}() within the kernel
> > > 	syscalls: do not call sys_symlink{,at}() within the kernel
> > > 	syscalls: do not call sys_mknod{,at}() within the kernel
> > > 	syscalls: do not call sys_link{,at}() within the kernel
> > > 	syscalls: do not call sys_{f,}chmod{at,}() within the kernel
> > > 	syscalls: do not call sys_{f,}access{,at}() within the kernel
> > > 	syscalls: do not call sys_ftruncate() within the kernel
> > > 	syscalls: do not call sys_{,l,f}chown() within the kernel
> > > 	syscalls: do not call sys_close() within the kernel
> > 
> > >  72 files changed, 572 insertions(+), 274 deletions(-)
> > 
> > Just curious, have you done a before/after vmlinux /usr/bin/size comparison?
> > How do these changes impact generated code?
> > 
> > My expectation would be for there to be a noticeable decrease in text size.
> 
> Unfortunately, no:
> 
>    text	   data	    bss	    dec	    hex	filename
> 10352515	6598692	13344972	30296179	1ce4873	vmlinux-v4.16-rc5
> 10352845	6598852	13344972	30296669	1ce4a5d	vmlinux-v4.16-rc5-patch23
> 10352942	6598948	13344972	30296862	1ce4b1e	vmlinux-v4.16-rc5-patch35

Maybe it's due to the new helpers - still, the changes in size are very small so 
this isn't a showstopper.

Thanks,

	Ingo
