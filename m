Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935046AbeE1Wdi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 18:33:38 -0400
Received: from ipmail03.adl2.internode.on.net ([150.101.137.141]:45213 "EHLO
        ipmail03.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934147AbeE1Wdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 18:33:35 -0400
Date: Tue, 29 May 2018 08:32:05 +1000
From: Dave Chinner <david@fromorbit.com>
To: Michal Hocko <mhocko@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH] doc: document scope NOFS, NOIO APIs
Message-ID: <20180528223205.GG23861@dastard>
References: <20180424183536.GF30619@thunk.org>
 <20180524114341.1101-1-mhocko@kernel.org>
 <20180524221715.GY10363@dastard>
 <20180525081624.GH11881@dhcp22.suse.cz>
 <20180527234854.GF23861@dastard>
 <20180528091923.GH1517@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180528091923.GH1517@dhcp22.suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 11:19:23AM +0200, Michal Hocko wrote:
> On Mon 28-05-18 09:48:54, Dave Chinner wrote:
> > On Fri, May 25, 2018 at 10:16:24AM +0200, Michal Hocko wrote:
> > > On Fri 25-05-18 08:17:15, Dave Chinner wrote:
> > > > On Thu, May 24, 2018 at 01:43:41PM +0200, Michal Hocko wrote:
> > > [...]
> > > > > +FS/IO code then simply calls the appropriate save function right at the
> > > > > +layer where a lock taken from the reclaim context (e.g. shrinker) and
> > > > > +the corresponding restore function when the lock is released. All that
> > > > > +ideally along with an explanation what is the reclaim context for easier
> > > > > +maintenance.
> > > > 
> > > > This paragraph doesn't make much sense to me. I think you're trying
> > > > to say that we should call the appropriate save function "before
> > > > locks are taken that a reclaim context (e.g a shrinker) might
> > > > require access to."
> > > > 
> > > > I think it's also worth making a note about recursive/nested
> > > > save/restore stacking, because it's not clear from this description
> > > > that this is allowed and will work as long as inner save/restore
> > > > calls are fully nested inside outer save/restore contexts.
> > > 
> > > Any better?
> > > 
> > > -FS/IO code then simply calls the appropriate save function right at the
> > > -layer where a lock taken from the reclaim context (e.g. shrinker) and
> > > -the corresponding restore function when the lock is released. All that
> > > -ideally along with an explanation what is the reclaim context for easier
> > > -maintenance.
> > > +FS/IO code then simply calls the appropriate save function before any
> > > +lock shared with the reclaim context is taken.  The corresponding
> > > +restore function when the lock is released. All that ideally along with
> > > +an explanation what is the reclaim context for easier maintenance.
> > > +
> > > +Please note that the proper pairing of save/restore function allows nesting
> > > +so memalloc_noio_save is safe to be called from an existing NOIO or NOFS scope.
> > 
> > It's better, but the talk of this being necessary for locking makes
> > me cringe. XFS doesn't do it for locking reasons - it does it
> > largely for preventing transaction context nesting, which has all
> > sorts of problems that cause hangs (e.g. log space reservations
> > can't be filled) that aren't directly locking related.
> 
> Yeah, I wanted to not mention locks as much as possible.
>  
> > i.e we should be talking about using these functions around contexts
> > where recursion back into the filesystem through reclaim is
> > problematic, not that "holding locks" is problematic. Locks can be
> > used as an example of a problematic context, but locks are not the
> > only recursion issue that require GFP_NOFS allocation contexts to
> > avoid.
> 
> agreed. Do you have any suggestion how to add a more abstract wording
> that would not make head spinning?
> 
> I've tried the following. Any better?
> 
> diff --git a/Documentation/core-api/gfp_mask-from-fs-io.rst b/Documentation/core-api/gfp_mask-from-fs-io.rst
> index c0ec212d6773..adac362b2875 100644
> --- a/Documentation/core-api/gfp_mask-from-fs-io.rst
> +++ b/Documentation/core-api/gfp_mask-from-fs-io.rst
> @@ -34,9 +34,11 @@ scope will inherently drop __GFP_FS respectively __GFP_IO from the given
>  mask so no memory allocation can recurse back in the FS/IO.
>  
>  FS/IO code then simply calls the appropriate save function before any
> -lock shared with the reclaim context is taken.  The corresponding
> -restore function when the lock is released. All that ideally along with
> -an explanation what is the reclaim context for easier maintenance.
> +critical section wrt. the reclaim is started - e.g. lock shared with the
> +reclaim context or when a transaction context nesting would be possible
> +via reclaim. The corresponding restore function when the critical

.... restore function should be called when ...

But otherwise I think this is much better.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
