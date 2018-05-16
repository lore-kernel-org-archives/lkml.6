Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752622AbeEPL7Q (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 07:59:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52500 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752026AbeEPL7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 07:59:15 -0400
Date: Wed, 16 May 2018 13:59:06 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v4 1/2] locking/rwsem: Add a new RWSEM_ANONYMOUSLY_OWNED
 flag
Message-ID: <20180516115906.GF12217@hirez.programming.kicks-ass.net>
References: <1526420991-21213-1-git-send-email-longman@redhat.com>
 <1526420991-21213-2-git-send-email-longman@redhat.com>
 <20180516104829.GA24332@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516104829.GA24332@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 12:48:30PM +0200, Oleg Nesterov wrote:
> > +static inline bool is_rwsem_owner_spinnable(struct task_struct *owner)
> >  {
> > -	return owner && owner != RWSEM_READER_OWNED;
> > +	return !((unsigned long)owner & RWSEM_ANONYMOUSLY_OWNED);
> >  }
> 
> Perhaps you should add __attribute__(aligned) to struct rw_semaphore then...
> 
> I don't think it is really needed, but see the comment under struct address_space.

Luckily we just dropped CRIS support, but yeah, who knows if some other
dodgy arch also doesn't properly align things.

>From a quick test, m68k is the only odd one, it seems to align pointers
on 2 bytes.
