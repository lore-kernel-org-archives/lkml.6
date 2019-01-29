Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40209C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03ED221873
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbfA2XlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 18:41:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50230 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbfA2XlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 18:41:02 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 466A29B309;
        Tue, 29 Jan 2019 23:41:01 +0000 (UTC)
Received: from sky.random (ovpn-121-14.rdu2.redhat.com [10.10.121.14])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DB1D6112C1A0;
        Tue, 29 Jan 2019 23:40:58 +0000 (UTC)
Date:   Tue, 29 Jan 2019 18:40:58 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>,
        Blake Caldwell <blake.caldwell@colorado.edu>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>
Subject: [LSF/MM TOPIC] NUMA remote THP vs NUMA local non-THP under
 MADV_HUGEPAGE
Message-ID: <20190129234058.GH31695@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 29 Jan 2019 23:41:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'd like to attend the LSF/MM Summit 2019. I'm interested in most MM
topics and it's enlightening to listen to the common non-MM topics
too.

One current topic that could be of interest is the THP / NUMA tradeoff
in subject.

One issue about a change in MADV_HUGEPAGE behavior made ~3 years ago
kept floating around for the last 6 months (~12 months since it was
initially reported as regression through an enterprise-like workload)
and it was hot-fixed in commit
ac5b2c18911ffe95c08d69273917f90212cf5659, but it got quickly reverted
for various reasons.

I posted some benchmark results showing that for tasks without strong
NUMA locality the __GFP_THISNODE logic is not guaranteed to be optimal
(and here of course I mean even if we ignore the large slowdown with
swap storms at allocation time that might be caused by
__GFP_THISNODE). The results also show NUMA remote THPs help
intrasocket as well as intersocket.

https://lkml.kernel.org/r/20181210044916.GC24097@redhat.com
https://lkml.kernel.org/r/20181212104418.GE1130@redhat.com

The following seems the interim conclusion which I happen to be in
agreement with Michal and Mel:

https://lkml.kernel.org/r/20181212095051.GO1286@dhcp22.suse.cz
https://lkml.kernel.org/r/20181212170016.GG1130@redhat.com

Hopefully this strict issue will be hot-fixed before April (like we
had to hot-fix it in the enterprise kernels to avoid the 3 years old
regression to break large workloads that can't fit it in a single NUMA
node and I assume other enterprise distributions will follow suit),
but whatever hot-fix will likely allow ample margin for discussions on
what we can do better to optimize the decision between local non-THP
and remote THP under MADV_HUGEPAGE.

It is clear that the __GFP_THISNODE forced in the current code
provides some minor advantage to apps using MADV_HUGEPAGE that can fit
in a single NUMA node, but we should try to achieve it without major
disadvantages to apps that can't fit in a single NUMA node.

For example it was mentioned that we could allocate readily available
already-free local 4k if local compaction fails and the watermarks
still allows local 4k allocations without invoking reclaim, before
invoking compaction on remote nodes. The same can be repeated at a
second level with intra-socket non-THP memory before invoking
compaction inter-socket. However we can't do things like that with the
current page allocator workflow. It's possible some larger change is
required than just sending a single gfp bitflag down to the page
allocator that creates an implicit MPOL_LOCAL binding to make it
behave like the obsoleted numa/zone reclaim behavior, but weirdly only
applied to THP allocations.

--

In addition to the above "NUMA remote THP vs NUMA local non-THP
tradeoff" topic, there are other developments in "userfaultfd" land that
are approaching merge readiness and that would be possible to provide a
short overview about:

- Peter Xu made significant progress in finalizing the userfaultfd-WP
  support over the last few months. That feature was planned from the
  start and it will allow userland to do some new things that weren't
  possible to achieve before. In addition to synchronously blocking
  write faults to be resolved by an userland manager, it has also the
  ability to obsolete the softdirty feature, because it can provide
  the same information, but with O(1) complexity (as opposed of the
  current softdirty O(N) complexity) similarly to what the Page
  Modification Logging (PML) does in hardware for EPT write accesses.

- Blake Caldwell maintained the UFFDIO_REMAP support to atomically
  remove memory from a mapping with userfaultfd (which can't be done
  with a copy as in UFFDIO_COPY and it requires a slow TLB flush to be
  safe) as an alternative to host swapping (which of course also
  requires a TLB flush for similar reasons). Notably UFFDIO_REMAP was
  rightfully naked early on and quickly replaced by UFFDIO_COPY which
  is more optimal to add memory to a mapping is small chunks, but we
  can't remove memory with UFFDIO_COPY and UFFDIO_REMAP should be as
  efficient as it gets when it comes to removing memory from a
  mapping.

Thank you,
Andrea
