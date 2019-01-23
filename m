Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B31CC282C3
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 02:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 136DF20868
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 02:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfAWCM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 21:12:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54806 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726895AbfAWCM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 21:12:57 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 499867F3E8;
        Wed, 23 Jan 2019 02:12:56 +0000 (UTC)
Received: from xz-x1 (ovpn-12-57.pek2.redhat.com [10.72.12.57])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E113268865;
        Wed, 23 Jan 2019 02:12:45 +0000 (UTC)
Date:   Wed, 23 Jan 2019 10:12:41 +0800
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
        Mike Kravetz <mike.kravetz@oracle.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH RFC 03/24] mm: allow VM_FAULT_RETRY for multiple times
Message-ID: <20190123021241.GA2970@xz-x1>
References: <20190121075722.7945-1-peterx@redhat.com>
 <20190121075722.7945-4-peterx@redhat.com>
 <20190121155536.GB3711@redhat.com>
 <20190122082238.GC14907@xz-x1>
 <20190122165310.GB3188@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190122165310.GB3188@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 23 Jan 2019 02:12:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 11:53:10AM -0500, Jerome Glisse wrote:
> On Tue, Jan 22, 2019 at 04:22:38PM +0800, Peter Xu wrote:
> > On Mon, Jan 21, 2019 at 10:55:36AM -0500, Jerome Glisse wrote:
> > > On Mon, Jan 21, 2019 at 03:57:01PM +0800, Peter Xu wrote:
> > > > The idea comes from a discussion between Linus and Andrea [1].
> > > > 
> > > > Before this patch we only allow a page fault to retry once.  We achieved
> > > > this by clearing the FAULT_FLAG_ALLOW_RETRY flag when doing
> > > > handle_mm_fault() the second time.  This was majorly used to avoid
> > > > unexpected starvation of the system by looping over forever to handle
> > > > the page fault on a single page.  However that should hardly happen, and
> > > > after all for each code path to return a VM_FAULT_RETRY we'll first wait
> > > > for a condition (during which time we should possibly yield the cpu) to
> > > > happen before VM_FAULT_RETRY is really returned.
> > > > 
> > > > This patch removes the restriction by keeping the FAULT_FLAG_ALLOW_RETRY
> > > > flag when we receive VM_FAULT_RETRY.  It means that the page fault
> > > > handler now can retry the page fault for multiple times if necessary
> > > > without the need to generate another page fault event. Meanwhile we
> > > > still keep the FAULT_FLAG_TRIED flag so page fault handler can still
> > > > identify whether a page fault is the first attempt or not.
> > > 
> > > So there is nothing protecting starvation after this patch ? AFAICT.
> > > Do we sufficient proof that we never have a scenario where one process
> > > might starve fault another ?
> > > 
> > > For instance some page locking could starve one process.
> > 
> > Hi, Jerome,
> > 
> > Do you mean lock_page()?
> > 
> > AFAIU lock_page() will only yield the process itself until the lock is
> > released, so IMHO it's not really starving the process but a natural
> > behavior.  After all the process may not continue without handling the
> > page fault correctly.
> > 
> > Or when you say "starvation" do you mean that we might return
> > VM_FAULT_RETRY from handle_mm_fault() continuously so we'll looping
> > over and over inside the page fault handler?
> 
> That one ie every time we retry someone else is holding the lock and
> thus lock_page_or_retry() will continuously retry. Some process just
> get unlucky ;)
> 
> With existing code because we remove the retry flag then on the second
> try we end up waiting for the page lock while holding the mmap_sem so
> we know that we are in line for the page lock and we will get it once
> it is our turn.

Ah I see. :)  It's indeed a valid questioning.

Firstly note that even after this patch we can still identify whether
we're at the first attempt or not by checking against FAULT_FLAG_TRIED
(it will be applied to the fault flag in all the retries but not in
the first atttempt). So IMHO this change might suite if we want to
keep the old behavior [1]:

diff --git a/mm/filemap.c b/mm/filemap.c
index 9f5e323e883e..44942c78bb92 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1351,7 +1351,7 @@ EXPORT_SYMBOL_GPL(__lock_page_killable);
 int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
                         unsigned int flags)
 {
-       if (flags & FAULT_FLAG_ALLOW_RETRY) {
+       if (!flags & FAULT_FLAG_TRIED) {
                /*
                 * CAUTION! In this case, mmap_sem is not released
                 * even though return 0.

But at the same time I'm stepping back trying to see the whole
picture... My understanding is that this is really a policy that we
can decide, and a trade off between "being polite or not on the
mmap_sem", that when taking the page lock in slow path we either:

  (1) release mmap_sem before waiting, polite enough but uncertain to
      finally have the lock, or,

  (2) keep mmap_sem before waiting, not polite enough but certain to
      take the lock.

We did (2) before on the reties because in existing code we only allow
to retry once, so we can't fail on the 2nd attempt.  That seems to be
a good reason to being "unpolite" - we took the mmap_sem without
considering others because we've been "polite" once.  I'm not that
experienced in mm development but AFAIU solution 2 is only reducing
our chance of starvation but adding that chance of starvation to other
processes that want the mmap_sem instead.  So IMHO the starvation
issue always existed even before this patch, and it looks natural and
sane to me so far...  And if with that in mind, I can't say that above
change at [1] would be better, and maybe, it'll be even more fair that
we should always release the mmap_sem first in this case (assuming
that we'll after all have that lock though we might pay more times of
retries)?

Or, is there a way to constantly starve the process that handles the
page fault that I've totally missed?

Thanks,

-- 
Peter Xu
