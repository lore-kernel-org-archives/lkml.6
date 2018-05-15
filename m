Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752978AbeEOM6l (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 08:58:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48602 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752433AbeEOM6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 08:58:39 -0400
Date: Tue, 15 May 2018 14:58:30 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH v2 2/2] locking/percpu-rwsem: Mark rwsem as
 non-spinnable in percpu_rwsem_release()
Message-ID: <20180515125830.GC12217@hirez.programming.kicks-ass.net>
References: <1526326267-22501-1-git-send-email-longman@redhat.com>
 <1526326267-22501-3-git-send-email-longman@redhat.com>
 <20180515085111.GW12217@hirez.programming.kicks-ass.net>
 <20180515110632.GA14527@redhat.com>
 <20180515115112.GZ12217@hirez.programming.kicks-ass.net>
 <20180515124532.GA19429@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180515124532.GA19429@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 02:45:32PM +0200, Oleg Nesterov wrote:
> On 05/15, Peter Zijlstra wrote:
> >
> > > > Afaict the whole .owner=NULL thing in release already stops the spinners
> > >
> > > Not really, the new writer will spin in this case, afaics.
> > >
> > > But this is another problem and probably we do not care. The new writer is
> > > almost impossible in this particular case, another freeze_super() should
> > > notice frozen != SB_UNFROZEN and return EBUSY.
> >
> > rwsem_spin_on_owner() checks rwsem_owner_is_writer(), which does owner
> > && owner != RWSEM_READER_OWNED, which will fail for !owner.
> 
> Yep. So rwsem_spin_on_owner() goes to "out:" and returns
> !rwsem_owner_is_reader() == T.
> 
> IOW, afaics owner == NULL means "spin unconditionally", I guess this is for
> the case when the new writer is going to do rwsem_set_owner() or up_write()
> has already called rwsem_clear_owner() but didn't do up_write() yet.
> 
> Probably makes sense, but the code is not very clean,

Arrgh, you're right... I hate this rwsem code.

Some day I'll finish the atomic_long_t version, which similar to mutex,
merges the owner and 'count' fields.
