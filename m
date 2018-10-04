Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13258C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0FA62084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:10:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0FA62084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbeJEEFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 00:05:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59366 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725758AbeJEEFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 00:05:38 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 39627C07C572;
        Thu,  4 Oct 2018 21:10:31 +0000 (UTC)
Received: from sky.random (ovpn-120-23.rdu2.redhat.com [10.10.120.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C0CB05D6B5;
        Thu,  4 Oct 2018 21:10:30 +0000 (UTC)
Date:   Thu, 4 Oct 2018 17:10:29 -0400
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     David Rientjes <rientjes@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Andrea Argangeli <andrea@kernel.org>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Stable tree <stable@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 1/2] mm: thp:  relax __GFP_THISNODE for MADV_HUGEPAGE
 mappings
Message-ID: <20181004211029.GE7344@redhat.com>
References: <20180925120326.24392-1-mhocko@kernel.org>
 <20180925120326.24392-2-mhocko@kernel.org>
 <alpine.DEB.2.21.1810041302330.16935@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1810041302330.16935@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 04 Oct 2018 21:10:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David,

On Thu, Oct 04, 2018 at 01:16:32PM -0700, David Rientjes wrote:
> There are ways to address this without introducing regressions for 
> existing users of MADV_HUGEPAGE: introduce an madvise() mode to accept 
> remote thp allocations, which users of this library would never set, or 
> fix memory compaction so that it does not incur substantial allocation 
> latency when it will likely fail.

These librarians needs to call a new MADV_ and the current
MADV_HUGEPAGE should not be affected because the new MADV_ will
require some capbility (i.e. root privilege).

qemu was the first user of MADV_HUGEPAGE and I don't think it's fair
to break it and require change to it to run at higher privilege to
retain the direct compaction behavior of MADV_HUGEPAGE.

The new behavior you ask to retain in MADV_HUGEPAGE, generated the
same misbehavior to VM as mlock could have done too, so it can't just
be given by default without any privilege whatsoever.

Ok you could mitigate the breakage that MADV_HUGEPAGE could have
generated (before the recent fix) by isolating malicious or
inefficient programs with memcg, but by default in a multiuser system
without cgroups the global disruption provided before the fix
(i.e. the pathological THP behavior) is not warranted. memcg shouldn't
be mandatory to avoid a process to affect the VM in such a strong way
(i.e. all other processes who happened to be allocated in the node
where the THP allocation triggered, being trashed in swap like if all
memory of all other nodes was not completely free).

Not only that, it's not only about malicious processes it's also
excessively inefficient for processes that just don't fit in a local
node and use MADV_HUGEPAGE. Your processes all fit in the local node
for sure if they're happy about it. This was reported as a
"pathological THP regression" after all in a workload that couldn't
swap at all because of the iommu gup persistent refcount pins.

The alternative patch I posted which still invoked direct reclaim
locally, and falled back to NUMA-local PAGE_SIZEd allocations instead
of falling back to NUMA-remote THP, could have been given without
privilege, but it still won't swapout as this patch would have done,
so it still won't go as far as the MADV_HUGEPAGE behavior had before
the fix (for the lib users that strongly needed local memory).

Overall I think the call about the default behavior of MADV_HUGEPAGE
is still between removing __GFP_THISNODE if gfp_flags can reclaim (the
fix in -mm), or by changing direct compaction to only call compaction
and not reclaim (i.e. __GFP_COMPACT_ONLY) when __GFP_THISNODE is set.

To go beyond that some privilege is needed and a new MADV_ flag can
require privilege or return error if there's not enough privilege. So
the lib with 100's users can try to use that new flag first, show an
error in stderr (maybe under debug), and fallback to MADV_HUGEPAGE if
the app hasn't enough privilege. The alternative is to add a new mem
policy less strict than MPOL_BIND to achieve what you need on top of
MADV_HUGEPAGE (which also would require some privilege of course as
all mbinds). I assume you already evaluated the preferred and local
mbinds and it's not a perfect fit?

If we keep this as a new MADV_HUGEPAGE_FORCE_LOCAL flag, you could
still add a THP sysfs/sysctl control to lift the privilege requirement
marking it as insecure setting in docs
(mm/transparent_hugepage/madv_hugepage_force_local=0|1 forced to 0 by
default). This would be on the same lines of other sysctl that
increase the max number of files open and such things (perhaps a
sysctl would be better in fact for tuning in /etc/sysctl.conf).

Note there was still some improvement left possible in my
__GFP_COMPACT_ONLY patch alternative. Notably if the watermarks for
the local node shown the local node not to have enough real "free"
PAGE_SIZEd pages to succeed the PAGE_SIZEd local THP allocation if
compaction failed, we should have relaxed __GFP_THISNODE and tried to
allocate THP from the NUMA-remote nodes before falling back to
PAGE_SIZEd allocations. That also won't require any new privilege.

To get the same behavior as before though you would need to drop all
caches with echo 3 >drop_caches before the app starts (and it still
won't swap anon memory which previous MADV_HUGEPAGE behavior would
have, but the whole point is that the previous MADV_HUGEPAGE behavior
would have backfired for the lib too if the app was allocating so much
RAM from the local node that it required swapouts of local anon
memory).

Thanks,
Andrea
