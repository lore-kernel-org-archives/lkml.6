Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99C9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C053A20818
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbfBUS2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 13:28:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59138 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbfBUS2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 13:28:34 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9EE1B5AFE3;
        Thu, 21 Feb 2019 18:28:33 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 590065D704;
        Thu, 21 Feb 2019 18:28:27 +0000 (UTC)
Date:   Thu, 21 Feb 2019 13:28:25 -0500
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
Subject: Re: [PATCH v2 21/26] userfaultfd: wp: add the writeprotect API to
 userfaultfd ioctl
Message-ID: <20190221182825.GA4198@redhat.com>
References: <20190212025632.28946-1-peterx@redhat.com>
 <20190212025632.28946-22-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190212025632.28946-22-peterx@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 21 Feb 2019 18:28:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 10:56:27AM +0800, Peter Xu wrote:
> From: Andrea Arcangeli <aarcange@redhat.com>
> 
> v1: From: Shaohua Li <shli@fb.com>
> 
> v2: cleanups, remove a branch.
> 
> [peterx writes up the commit message, as below...]
> 
> This patch introduces the new uffd-wp APIs for userspace.
> 
> Firstly, we'll allow to do UFFDIO_REGISTER with write protection
> tracking using the new UFFDIO_REGISTER_MODE_WP flag.  Note that this
> flag can co-exist with the existing UFFDIO_REGISTER_MODE_MISSING, in
> which case the userspace program can not only resolve missing page
> faults, and at the same time tracking page data changes along the way.
> 
> Secondly, we introduced the new UFFDIO_WRITEPROTECT API to do page
> level write protection tracking.  Note that we will need to register
> the memory region with UFFDIO_REGISTER_MODE_WP before that.
> 
> Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> [peterx: remove useless block, write commit message, check against
>  VM_MAYWRITE rather than VM_WRITE when register]
> Signed-off-by: Peter Xu <peterx@redhat.com>

I am not an expert with userfaultfd code but it looks good to me so:

Also see my question down below, just a minor one.

Reviewed-by: Jérôme Glisse <jglisse@redhat.com>

> ---
>  fs/userfaultfd.c                 | 82 +++++++++++++++++++++++++-------
>  include/uapi/linux/userfaultfd.h | 11 +++++
>  2 files changed, 77 insertions(+), 16 deletions(-)
> 

[...]

> diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
> index 297cb044c03f..1b977a7a4435 100644
> --- a/include/uapi/linux/userfaultfd.h
> +++ b/include/uapi/linux/userfaultfd.h
> @@ -52,6 +52,7 @@
>  #define _UFFDIO_WAKE			(0x02)
>  #define _UFFDIO_COPY			(0x03)
>  #define _UFFDIO_ZEROPAGE		(0x04)
> +#define _UFFDIO_WRITEPROTECT		(0x06)
>  #define _UFFDIO_API			(0x3F)

What did happen to ioctl 0x05 ? :)
