Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936028AbeEYIQ1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 04:16:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:43833 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935866AbeEYIQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 04:16:26 -0400
Date: Fri, 25 May 2018 10:16:24 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Jonathan Corbet <corbet@lwn.net>, LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH] doc: document scope NOFS, NOIO APIs
Message-ID: <20180525081624.GH11881@dhcp22.suse.cz>
References: <20180424183536.GF30619@thunk.org>
 <20180524114341.1101-1-mhocko@kernel.org>
 <20180524221715.GY10363@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524221715.GY10363@dastard>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 25-05-18 08:17:15, Dave Chinner wrote:
> On Thu, May 24, 2018 at 01:43:41PM +0200, Michal Hocko wrote:
[...]
> > +FS/IO code then simply calls the appropriate save function right at the
> > +layer where a lock taken from the reclaim context (e.g. shrinker) and
> > +the corresponding restore function when the lock is released. All that
> > +ideally along with an explanation what is the reclaim context for easier
> > +maintenance.
> 
> This paragraph doesn't make much sense to me. I think you're trying
> to say that we should call the appropriate save function "before
> locks are taken that a reclaim context (e.g a shrinker) might
> require access to."
> 
> I think it's also worth making a note about recursive/nested
> save/restore stacking, because it's not clear from this description
> that this is allowed and will work as long as inner save/restore
> calls are fully nested inside outer save/restore contexts.

Any better?

-FS/IO code then simply calls the appropriate save function right at the
-layer where a lock taken from the reclaim context (e.g. shrinker) and
-the corresponding restore function when the lock is released. All that
-ideally along with an explanation what is the reclaim context for easier
-maintenance.
+FS/IO code then simply calls the appropriate save function before any
+lock shared with the reclaim context is taken.  The corresponding
+restore function when the lock is released. All that ideally along with
+an explanation what is the reclaim context for easier maintenance.
+
+Please note that the proper pairing of save/restore function allows nesting
+so memalloc_noio_save is safe to be called from an existing NOIO or NOFS scope.
 
 What about __vmalloc(GFP_NOFS)
 ==============================
-- 
Michal Hocko
SUSE Labs
