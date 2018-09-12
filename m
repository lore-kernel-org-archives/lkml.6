Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF71C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 12:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9384B20890
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 12:05:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9384B20890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbeILRJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 13:09:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:47320 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726221AbeILRJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 13:09:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4C3D7ACD1;
        Wed, 12 Sep 2018 12:05:05 +0000 (UTC)
Date:   Wed, 12 Sep 2018 14:05:04 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: [PATCH] mm, thp: relax __GFP_THISNODE for MADV_HUGEPAGE mappings
Message-ID: <20180912120504.GE10951@dhcp22.suse.cz>
References: <20180907130550.11885-1-mhocko@kernel.org>
 <alpine.DEB.2.21.1809101253080.177111@chino.kir.corp.google.com>
 <20180911115613.GR10951@dhcp22.suse.cz>
 <alpine.DEB.2.21.1809111319060.189563@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1809111319060.189563@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 11-09-18 13:30:20, David Rientjes wrote:
> On Tue, 11 Sep 2018, Michal Hocko wrote:
[...]
> > hugepage specific MPOL flags sounds like yet another step into even more
> > cluttered API and semantic, I am afraid. Why should this be any
> > different from regular page allocations? You are getting off-node memory
> > once your local node is full. You have to use an explicit binding to
> > disallow that. THP should be similar in that regards. Once you have said
> > that you _really_ want THP then you are closer to what we do for regular
> > pages IMHO.
> > 
> 
> Saying that we really want THP isn't an all-or-nothing decision.  We 
> certainly want to try hard to fault hugepages locally especially at task 
> startup when remapping our .text segment to thp, and MADV_HUGEPAGE works 
> very well for that.  Remote hugepages would be a regression that we now 
> have no way to avoid because the kernel doesn't provide for it, if we were 
> to remove __GFP_THISNODE that this patch introduces.

Why cannot you use mempolicy to bind to local nodes if you really care
about the locality?

> On Broadwell, for example, we find 7% slower access to remote hugepages 
> than local native pages.  On Naples, that becomes worse: 14% slower access 
> latency for intrasocket hugepages compared to local native pages and 39% 
> slower for intersocket.

So, again, how does this compare to regular 4k pages? You are going to
pay for the same remote access as well.

From what you have said so far it sounds like you would like to have
something like the zone/node reclaim mode fine grained for a specific
mapping. If we really want to support something like that then it should
be a generic policy rather than THP specific thing IMHO.

As I've said it is hard to come up with a solution that would satisfy
everybody but considering that the existing reports are seeing this a
regression and cosindering their NUMA requirements are not so strict as
yours I would tend to think that stronger NUMA requirements should be
expressed explicitly rather than implicit effect of a madvise flag. We
do have APIs for that.
-- 
Michal Hocko
SUSE Labs
