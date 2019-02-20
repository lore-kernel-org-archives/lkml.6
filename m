Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107CEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9BFC2086C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfBTLtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:49:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33630 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbfBTLtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:49:01 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2DC215945B;
        Wed, 20 Feb 2019 11:49:01 +0000 (UTC)
Received: from xz-x1 (ovpn-12-37.pek2.redhat.com [10.72.12.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5ACAB17B15;
        Wed, 20 Feb 2019 11:48:52 +0000 (UTC)
Date:   Wed, 20 Feb 2019 19:48:49 +0800
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Martin Cracauer <cracauer@cons.org>, Shaohua Li <shli@fb.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v2 04/26] mm: allow VM_FAULT_RETRY for multiple times
Message-ID: <20190220114849.GA4060@xz-x1>
References: <20190212025632.28946-1-peterx@redhat.com>
 <20190212025632.28946-5-peterx@redhat.com>
 <20190213033444.GD11247@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190213033444.GD11247@xz-x1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 20 Feb 2019 11:49:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 11:34:44AM +0800, Peter Xu wrote:
> On Tue, Feb 12, 2019 at 10:56:10AM +0800, Peter Xu wrote:
> 
> [...]
> 
> > @@ -1351,7 +1351,7 @@ EXPORT_SYMBOL_GPL(__lock_page_killable);
> >  int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
> >  			 unsigned int flags)
> >  {
> > -	if (flags & FAULT_FLAG_ALLOW_RETRY) {
> > +	if (!flags & FAULT_FLAG_TRIED) {
> 
> Sorry, this should be:
> 
>         if (!(flags & FAULT_FLAG_TRIED))

Ok this is problematic too...  Because we for sure allow the page
fault flags to be both !ALLOW_RETRY and !TRIED (e.g., when doing GUP
and when __get_user_pages() is with locked==NULL and !FOLL_NOWAIT).
So current code will fall through the if condition and call
up_read(mmap_sem) even if above condition happened (while we shouldn't
because the GUP caller would assume the mmap_sem should be still
held).  So the correct check should be:

  if ((flags & FAULT_FLAG_ALLOW_RETRY) && !(flags & FAULT_FLAG_TRIED))

To make things easier, I'll just repost this single patch later.
Sorry for the noise.

Regards,

-- 
Peter Xu
