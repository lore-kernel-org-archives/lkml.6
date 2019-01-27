Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FDDC282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 14:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 833962133F
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 14:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfA0OQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 09:16:00 -0500
Received: from outbound-smtp10.blacknight.com ([46.22.139.15]:53727 "EHLO
        outbound-smtp10.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726511AbfA0OQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 09:16:00 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp10.blacknight.com (Postfix) with ESMTPS id D50C11C31EB
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 14:15:57 +0000 (GMT)
Received: (qmail 9036 invoked from network); 27 Jan 2019 14:15:57 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.225.79])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 27 Jan 2019 14:15:57 -0000
Date:   Sun, 27 Jan 2019 14:15:56 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     valdis.kletnieks@vt.edu
Cc:     Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>, vbabka@suse.cz,
        aarcange@redhat.com, rientjes@google.com, mhocko@kernel.org,
        zi.yan@cs.rutgers.edu, hannes@cmpxchg.org, jack@suse.cz
Subject: Re: [regression -next0117] What is kcompactd and why is he eating
 100% of my cpu?
Message-ID: <20190127141556.GB9565@techsingularity.net>
References: <20190126200005.GB27513@amd>
 <12171.1548557813@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <12171.1548557813@turing-police.cc.vt.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 26, 2019 at 09:56:53PM -0500, valdis.kletnieks@vt.edu wrote:
> On Sat, 26 Jan 2019 21:00:05 +0100, Pavel Machek said:
> 
> > top - 13:38:51 up  1:42, 16 users,  load average: 1.41, 1.93, 1.62
> > Tasks: 182 total,   3 running, 138 sleeping,   0 stopped,   0 zombie
> > %Cpu(s):  2.3 us, 57.8 sy,  0.0 ni, 39.9 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
> > KiB Mem:   3020044 total,  2429420 used,   590624 free,    27468 buffers
> > KiB Swap:  2097148 total,        0 used,  2097148 free.  1924268 cached Mem
> >
> >   PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND
> >   608 root      20   0       0      0      0 R  99.6  0.0  11:34.38 kcompactd0
> >  9782 root      20   0       0      0      0 I   7.9  0.0   0:59.02 kworker/0:
> >  2971 root      20   0   46624  23076  13576 S   4.3  0.8   2:50.22 Xorg
> 
> I've noticed this as well on earlier kernels (next-20181224 to 20190115)
> 
> Some more info:
> 
> 1) echo 3 > /proc/sys/vm/drop_caches  unwedges kcompactd in 1-3 seconds.
> 

This aspect is curious as it indicates that kcompactd could potentially
be infinite looping but it's not something I've experienced myself. By
any chance is there a preditable reproduction case for this?

> I've also seen khugepaged hung up:
> 
> cat /proc/29/stack
> [<0>] ___preempt_schedule+0x16/0x18
> [<0>] page_vma_mapped_walk+0x60/0x840
> [<0>] remove_migration_pte+0x67/0x390
> [<0>] rmap_walk_file+0x186/0x380
> [<0>] rmap_walk+0xa3/0xd0
> [<0>] remove_migration_ptes+0x69/0x70
> [<0>] migrate_pages+0xb6d/0xfd8
> [<0>] compact_zone+0xb70/0x1370
> [<0>] compact_zone_order+0xd8/0x120
> [<0>] try_to_compact_pages+0xe5/0x550
> [<0>] __alloc_pages_direct_compact+0x6d/0x1a0
> [<0>] __alloc_pages_slowpath+0x6c9/0x1640
> [<0>] __alloc_pages_nodemask+0x558/0x5b0
> [<0>] khugepaged+0x499/0x810
> [<0>] kthread+0x158/0x170
> [<0>] ret_from_fork+0x3a/0x50
> [<0>] 0xffffffffffffffff
> 
> Looks like something has gone astray with compact_zone.
> 

It's a possibility that the buffer aspect of the trace is a red herring
and there is some corner case that prevents the migration scan/free
scanner meeting and exiting compaction. Again, a reproduction case of
some sort would be nice or an indication of how long it takes to
trigger. An update of the series is due which may or may not fix this
but if it doesn't, we'll need to start tracing this to see what's going
on at the point of failure.

-- 
Mel Gorman
SUSE Labs
