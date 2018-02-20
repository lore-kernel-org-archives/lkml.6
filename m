Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751783AbeBTX41 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 18:56:27 -0500
Received: from mail-wr0-f178.google.com ([209.85.128.178]:37032 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751683AbeBTX4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 18:56:25 -0500
X-Google-Smtp-Source: AH8x226hvvHh3gvLAwKcVZWCidbl+y4Vr8czaBMveHXcBtfQbNAihv8l4QPSwzmFf2rrzOXPTN+xdA==
Date: Wed, 21 Feb 2018 00:56:21 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Peter Zijlstra <peterz@infradead.org>
Cc: christian.koenig@amd.com, dev@mblankhorst.nl,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] locking/ww_mutex: add ww_mutex_is_owned_by function
 v3
Message-ID: <20180220235621.GD22199@phenom.ffwll.local>
Mail-Followup-To: Peter Zijlstra <peterz@infradead.org>,
        christian.koenig@amd.com, dev@mblankhorst.nl,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20180220125829.27060-1-christian.koenig@amd.com>
 <20180220131253.GF25314@hirez.programming.kicks-ass.net>
 <8fd80334-4d0e-8ed0-8a09-02a7e36a0eae@gmail.com>
 <20180220135709.GD25201@hirez.programming.kicks-ass.net>
 <b625cbca-c05a-afd1-fe97-a7a0760383c1@amd.com>
 <20180220145413.GF25201@hirez.programming.kicks-ass.net>
 <2dac8ec9-c54a-7dd1-af4e-62f2bc1a959c@gmail.com>
 <20180220152158.GH25201@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180220152158.GH25201@hirez.programming.kicks-ass.net>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 04:21:58PM +0100, Peter Zijlstra wrote:
> On Tue, Feb 20, 2018 at 04:05:49PM +0100, Christian König wrote:
> > Am 20.02.2018 um 15:54 schrieb Peter Zijlstra:
> > > On Tue, Feb 20, 2018 at 03:34:07PM +0100, Christian König wrote:
> > > > > OK, but neither case would in fact need the !ctx case right? That's just
> > > > > there for completeness sake?
> > > > Unfortunately not. TTM uses trylock to lock BOs which are about to be
> > > > evicted to make room for all the BOs locked with a ctx.
> > > > 
> > > > I need to be able to distinct between the BOs which are trylocked and those
> > > > which are locked with a ctx.
> > > > 
> > > > Writing this I actually noticed the current version is buggy, cause even
> > > > when we check the mutex owner we still need to make sure that the ctx in the
> > > > lock is NULL.
> > > Hurm... I can't remember why trylocks behave like that, and it seems
> > > rather unfortunate / inconsistent.
> > 
> > Actually for me that is rather fortunate, cause I need to distinct between
> > the locks acquired through trylock and lock.
> 
> I suppose that would always be possible using:
> ww_mutex_trylock(.ctx=NULL), and it could be that there simply weren't
> any immediate uses for a !NULL trylock and it was thus not implemented.
> 
> But that is all very long ago..

I think we simple never had a use-case for interleaving ww_mutex_lock(ctx)
and ww_mutex_trylock(ctx). Nesting multiple trylocks in ctx-locks happens
plenty, but not further:

The common use-case for that is locking a bunch of buffers you need (for
command submission or whatever), and then trylocking other buffers to make
space for the buffers you need to move into VRAM. I guess if only
trylocking buffers doesn't succeed in freeing up enough VRAM then we could
go into blocking ww_mutex_locks which need the ctx (and which would need
all the trylock-acquired buffers to be annotated with the ctx too). TTM
currently tries to be far enough away from that corner case (using a
defensive "never use more than 50% of all memory for gfx" approach) that
it doesn't seem to need that.

Once we get there it should indeed be simply to add a ctx parameter to
ww_mutex_trylock to fix this case. The TTM side rework is definitely going
to be the much bigger issue here ...
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
