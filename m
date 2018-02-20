Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751360AbeBTN5P (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 08:57:15 -0500
Received: from merlin.infradead.org ([205.233.59.134]:56032 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751300AbeBTN5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 08:57:13 -0500
Date: Tue, 20 Feb 2018 14:57:09 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] locking/ww_mutex: add ww_mutex_is_owned_by function
 v3
Message-ID: <20180220135709.GD25201@hirez.programming.kicks-ass.net>
References: <20180220125829.27060-1-christian.koenig@amd.com>
 <20180220131253.GF25314@hirez.programming.kicks-ass.net>
 <8fd80334-4d0e-8ed0-8a09-02a7e36a0eae@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8fd80334-4d0e-8ed0-8a09-02a7e36a0eae@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 02:26:55PM +0100, Christian König wrote:
> > > +static inline bool ww_mutex_is_owned_by(struct ww_mutex *lock,
> > > +					struct ww_acquire_ctx *ctx)
> > > +{
> > > +	if (ctx)
> > > +		return likely(READ_ONCE(lock->ctx) == ctx);
> > > +	else
> > > +		return likely(__mutex_owner(&lock->base) == current);
> > > +}
> > Much better than the previous version. If you want to bike-shed, you can
> > leave out the 'else' and unindent the last line.
> 
> Thanks for the suggestion, going to do this.

You might also want likely(ctx), since ww_mutex without ctx is
a-typical I would think.

> > I do worry about potential users of .ctx = NULL, though. It makes it far
> > too easy to do recursive locking, which is something we should strongly
> > discourage.
> 
> Well, one of the addressed use cases is indeed checking for recursive
> locking. But recursive locking is something rather normal for ww_mutex and
> we are just exercising an existing code path.

But that would be the ctx case, right? I'm not sure there is a lot of
!ctx use out there, and in that case it really is rather like a normal
mutex.

> E.g. the most common use case for the ww_mutex is in the graphics drivers
> where usespace sends us a list of buffer objects to work with.
> 
> Now when userspace sends us duplicates in that buffer list the expectation
> is to get -EALREADY from ww_mutex_lock when we try to lock the same ww_mutex
> twice.

Right, I remember that much.. :-)

> The intention behind this function is now to a) be able to extend those
> checks to make sure user space doesn't sends us potentially harmful nonsense
> and b) allow to check for recursion in TTM during buffer object eviction
> which uses ww_mutex_trylock instead of ww_mutex_lock.

OK, but neither case would in fact need the !ctx case right? That's just
there for completeness sake?

But yes, I cannot think of a better fallback there either.
