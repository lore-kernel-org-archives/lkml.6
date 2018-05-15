Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752805AbeEOVVg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 17:21:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37242 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752483AbeEOVVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 17:21:35 -0400
Date: Tue, 15 May 2018 14:21:30 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Waiman Long <longman@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Oleg Nesterov <oleg@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v3 2/2] locking/percpu-rwsem: Annotate rwsem ownership
 transfer by setting RWSEM_OWNER_UNKNOWN
Message-ID: <20180515212130.GA12204@bombadil.infradead.org>
References: <1526405884-4860-1-git-send-email-longman@redhat.com>
 <1526405884-4860-3-git-send-email-longman@redhat.com>
 <20180515175805.GN12217@hirez.programming.kicks-ass.net>
 <20180515180219.GA6612@bombadil.infradead.org>
 <4a3fbd3c-3cfa-f9c2-c73c-fa6d9c55c2d5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a3fbd3c-3cfa-f9c2-c73c-fa6d9c55c2d5@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 02:45:12PM -0400, Waiman Long wrote:
> On 05/15/2018 02:02 PM, Matthew Wilcox wrote:
> > On Tue, May 15, 2018 at 07:58:05PM +0200, Peter Zijlstra wrote:
> >> On Tue, May 15, 2018 at 01:38:04PM -0400, Waiman Long wrote:
> >>> +/*
> >>> + * Owner value to indicate the rwsem's owner is not currently known.
> >>> + */
> >>> +#define RWSEM_OWNER_UNKNOWN	((struct task_struct *)-1)
> >> It might be nice to comment that this works and relies on having that
> >> ANON_OWNER bit set.
> > I'd rather change the definition to be ((struct task_struct *)2)
> > otherwise this is both reader-owned and anonymously-owned which doesn't
> > make much sense.
> 
> Thinking about it a bit more. I can actually just use one special bit
> (bit 0) to designate an unknown owner. So for a reader-owned lock, it is
> just owner == 1 as the owners are unknown for a reader owned lock. For a
> lock owned by an unknown writer, it is (owner & 1) && (owner != 1). That
> will justify the use of -1L and save bit 1 for future extension.

To quote from your patch:

- * In essence, the owner field now has the following 3 states:
+ * In essence, the owner field now has the following 4 states:
  *  1) 0
  *     - lock is free or the owner hasn't set the field yet
  *  2) RWSEM_READER_OWNED
  *     - lock is currently or previously owned by readers (lock is free
  *	  or not set by owner yet)
- *  3) Other non-zero value
- *     - a writer owns the lock
+ *  3) RWSEM_ANONYMOUSLY_OWNED
+ *     - lock is owned by an anonymous writer, so spinning on the lock
+ *	  owner should be disabled.
+ *  4) Other non-zero value
+ *     - a writer owns the lock and other writers can spin on the lock owner.

I'd leave these as 0, 1, 2, other.  It's not really worth messing with
testing bits.

Actually, if you change them to all be values -- s/NULL/RWSEM_NO_OWNER/

then you could define them as:

RWSEM_READER_OWNED	0
RWSEM_ANON_OWNED	1
RWSEM_NO_OWNER		2

and rwsem_should_spin() is just sem->owner > 1.
