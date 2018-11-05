Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9264AC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D2D52082A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:21:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D2D52082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbeKESkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:40:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:54660 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726125AbeKESkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:40:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A5E4BAD70;
        Mon,  5 Nov 2018 09:21:23 +0000 (UTC)
Date:   Mon, 5 Nov 2018 10:21:23 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Dexuan Cui <decui@microsoft.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Rik van Riel <riel@surriel.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Stable@vger.kernel.org" <Stable@vger.kernel.org>
Subject: Re: Will the recent memory leak fixes be backported to longterm
 kernels?
Message-ID: <20181105092053.GC4361@dhcp22.suse.cz>
References: <20181102005816.GA10297@tower.DHCP.thefacebook.com>
 <PU1P153MB0169FE681EF81BCE81B005A1BFCF0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20181102073009.GP23921@dhcp22.suse.cz>
 <20181102154844.GA17619@tower.DHCP.thefacebook.com>
 <20181102161314.GF28039@dhcp22.suse.cz>
 <20181102162237.GB17619@tower.DHCP.thefacebook.com>
 <20181102165147.GG28039@dhcp22.suse.cz>
 <20181102172547.GA19042@tower.DHCP.thefacebook.com>
 <20181102174823.GI28039@dhcp22.suse.cz>
 <20181102193827.GA18024@castle.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102193827.GA18024@castle.DHCP.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 02-11-18 19:38:35, Roman Gushchin wrote:
> On Fri, Nov 02, 2018 at 06:48:23PM +0100, Michal Hocko wrote:
> > On Fri 02-11-18 17:25:58, Roman Gushchin wrote:
> > > On Fri, Nov 02, 2018 at 05:51:47PM +0100, Michal Hocko wrote:
> > > > On Fri 02-11-18 16:22:41, Roman Gushchin wrote:
> > [...]
> > > > > 2) We do forget to scan the last page in the LRU list. So if we ended up with
> > > > > 1-page long LRU, it can stay there basically forever.
> > > > 
> > > > Why 
> > > > 		/*
> > > > 		 * If the cgroup's already been deleted, make sure to
> > > > 		 * scrape out the remaining cache.
> > > > 		 */
> > > > 		if (!scan && !mem_cgroup_online(memcg))
> > > > 			scan = min(size, SWAP_CLUSTER_MAX);
> > > > 
> > > > in get_scan_count doesn't work for that case?
> > > 
> > > No, it doesn't. Let's look at the whole picture:
> > > 
> > > 		size = lruvec_lru_size(lruvec, lru, sc->reclaim_idx);
> > > 		scan = size >> sc->priority;
> > > 		/*
> > > 		 * If the cgroup's already been deleted, make sure to
> > > 		 * scrape out the remaining cache.
> > > 		 */
> > > 		if (!scan && !mem_cgroup_online(memcg))
> > > 			scan = min(size, SWAP_CLUSTER_MAX);
> > > 
> > > If size == 1, scan == 0 => scan = min(1, 32) == 1.
> > > And after proportional adjustment we'll have 0.
> > 
> > My friday brain hurst when looking at this but if it doesn't work as
> > advertized then it should be fixed. I do not see any of your patches to
> > touch this logic so how come it would work after them applied?
> 
> This part works as expected. But the following
> 	scan = div64_u64(scan * fraction[file], denominator);
> reliable turns 1 page to scan to 0 pages to scan.

OK, 68600f623d69 ("mm: don't miss the last page because of round-off
error") sounds like a good and safe stable backport material.

-- 
Michal Hocko
SUSE Labs
