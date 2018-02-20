Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752517AbeBTPWK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 10:22:10 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50576 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752339AbeBTPWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 10:22:06 -0500
Date: Tue, 20 Feb 2018 16:21:58 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: christian.koenig@amd.com
Cc: dev@mblankhorst.nl, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] locking/ww_mutex: add ww_mutex_is_owned_by function
 v3
Message-ID: <20180220152158.GH25201@hirez.programming.kicks-ass.net>
References: <20180220125829.27060-1-christian.koenig@amd.com>
 <20180220131253.GF25314@hirez.programming.kicks-ass.net>
 <8fd80334-4d0e-8ed0-8a09-02a7e36a0eae@gmail.com>
 <20180220135709.GD25201@hirez.programming.kicks-ass.net>
 <b625cbca-c05a-afd1-fe97-a7a0760383c1@amd.com>
 <20180220145413.GF25201@hirez.programming.kicks-ass.net>
 <2dac8ec9-c54a-7dd1-af4e-62f2bc1a959c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2dac8ec9-c54a-7dd1-af4e-62f2bc1a959c@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 04:05:49PM +0100, Christian König wrote:
> Am 20.02.2018 um 15:54 schrieb Peter Zijlstra:
> > On Tue, Feb 20, 2018 at 03:34:07PM +0100, Christian König wrote:
> > > > OK, but neither case would in fact need the !ctx case right? That's just
> > > > there for completeness sake?
> > > Unfortunately not. TTM uses trylock to lock BOs which are about to be
> > > evicted to make room for all the BOs locked with a ctx.
> > > 
> > > I need to be able to distinct between the BOs which are trylocked and those
> > > which are locked with a ctx.
> > > 
> > > Writing this I actually noticed the current version is buggy, cause even
> > > when we check the mutex owner we still need to make sure that the ctx in the
> > > lock is NULL.
> > Hurm... I can't remember why trylocks behave like that, and it seems
> > rather unfortunate / inconsistent.
> 
> Actually for me that is rather fortunate, cause I need to distinct between
> the locks acquired through trylock and lock.

I suppose that would always be possible using:
ww_mutex_trylock(.ctx=NULL), and it could be that there simply weren't
any immediate uses for a !NULL trylock and it was thus not implemented.

But that is all very long ago..
