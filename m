Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751903AbeBTNXC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 08:23:02 -0500
Received: from merlin.infradead.org ([205.233.59.134]:55774 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751718AbeBTNXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 08:23:00 -0500
Date: Tue, 20 Feb 2018 14:22:54 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] locking/ww_mutex: cleanup lock->ctx usage in amdgpu
Message-ID: <20180220132254.GB25201@hirez.programming.kicks-ass.net>
References: <20180215141944.4332-1-christian.koenig@amd.com>
 <20180220123532.GD25314@hirez.programming.kicks-ass.net>
 <c22fe062-6c7e-cfa3-5f0b-da135a751921@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c22fe062-6c7e-cfa3-5f0b-da135a751921@amd.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 02:08:26PM +0100, Christian König wrote:
> Am 20.02.2018 um 13:35 schrieb Peter Zijlstra:
> > > +static inline bool ww_mutex_is_owned_by(struct ww_mutex *lock,
> > > +					struct task_struct *task,
> > > +					struct ww_acquire_ctx *ctx)
> > > +{
> > > +	return likely(__mutex_owner(&lock->base) == task) &&
> > > +		READ_ONCE(lock->ctx) == ctx;
> > > +}
> > Nak on that interface, that's racy and broken by design.
> 
> Why?

If task != current you can race with a concurrent mutex_unlock().
