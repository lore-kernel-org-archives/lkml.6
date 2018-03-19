Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968014AbeCSTau (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 15:30:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48378 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965715AbeCSTad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 15:30:33 -0400
Date: Mon, 19 Mar 2018 12:30:31 -0700
From: Matthew Wilcox <willy@infradead.org>
To: David Rientjes <rientjes@google.com>
Cc: Ian Kent <raven@themaw.net>, autofs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <mawilcox@microsoft.com>
Subject: Re: [PATCH] autofs4: Use wait_event_killable
Message-ID: <20180319193031.GC6739@bombadil.infradead.org>
References: <20180319191609.23880-1-willy@infradead.org>
 <alpine.DEB.2.20.1803191218210.114201@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1803191218210.114201@chino.kir.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 12:25:58PM -0700, David Rientjes wrote:
> On Mon, 19 Mar 2018, Matthew Wilcox wrote:
> >  	 * wq->name.name is NULL iff the lock is already released
> >  	 * or the mount has been made catatonic.
> >  	 */
> > -	if (wq->name.name) {
> > -		/* Block all but "shutdown" signals while waiting */
> > -		unsigned long shutdown_sigs_mask;
> > -		unsigned long irqflags;
> > -		sigset_t oldset;
> > -
[...]
> > -
> > -		wait_event_interruptible(wq->queue, wq->name.name == NULL);
[...]
> > -	} else {
> > -		pr_debug("skipped sleeping\n");
> > -	}
> > -
> > +	wait_event_killable(wq->queue, wq->name.name == NULL);
>
> I understand converting the wait_event_interruptible() to 
> wait_event_killable(), but why was the above wait_event_interruptible() 
> only called when wq->name.name != NULL?  

My guess is that it was to avoid the overhead of diddling the signal set
when wq->name.name was already NULL.  I don't really kow though, it
predates git history and I'm too lazy to go and poke through the historical
repos to see if that reason was captured by BitKeeper.

> wait_event_{killable,interruptible}() will return without sleeping when 
> wq->name.name == NULL, so I suppose it has something to do with the 
> comment above it.
