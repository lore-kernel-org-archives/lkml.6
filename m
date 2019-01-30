Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A03C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C715218A4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731293AbfA3OnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 09:43:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57218 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727555AbfA3OnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 09:43:09 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E8534A402E;
        Wed, 30 Jan 2019 14:43:08 +0000 (UTC)
Received: from sky.random (ovpn-121-14.rdu2.redhat.com [10.10.121.14])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A306718823;
        Wed, 30 Jan 2019 14:43:05 +0000 (UTC)
Date:   Wed, 30 Jan 2019 09:43:04 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Peter Xu <peterx@redhat.com>,
        Blake Caldwell <blake.caldwell@colorado.edu>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>
Subject: Re: [LSF/MM TOPIC]: userfaultfd (was: [LSF/MM TOPIC] NUMA remote THP
 vs NUMA local non-THP under MADV_HUGEPAGE)
Message-ID: <20190130144304.GA19021@redhat.com>
References: <20190129234058.GH31695@redhat.com>
 <20190130081336.GC17937@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130081336.GC17937@rapoport-lnx>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 30 Jan 2019 14:43:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mike,

On Wed, Jan 30, 2019 at 10:13:36AM +0200, Mike Rapoport wrote:
> We (CRIU) have some concerns about obsoleting soft-dirty in favor of
> uffd-wp. If there are other soft-dirty users these concerns would be
> relevant to them as well.
> 
> With soft-dirty we collect the information about the changed memory every
> pre-dump iteration in the following manner:
> * freeze the tasks
> * find entries in /proc/pid/pagemap with SOFT_DIRTY set
> * unfreeze the tasks
> * dump the modified pages to disk/remote host
> 
> While we do need to traverse the /proc/pid/pagemap to identify dirty pages,
> in between the pre-dump iterations and during the actual memory dump the
> tasks are running freely.
> 
> If we are to switch to uffd-wp, every write by the snapshotted/migrated
> task will incur latency of uffd-wp processing by the monitor.

That's valid concern indeed.

I didn't go into the details of what additional feature is needed in
addition to what is already present present in Peter's current
patchset, but you're correct that in order to perform well to do the
softdirty equivalent, we'll also need to add an async event model.

The async event model would be set during UFFD registration. It'd work
like async signals, you just queue up uffd events in the kernel by
allocating them with a slab object (not in the kernel stack of the
faulting process). Only if the monitor won't read() them fast enough
it'll eventually block the write protect fault and release the
mmap_sem but the page fault would always be resolved by the kernel
even in that case. For the monitor there'll be just a stream of
uffd_msg structures to read in multiples of the uffd_msg structure
size with a single syscall per wakeup of the monitor. Conceptually
it'd work the same as how PML works for EPT.

The main downside will be an allocation per fault (soft dirty doesn't
need to do such allocation), but there will be no round-trip to
userland latency added to the wrprotect fault that needs to be logged.

We need the synchronous/blocking uffd-wp for other things that aren't
related to soft dirty and can't be achieved with an async model like
softdirty. Adding an async model later would be a self contained
feature inside uffd.

So the idea would be to ignore any comparison with softdirty until
uffd-wp is finalized, and then evaluate the possibility of adding an
async model which would be simple thing to add in comparison of the
uffd-wp feature itself.

The theoretical expectation would be that softdirty would perform
better for small processes (but for those the overall logging overhead
is small anyway), but when it gets to the hundred-gigabytes/terabytes
regions, async uffd-wp should perform much better.

Thanks,
Andrea
