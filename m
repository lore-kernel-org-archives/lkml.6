Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98EBC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B04E20850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B04E20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbeLEJF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:05:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:44632 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726102AbeLEJF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:05:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0F1D9B17F;
        Wed,  5 Dec 2018 09:05:55 +0000 (UTC)
Date:   Wed, 5 Dec 2018 10:05:54 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>, ying.huang@intel.com,
        s.priebe@profihost.ag, mgorman@techsingularity.net,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu
Subject: Re: [patch 0/2 for-4.20] mm, thp: fix remote access and allocation
 regressions
Message-ID: <20181205090554.GX1286@dhcp22.suse.cz>
References: <alpine.DEB.2.21.1812031545080.161134@chino.kir.corp.google.com>
 <bb198d88-27be-0d5c-d871-1ffd26a08e29@suse.cz>
 <alpine.DEB.2.21.1812041356490.157466@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1812041356490.157466@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 04-12-18 14:04:10, David Rientjes wrote:
> On Tue, 4 Dec 2018, Vlastimil Babka wrote:
> 
> > So, AFAIK, the situation is:
> > 
> > - commit 5265047ac301 in 4.1 introduced __GFP_THISNODE for THP. The
> > intention came a bit earlier in 4.0 commit 077fcf116c8c. (I admit acking
> > both as it seemed to make sense).
> 
> Yes, both are based on the preference to fault local thp and fallback to 
> local pages before allocating remotely because it does not cause the 
> performance regression introduced by not setting __GFP_THISNODE.
> 
> > - The resulting node-reclaim-like behavior regressed Andrea's KVM
> > workloads, but reverting it (only for madvised or non-default
> > defrag=always THP by commit ac5b2c18911f) would regress David's
> > workloads starting with 4.20 to pre-4.1 levels.
> > 
> 
> Almost, but the defrag=always case had the subtle difference of also 
> setting __GFP_NORETRY whereas MADV_HUGEPAGE did not.  This was different 
> than the comment in __alloc_pages_slowpath() that expected thp fault 
> allocations to be caught by checking __GFP_NORETRY.
> 
> > If the decision is that it's too late to revert a 4.1 regression for one
> > kind of workload in 4.20 because it causes regression for another
> > workload, then I guess we just revert ac5b2c18911f (patch 1) for 4.20
> > and don't rush a different fix (patch 2) to 4.20. It's not a big
> > difference if a 4.1 regression is fixed in 4.20 or 4.21?
> > 
> 
> The revert is certainly needed to prevent the regression, yes, but I 
> anticipate that Andrea will report back that patch 2 at least improves the 
> situation for the problem that he was addressing, specifically that it is 
> pointless to thrash any node or reclaim unnecessarily when compaction has 
> already failed.  This is what setting __GFP_NORETRY for all thp fault 
> allocations fixes.

Yes but earlier numbers from Mel and repeated again [1] simply show
that the swap storms are only handled in favor of an absolute drop of
THP success rate.
 
> > Because there might be other unexpected consequences of patch 2 that
> > testing won't be able to catch in the remaining 4.20 rc's. And I'm not
> > even sure if it will fix Andrea's workloads. While it should prevent
> > node-reclaim-like thrashing, it will still mean that KVM (or anyone)
> > won't be able to allocate THP's remotely, even if the local node is
> > exhausted of both huge and base pages.
> > 
> 
> Patch 2 does nothing with respect to the remote allocation policy; it 
> simply prevents reclaim (and potentially thrashing).  Patch 1 sets 
> __GFP_THISNODE to prevent the remote allocation.

Yes, this is understood. So we are getting worst of both. We have a
numa locality side effect of MADV_HUGEPAGE and we have a poor THP
utilization. So how come this is an improvement. Especially when the
reported regression hasn't been demonstrated on a real or repeatable
workload but rather a very vague presumably worst case behavior where
the access penalty is absolutely prevailing.

[1] http://lkml.kernel.org/r/20181204104558.GV23260@techsingularity.net
-- 
Michal Hocko
SUSE Labs
