Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A498CC10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 20:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 716762087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 20:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbfBYUsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 15:48:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38230 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727230AbfBYUsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 15:48:31 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1PKiLhC099902
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 15:48:29 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qvnuvngbs-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 15:48:29 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Mon, 25 Feb 2019 20:48:27 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Feb 2019 20:48:22 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1PKmLPL30670850
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Feb 2019 20:48:21 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 13A2C11C064;
        Mon, 25 Feb 2019 20:48:21 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 743B411C04C;
        Mon, 25 Feb 2019 20:48:18 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.204.243])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 25 Feb 2019 20:48:18 +0000 (GMT)
Date:   Mon, 25 Feb 2019 22:48:15 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
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
Subject: Re: [PATCH v2 19/26] userfaultfd: introduce helper vma_find_uffd
References: <20190212025632.28946-1-peterx@redhat.com>
 <20190212025632.28946-20-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212025632.28946-20-peterx@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19022520-0012-0000-0000-000002FA0E9C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022520-0013-0000-0000-00002131B02E
Message-Id: <20190225204815.GB10454@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-25_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=956 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902250149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 10:56:25AM +0800, Peter Xu wrote:
> We've have multiple (and more coming) places that would like to find a
> userfault enabled VMA from a mm struct that covers a specific memory
> range.  This patch introduce the helper for it, meanwhile apply it to
> the code.
> 
> Suggested-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  mm/userfaultfd.c | 54 +++++++++++++++++++++++++++---------------------
>  1 file changed, 30 insertions(+), 24 deletions(-)
> 
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 80bcd642911d..fefa81c301b7 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -20,6 +20,34 @@
>  #include <asm/tlbflush.h>
>  #include "internal.h"
> 
> +/*
> + * Find a valid userfault enabled VMA region that covers the whole
> + * address range, or NULL on failure.  Must be called with mmap_sem
> + * held.
> + */
> +static struct vm_area_struct *vma_find_uffd(struct mm_struct *mm,
> +					    unsigned long start,
> +					    unsigned long len)
> +{
> +	struct vm_area_struct *vma = find_vma(mm, start);
> +
> +	if (!vma)
> +		return NULL;
> +
> +	/*
> +	 * Check the vma is registered in uffd, this is required to
> +	 * enforce the VM_MAYWRITE check done at uffd registration
> +	 * time.
> +	 */
> +	if (!vma->vm_userfaultfd_ctx.ctx)
> +		return NULL;
> +
> +	if (start < vma->vm_start || start + len > vma->vm_end)
> +		return NULL;
> +
> +	return vma;
> +}
> +
>  static int mcopy_atomic_pte(struct mm_struct *dst_mm,
>  			    pmd_t *dst_pmd,
>  			    struct vm_area_struct *dst_vma,
> @@ -228,20 +256,9 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
>  	 */
>  	if (!dst_vma) {
>  		err = -ENOENT;
> -		dst_vma = find_vma(dst_mm, dst_start);
> +		dst_vma = vma_find_uffd(dst_mm, dst_start, len);
>  		if (!dst_vma || !is_vm_hugetlb_page(dst_vma))
>  			goto out_unlock;
> -		/*
> -		 * Check the vma is registered in uffd, this is
> -		 * required to enforce the VM_MAYWRITE check done at
> -		 * uffd registration time.
> -		 */
> -		if (!dst_vma->vm_userfaultfd_ctx.ctx)
> -			goto out_unlock;
> -
> -		if (dst_start < dst_vma->vm_start ||
> -		    dst_start + len > dst_vma->vm_end)
> -			goto out_unlock;
> 
>  		err = -EINVAL;
>  		if (vma_hpagesize != vma_kernel_pagesize(dst_vma))
> @@ -488,20 +505,9 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
>  	 * both valid and fully within a single existing vma.
>  	 */
>  	err = -ENOENT;
> -	dst_vma = find_vma(dst_mm, dst_start);
> +	dst_vma = vma_find_uffd(dst_mm, dst_start, len);
>  	if (!dst_vma)
>  		goto out_unlock;
> -	/*
> -	 * Check the vma is registered in uffd, this is required to
> -	 * enforce the VM_MAYWRITE check done at uffd registration
> -	 * time.
> -	 */
> -	if (!dst_vma->vm_userfaultfd_ctx.ctx)
> -		goto out_unlock;
> -
> -	if (dst_start < dst_vma->vm_start ||
> -	    dst_start + len > dst_vma->vm_end)
> -		goto out_unlock;
> 
>  	err = -EINVAL;
>  	/*
> -- 
> 2.17.1
> 

-- 
Sincerely yours,
Mike.

