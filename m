Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79E7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF71C206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfBUSjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 13:39:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41116 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbfBUSjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 13:39:01 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2FBCCC049E24;
        Thu, 21 Feb 2019 18:39:00 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8949060139;
        Thu, 21 Feb 2019 18:38:52 +0000 (UTC)
Date:   Thu, 21 Feb 2019 13:38:51 -0500
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
Subject: Re: [PATCH v2 24/26] userfaultfd: wp: UFFDIO_REGISTER_MODE_WP
 documentation update
Message-ID: <20190221183851.GW2813@redhat.com>
References: <20190212025632.28946-1-peterx@redhat.com>
 <20190212025632.28946-25-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190212025632.28946-25-peterx@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 21 Feb 2019 18:39:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 10:56:30AM +0800, Peter Xu wrote:
> From: Martin Cracauer <cracauer@cons.org>
> 
> Adds documentation about the write protection support.
> 
> Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> [peterx: rewrite in rst format; fixups here and there]
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Jérôme Glisse <jglisse@redhat.com>

> ---
>  Documentation/admin-guide/mm/userfaultfd.rst | 51 ++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/Documentation/admin-guide/mm/userfaultfd.rst b/Documentation/admin-guide/mm/userfaultfd.rst
> index 5048cf661a8a..c30176e67900 100644
> --- a/Documentation/admin-guide/mm/userfaultfd.rst
> +++ b/Documentation/admin-guide/mm/userfaultfd.rst
> @@ -108,6 +108,57 @@ UFFDIO_COPY. They're atomic as in guaranteeing that nothing can see an
>  half copied page since it'll keep userfaulting until the copy has
>  finished.
>  
> +Notes:
> +
> +- If you requested UFFDIO_REGISTER_MODE_MISSING when registering then
> +  you must provide some kind of page in your thread after reading from
> +  the uffd.  You must provide either UFFDIO_COPY or UFFDIO_ZEROPAGE.
> +  The normal behavior of the OS automatically providing a zero page on
> +  an annonymous mmaping is not in place.
> +
> +- None of the page-delivering ioctls default to the range that you
> +  registered with.  You must fill in all fields for the appropriate
> +  ioctl struct including the range.
> +
> +- You get the address of the access that triggered the missing page
> +  event out of a struct uffd_msg that you read in the thread from the
> +  uffd.  You can supply as many pages as you want with UFFDIO_COPY or
> +  UFFDIO_ZEROPAGE.  Keep in mind that unless you used DONTWAKE then
> +  the first of any of those IOCTLs wakes up the faulting thread.
> +
> +- Be sure to test for all errors including (pollfd[0].revents &
> +  POLLERR).  This can happen, e.g. when ranges supplied were
> +  incorrect.
> +
> +Write Protect Notifications
> +---------------------------
> +
> +This is equivalent to (but faster than) using mprotect and a SIGSEGV
> +signal handler.
> +
> +Firstly you need to register a range with UFFDIO_REGISTER_MODE_WP.
> +Instead of using mprotect(2) you use ioctl(uffd, UFFDIO_WRITEPROTECT,
> +struct *uffdio_writeprotect) while mode = UFFDIO_WRITEPROTECT_MODE_WP
> +in the struct passed in.  The range does not default to and does not
> +have to be identical to the range you registered with.  You can write
> +protect as many ranges as you like (inside the registered range).
> +Then, in the thread reading from uffd the struct will have
> +msg.arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_WP set. Now you send
> +ioctl(uffd, UFFDIO_WRITEPROTECT, struct *uffdio_writeprotect) again
> +while pagefault.mode does not have UFFDIO_WRITEPROTECT_MODE_WP set.
> +This wakes up the thread which will continue to run with writes. This
> +allows you to do the bookkeeping about the write in the uffd reading
> +thread before the ioctl.
> +
> +If you registered with both UFFDIO_REGISTER_MODE_MISSING and
> +UFFDIO_REGISTER_MODE_WP then you need to think about the sequence in
> +which you supply a page and undo write protect.  Note that there is a
> +difference between writes into a WP area and into a !WP area.  The
> +former will have UFFD_PAGEFAULT_FLAG_WP set, the latter
> +UFFD_PAGEFAULT_FLAG_WRITE.  The latter did not fail on protection but
> +you still need to supply a page when UFFDIO_REGISTER_MODE_MISSING was
> +used.
> +
>  QEMU/KVM
>  ========
>  
> -- 
> 2.17.1
> 
