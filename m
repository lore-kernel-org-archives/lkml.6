Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275F5C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 009F920855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbfAQRhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 12:37:45 -0500
Received: from outbound-smtp04.blacknight.com ([81.17.249.35]:36100 "EHLO
        outbound-smtp04.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727226AbfAQRho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 12:37:44 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp04.blacknight.com (Postfix) with ESMTPS id D20DC98B35
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 17:37:42 +0000 (UTC)
Received: (qmail 15152 invoked from network); 17 Jan 2019 17:37:42 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.229.96])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 17 Jan 2019 17:37:42 -0000
Date:   Thu, 17 Jan 2019 17:37:41 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Linux-MM <linux-mm@kvack.org>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>, ying.huang@intel.com,
        kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 17/25] mm, compaction: Keep cached migration PFNs synced
 for unusable pageblocks
Message-ID: <20190117173741.GM27437@techsingularity.net>
References: <20190104125011.16071-1-mgorman@techsingularity.net>
 <20190104125011.16071-18-mgorman@techsingularity.net>
 <2e384ff6-a4fd-5047-428d-b90cfa95be2e@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <2e384ff6-a4fd-5047-428d-b90cfa95be2e@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 06:17:28PM +0100, Vlastimil Babka wrote:
> On 1/4/19 1:50 PM, Mel Gorman wrote:
> > Migrate has separate cached PFNs for ASYNC and SYNC* migration on the
> > basis that some migrations will fail in ASYNC mode. However, if the cached
> > PFNs match at the start of scanning and pageblocks are skipped due to
> > having no isolation candidates, then the sync state does not matter.
> > This patch keeps matching cached PFNs in sync until a pageblock with
> > isolation candidates is found.
> > 
> > The actual benefit is marginal given that the sync scanner following the
> > async scanner will often skip a number of pageblocks but it's useless
> > work. Any benefit depends heavily on whether the scanners restarted
> > recently so overall the reduction in scan rates is a mere 2.8% which
> > is borderline noise.
> > 
> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> 
> My easlier suggestion to check more thoroughly if pages can be migrated (which
> depends on the mode) before isolating them wouldn't play nice with this :)
> 

No, unfortunately it wouldn't. I did find though that sync_light often
ran very quickly after async when compaction was having trouble
succeeding. The time window was short enough that states like
Dirty/Writeback were highly unlikely to be cleared. It might have played
nice when fragmentation was very low but any benefit then would be very
difficult to detect.

-- 
Mel Gorman
SUSE Labs
