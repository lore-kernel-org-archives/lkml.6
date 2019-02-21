Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD77C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D39420818
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbfBUS3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 13:29:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52648 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728326AbfBUS3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 13:29:38 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9471637E74;
        Thu, 21 Feb 2019 18:29:38 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B4035D9E1;
        Thu, 21 Feb 2019 18:29:27 +0000 (UTC)
Date:   Thu, 21 Feb 2019 13:29:26 -0500
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
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Pavel Emelyanov <xemul@parallels.com>,
        Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH v2 22/26] userfaultfd: wp: enabled write protection in
 userfaultfd API
Message-ID: <20190221182926.GU2813@redhat.com>
References: <20190212025632.28946-1-peterx@redhat.com>
 <20190212025632.28946-23-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190212025632.28946-23-peterx@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 21 Feb 2019 18:29:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 10:56:28AM +0800, Peter Xu wrote:
> From: Shaohua Li <shli@fb.com>
> 
> Now it's safe to enable write protection in userfaultfd API
> 
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Pavel Emelyanov <xemul@parallels.com>
> Cc: Rik van Riel <riel@redhat.com>
> Cc: Kirill A. Shutemov <kirill@shutemov.name>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Shaohua Li <shli@fb.com>
> Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Maybe fold that patch with the previous one ? In any case:

Reviewed-by: Jérôme Glisse <jglisse@redhat.com>

> ---
>  include/uapi/linux/userfaultfd.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
> index 1b977a7a4435..a50f1ed24d23 100644
> --- a/include/uapi/linux/userfaultfd.h
> +++ b/include/uapi/linux/userfaultfd.h
> @@ -19,7 +19,8 @@
>   * means the userland is reading).
>   */
>  #define UFFD_API ((__u64)0xAA)
> -#define UFFD_API_FEATURES (UFFD_FEATURE_EVENT_FORK |		\
> +#define UFFD_API_FEATURES (UFFD_FEATURE_PAGEFAULT_FLAG_WP |	\
> +			   UFFD_FEATURE_EVENT_FORK |		\
>  			   UFFD_FEATURE_EVENT_REMAP |		\
>  			   UFFD_FEATURE_EVENT_REMOVE |	\
>  			   UFFD_FEATURE_EVENT_UNMAP |		\
> @@ -34,7 +35,8 @@
>  #define UFFD_API_RANGE_IOCTLS			\
>  	((__u64)1 << _UFFDIO_WAKE |		\
>  	 (__u64)1 << _UFFDIO_COPY |		\
> -	 (__u64)1 << _UFFDIO_ZEROPAGE)
> +	 (__u64)1 << _UFFDIO_ZEROPAGE |		\
> +	 (__u64)1 << _UFFDIO_WRITEPROTECT)
>  #define UFFD_API_RANGE_IOCTLS_BASIC		\
>  	((__u64)1 << _UFFDIO_WAKE |		\
>  	 (__u64)1 << _UFFDIO_COPY)
> -- 
> 2.17.1
> 
