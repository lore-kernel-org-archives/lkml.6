Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E650C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12B0521920
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388956AbeLUOCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 09:02:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46218 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730556AbeLUOCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 09:02:04 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9DC4AC073D79;
        Fri, 21 Dec 2018 14:02:03 +0000 (UTC)
Received: from sky.random (ovpn-120-37.rdu2.redhat.com [10.10.120.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 310551001F3D;
        Fri, 21 Dec 2018 14:01:44 +0000 (UTC)
Date:   Fri, 21 Dec 2018 09:01:42 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, mhocko@kernel.org,
        vbabka@suse.cz, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: Re: [PATCH 1/2] mm: vmscan: skip KSM page in direct reclaim if
 priority is low
Message-ID: <20181221140142.GA4322@redhat.com>
References: <1541618201-120667-1-git-send-email-yang.shi@linux.alibaba.com>
 <20181220144513.bf099a67c1140865f496011f@linux-foundation.org>
 <alpine.LSU.2.11.1812202143340.2191@eggly.anvils>
 <575fdffe-abfa-e52b-7b91-97e5e6ffb4bb@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <575fdffe-abfa-e52b-7b91-97e5e6ffb4bb@linux.alibaba.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 21 Dec 2018 14:02:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Yang,

On Thu, Dec 20, 2018 at 10:33:26PM -0800, Yang Shi wrote:
> 
> 
> On 12/20/18 10:04 PM, Hugh Dickins wrote:
> > On Thu, 20 Dec 2018, Andrew Morton wrote:
> >> Is anyone interested in reviewing this?  Seems somewhat serious.
> >> Thanks.
> > Somewhat serious, but no need to rush.
> >
> >> From: Yang Shi <yang.shi@linux.alibaba.com>
> >> Subject: mm: vmscan: skip KSM page in direct reclaim if priority is low
> >>
> >> When running a stress test, we occasionally run into the below hang issue:
> > Artificial load presumably.
> >
> >> INFO: task ksmd:205 blocked for more than 360 seconds.
> >>        Tainted: G            E 4.9.128-001.ali3000_nightly_20180925_264.alios7.x86_64 #1
> > 4.9-stable does not contain Andrea's 4.13 commit 2c653d0ee2ae
> > ("ksm: introduce ksm_max_page_sharing per page deduplication limit").
> >
> > The patch below is more economical than Andrea's, but I don't think
> > a second workaround should be added, unless Andrea's is shown to be
> > insufficient, even with its ksm_max_page_sharing tuned down to suit.
> >
> > Yang, please try to reproduce on upstream, or backport Andrea's to
> > 4.9-stable - thanks.

I think it's reasonable to backport it and it should be an easy
backport. Just make sure to backport
b4fecc67cc569b14301f5a1111363d5818b8da5e too which was the only bug
there was in the initial patch and it happened with
"merge_across_nodes = 0" (not the default).

We shipped it in production years ago and it was pretty urgent for
those workloads that initially run into this issue.

> 
> I believe Andrea's commit could workaround this problem too by limiting 
> the number of sharing pages.
> 
> However, IMHO, even though we just have a few hundred pages share one 
> KSM page, it still sounds not worth reclaiming it in direct reclaim in 
> low priority. According to Andrea's commit log, it still takes a few 

You've still to walk the entire chain for compaction and memory
hotplug, otherwise the KSM page becomes practically
unmovable. Allowing the rmap chain to grow to infinitely is still not
ok.

If the page should be reclaimed or not in direct reclaim is already
told by page_referenced(), the more mappings there are the more likely
at least one was touched and has the young bit set in the pte.

> msec to walk the rmap for 256 shared pages.

Those ~2.5msec was in the context of page migration: in the previous
sentence I specified it takes 10usec for the IPI and all other stuff
page migration has to do (which also largely depends on multiple
factors like the total number of CPUs).

page_referenced() doesn't flush the TLB during the rmap walk when it
clears the accessed bit, so it's orders of magnitude faster than the
real page migration at walking the KSM rmap chain.

If the page migration latency of 256 max mappings is a concern the max
sharing can be configured at runtime or the default max sharing can be
reduced to 10 to give a max latency of ~100usec and it would still
give a fairly decent x10 compression ratio. That's a minor detail to
change if that's a concern.

The only difference compared to all other page types is KSM pages can
occasionally merge very aggressively and the apps have no way to limit
the merging or even avoid it. We simply can't ask the app to create
fewer equal pages..

This is why the max sharing has to be limited inside KSM, then we
don't need anything special in the VM anymore to threat KSM pages.

As opposed the max sharing of COW anon memory post fork is limited by
the number of fork invocations, for MAP_SHARED the sharing is limited
by the number of mmaps, those don't tend to escalate to the million or
they would run into other limits first. It's reasonable to expect the
developer to optimize the app to create fewer mmaps or to use thread
instead of processes to reduce the VM overhead in general (which will
improve the rmap walks too).

Note the MAP_SHARED/PRIVATE/anon-COW sharing can exceed 256 mappings
too, you've just to fork 257 times in a row or much more realistically
mmap the same glibc library 257 times in a row, so if something KSM is
now less of a concern for occasional page_referenced worst case
latencies, than all the rest of the page types.

KSM by enforcing the max sharing is now the most RMAP walk
computational complexity friendly of all the page types out there. So
there's no need to threat it specially at low priority reclaim scans.

Thanks,
Andrea
