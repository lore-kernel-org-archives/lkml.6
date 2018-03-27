Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752543AbeC0NNt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 09:13:49 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35873 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752289AbeC0NNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 09:13:48 -0400
X-Google-Smtp-Source: AG47ELso81ZkAem01332GHCV4LrkIfrXf+FJcM4pzVJyD0WdEusBrhK+quo45Y2NZfCEaE+YSE2UZQ==
Date: Tue, 27 Mar 2018 15:13:39 +0200
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH for-4.17 2/2] powerpc: Remove smp_mb() from
 arch_spin_is_locked()
Message-ID: <20180327131339.GA4278@andrea>
References: <1522060667-7034-1-git-send-email-andrea.parri@amarulasolutions.com>
 <1522109216.7364.30.camel@kernel.crashing.org>
 <20180327102521.GA7347@andrea>
 <1522150386.7364.53.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522150386.7364.53.camel@kernel.crashing.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 10:33:06PM +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2018-03-27 at 12:25 +0200, Andrea Parri wrote:
> > > I would rather wait until it is properly documented. Debugging that IPC
> > > problem took a *LOT* of time and energy, I wouldn't want these issues
> > > to come and bite us again.
> > 
> > I understand. And I'm grateful for this debugging as well as for the (IMO)
> > excellent account of it you provided in 51d7d5205d338.
> > 
> > Said this ;) I cannot except myself from saying that I would probably have
> > resisted that solution (adding an smp_mb() in my arch_spin_is_locked), and
> > instead "blamed"/suggested that caller to fix his memory ordering...
> 
> This is debatable. I tend go for the conservative approach assuming
> most people using fairly high level APIs such as spin_is_locked() are
> not fully cognisant of the subtleties of our memory model.
> 
> After all, it works on x86 ...
> 
> The fact that the load can leak into the internals of spin_lock()
> implementation and re-order with the lock word load itself is quite
> hard to fathom for somebody who doesn't have years of experience
> dealing with that sort of issue.
> 
> So people will get it wrong.
> 
> So unless it's very performance sensitive, I'd rather have things like
> spin_is_locked be conservative by default and provide simpler ordering
> semantics.

Well, it might not be "very performance sensitive" but allow me to say
that "40+ SYNCs in stuff like BUG_ON or such" is sadness to my eyes ;),
especially when considered that our "high level API" provides means to
avoid this situation (e.g., smp_mb__after_spinlock(); BTW, if you look
at architectures for which this macro is "non-trivial", you can get an
idea of the architectures which "wouldn't work"; of course, x86 is not
among these).  Yes, we do appear to have different views on what is to
be considered the "simpler ordering semantics".  I'm willing to change
mine _as soon as_ this gets documented: would you be willing to send a
patch (on the lines of my [1]) to describe/document such semantics?

  Andrea


> 
> Cheers,
> Ben.
> 
