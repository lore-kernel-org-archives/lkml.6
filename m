Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969225AbeE1Px4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:53:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:43147 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967281AbeE1Pxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 11:53:50 -0400
Date: Mon, 28 May 2018 09:21:43 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mel Gorman <mgorman@techsingularity.net>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, stable@vger.kernel.org
Subject: Re: [PATCH] mm, page_alloc: do not break __GFP_THISNODE by zonelist
 reset
Message-ID: <20180528072143.GB1517@dhcp22.suse.cz>
References: <20180525130853.13915-1-vbabka@suse.cz>
 <20180525124300.964a1a15d953e8972625bb0f@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525124300.964a1a15d953e8972625bb0f@linux-foundation.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 25-05-18 12:43:00, Andrew Morton wrote:
> On Fri, 25 May 2018 15:08:53 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:
> 
> > we might consider this for 4.17 although I don't know if there's anything
> > currently broken. Stable backports should be more important, but will have to
> > be reviewed carefully, as the code went through many changes.
> > BTW I think that also the ac->preferred_zoneref reset is currently useless if
> > we don't also reset ac->nodemask from a mempolicy to NULL first (which we
> > probably should for the OOM victims etc?), but I would leave that for a
> > separate patch.
> 
> Confused.  If nothing is currently broken then why is a backport
> needed?  Presumably because we expect breakage in the future?  Can you
> expand on this?

__GFP_THISNODE is documented to _use_ the given node. Allocating from a
different one is a bug. Maybe the current code can cope with that or at
least doesn't blow up in an obvious way but the bug is still there.

I am still not sure what to do about the zonelist reset. It still seems
like an echo from the past but using numa_node_id for __GFP_THISNODE is
a clear bug because our task could have been migrated to a cpu on a
different than requested node.

Acked-by: Michal Hocko <mhocko@suse.com>

-- 
Michal Hocko
SUSE Labs
