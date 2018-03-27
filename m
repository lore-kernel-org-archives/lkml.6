Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752133AbeC0Ldt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 07:33:49 -0400
Received: from gate.crashing.org ([63.228.1.57]:37689 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751124AbeC0Ldp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 07:33:45 -0400
Message-ID: <1522150386.7364.53.camel@kernel.crashing.org>
Subject: Re: [PATCH for-4.17 2/2] powerpc: Remove smp_mb() from
 arch_spin_is_locked()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 27 Mar 2018 22:33:06 +1100
In-Reply-To: <20180327102521.GA7347@andrea>
References: <1522060667-7034-1-git-send-email-andrea.parri@amarulasolutions.com>
         <1522109216.7364.30.camel@kernel.crashing.org>
         <20180327102521.GA7347@andrea>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-03-27 at 12:25 +0200, Andrea Parri wrote:
> > I would rather wait until it is properly documented. Debugging that IPC
> > problem took a *LOT* of time and energy, I wouldn't want these issues
> > to come and bite us again.
> 
> I understand. And I'm grateful for this debugging as well as for the (IMO)
> excellent account of it you provided in 51d7d5205d338.
> 
> Said this ;) I cannot except myself from saying that I would probably have
> resisted that solution (adding an smp_mb() in my arch_spin_is_locked), and
> instead "blamed"/suggested that caller to fix his memory ordering...

This is debatable. I tend go for the conservative approach assuming
most people using fairly high level APIs such as spin_is_locked() are
not fully cognisant of the subtleties of our memory model.

After all, it works on x86 ...

The fact that the load can leak into the internals of spin_lock()
implementation and re-order with the lock word load itself is quite
hard to fathom for somebody who doesn't have years of experience
dealing with that sort of issue.

So people will get it wrong.

So unless it's very performance sensitive, I'd rather have things like
spin_is_locked be conservative by default and provide simpler ordering
semantics.

Cheers,
Ben.
