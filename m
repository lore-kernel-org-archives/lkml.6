Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752724AbeE0Xs7 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 19:48:59 -0400
Received: from ipmail03.adl6.internode.on.net ([150.101.137.143]:15684 "EHLO
        ipmail03.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752406AbeE0Xs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 19:48:57 -0400
Date: Mon, 28 May 2018 09:48:54 +1000
From: Dave Chinner <david@fromorbit.com>
To: Michal Hocko <mhocko@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH] doc: document scope NOFS, NOIO APIs
Message-ID: <20180527234854.GF23861@dastard>
References: <20180424183536.GF30619@thunk.org>
 <20180524114341.1101-1-mhocko@kernel.org>
 <20180524221715.GY10363@dastard>
 <20180525081624.GH11881@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525081624.GH11881@dhcp22.suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 10:16:24AM +0200, Michal Hocko wrote:
> On Fri 25-05-18 08:17:15, Dave Chinner wrote:
> > On Thu, May 24, 2018 at 01:43:41PM +0200, Michal Hocko wrote:
> [...]
> > > +FS/IO code then simply calls the appropriate save function right at the
> > > +layer where a lock taken from the reclaim context (e.g. shrinker) and
> > > +the corresponding restore function when the lock is released. All that
> > > +ideally along with an explanation what is the reclaim context for easier
> > > +maintenance.
> > 
> > This paragraph doesn't make much sense to me. I think you're trying
> > to say that we should call the appropriate save function "before
> > locks are taken that a reclaim context (e.g a shrinker) might
> > require access to."
> > 
> > I think it's also worth making a note about recursive/nested
> > save/restore stacking, because it's not clear from this description
> > that this is allowed and will work as long as inner save/restore
> > calls are fully nested inside outer save/restore contexts.
> 
> Any better?
> 
> -FS/IO code then simply calls the appropriate save function right at the
> -layer where a lock taken from the reclaim context (e.g. shrinker) and
> -the corresponding restore function when the lock is released. All that
> -ideally along with an explanation what is the reclaim context for easier
> -maintenance.
> +FS/IO code then simply calls the appropriate save function before any
> +lock shared with the reclaim context is taken.  The corresponding
> +restore function when the lock is released. All that ideally along with
> +an explanation what is the reclaim context for easier maintenance.
> +
> +Please note that the proper pairing of save/restore function allows nesting
> +so memalloc_noio_save is safe to be called from an existing NOIO or NOFS scope.

It's better, but the talk of this being necessary for locking makes
me cringe. XFS doesn't do it for locking reasons - it does it
largely for preventing transaction context nesting, which has all
sorts of problems that cause hangs (e.g. log space reservations
can't be filled) that aren't directly locking related.

i.e we should be talking about using these functions around contexts
where recursion back into the filesystem through reclaim is
problematic, not that "holding locks" is problematic. Locks can be
used as an example of a problematic context, but locks are not the
only recursion issue that require GFP_NOFS allocation contexts to
avoid.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
