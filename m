Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3DBC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 07:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9A9020834
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 07:38:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9A9020834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbeLDHiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 02:38:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:43292 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726011AbeLDHiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 02:38:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3FC42ADDD;
        Tue,  4 Dec 2018 07:38:51 +0000 (UTC)
Date:   Tue, 4 Dec 2018 08:38:50 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>, ying.huang@intel.com,
        s.priebe@profihost.ag, mgorman@techsingularity.net,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [patch 0/2 for-4.20] mm, thp: fix remote access and allocation
 regressions
Message-ID: <20181204073850.GW31738@dhcp22.suse.cz>
References: <alpine.DEB.2.21.1812031545080.161134@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1812031545080.161134@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 03-12-18 15:50:18, David Rientjes wrote:
> This fixes a 13.9% of remote memory access regression and 40% remote
> memory allocation regression on Haswell when the local node is fragmented
> for hugepage sized pages and memory is being faulted with either the thp
> defrag setting of "always" or has been madvised with MADV_HUGEPAGE.
> 
> The usecase that initially identified this issue were binaries that mremap
> their .text segment to be backed by transparent hugepages on startup.
> They do mmap(), madvise(MADV_HUGEPAGE), memcpy(), and mremap().

Do you have something you can share with so that other people can play
and try to reproduce?

> This requires a full revert and partial revert of commits merged during
> the 4.20 rc cycle.  The full revert, of ac5b2c18911f ("mm: thp: relax
> __GFP_THISNODE for MADV_HUGEPAGE mappings"), was anticipated to fix large
> amounts of swap activity on the local zone when faulting hugepages by
> falling back to remote memory.  This remote allocation causes the access
> regression and, if fragmented, the allocation regression.

Have you tried to measure any of the workloads Mel and Andrea have
pointed out during the previous review discussion? In other words what
is the impact on the THP success rate and allocation latencies for other
usecases?
-- 
Michal Hocko
SUSE Labs
