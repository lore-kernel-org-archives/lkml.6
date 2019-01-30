Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FB2C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1317D20882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730280AbfA3JXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:23:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56088 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbfA3JXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:23:12 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9AEF98AE6F;
        Wed, 30 Jan 2019 09:23:11 +0000 (UTC)
Received: from xz-x1 (dhcp-14-116.nay.redhat.com [10.66.14.116])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 256A71A7CE;
        Wed, 30 Jan 2019 09:23:04 +0000 (UTC)
Date:   Wed, 30 Jan 2019 17:23:02 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
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
Message-ID: <20190130092302.GA25119@xz-x1>
References: <20190129234058.GH31695@redhat.com>
 <20190130081336.GC17937@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190130081336.GC17937@rapoport-lnx>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 30 Jan 2019 09:23:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 10:13:36AM +0200, Mike Rapoport wrote:
> Hi,
> 
> (changed the subject and added CRIU folks)
> 
> On Tue, Jan 29, 2019 at 06:40:58PM -0500, Andrea Arcangeli wrote:
> > Hello,
> > 
> > --
> > 
> > In addition to the above "NUMA remote THP vs NUMA local non-THP
> > tradeoff" topic, there are other developments in "userfaultfd" land that
> > are approaching merge readiness and that would be possible to provide a
> > short overview about:
> > 
> > - Peter Xu made significant progress in finalizing the userfaultfd-WP
> >   support over the last few months. That feature was planned from the
> >   start and it will allow userland to do some new things that weren't
> >   possible to achieve before. In addition to synchronously blocking
> >   write faults to be resolved by an userland manager, it has also the
> >   ability to obsolete the softdirty feature, because it can provide
> >   the same information, but with O(1) complexity (as opposed of the
> >   current softdirty O(N) complexity) similarly to what the Page
> >   Modification Logging (PML) does in hardware for EPT write accesses.
>  
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
> 
> We'd need to see how this affects overall slowdown of the workload under
> migration before moving forward with obsoleting soft-dirty.
> 
> > - Blake Caldwell maintained the UFFDIO_REMAP support to atomically
> >   remove memory from a mapping with userfaultfd (which can't be done
> >   with a copy as in UFFDIO_COPY and it requires a slow TLB flush to be
> >   safe) as an alternative to host swapping (which of course also
> >   requires a TLB flush for similar reasons). Notably UFFDIO_REMAP was
> >   rightfully naked early on and quickly replaced by UFFDIO_COPY which
> >   is more optimal to add memory to a mapping is small chunks, but we
> >   can't remove memory with UFFDIO_COPY and UFFDIO_REMAP should be as
> >   efficient as it gets when it comes to removing memory from a
> >   mapping.
> 
> If we are to discuss userfaultfd, I'd like also to bring the subject of COW
> mappings.
> The pages populated with UFFDIO_COPY cannot be COW-shared between related
> processes which unnecessarily increases memory footprint of a migrated
> process tree.
> I've posted a patch [1] a (real) while ago, but nobody reacted and I've put
> this aside.
> Maybe it's time to discuss it again :)

Hi, Mike,

It's interesting to know such a work...

Since I really don't have much context on this, so sorry if I'm going
to ask a silly question... but I'd say when reading this I'm thinking
of KSM.  I think KSM does not suite in this case since when doing
UFFDIO_COPY_COW it'll contain hinting information while KSM was only
scanning over the pages between processes which seems to be O(N*N) if
assuming there're two processes.  However, would it make any sense to
provide a general interface to scan for same pages between any two
processes within specific range and merge them if found (rather than a
specific interface for userfaultfd only)?  Then it might even be used
by KSM admins (just as an example) when the admin knows exactly that
memory range (addr1, len) of process A should very probably has many
same contents as the memory range (addr2, len) of process B?

Thanks,

-- 
Peter Xu
