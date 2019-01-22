Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3B3C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 067D021019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbfAVQxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 11:53:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:18409 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729316AbfAVQxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 11:53:17 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A8623C079C2B;
        Tue, 22 Jan 2019 16:53:15 +0000 (UTC)
Received: from redhat.com (ovpn-125-220.rdu2.redhat.com [10.10.125.220])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BB77660BE7;
        Tue, 22 Jan 2019 16:53:12 +0000 (UTC)
Date:   Tue, 22 Jan 2019 11:53:10 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Martin Cracauer <cracauer@cons.org>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Shaohua Li <shli@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH RFC 03/24] mm: allow VM_FAULT_RETRY for multiple times
Message-ID: <20190122165310.GB3188@redhat.com>
References: <20190121075722.7945-1-peterx@redhat.com>
 <20190121075722.7945-4-peterx@redhat.com>
 <20190121155536.GB3711@redhat.com>
 <20190122082238.GC14907@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190122082238.GC14907@xz-x1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 22 Jan 2019 16:53:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 04:22:38PM +0800, Peter Xu wrote:
> On Mon, Jan 21, 2019 at 10:55:36AM -0500, Jerome Glisse wrote:
> > On Mon, Jan 21, 2019 at 03:57:01PM +0800, Peter Xu wrote:
> > > The idea comes from a discussion between Linus and Andrea [1].
> > > 
> > > Before this patch we only allow a page fault to retry once.  We achieved
> > > this by clearing the FAULT_FLAG_ALLOW_RETRY flag when doing
> > > handle_mm_fault() the second time.  This was majorly used to avoid
> > > unexpected starvation of the system by looping over forever to handle
> > > the page fault on a single page.  However that should hardly happen, and
> > > after all for each code path to return a VM_FAULT_RETRY we'll first wait
> > > for a condition (during which time we should possibly yield the cpu) to
> > > happen before VM_FAULT_RETRY is really returned.
> > > 
> > > This patch removes the restriction by keeping the FAULT_FLAG_ALLOW_RETRY
> > > flag when we receive VM_FAULT_RETRY.  It means that the page fault
> > > handler now can retry the page fault for multiple times if necessary
> > > without the need to generate another page fault event. Meanwhile we
> > > still keep the FAULT_FLAG_TRIED flag so page fault handler can still
> > > identify whether a page fault is the first attempt or not.
> > 
> > So there is nothing protecting starvation after this patch ? AFAICT.
> > Do we sufficient proof that we never have a scenario where one process
> > might starve fault another ?
> > 
> > For instance some page locking could starve one process.
> 
> Hi, Jerome,
> 
> Do you mean lock_page()?
> 
> AFAIU lock_page() will only yield the process itself until the lock is
> released, so IMHO it's not really starving the process but a natural
> behavior.  After all the process may not continue without handling the
> page fault correctly.
> 
> Or when you say "starvation" do you mean that we might return
> VM_FAULT_RETRY from handle_mm_fault() continuously so we'll looping
> over and over inside the page fault handler?

That one ie every time we retry someone else is holding the lock and
thus lock_page_or_retry() will continuously retry. Some process just
get unlucky ;)

With existing code because we remove the retry flag then on the second
try we end up waiting for the page lock while holding the mmap_sem so
we know that we are in line for the page lock and we will get it once
it is our turn.

Cheers,
Jérôme
