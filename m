Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753004AbeDCUEp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 16:04:45 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:32968 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1751859AbeDCUEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 16:04:44 -0400
Date: Tue, 3 Apr 2018 16:04:43 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrea Parri <andrea.parri@amarulasolutions.com>
cc: David Howells <dhowells@redhat.com>, <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v2 1/3] locking: Document the semantics of spin_is_locked()
In-Reply-To: <20180403193139.GA6143@andrea>
Message-ID: <Pine.LNX.4.44L0.1804031557470.1399-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Apr 2018, Andrea Parri wrote:

> On Tue, Apr 03, 2018 at 04:23:07PM +0100, David Howells wrote:
> > Andrea Parri <andrea.parri@amarulasolutions.com> wrote:
> > 
> > > Sorry, but I don't understand your objection: are you suggesting to add
> > > something like "Always return 0 on !SMP" to the comment?  what else?
> > 
> > Something like that, possibly along with a warning that this might not be what
> > you want.  You might actually want it to return true on !SMP, it depends on
> > what you're using it for.
> 
> I ended up with the following revision.  I hesitated on whether to refer
> to 'include/linux/spinlock_up.h' or not, but in the end I decided to not
> include the reference.  Please let me know what you think about this.


> +/**
> + * spin_is_locked() - Check whether a spinlock is locked.
> + * @lock: Pointer to the spinlock.
> + *
> + * This function is NOT required to provide any memory ordering
> + * guarantees; it could be used for debugging purposes or, when
> + * additional synchronization is needed, accompanied with other
> + * constructs (memory barriers) enforcing the synchronization.
> + *
> + * Return: 1, if @lock is (found to be) locked; 0, otherwise.
> + *
> + *	   Remark that this primitve can return a fixed value
> + *	   under certain !SMP configurations.

I would change these last two paragraphs as follows:

+ * Returns: 1 if @lock is locked, 0 otherwise.
+ * However, on !CONFIG_SMP builds with !CONFIG_DEBUG_SPINLOCK,
+ * the return value is always 0 (see include/linux/spinlock_up.h).
+ * Therefore you should not rely heavily on the return value.

Alan
