Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10481C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD5C3218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730193AbfBAPGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:06:18 -0500
Received: from outbound-smtp12.blacknight.com ([46.22.139.17]:46547 "EHLO
        outbound-smtp12.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729043AbfBAPGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 10:06:17 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp12.blacknight.com (Postfix) with ESMTPS id A50501C2246
        for <linux-kernel@vger.kernel.org>; Fri,  1 Feb 2019 15:06:15 +0000 (GMT)
Received: (qmail 22173 invoked from network); 1 Feb 2019 15:06:15 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.225.79])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 1 Feb 2019 15:06:15 -0000
Date:   Fri, 1 Feb 2019 15:06:14 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 09/22] mm, compaction: Use free lists to quickly locate a
 migration source
Message-ID: <20190201150614.GJ9565@techsingularity.net>
References: <20190118175136.31341-1-mgorman@techsingularity.net>
 <20190118175136.31341-10-mgorman@techsingularity.net>
 <4a6ae9fc-a52b-4300-0edb-a0f4169c314a@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <4a6ae9fc-a52b-4300-0edb-a0f4169c314a@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 02:55:01PM +0100, Vlastimil Babka wrote:
> > +
> > +				/*
> > +				 * Avoid if skipped recently. Ideally it would
> > +				 * move to the tail but even safe iteration of
> > +				 * the list assumes an entry is deleted, not
> > +				 * reordered.
> > +				 */
> > +				if (get_pageblock_skip(freepage)) {
> > +					if (list_is_last(freelist, &freepage->lru))
> > +						break;
> > +
> > +					continue;
> > +				}
> > +
> > +				/* Reorder to so a future search skips recent pages */
> > +				move_freelist_tail(freelist, freepage);
> > +
> > +				pfn = pageblock_start_pfn(free_pfn);
> > +				cc->fast_search_fail = 0;
> > +				set_pageblock_skip(freepage);
> > +				break;
> > +			}
> > +
> > +			if (nr_scanned >= limit) {
> > +				cc->fast_search_fail++;
> > +				move_freelist_tail(freelist, freepage);
> > +				break;
> > +			}
> > +		}
> > +		spin_unlock_irqrestore(&cc->zone->lock, flags);
> > +	}
> > +
> > +	cc->total_migrate_scanned += nr_scanned;
> > +
> > +	/*
> > +	 * If fast scanning failed then use a cached entry for a page block
> > +	 * that had free pages as the basis for starting a linear scan.
> > +	 */
> > +	if (pfn == cc->migrate_pfn)
> > +		reinit_migrate_pfn(cc);
> 
> This will set cc->migrate_pfn to the lowest pfn encountered, yet return
> pfn initialized by original cc->migrate_pfn.
> AFAICS isolate_migratepages() will use the returned pfn for the linear
> scan and then overwrite cc->migrate_pfn with wherever it advanced from
> there. So whatever we stored here into cc->migrate_pfn will never get
> actually used, except when isolate_migratepages() returns with
> ISOLATED_ABORT.
> So maybe the infinite kcompactd loop is linked to ISOLATED_ABORT?
> 

I'm not entirely sure it would fix the infinite loop. I suspect that is
going to be a boundary conditions where the two scanners are close but
do not meet if it still exists after the batch of fixes. However, you're
right that this code is problematic. I'll write a fix, test it and post
it if it's ok.

Well spotted!

-- 
Mel Gorman
SUSE Labs
