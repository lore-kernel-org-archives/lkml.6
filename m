Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C84C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 05:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0A59217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 05:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbfAXFQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 00:16:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36966 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbfAXFQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 00:16:26 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EE0317AEA1;
        Thu, 24 Jan 2019 05:16:25 +0000 (UTC)
Received: from xz-x1 (dhcp-14-116.nay.redhat.com [10.66.14.116])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B07916B8F7;
        Thu, 24 Jan 2019 05:16:18 +0000 (UTC)
Date:   Thu, 24 Jan 2019 13:16:16 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Martin Cracauer <cracauer@cons.org>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Shaohua Li <shli@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Pavel Emelyanov <xemul@parallels.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH RFC 10/24] userfaultfd: wp: add WP pagetable tracking to
 x86
Message-ID: <20190124051616.GE18231@xz-x1>
References: <20190121075722.7945-1-peterx@redhat.com>
 <20190121075722.7945-11-peterx@redhat.com>
 <20190121150937.GE3344@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190121150937.GE3344@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 24 Jan 2019 05:16:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 10:09:38AM -0500, Jerome Glisse wrote:
> On Mon, Jan 21, 2019 at 03:57:08PM +0800, Peter Xu wrote:
> > From: Andrea Arcangeli <aarcange@redhat.com>
> > 
> > Accurate userfaultfd WP tracking is possible by tracking exactly which
> > virtual memory ranges were writeprotected by userland. We can't relay
> > only on the RW bit of the mapped pagetable because that information is
> > destroyed by fork() or KSM or swap. If we were to relay on that, we'd
> > need to stay on the safe side and generate false positive wp faults
> > for every swapped out page.

(I'm trying to leave comments with my own understanding here; they
 might not be the original purposes when Andrea proposed the idea.
 Andrea, please feel free to chim in anytime especially if I am
 wrong... :-)

> 
> So you want to forward write fault (of a protected range) to user space
> only if page is not write protected because of fork(), KSM or swap.
> 
> This write protection feature is only for anonymous page right ? Other-
> wise how would you protect a share page (ie anyone can look it up and
> call page_mkwrite on it and start writting to it) ?

AFAIU we want to support shared memory too in the future.  One example
I can think of is current QEMU usage with DPDK: we have two processes
sharing the guest memory range.  So indeed this might not work if
there are unknown/malicious users of the shared memory, however in
many use cases the users are all known and AFAIU we should just write
protect all these users then we'll still get notified when any of them
write to a page.

> 
> So for anonymous page for fork() the mapcount will tell you if page is
> write protected for COW. For KSM it is easy check the page flag.

Yes I agree that KSM should be easy.  But for COW, please consider
when we write protect a page that was shared and RW removed due to
COW.  Then when we page fault on this page should we report to the
monitor?  IMHO we can't know if without a specific bit in the PTE.

> 
> For swap you can use the page lock to synchronize. A page that is
> write protected because of swap is write protected because it is being
> write to disk thus either under page lock, or with PageWriteback()
> returning true while write is on going.

For swap I think the major problem is when the page was swapped out of
main memory and then we write to the page (which was already a swap
entry now).  Then we'll first swap in the page into main memory again,
but then IMHO we will face the similar issue like COW above - we can't
judge whether this page was write protected by uffd-wp at all.  Of
course here we can detect the VMA flags and assuming it's write
protected if the UFFD_WP flag was set on the VMA flag, however we'll
also mark those pages which were not write protected at all hence
it'll generate false positives of write protection messages.  This
idea can apply too to above COW use case.  As a conclusion, in these
use cases we should not be able to identify explicitly on page
granularity write protection if without a specific _PAGE_UFFD_WP bit
in the PTE entries.

Thanks,

-- 
Peter Xu
