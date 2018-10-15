Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F24C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 22:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E99162054F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 22:57:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E99162054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbeJPGpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 02:45:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47510 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726964AbeJPGpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 02:45:05 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 684238553D;
        Mon, 15 Oct 2018 22:57:44 +0000 (UTC)
Received: from sky.random (ovpn-120-12.rdu2.redhat.com [10.10.120.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2923027093;
        Mon, 15 Oct 2018 22:57:44 +0000 (UTC)
Date:   Mon, 15 Oct 2018 18:57:43 -0400
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     David Rientjes <rientjes@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Argangeli <andrea@kernel.org>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Stable tree <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: thp:  relax __GFP_THISNODE for MADV_HUGEPAGE
 mappings
Message-ID: <20181015225743.GB30832@redhat.com>
References: <alpine.DEB.2.21.1810051320270.202739@chino.kir.corp.google.com>
 <20181005232155.GA2298@redhat.com>
 <alpine.DEB.2.21.1810081303060.221006@chino.kir.corp.google.com>
 <20181009094825.GC6931@suse.de>
 <20181009122745.GN8528@dhcp22.suse.cz>
 <20181009130034.GD6931@suse.de>
 <20181009142510.GU8528@dhcp22.suse.cz>
 <20181009230352.GE9307@redhat.com>
 <alpine.DEB.2.21.1810101410530.53455@chino.kir.corp.google.com>
 <alpine.DEB.2.21.1810151525460.247641@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1810151525460.247641@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 15 Oct 2018 22:57:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 03:30:17PM -0700, David Rientjes wrote:
> At the risk of beating a dead horse that has already been beaten, what are 
> the plans for this patch when the merge window opens?  It would be rather 
> unfortunate for us to start incurring a 14% increase in access latency and 
> 40% increase in fault latency.  Would it be possible to test with my 
> patch[*] that does not try reclaim to address the thrashing issue?  If 
> that is satisfactory, I don't have a strong preference if it is done with 
> a hardcoded pageblock_order and __GFP_NORETRY check or a new 
> __GFP_COMPACT_ONLY flag.

I don't like the pageblock size hardcoding inside the page
allocator. __GFP_COMPACT_ONLY is fully runtime equivalent, but it at
least let the caller choose the behavior, so it looks more flexible.

To fix your 40% fault latency concern in the short term we could use
__GFP_COMPACT_ONLY, but I think we should get rid of
__GFP_COMPACT_ONLY later: we need more statistical data in the zone
structure to track remote compaction failures triggering because the
zone is fully fragmented.

Once the zone is fully fragmented we need to do a special exponential
backoff on that zone when the zone is from a remote node.

Furthermore at the first remote NUMA node zone failure caused by full
fragmentation we need to interrupt compaction and stop trying with all
remote nodes.

As long as compaction returns COMPACT_SKIPPED it's ok to keep doing
reclaim and keep doing compaction, as long as compaction succeeds.

What is causing the higher latency is the fact we try all zones from
all remote nodes even if there's a failure caused by full
fragmentation of all remote zone, and we're unable to skip (skip with
exponential backoff) only those zones where compaction cannot succeed
because of fragmentation.

Once we achieve the above deleting __GFP_COMPACT_ONLY will be a
trivial patch.

> I think the second issue of faulting remote thp by removing __GFP_THISNODE 
> needs supporting evidence that shows some platforms benefit from this (and 
> not with numa=fake on the command line :).
> 
>  [*] https://marc.info/?l=linux-kernel&m=153903127717471

That is needed to compare the current one liner fix with
__GFP_COMPACT_ONLY, but I don't think it's needed to compare v4.18
with the current fix. The badness of v4.18 was too bad keep, getting
local PAGE_SIZEd memory or remote THPs is a secondary issue.

In fact the main reason for __GFP_COMPACT_ONLY is not anymore such
tradeoff, but not to spend too much CPU in compaction when all nodes
are fragmented to avoid increasing the allocation latency too much.

Thanks,
Andrea
