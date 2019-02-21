Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E73AC00319
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FC412084F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbfBUQIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 11:08:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33904 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbfBUQIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 11:08:09 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8E50F3001D5F;
        Thu, 21 Feb 2019 16:08:08 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1988260C18;
        Thu, 21 Feb 2019 16:07:59 +0000 (UTC)
Date:   Thu, 21 Feb 2019 11:07:58 -0500
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
Subject: Re: [PATCH v2 06/26] userfaultfd: wp: add helper for writeprotect
 check
Message-ID: <20190221160757.GF2813@redhat.com>
References: <20190212025632.28946-1-peterx@redhat.com>
 <20190212025632.28946-7-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190212025632.28946-7-peterx@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 21 Feb 2019 16:08:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 10:56:12AM +0800, Peter Xu wrote:
> From: Shaohua Li <shli@fb.com>
> 
> add helper for writeprotect check. Will use it later.
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

Reviewed-by: Jérôme Glisse <jglisse@redhat.com>

> ---
>  include/linux/userfaultfd_k.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> index 37c9eba75c98..38f748e7186e 100644
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h
> @@ -50,6 +50,11 @@ static inline bool userfaultfd_missing(struct vm_area_struct *vma)
>  	return vma->vm_flags & VM_UFFD_MISSING;
>  }
>  
> +static inline bool userfaultfd_wp(struct vm_area_struct *vma)
> +{
> +	return vma->vm_flags & VM_UFFD_WP;
> +}
> +
>  static inline bool userfaultfd_armed(struct vm_area_struct *vma)
>  {
>  	return vma->vm_flags & (VM_UFFD_MISSING | VM_UFFD_WP);
> @@ -94,6 +99,11 @@ static inline bool userfaultfd_missing(struct vm_area_struct *vma)
>  	return false;
>  }
>  
> +static inline bool userfaultfd_wp(struct vm_area_struct *vma)
> +{
> +	return false;
> +}
> +
>  static inline bool userfaultfd_armed(struct vm_area_struct *vma)
>  {
>  	return false;
> -- 
> 2.17.1
> 
