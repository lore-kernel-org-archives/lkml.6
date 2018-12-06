Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A32C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 00:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8E8D208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 00:54:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8E8D208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbeLFAya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 19:54:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50012 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727358AbeLFAya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 19:54:30 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 03D283082130;
        Thu,  6 Dec 2018 00:54:29 +0000 (UTC)
Received: from sky.random (ovpn-122-73.rdu2.redhat.com [10.10.122.73])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F228604DA;
        Thu,  6 Dec 2018 00:54:26 +0000 (UTC)
Date:   Wed, 5 Dec 2018 19:54:25 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     David Rientjes <rientjes@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        mgorman@techsingularity.net, Vlastimil Babka <vbabka@suse.cz>,
        mhocko@kernel.org, ying.huang@intel.com, s.priebe@profihost.ag,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu
Subject: Re: [LKP] [mm] ac5b2c1891: vm-scalability.throughput -61.3%
 regression
Message-ID: <20181206005425.GB21159@redhat.com>
References: <CAHk-=wiNKLH2Pbnr9z2SvmDhf7XT==U6NPRkQNX13Sg-FRk0Yw@mail.gmail.com>
 <20181203201214.GB3540@redhat.com>
 <CAHk-=wg=6uxAJMbvGJC-5CSikC8OdqsjE1vw+DsCMj=2SNSnZg@mail.gmail.com>
 <CAHk-=whDg5+e2-eXYo-jwC1spt2r7JjLQSaLm4OyfGMQHLTrdw@mail.gmail.com>
 <64a4aec6-3275-a716-8345-f021f6186d9b@suse.cz>
 <20181204104558.GV23260@techsingularity.net>
 <20181205204034.GB11899@redhat.com>
 <CAHk-=whi8Ju-cTDL4cYtwuLA7BYgGJYyy6HVMoknZaLHnRc83g@mail.gmail.com>
 <20181205233632.GE11899@redhat.com>
 <alpine.DEB.2.21.1812051614410.50028@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1812051614410.50028@chino.kir.corp.google.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 06 Dec 2018 00:54:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 04:18:14PM -0800, David Rientjes wrote:
> On Wed, 5 Dec 2018, Andrea Arcangeli wrote:
> 
> > __GFP_COMPACT_ONLY gave an hope it could give some middle ground but
> > it shows awful compaction results, it basically destroys compaction
> > effectiveness and we know why (COMPACT_SKIPPED must call reclaim or
> > compaction can't succeed because there's not enough free memory in the
> > node). If somebody used MADV_HUGEPAGE compaction should still work and
> > not fail like that. Compaction would fail to be effective even in the
> > local node where __GFP_THISNODE didn't fail. Worst of all it'd fail
> > even on non-NUMA systems (that would be easy to fix though by making
> > the HPAGE_PMD_ORDER check conditional to NUMA being enabled at
> > runtime).
> > 
> 
> Note that in addition to COMPACT_SKIPPED that you mention, compaction can 
> fail with COMPACT_COMPLETE, meaning the full scan has finished without 
> freeing a hugepage, or COMPACT_DEFERRED, meaning that doing another scan 
> is unlikely to produce a different result.  COMPACT_SKIPPED makes sense to 
> do reclaim if it can become accessible to isolate_freepages() and 
> hopefully another allocator does not allocate from these newly freed pages 
> before compaction can scan the zone again.  For COMPACT_COMPLETE and 
> COMPACT_DEFERRED, reclaim is unlikely to ever help.

The COMPACT_COMPLETE and (COMPACT_PARTIAL_SKIPPED for that matter)
seems just a mistake in the max() evaluation try_to_compact_pages()
that let it return COMPACT_COMPLETE and COMPACT_PARTIAL_SKIPPED. I
think it should just return COMPACT_DEFERRED in those two cases and it
should be enforced forced for all prio.

There are really only 3 cases that matter for the caller:

1) succeed -> we got the page
2) defer -> we failed (caller won't care about why)
3) skipped -> failed because not enough 4k freed -> reclaim must be invoked then
   compaction can be retried

PARTIAL_SKIPPED/COMPLETE both fall into 2) above so for the caller
they should be treated the same way. It doesn't seem very concerning
that it may try like if it succeeded and do a spurious single reclaim
invocation, but it's good to fix this and take the COMPACT_DEFERRED
nopage path in the __GFP_NORETRY case.
