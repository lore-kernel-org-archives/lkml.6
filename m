Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B6CC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 23:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1150C2089D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 23:19:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1150C2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbeJPHHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 03:07:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55674 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726917AbeJPHHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 03:07:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3E47A308A94E;
        Mon, 15 Oct 2018 23:19:54 +0000 (UTC)
Received: from sky.random (ovpn-120-12.rdu2.redhat.com [10.10.120.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F368967C64;
        Mon, 15 Oct 2018 23:19:53 +0000 (UTC)
Date:   Mon, 15 Oct 2018 19:19:53 -0400
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Argangeli <andrea@kernel.org>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Stable tree <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: thp:  relax __GFP_THISNODE for MADV_HUGEPAGE
 mappings
Message-ID: <20181015231953.GC30832@redhat.com>
References: <20181005232155.GA2298@redhat.com>
 <alpine.DEB.2.21.1810081303060.221006@chino.kir.corp.google.com>
 <20181009094825.GC6931@suse.de>
 <20181009122745.GN8528@dhcp22.suse.cz>
 <20181009130034.GD6931@suse.de>
 <20181009142510.GU8528@dhcp22.suse.cz>
 <20181009230352.GE9307@redhat.com>
 <alpine.DEB.2.21.1810101410530.53455@chino.kir.corp.google.com>
 <alpine.DEB.2.21.1810151525460.247641@chino.kir.corp.google.com>
 <20181015154459.e870c30df5c41966ffb4aed8@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015154459.e870c30df5c41966ffb4aed8@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Mon, 15 Oct 2018 23:19:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

On Mon, Oct 15, 2018 at 03:44:59PM -0700, Andrew Morton wrote:
> On Mon, 15 Oct 2018 15:30:17 -0700 (PDT) David Rientjes <rientjes@google.com> wrote:
> >  Would it be possible to test with my 
> > patch[*] that does not try reclaim to address the thrashing issue?
> 
> Yes please.

It'd also be great if a testcase reproducing the 40% higher access
latency (with the one liner original fix) was available.

We don't have a testcase for David's 40% latency increase problem, but
that's likely to only happen when the system is somewhat low on memory
globally. So the measurement must be done when compaction starts
failing globally on all zones, but before the system starts
swapping. The more global fragmentation the larger will be the window
between "compaction fails because all zones are too fragmented" and
"there is still free PAGE_SIZEd memory available to reclaim without
swapping it out". If I understood correctly, that is precisely the
window where the 40% higher latency should materialize.

The workload that shows the badness in the upstream code is fairly
trivial. Mel and Zi reproduced it too and I have two testcases that
can reproduce it, one with device assignment and the other is just
memhog. That's a massively larger window than the one where the 40%
higher latency materializes.

When there's 75% or more of the RAM free (not even allocated as easily
reclaimable pagecache) globally, you don't expect to hit heavy
swapping.

The 40% THP allocation latency increase if you use MADV_HUGEPAGE in
such window where all remote zones are fully fragmented is somehow
lesser of a concern in my view (plus there's the compact deferred
logic that should mitigate that scenario). Furthermore it is only a
concern for page faults in MADV_HUGEPAGE ranges. If MADV_HUGEPAGE is
set the userland allocation is long lived, so such higher allocation
latency won't risk to hit short lived allocations that don't set
MADV_HUGEPAGE (unless madvise=always, but that's not the default
precisely because not all allocations are long lived).

If the MADV_HUGEPAGE using library was freely available it'd also be
nice.
