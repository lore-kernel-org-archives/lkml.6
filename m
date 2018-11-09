Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9861C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1C2920825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1C2920825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbeKJFd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 00:33:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:23360 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725752AbeKJFd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 00:33:56 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4C459C0587D2;
        Fri,  9 Nov 2018 19:51:52 +0000 (UTC)
Received: from sky.random (ovpn-123-95.rdu2.redhat.com [10.10.123.95])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E9E85D717;
        Fri,  9 Nov 2018 19:51:51 +0000 (UTC)
Date:   Fri, 9 Nov 2018 14:51:50 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Anthony Yznaga <anthony.yznaga@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, aneesh.kumar@linux.ibm.com,
        akpm@linux-foundation.org, jglisse@redhat.com,
        khandual@linux.vnet.ibm.com, kirill.shutemov@linux.intel.com,
        mgorman@techsingularity.net, mhocko@kernel.org, minchan@kernel.org,
        peterz@infradead.org, rientjes@google.com, vbabka@suse.cz,
        willy@infradead.org, ying.huang@intel.com, nitingupta910@gmail.com
Subject: Re: [RFC PATCH] mm: thp: implement THP reservations for anonymous
 memory
Message-ID: <20181109195150.GA24747@redhat.com>
References: <1541746138-6706-1-git-send-email-anthony.yznaga@oracle.com>
 <20181109121318.3f3ou56ceegrqhcp@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109121318.3f3ou56ceegrqhcp@kshutemo-mobl1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 09 Nov 2018 19:51:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Nov 09, 2018 at 03:13:18PM +0300, Kirill A. Shutemov wrote:
> On Thu, Nov 08, 2018 at 10:48:58PM -0800, Anthony Yznaga wrote:
> > The basic idea as outlined by Mel Gorman in [2] is:
> > 
> > 1) On first fault in a sufficiently sized range, allocate a huge page
> >    sized and aligned block of base pages.  Map the base page
> >    corresponding to the fault address and hold the rest of the pages in
> >    reserve.
> > 2) On subsequent faults in the range, map the pages from the reservation.
> > 3) When enough pages have been mapped, promote the mapped pages and
> >    remaining pages in the reservation to a huge page.
> > 4) When there is memory pressure, release the unused pages from their
> >    reservations.
> 
> I haven't yet read the patch in details, but I'm skeptical about the
> approach in general for few reasons:
> 
> - PTE page table retracting to replace it with huge PMD entry requires
>   down_write(mmap_sem). It makes the approach not practical for many
>   multi-threaded workloads.
> 
>   I don't see a way to avoid exclusive lock here. I will be glad to
>   be proved otherwise.
> 
> - The promotion will also require TLB flush which might be prohibitively
>   slow on big machines.
> 
> - Short living processes will fail to benefit from THP with the policy,
>   even with plenty of free memory in the system: no time to promote to THP
>   or, with synchronous promotion, cost will overweight the benefit.
> 
> The goal to reduce memory overhead of THP is admirable, but we need to be
> careful not to kill THP benefit itself. The approach will reduce number of
> THP mapped in the system and/or shift their allocation to later stage of
> process lifetime.
> 
> The only way I see it can be useful is if it will be possible to apply the
> policy on per-VMA basis. It will be very useful for malloc()
> implementations, for instance. But as a global policy it's no-go to me.

I'm also skeptical about this: the current design is quite
intentional. It's not a bug but a feature that we're not doing the
promotion.

Part of the tradeoff with THP is to use more RAM to save CPU, when you
use less RAM you're inherently already wasting some CPU just for the
reservation management and you don't get the immediate TLB benefit
anymore either.

And if you're in the camp that is concerned about the use of more RAM
or/and about the higher latency of COW faults, I'm afraid the
intermediate solution will be still slower than the already available
MADV_NOHUGEPAGE or enabled=madvise.

Apps like redis that will use more RAM during snapshot and that are
slowed down with THP needs to simply use MADV_NOHUGEPAGE which already
exists as an madvise from the very first kernel that supported
THP-anon. Same thing for other apps that use more RAM with THP and
that are on the losing end of the tradeoff.

Now about the implementation: the whole point of the reservation
complexity is to skip the khugepaged copy, so it can collapse in
place. Is skipping the copy worth it? Isn't the big cost the IPI
anyway to avoid leaving two simultaneous TLB mappings of different
granularity?

khugepaged is already tunable to specify a ratio of memory in use to
avoid wasting memory
/sys/kernel/mm/transparent_hugepage/khugepaged/max_ptes_none.

If you set max_ptes_none to half the default value, it'll only promote
pages that are half mapped, reducing the memory waste to 50% of what
it is by default.

So if you are ok to copy the memory that you promote to THP, you'd
just need a global THP mode to avoid allocating THP even when they're
available during the page fault (while still allowing khugepaged to
collapse hugepages in the background), and then reduce max_ptes_none
to get the desired promotion ratio.

Doing the copy will avoid the reservation there will be also more THP
available to use for those khugepaged users without losing them in
reservations. You won't have to worry about what to do when there's
memory pressure because you won't have to undo the reservation because
there was no reservation in the first place. That problem also goes
away with the copy.

So it sounds like you could achieve a similar runtime behavior with
much less complexity by reducing max_ptes_none and by doing the copy
and dropping all reservation code.

> Prove me wrong with performance data. :)

Same here.

Thanks,
Andrea
