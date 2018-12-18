Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513CAC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2932521841
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbeLRJzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 04:55:16 -0500
Received: from outbound-smtp12.blacknight.com ([46.22.139.17]:42734 "EHLO
        outbound-smtp12.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726397AbeLRJzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 04:55:14 -0500
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp12.blacknight.com (Postfix) with ESMTPS id 6AB6B1C2222
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 09:55:12 +0000 (GMT)
Received: (qmail 17620 invoked from network); 18 Dec 2018 09:55:12 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.229.96])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 18 Dec 2018 09:55:12 -0000
Date:   Tue, 18 Dec 2018 09:55:10 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Linux-MM <linux-mm@kvack.org>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, ying.huang@intel.com,
        kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/14] mm, migrate: Immediately fail migration of a page
 with no migration handler
Message-ID: <20181218095510.GJ29005@techsingularity.net>
References: <20181214230310.572-1-mgorman@techsingularity.net>
 <20181214230310.572-7-mgorman@techsingularity.net>
 <0ef5c1d0-1853-8fdb-1a68-7482297cb802@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <0ef5c1d0-1853-8fdb-1a68-7482297cb802@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 10:06:31AM +0100, Vlastimil Babka wrote:
> On 12/15/18 12:03 AM, Mel Gorman wrote:
> > Pages with no migration handler use a fallback hander which sometimes
> > works and sometimes persistently fails such as blockdev pages. Migration
> > will retry a number of times on these persistent pages which is wasteful
> > during compaction. This patch will fail migration immediately unless the
> > caller is in MIGRATE_SYNC mode which indicates the caller is willing to
> > wait while being persistent.
> 
> Right.
> 
> > This is not expected to help THP allocation success rates but it does
> > reduce latencies slightly.
> > 
> > 1-socket thpfioscale
> >                                     4.20.0-rc6             4.20.0-rc6
> >                                noreserved-v1r4          failfast-v1r4
> > Amean     fault-both-1         0.00 (   0.00%)        0.00 *   0.00%*
> > Amean     fault-both-3      2276.15 (   0.00%)     3867.54 * -69.92%*
> 
> This is rather weird.
> 

Fault latency is extremely variable and there can be very large outliers
that skew the mean (the full report includes quartiles but it makes for an
excessive changelog). It can be down to luck about how often the migrate
scanner advances and how often it gets reset. For this series, it'll
not be unusual to see jitter in the latencies for individual patches
that will not get nailed down reliably until later in the series. The
alternative is massive patches that do multiple things which will look
nice in changelogs and be horrible to review.

> > Amean     fault-both-5      4992.20 (   0.00%)     5313.20 (  -6.43%)
> > Amean     fault-both-7      7373.30 (   0.00%)     7039.11 (   4.53%)
> > Amean     fault-both-12    11911.52 (   0.00%)    11328.29 (   4.90%)
> > Amean     fault-both-18    17209.42 (   0.00%)    16455.34 (   4.38%)
> > Amean     fault-both-24    20943.71 (   0.00%)    20448.94 (   2.36%)
> > Amean     fault-both-30    22703.00 (   0.00%)    21655.07 (   4.62%)
> > Amean     fault-both-32    22461.41 (   0.00%)    21415.35 (   4.66%)
> > 
> > The 2-socket results are not materially different. Scan rates are
> > similar as expected.
> > 
> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> 

Thanks.

-- 
Mel Gorman
SUSE Labs
