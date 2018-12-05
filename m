Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A678C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3BEE20879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:45:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3BEE20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbeLEVpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 16:45:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37008 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727309AbeLEVpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 16:45:50 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AEEE5307D85E;
        Wed,  5 Dec 2018 21:45:49 +0000 (UTC)
Received: from sky.random (ovpn-122-73.rdu2.redhat.com [10.10.122.73])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A8E71194AF;
        Wed,  5 Dec 2018 21:45:43 +0000 (UTC)
Date:   Wed, 5 Dec 2018 16:45:42 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     David Rientjes <rientjes@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ying.huang@intel.com, s.priebe@profihost.ag,
        mgorman@techsingularity.net,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu
Subject: Re: [patch 0/2 for-4.20] mm, thp: fix remote access and allocation
 regressions
Message-ID: <20181205214542.GC11899@redhat.com>
References: <alpine.DEB.2.21.1812031545080.161134@chino.kir.corp.google.com>
 <bb198d88-27be-0d5c-d871-1ffd26a08e29@suse.cz>
 <alpine.DEB.2.21.1812041356490.157466@chino.kir.corp.google.com>
 <20181205090554.GX1286@dhcp22.suse.cz>
 <alpine.DEB.2.21.1812051142040.240991@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1812051142040.240991@chino.kir.corp.google.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 05 Dec 2018 21:45:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 11:49:26AM -0800, David Rientjes wrote:
> High thp utilization is not always better, especially when those hugepages 
> are accessed remotely and introduce the regressions that I've reported.  
> Seeking high thp utilization at all costs is not the goal if it causes 
> workloads to regress.

Is it possible what you need is a defrag=compactonly_thisnode to set
instead of the default defrag=madvise? The fact you seem concerned
about page fault latencies doesn't make your workload an obvious
candidate for MADV_HUGEPAGE to begin with. At least unless you decide
to smooth the MADV_HUGEPAGE behavior with an mbind that will simply
add __GFP_THISNODE to the allocations, perhaps you'll be even faster
if you invoke reclaim in the local node for 4k allocations too.

It looks like for your workload THP is a nice to have add-on, which is
practically true of all workloads (with a few corner cases that must
use MADV_NOHUGEPAGE), and it's what the defrag= default is about.

Is it possible that you just don't want to shut off completely
compaction in the page fault and if you're ok to do it for your
library, you may be ok with that for all other apps too?

That's a different stance from other MADV_HUGEPAGE users because you
don't seem to mind a severely crippled THP utilization in your
app.

With your patch the utilization will go down a lot compared to the
previous __GFP_THISNODE swap storm capable and you're still very fine
with that. The fact you're fine with that points in the direction of
changing the default tuning for defrag= to something stronger than
madvise (that is precisely the default setting that is forcing you to
use MADV_HUGEPAGE to get a chance to get some THP once a in a while
during the page fault, after some uptime).

Considering mbind surprisingly isn't privileged (so I suppose it may
cause swap storms equivalent to __GFP_THISNODE if maliciously used
after all) you could even consider a defrag=thisnode to force
compaction+defrag local to the node to retain your THP+NUMA dynamic
partitioning behavior that ends up swappin heavy in the local node.
