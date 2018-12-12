Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E78C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A4C120870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:09:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A4C120870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbeLLRJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 12:09:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46930 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbeLLRJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 12:09:03 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7BF0930832D2;
        Wed, 12 Dec 2018 17:09:02 +0000 (UTC)
Received: from sky.random (ovpn-122-218.rdu2.redhat.com [10.10.122.218])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B41965ED3C;
        Wed, 12 Dec 2018 17:08:58 +0000 (UTC)
Date:   Wed, 12 Dec 2018 12:00:16 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     David Rientjes <rientjes@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        mgorman@techsingularity.net, Vlastimil Babka <vbabka@suse.cz>,
        ying.huang@intel.com, s.priebe@profihost.ag,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu
Subject: Re: [LKP] [mm] ac5b2c1891: vm-scalability.throughput -61.3%
 regression
Message-ID: <20181212170016.GG1130@redhat.com>
References: <CAHk-=whi8Ju-cTDL4cYtwuLA7BYgGJYyy6HVMoknZaLHnRc83g@mail.gmail.com>
 <20181205233632.GE11899@redhat.com>
 <CAHk-=wguXjkbK8BUU998s7HD7AXJgBkuc9JmuNxiN7uGQyfSfQ@mail.gmail.com>
 <CAHk-=wjm9V843eg0uesMrxKnCCq7UfWn8VJ+z-cNztb_0fVW6A@mail.gmail.com>
 <alpine.DEB.2.21.1812061505010.162675@chino.kir.corp.google.com>
 <CAHk-=wjVuLjZ1Wr52W=hNqh=_8gbzuKA+YpsVb4NBHCJsE6cyA@mail.gmail.com>
 <alpine.DEB.2.21.1812091538310.215735@chino.kir.corp.google.com>
 <20181210044916.GC24097@redhat.com>
 <alpine.DEB.2.21.1812111609060.255489@chino.kir.corp.google.com>
 <20181212095051.GO1286@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212095051.GO1286@dhcp22.suse.cz>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 12 Dec 2018 17:09:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 10:50:51AM +0100, Michal Hocko wrote:
> I can be convinced that larger pages really require a different behavior
> than base pages but you should better show _real_ numbers on a wider
> variety workloads to back your claims. I have only heard hand waving and

I agree with your point about node_reclaim and I think David complaint
of "I got remote THP instead of local 4k" with our proposed fix, is
going to morph into "I got remote 4k instead of local 4k" with his
favorite fix.

Because David stopped calling reclaim with __GFP_THISNODE, the moment
the node is full of pagecache, node_reclaim behavior will go away and
even 4k pages will start to be allocated remote (and because of
__GFP_THISNODE set in the THP allocation, all readily available or
trivial to compact remote THP will be ignored too).

What David needs I think is a way to set __GFP_THISNODE for THP *and
4k* allocations and if both fails in a row with __GFP_THISNODE set, we
need to repeat the whole thing without __GFP_THISNODE set (ideally
with a mask to skip the node that we already scraped down to the
bottom during the initial __GFP_THISNODE pass). This way his
proprietary software binary will work even better than before when the
local node is fragmented and he'll finally be able to get the speedup
from remote THP too in case the local node is truly OOM, but all other
nodes are full of readily available THP.

To achieve this without a new MADV_THISNODE/MADV_NODE_RECLAIM, we'd
need a way to start with __GFP_THISNODE and then draw the line in
reclaim and decide to drop __GFP_THISNODE when too much pressure
mounts in the local node, but like you said it becomes like
node_reclaim and it would be better if it can be done with an opt-in,
like MADV_HUGEPAGE because not all workloads would benefit from such
extra pagecache reclaim cost (like not all workload benefits from
synchronous compaction).

I think some NUMA reclaim mode semantics ended up being embedded and
hidden in the THP MADV_HUGEPAGE, but they imposed massive slowdown to
all workloads that can't cope with the node_reclaim mode behavior
because they don't fit in a node.

Adding MADV_THISNODE/MADV_NODE_RECLAIM, will guarantee his proprietary
software binary will run at maximum performance without cache
interference, and he's happy to accept the risk of massive slowdown in
case the local node is truly OOM. The fallback, despite very
inefficient, will still happen without OOM killer triggering.

Thanks,
Andrea
