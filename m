Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3CFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98DC42081B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfBUShE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 13:37:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40342 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbfBUShE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 13:37:04 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3E3DF3086275;
        Thu, 21 Feb 2019 18:37:03 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EA0B460139;
        Thu, 21 Feb 2019 18:36:55 +0000 (UTC)
Date:   Thu, 21 Feb 2019 13:36:54 -0500
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
Subject: Re: [PATCH v2 23/26] userfaultfd: wp: don't wake up when doing write
 protect
Message-ID: <20190221183653.GV2813@redhat.com>
References: <20190212025632.28946-1-peterx@redhat.com>
 <20190212025632.28946-24-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212025632.28946-24-peterx@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 21 Feb 2019 18:37:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 10:56:29AM +0800, Peter Xu wrote:
> It does not make sense to try to wake up any waiting thread when we're
> write-protecting a memory region.  Only wake up when resolving a write
> protected page fault.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

I am bit confuse here, see below.

> ---
>  fs/userfaultfd.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 81962d62520c..f1f61a0278c2 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -1771,6 +1771,7 @@ static int userfaultfd_writeprotect(struct userfaultfd_ctx *ctx,
>  	struct uffdio_writeprotect uffdio_wp;
>  	struct uffdio_writeprotect __user *user_uffdio_wp;
>  	struct userfaultfd_wake_range range;
> +	bool mode_wp, mode_dontwake;
>  
>  	if (READ_ONCE(ctx->mmap_changing))
>  		return -EAGAIN;
> @@ -1789,18 +1790,20 @@ static int userfaultfd_writeprotect(struct userfaultfd_ctx *ctx,
>  	if (uffdio_wp.mode & ~(UFFDIO_WRITEPROTECT_MODE_DONTWAKE |
>  			       UFFDIO_WRITEPROTECT_MODE_WP))
>  		return -EINVAL;
> -	if ((uffdio_wp.mode & UFFDIO_WRITEPROTECT_MODE_WP) &&
> -	     (uffdio_wp.mode & UFFDIO_WRITEPROTECT_MODE_DONTWAKE))
> +
> +	mode_wp = uffdio_wp.mode & UFFDIO_WRITEPROTECT_MODE_WP;
> +	mode_dontwake = uffdio_wp.mode & UFFDIO_WRITEPROTECT_MODE_DONTWAKE;
> +
> +	if (mode_wp && mode_dontwake)
>  		return -EINVAL;

I am confuse by the logic here. DONTWAKE means do not wake any waiting
thread right ? So if the patch header it seems to me the logic should
be:
    if (mode_wp && !mode_dontwake)
        return -EINVAL;

At very least this part does seems to mean the opposite of what the
commit message says.

>  
>  	ret = mwriteprotect_range(ctx->mm, uffdio_wp.range.start,
> -				  uffdio_wp.range.len, uffdio_wp.mode &
> -				  UFFDIO_WRITEPROTECT_MODE_WP,
> +				  uffdio_wp.range.len, mode_wp,
>  				  &ctx->mmap_changing);
>  	if (ret)
>  		return ret;
>  
> -	if (!(uffdio_wp.mode & UFFDIO_WRITEPROTECT_MODE_DONTWAKE)) {
> +	if (!mode_wp && !mode_dontwake) {

This part match the commit message :)

>  		range.start = uffdio_wp.range.start;
>  		range.len = uffdio_wp.range.len;
>  		wake_userfault(ctx, &range);
