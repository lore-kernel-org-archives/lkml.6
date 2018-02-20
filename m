Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751485AbeBTLdY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 06:33:24 -0500
Received: from mail-wr0-f169.google.com ([209.85.128.169]:41855 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751348AbeBTLdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 06:33:22 -0500
X-Google-Smtp-Source: AH8x2254PiCwPtg1OGII2G4w0DnW0FwLcvL9c17feAQ4JWdAwXGLDj+pKSDQHEW5Z/IT1GPekg4nlg==
Date: Tue, 20 Feb 2018 12:33:18 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: christian.koenig@amd.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] locking/ww_mutex: cleanup lock->ctx usage in amdgpu
Message-ID: <20180220113318.GN22199@phenom.ffwll.local>
Mail-Followup-To: christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20180215141944.4332-1-christian.koenig@amd.com>
 <20180219152421.GQ22199@phenom.ffwll.local>
 <cbfec1ed-d01f-1d4f-c3c0-cc04b93bc58c@gmail.com>
 <20180219161544.GY22199@phenom.ffwll.local>
 <2e696981-6b4a-e292-c16a-0f3477dbf8ce@gmail.com>
 <20180219164354.GB22199@phenom.ffwll.local>
 <f3cef14f-135c-2446-74b5-20e14773b0c4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f3cef14f-135c-2446-74b5-20e14773b0c4@gmail.com>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 10:43:48AM +0100, Christian König wrote:
> Am 19.02.2018 um 17:43 schrieb Daniel Vetter:
> > On Mon, Feb 19, 2018 at 05:29:46PM +0100, Christian König wrote:
> > > [SNIP]
> > > Well that is not a problem at all. See we don't nest trylock with normal
> > > lock acquiring, cause that would indeed bypass the whole deadlock detection.
> > > 
> > > Instead we first use ww_mutex_acquire to lock all BOs which are needed for a
> > > command submission, including the deadlock detection.
> > > 
> > > Then all additional BOs which needed to be evicted to fulfill the current
> > > request are trylocked.
> > Yeah it's the lock; trylock; lock combo that deadlocks. If lockdep indeed
> > catches that one (and not some other recursion combo) then I think we
> > don't have to worry about holding tons of trylock'ed locks.
> 
> Well I haven't explicitly tested the lock; trylock; lock case, but you get a
> warning anyway in the lock; ... anything ...; lock case.
> 
> See the first and the second lock can't use the same acquire context,
> because that isn't known down the call stack and lockdep warns about that
> quite intensively.

Ah, so the ttm_ctx I've spotted was something entirely different and
doesn't contain the ww_acquire_ctx (I didn't check)? I'd assume you have
the same ctx passed around to everything in ttm, but if that doesn't exist
then we can indeed not annotate ww_mutex_trylock_ctx with the right ctx.

> What is a problem is that lockdep sometimes runs out of space to keep track
> of all the trylocked mutexes, but that could have happened before as well if
> I'm not completely mistaken.
> 
> > > > If this is really what you want to do, then we need a
> > > > ww_mutex_trylock_ctx, which also fills out the ctx value (so that other
> > > > threads can correctly resolve deadlocks when you hold that lock while
> > > > trying to grab additional locks). In which case you really don't need the
> > > > task pointer.
> > > Actually considered that as well, but it turned out that this is exactly
> > > what I don't want.
> > > 
> > > Cause then we wouldn't be able to distinct ww_mutex locked with a context
> > > (because they are part of the submission) and without (because TTM trylocked
> > > them).
> > Out of curiosity, why do you need to know that?
> 
> The control flow in TTM is that when you trylocked a BO you start to evict
> it.
> 
> Now sometimes it happens that we evict it from VRAM to GTT, but then find
> that we don't have enough GTT space and need to evict something from there
> to the SYSTEM domain.
> 
> The problem is now since the reservation object is trylocked because of the
> VRAM to GTT eviction we can't lock it again because of the GTT to the SYSTEM
> domain.
> 
> > > > Yes it's a disappointment that lockdep doesn't correctly track trylocks,
> > > > it just does basic sanity checks, but then drops them on the floor wrt
> > > > depency tracking. Just in case you wonder why you're not getting a
> > > > lockdeps splat for this. Unfortunately I don't understand lockdep enough
> > > > to be able to fix this gap.
> > > Sorry to disappoint you, but lockdep is indeed capable to correctly track
> > > those trylocked BOs.
> > > 
> > > Got quite a bunch of warning before I was able to resolve to this solution.
> > Hm, I thought it didn't detect a lock; trylock; lock combo because the
> > trylock didn't show up in the dependency stack. Maybe that got fixed
> > meanwhile.
> 
> Yeah I can confirm that this indeed got fixed.
> 
> > Assuming that we indeed need both, could we split up the two use-cases for
> > clarity? I.e. ww_mutex_is_owned_by_ctx, which only takes the ctx (and
> > forgoes checking for a task, since that's implied) and requires a non-NULL
> > ctx. And ww_mutex_is_owned_by_task, which only takes the task (and maybe
> > we should limit it to trylock and _single locks, i.e. WARN_ON(lock->ctx)
> > if ww-mutex debugging is enabled).
> > 
> > Or does that hit another requirement of your use-case?
> 
> Well we could add two tests, one which only checks the context and one which
> checks that the context is NULL and then checks the mutex owner.
> 
> But to me it actually looks more like that makes it unnecessary complicated.
> The use case in amdgpu which could only check the context isn't performance
> critical.

Oh I'm not worried about the runtime overhead at all, I'm worried about
conceptual clarity of this stuff. If you have a ctx there's no need to
also look at ->owner.

Another idea: We drop the task argument from functions and go with the
following logic:

ww_mutex_is_owner(lock, ctx)
{
	if (ctx)
		return lock->ctx == ctx;
	else
		return lock->owner == current;
}

I think that would solve your use case, and gives us the neat interface
I'm aiming for. Kerneldoc can then explain what's happening for a NULL
ctx.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
