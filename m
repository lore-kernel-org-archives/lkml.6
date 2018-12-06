Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FA6C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 00:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85CC22133F
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 00:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85CC22133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbeLFAbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 19:31:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56886 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727620AbeLFAbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 19:31:33 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 125383086249;
        Thu,  6 Dec 2018 00:31:32 +0000 (UTC)
Received: from sky.random (ovpn-122-73.rdu2.redhat.com [10.10.122.73])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 535565D757;
        Thu,  6 Dec 2018 00:31:27 +0000 (UTC)
Date:   Wed, 5 Dec 2018 19:31:26 -0500
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
Message-ID: <20181206003126.GA21159@redhat.com>
References: <alpine.DEB.2.21.1812031545080.161134@chino.kir.corp.google.com>
 <bb198d88-27be-0d5c-d871-1ffd26a08e29@suse.cz>
 <alpine.DEB.2.21.1812041356490.157466@chino.kir.corp.google.com>
 <20181205090554.GX1286@dhcp22.suse.cz>
 <alpine.DEB.2.21.1812051142040.240991@chino.kir.corp.google.com>
 <20181205214542.GC11899@redhat.com>
 <alpine.DEB.2.21.1812051402150.9633@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1812051402150.9633@chino.kir.corp.google.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 06 Dec 2018 00:31:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 02:10:47PM -0800, David Rientjes wrote:
> I've must have said this at least six or seven times: fault latency is 

In your original regression report in this thread to Linus:

https://lkml.kernel.org/r/alpine.DEB.2.21.1811281504030.231719@chino.kir.corp.google.com

you said "On a fragmented host, the change itself showed a 13.9%
access latency regression on Haswell and up to 40% allocation latency
                                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
regression. This is more substantial on Naples and Rome.  I also
^^^^^^^^^^
measured similar numbers to this for Haswell."

> secondary to the *access* latency.  We want to try hard for MADV_HUGEPAGE 
> users to do synchronous compaction and try to make a hugepage available.  

I'm glad you said it six or seven times now, because you forgot to
mention in the above email that the "40% allocation/fault latency
regression" you reported above, is actually a secondary concern because
those must be long lived allocations and we can't yet generate
compound pages for free after all..

> We really want to be backed by hugepages, but certainly not when the 
> access latency becomes 13.9% worse as a result compared to local pages of 
> the native page size.

Yes the only regression that you measure that isn't only a secondary
concern, is that 13.9% access latency because of not immediate NUMA
locality.

BTW, I never bothered to ask yet, but, did you enable NUMA balancing
in your benchmarks? NUMA balancing would fix the access latency very
easily too, so that 13.9% access latency must quickly disappear if you
correctly have NUMA balancing enabled in a NUMA system.

Furthermore NUMA balancing is fully converging guaranteed if the
workload can fit in a single node (your case or __GFP_THISNODE would
hardly fly in the first place). It'll work even better for you because
you copy off all MAP_PRIVATE binaries into MAP_ANON to make them THP
backed so they can also be replicated per NODE and they won't increase
the NUMA balancing false sharing. And khugepaged always remains NUMA
agnostic so it won't risk to stop on NUMA balancing toes no matter how
we tweak the MADV_HUGEPAGE behavior.

> This is not a system-wide configuration detail, it is specific to the 
> workload: does it span more than one node or not?  No workload that can 
> fit into a single node, which you also say is going to be the majority of 
> workloads on today's platforms, is going to want to revert __GFP_THISNODE 
> behavior of the past almost four years.  It perfectly makes sense, 
> however, to be a new mempolicy mode, a new madvise mode, or a prctl.

qemu has been using MADV_HUGEPAGE since the below commit in Oct 2012.

From ad0b5321f1f797274603ebbe20108b0750baee94 Mon Sep 17 00:00:00 2001
From: Luiz Capitulino <lcapitulino@redhat.com>
Date: Fri, 5 Oct 2012 16:47:57 -0300
Subject: [PATCH 1/1] Call MADV_HUGEPAGE for guest RAM allocations

This makes it possible for QEMU to use transparent huge pages (THP)
when transparent_hugepage/enabled=madvise. Otherwise THP is only
used when it's enabled system wide.

Signed-off-by: Luiz Capitulino <lcapitulino@redhat.com>
Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>
Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
---
 exec.c  | 1 +
 osdep.h | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/exec.c b/exec.c
index c4ed6fdef1..750008c4e1 100644
--- a/exec.c
+++ b/exec.c
@@ -2571,6 +2571,7 @@ ram_addr_t qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
     cpu_physical_memory_set_dirty_range(new_block->offset, size, 0xff);
 
     qemu_ram_setup_dump(new_block->host, size);
+    qemu_madvise(new_block->host, size, QEMU_MADV_HUGEPAGE);
 
     if (kvm_enabled())
         kvm_setup_guest_memory(new_block->host, size);
diff --git a/osdep.h b/osdep.h
index cb213e0295..c5fd3d91ff 100644
--- a/osdep.h
+++ b/osdep.h
@@ -108,6 +108,11 @@ void qemu_vfree(void *ptr);
 #else
 #define QEMU_MADV_DONTDUMP QEMU_MADV_INVALID
 #endif
+#ifdef MADV_HUGEPAGE
+#define QEMU_MADV_HUGEPAGE MADV_HUGEPAGE
+#else
+#define QEMU_MADV_HUGEPAGE QEMU_MADV_INVALID
+#endif
 
 #elif defined(CONFIG_POSIX_MADVISE)
 
> Please: if we wish to change behavior from February 2015, let's extend the 
> API to allow for remote allocations in several of the ways we have already 
> brainstormed rather than cause regressions.

So if I understand correctly, you broke QEMU 3 years ago (again only
noticed Jan 2018 because it requires >2 nodes and it requires a VM
larger than 1 NODE which isn't common).

QEMU before your regression in April 2015:

Finished: 30 GB mapped, 10.163159s elapsed, 2.95GB/s
Finished: 34 GB mapped, 11.806526s elapsed, 2.88GB/s
Finished: 38 GB mapped, 10.369081s elapsed, 3.66GB/s
Finished: 42 GB mapped, 12.357719s elapsed, 3.40GB/s

QEMU after your regression in April 2015:

Finished: 30 GB mapped, 8.821632s elapsed, 3.40GB/s
Finished: 34 GB mapped, 341.979543s elapsed, 0.10GB/s
Finished: 38 GB mapped, 761.933231s elapsed, 0.05GB/s
Finished: 42 GB mapped, 1188.409235s elapsed, 0.04GB/s

And now you ask open source upstream QEMU to start using a special
mempolicy if it doesn't want to keep breaking with your change, so you
don't have to apply a one liner to your unreleased so far proprietary
software that uses MADV_HUGEPAGE and depends on a special
__GFP_THISNODE behavior that broke qemu in the first place?

Thanks,
Andrea
