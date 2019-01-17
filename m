Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429DFC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AFCF20855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbfAQRfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 12:35:17 -0500
Received: from outbound-smtp04.blacknight.com ([81.17.249.35]:56615 "EHLO
        outbound-smtp04.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727226AbfAQRfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 12:35:17 -0500
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp04.blacknight.com (Postfix) with ESMTPS id B7ADBF400B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 17:35:14 +0000 (UTC)
Received: (qmail 15587 invoked from network); 17 Jan 2019 17:35:14 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.229.96])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 17 Jan 2019 17:35:14 -0000
Date:   Thu, 17 Jan 2019 17:35:13 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Linux-MM <linux-mm@kvack.org>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>, ying.huang@intel.com,
        kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 16/25] mm, compaction: Check early for huge pages
 encountered by the migration scanner
Message-ID: <20190117173512.GL27437@techsingularity.net>
References: <20190104125011.16071-1-mgorman@techsingularity.net>
 <20190104125011.16071-17-mgorman@techsingularity.net>
 <724b7599-8300-15b5-2675-eecab2450f45@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <724b7599-8300-15b5-2675-eecab2450f45@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 06:01:18PM +0100, Vlastimil Babka wrote:
> On 1/4/19 1:50 PM, Mel Gorman wrote:
> > When scanning for sources or targets, PageCompound is checked for huge
> > pages as they can be skipped quickly but it happens relatively late after
> > a lot of setup and checking. This patch short-cuts the check to make it
> > earlier. It might still change when the lock is acquired but this has
> > less overhead overall. The free scanner advances but the migration scanner
> > does not. Typically the free scanner encounters more movable blocks that
> > change state over the lifetime of the system and also tends to scan more
> > aggressively as it's actively filling its portion of the physical address
> > space with data. This could change in the future but for the moment,
> > this worked better in practice and incurred fewer scan restarts.
> > 
> > The impact on latency and allocation success rates is marginal but the
> > free scan rates are reduced by 32% and system CPU usage is reduced by
> > 2.6%. The 2-socket results are not materially different.
> 
> Hmm, interesting that adjusting migrate scanner affected free scanner. Oh well.
> 

Russian Roulette again. The exact scan rates depend on the system state
which are non-deterministic.  It's not until very late in the series that
they stabilise somewhat. In fact, during the development of the series,
I had to reorder patches multiple times when a corner case was dealt with
to avoid 1 in every 3-6 runs having crazy insane scan rates. The final
ordering was based on *relative* stability.

> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Nit below.
> 

Nit fixed.

-- 
Mel Gorman
SUSE Labs
