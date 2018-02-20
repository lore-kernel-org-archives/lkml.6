Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751827AbeBTOyZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 09:54:25 -0500
Received: from merlin.infradead.org ([205.233.59.134]:56290 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbeBTOyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 09:54:24 -0500
Date: Tue, 20 Feb 2018 15:54:13 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dev@mblankhorst.nl,
        chris@chris-wilson.co.uk
Subject: Re: [PATCH 1/4] locking/ww_mutex: add ww_mutex_is_owned_by function
 v3
Message-ID: <20180220145413.GF25201@hirez.programming.kicks-ass.net>
References: <20180220125829.27060-1-christian.koenig@amd.com>
 <20180220131253.GF25314@hirez.programming.kicks-ass.net>
 <8fd80334-4d0e-8ed0-8a09-02a7e36a0eae@gmail.com>
 <20180220135709.GD25201@hirez.programming.kicks-ass.net>
 <b625cbca-c05a-afd1-fe97-a7a0760383c1@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b625cbca-c05a-afd1-fe97-a7a0760383c1@amd.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 03:34:07PM +0100, Christian König wrote:
> > OK, but neither case would in fact need the !ctx case right? That's just
> > there for completeness sake?
> 
> Unfortunately not. TTM uses trylock to lock BOs which are about to be
> evicted to make room for all the BOs locked with a ctx.
> 
> I need to be able to distinct between the BOs which are trylocked and those
> which are locked with a ctx.
> 
> Writing this I actually noticed the current version is buggy, cause even
> when we check the mutex owner we still need to make sure that the ctx in the
> lock is NULL.

Hurm... I can't remember why trylocks behave like that, and it seems
rather unfortunate / inconsistent.

Chris, Maarten, do either one of you remember?

I'm thinking that if we do acquire the trylock, the thing should join
the ctx such that a subsequent contending mutex_lock() can ww right.
