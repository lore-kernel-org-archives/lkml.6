Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A690C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 505C82133F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:21:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 505C82133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbeLEWVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 17:21:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45842 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727339AbeLEWVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 17:21:51 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2C7D43001E59;
        Wed,  5 Dec 2018 22:21:51 +0000 (UTC)
Received: from sky.random (ovpn-122-73.rdu2.redhat.com [10.10.122.73])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9316E5C57C;
        Wed,  5 Dec 2018 22:21:48 +0000 (UTC)
Date:   Wed, 5 Dec 2018 17:21:47 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     David Rientjes <rientjes@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ying.huang@intel.com, s.priebe@profihost.ag,
        mgorman@techsingularity.net,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [patch 1/2 for-4.20] mm, thp: restore node-local hugepage
 allocations
Message-ID: <20181205222147.GD11899@redhat.com>
References: <alpine.DEB.2.21.1812031545080.161134@chino.kir.corp.google.com>
 <alpine.DEB.2.21.1812031545560.161134@chino.kir.corp.google.com>
 <20181204073535.GV31738@dhcp22.suse.cz>
 <alpine.DEB.2.21.1812041355100.157466@chino.kir.corp.google.com>
 <20181205073434.GT1286@dhcp22.suse.cz>
 <alpine.DEB.2.21.1812051120550.240991@chino.kir.corp.google.com>
 <20181205201528.GW1286@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205201528.GW1286@dhcp22.suse.cz>
User-Agent: Mutt/1.11.0 (2018-11-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 05 Dec 2018 22:21:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 09:15:28PM +0100, Michal Hocko wrote:
> If the __GFP_THISNODE should be really used then it should be applied to
> all other types of pages. Not only THP. And as such done in a separate
> patch. Not a part of the revert. The cleanup was meant to unify THP
> allocations and that is why I object to reverting it as a part of this
> work.

I also wonder if using __GFP_THISNODE for all pages and not only THP
may really help David's workload performance further if it's so NUMA
sensitive and short lived too (plus we know it most of the time fits
in a single node). It'll get rid of the cache in the local node before
allocating remote memory. Of course than the swap storms and
pathological performance for processes that don't fit in a node, will
also materialize without THP enabled. If this is true, that'd point
further to the need of a MPOL that can set __GFP_THISNODE not just for
THP but for all allocations, with the only difference that if it's the
regular page size failing, instead of hitting OOM it should do one
last fallback to a regular page size allocation without __GFP_THISNODE
set.

Regardless of the above I think it's still interesting to look into
adding more NUMA affinity to THP somehow, but I doubt we want to do
that at the price of crippling compaction in a way it can't generate
THP anymore once a node is full of cache, and certainly we don't want
to cripple compaction in non-NUMA hosts too like it'd be happening
with the current proposed patch. Furthermore whatever we do should
work for order 8 7 6 etc.. too. If we did a order 9 specialized trick
that cripples compaction effectiveness, it'd be a short term approach
and it'd be tailored to David's use case that seems to be sensitive to
allocation latency. Being sensitive to allocation latency doesn't make
that process a good fit for MADV_HUGEPAGE to begin with.
