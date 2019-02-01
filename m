Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41CEC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78D05218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbfBAORi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 09:17:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:48038 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726330AbfBAORi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 09:17:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 00672ADF1;
        Fri,  1 Feb 2019 14:17:36 +0000 (UTC)
Date:   Fri, 1 Feb 2019 14:17:33 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Peter Xu <peterx@redhat.com>,
        Blake Caldwell <blake.caldwell@colorado.edu>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>
Subject: Re: [LSF/MM TOPIC] NUMA remote THP vs NUMA local non-THP under
 MADV_HUGEPAGE
Message-ID: <20190201141733.GC4926@suse.de>
References: <20190129234058.GH31695@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20190129234058.GH31695@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 06:40:58PM -0500, Andrea Arcangeli wrote:
> I posted some benchmark results showing that for tasks without strong
> NUMA locality the __GFP_THISNODE logic is not guaranteed to be optimal
> (and here of course I mean even if we ignore the large slowdown with
> swap storms at allocation time that might be caused by
> __GFP_THISNODE). The results also show NUMA remote THPs help
> intrasocket as well as intersocket.
> 
> https://lkml.kernel.org/r/20181210044916.GC24097@redhat.com
> https://lkml.kernel.org/r/20181212104418.GE1130@redhat.com
> 
> The following seems the interim conclusion which I happen to be in
> agreement with Michal and Mel:
> 
> https://lkml.kernel.org/r/20181212095051.GO1286@dhcp22.suse.cz
> https://lkml.kernel.org/r/20181212170016.GG1130@redhat.com
> 
> Hopefully this strict issue will be hot-fixed before April (like we
> had to hot-fix it in the enterprise kernels to avoid the 3 years old
> regression to break large workloads that can't fit it in a single NUMA
> node and I assume other enterprise distributions will follow suit),
> but whatever hot-fix will likely allow ample margin for discussions on
> what we can do better to optimize the decision between local non-THP
> and remote THP under MADV_HUGEPAGE.
> 
> It is clear that the __GFP_THISNODE forced in the current code
> provides some minor advantage to apps using MADV_HUGEPAGE that can fit
> in a single NUMA node, but we should try to achieve it without major
> disadvantages to apps that can't fit in a single NUMA node.
> 
> For example it was mentioned that we could allocate readily available
> already-free local 4k if local compaction fails and the watermarks
> still allows local 4k allocations without invoking reclaim, before
> invoking compaction on remote nodes. The same can be repeated at a
> second level with intra-socket non-THP memory before invoking
> compaction inter-socket. However we can't do things like that with the
> current page allocator workflow. It's possible some larger change is
> required than just sending a single gfp bitflag down to the page
> allocator that creates an implicit MPOL_LOCAL binding to make it
> behave like the obsoleted numa/zone reclaim behavior, but weirdly only
> applied to THP allocations.
> 

I would also be interested in discussing this topic. My activity is
mostly compaction-related but I believe it will evolve into something
that returns more sane data to the page allocator. That should make it a
bit easier to detect when local compaction fails and make it easier to
improve the page allocator workflow without throwing another workload
under a bus.

-- 
Mel Gorman
SUSE Labs
