Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5B0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 366602080D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbfBURcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 12:32:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43928 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbfBURcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 12:32:45 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1D71E308FE63;
        Thu, 21 Feb 2019 17:32:45 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 797251001DC5;
        Thu, 21 Feb 2019 17:32:39 +0000 (UTC)
Date:   Thu, 21 Feb 2019 12:32:37 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
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
Subject: Re: [PATCH v2 11/26] mm: merge parameters for change_protection()
Message-ID: <20190221173237.GK2813@redhat.com>
References: <20190212025632.28946-1-peterx@redhat.com>
 <20190212025632.28946-12-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190212025632.28946-12-peterx@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 21 Feb 2019 17:32:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 10:56:17AM +0800, Peter Xu wrote:
> change_protection() was used by either the NUMA or mprotect() code,
> there's one parameter for each of the callers (dirty_accountable and
> prot_numa).  Further, these parameters are passed along the calls:
> 
>   - change_protection_range()
>   - change_p4d_range()
>   - change_pud_range()
>   - change_pmd_range()
>   - ...
> 
> Now we introduce a flag for change_protect() and all these helpers to
> replace these parameters.  Then we can avoid passing multiple parameters
> multiple times along the way.
> 
> More importantly, it'll greatly simplify the work if we want to
> introduce any new parameters to change_protection().  In the follow up
> patches, a new parameter for userfaultfd write protection will be
> introduced.
> 
> No functional change at all.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

It would have been nice if this was a coccinelle patch, easier to
review.

Reviewed-by: Jérôme Glisse <jglisse@redhat.com>

> ---
>  include/linux/huge_mm.h |  2 +-
>  include/linux/mm.h      | 14 +++++++++++++-
>  mm/huge_memory.c        |  3 ++-
>  mm/mempolicy.c          |  2 +-
>  mm/mprotect.c           | 29 ++++++++++++++++-------------
>  5 files changed, 33 insertions(+), 17 deletions(-)

[...]
