Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259DDC282F6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA6572087F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfAUKUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 05:20:49 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33648 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726063AbfAUKUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 05:20:48 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0LAEJbf033075
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 05:20:47 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q5bh99wk2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 05:20:47 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Mon, 21 Jan 2019 10:20:45 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 21 Jan 2019 10:20:40 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0LAKdGc43974736
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Jan 2019 10:20:39 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D2B5A4054;
        Mon, 21 Jan 2019 10:20:39 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0F25A405C;
        Mon, 21 Jan 2019 10:20:37 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.206.247])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 21 Jan 2019 10:20:37 +0000 (GMT)
Date:   Mon, 21 Jan 2019 12:20:35 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Martin Cracauer <cracauer@cons.org>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Shaohua Li <shli@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Pavel Emelyanov <xemul@parallels.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH RFC 06/24] userfaultfd: wp: support write protection for
 userfault vma range
References: <20190121075722.7945-1-peterx@redhat.com>
 <20190121075722.7945-7-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121075722.7945-7-peterx@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19012110-0028-0000-0000-0000033BF104
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012110-0029-0000-0000-000023F925D7
Message-Id: <20190121102035.GC19725@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-21_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901210082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 03:57:04PM +0800, Peter Xu wrote:
> From: Shaohua Li <shli@fb.com>
> 
> Add API to enable/disable writeprotect a vma range. Unlike mprotect,
> this doesn't split/merge vmas.
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
> ---
>  include/linux/userfaultfd_k.h |  2 ++
>  mm/userfaultfd.c              | 52 +++++++++++++++++++++++++++++++++++
>  2 files changed, 54 insertions(+)
> 
> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> index 38f748e7186e..e82f3156f4e9 100644
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h
> @@ -37,6 +37,8 @@ extern ssize_t mfill_zeropage(struct mm_struct *dst_mm,
>  			      unsigned long dst_start,
>  			      unsigned long len,
>  			      bool *mmap_changing);
> +extern int mwriteprotect_range(struct mm_struct *dst_mm,
> +		unsigned long start, unsigned long len, bool enable_wp);
> 
>  /* mm helpers */
>  static inline bool is_mergeable_vm_userfaultfd_ctx(struct vm_area_struct *vma,
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 458acda96f20..c38903f501c7 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -615,3 +615,55 @@ ssize_t mfill_zeropage(struct mm_struct *dst_mm, unsigned long start,
>  {
>  	return __mcopy_atomic(dst_mm, start, 0, len, true, mmap_changing);
>  }
> +
> +int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
> +	unsigned long len, bool enable_wp)
> +{
> +	struct vm_area_struct *dst_vma;
> +	pgprot_t newprot;
> +	int err;
> +
> +	/*
> +	 * Sanitize the command parameters:
> +	 */
> +	BUG_ON(start & ~PAGE_MASK);
> +	BUG_ON(len & ~PAGE_MASK);
> +
> +	/* Does the address range wrap, or is the span zero-sized? */
> +	BUG_ON(start + len <= start);
> +
> +	down_read(&dst_mm->mmap_sem);
> +
> +	/*
> +	 * Make sure the vma is not shared, that the dst range is
> +	 * both valid and fully within a single existing vma.
> +	 */
> +	err = -EINVAL;

In non-cooperative mode, there can be a race between VM layout changes and
mcopy_atomic [1]. I believe the same races are possible here, so can we
please make err = -ENOENT for consistency with mcopy?

> +	dst_vma = find_vma(dst_mm, start);
> +	if (!dst_vma || (dst_vma->vm_flags & VM_SHARED))
> +		goto out_unlock;
> +	if (start < dst_vma->vm_start ||
> +	    start + len > dst_vma->vm_end)
> +		goto out_unlock;
> +
> +	if (!dst_vma->vm_userfaultfd_ctx.ctx)
> +		goto out_unlock;
> +	if (!userfaultfd_wp(dst_vma))
> +		goto out_unlock;
> +
> +	if (!vma_is_anonymous(dst_vma))
> +		goto out_unlock;

The sanity checks here seem to repeat those in mcopy_atomic(). I'd suggest
splitting them out to a helper function.

> +	if (enable_wp)
> +		newprot = vm_get_page_prot(dst_vma->vm_flags & ~(VM_WRITE));
> +	else
> +		newprot = vm_get_page_prot(dst_vma->vm_flags);
> +
> +	change_protection(dst_vma, start, start + len, newprot,
> +				!enable_wp, 0);
> +
> +	err = 0;
> +out_unlock:
> +	up_read(&dst_mm->mmap_sem);
> +	return err;
> +}
> -- 
> 2.17.1

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=27d02568f529e908399514dfbee8ee43bdfd5299

-- 
Sincerely yours,
Mike.

