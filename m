Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B131FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 811C32083B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbfBUPR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:17:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46558 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbfBUPR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 10:17:56 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4E7F7859FE;
        Thu, 21 Feb 2019 15:17:54 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D65295D9D4;
        Thu, 21 Feb 2019 15:17:44 +0000 (UTC)
Date:   Thu, 21 Feb 2019 10:17:42 -0500
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
Subject: Re: [PATCH v2 01/26] mm: gup: rename "nonblocking" to "locked" where
 proper
Message-ID: <20190221151742.GA2813@redhat.com>
References: <20190212025632.28946-1-peterx@redhat.com>
 <20190212025632.28946-2-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190212025632.28946-2-peterx@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 21 Feb 2019 15:17:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 10:56:07AM +0800, Peter Xu wrote:
> There's plenty of places around __get_user_pages() that has a parameter
> "nonblocking" which does not really mean that "it won't block" (because
> it can really block) but instead it shows whether the mmap_sem is
> released by up_read() during the page fault handling mostly when
> VM_FAULT_RETRY is returned.
> 
> We have the correct naming in e.g. get_user_pages_locked() or
> get_user_pages_remote() as "locked", however there're still many places
> that are using the "nonblocking" as name.
> 
> Renaming the places to "locked" where proper to better suite the
> functionality of the variable.  While at it, fixing up some of the
> comments accordingly.
> 
> Reviewed-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Minor issue see below

Reviewed-by: Jérôme Glisse <jglisse@redhat.com>

[...]

> @@ -656,13 +656,11 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
>   * appropriate) must be called after the page is finished with, and
>   * before put_page is called.
>   *
> - * If @nonblocking != NULL, __get_user_pages will not wait for disk IO
> - * or mmap_sem contention, and if waiting is needed to pin all pages,
> - * *@nonblocking will be set to 0.  Further, if @gup_flags does not
> - * include FOLL_NOWAIT, the mmap_sem will be released via up_read() in
> - * this case.
> + * If @locked != NULL, *@locked will be set to 0 when mmap_sem is
> + * released by an up_read().  That can happen if @gup_flags does not
> + * has FOLL_NOWAIT.

I am not a native speaker but i believe the correct wording is:
     @gup_flags does not have FOLL_NOWAIT
