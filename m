Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E3DECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38E5E20874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:22:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38E5E20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388431AbeGXR33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:29:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48218 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388389AbeGXR33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:29:29 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6OGIsQC112904
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 12:22:14 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ke41msnbb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 12:22:14 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ldufour@linux.vnet.ibm.com>;
        Tue, 24 Jul 2018 17:22:11 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 24 Jul 2018 17:22:08 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6OGM7Cp36241484
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 24 Jul 2018 16:22:07 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45BEF52052;
        Tue, 24 Jul 2018 19:22:22 +0100 (BST)
Received: from [9.145.45.110] (unknown [9.145.45.110])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id CA9C852050;
        Tue, 24 Jul 2018 19:22:21 +0100 (BST)
Subject: Re: [RFC v5 PATCH 1/2] mm: refactor do_munmap() to extract the common
 part
To:     Yang Shi <yang.shi@linux.alibaba.com>, mhocko@kernel.org,
        willy@infradead.org, kirill@shutemov.name,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1531956101-8526-1-git-send-email-yang.shi@linux.alibaba.com>
 <1531956101-8526-2-git-send-email-yang.shi@linux.alibaba.com>
From:   Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date:   Tue, 24 Jul 2018 18:22:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1531956101-8526-2-git-send-email-yang.shi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18072416-0028-0000-0000-000002DF9D05
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072416-0029-0000-0000-000023978420
Message-Id: <32ce6f0e-2c48-a54f-9839-baf7d11c48fe@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-24_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807240172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2018 01:21, Yang Shi wrote:
> Introduces three new helper functions:
>   * munmap_addr_sanity()
>   * munmap_lookup_vma()
>   * munmap_mlock_vma()
> 
> They will be used by do_munmap() and the new do_munmap with zapping
> large mapping early in the later patch.
> 
> There is no functional change, just code refactor.
> 
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>

FWIW : Reviewed-by : Laurent Dufour <ldufour@linux.vnet.ibm.com>

> ---
>  mm/mmap.c | 120 ++++++++++++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 82 insertions(+), 38 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index d1eb87e..2504094 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2686,34 +2686,44 @@ int split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
>  	return __split_vma(mm, vma, addr, new_below);
>  }
> 
> -/* Munmap is split into 2 main parts -- this part which finds
> - * what needs doing, and the areas themselves, which do the
> - * work.  This now handles partial unmappings.
> - * Jeremy Fitzhardinge <jeremy@goop.org>
> - */
> -int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
> -	      struct list_head *uf)
> +static inline bool munmap_addr_sanity(unsigned long start, size_t len)
>  {
> -	unsigned long end;
> -	struct vm_area_struct *vma, *prev, *last;
> -
>  	if ((offset_in_page(start)) || start > TASK_SIZE || len > TASK_SIZE-start)
> -		return -EINVAL;
> +		return false;
> 
> -	len = PAGE_ALIGN(len);
> -	if (len == 0)
> -		return -EINVAL;
> +	if (PAGE_ALIGN(len) == 0)
> +		return false;
> +
> +	return true;
> +}
> +
> +/*
> + * munmap_lookup_vma: find the first overlap vma and split overlap vmas.
> + * @mm: mm_struct
> + * @vma: the first overlapping vma
> + * @prev: vma's prev
> + * @start: start address
> + * @end: end address
> + *
> + * returns 1 if successful, 0 or errno otherwise
> + */
> +static int munmap_lookup_vma(struct mm_struct *mm, struct vm_area_struct **vma,
> +			     struct vm_area_struct **prev, unsigned long start,
> +			     unsigned long end)
> +{
> +	struct vm_area_struct *tmp, *last;
> 
>  	/* Find the first overlapping VMA */
> -	vma = find_vma(mm, start);
> -	if (!vma)
> +	tmp = find_vma(mm, start);
> +	if (!tmp)
>  		return 0;
> -	prev = vma->vm_prev;
> -	/* we have  start < vma->vm_end  */
> +
> +	*prev = tmp->vm_prev;
> +
> +	/* we have start < vma->vm_end  */
> 
>  	/* if it doesn't overlap, we have nothing.. */
> -	end = start + len;
> -	if (vma->vm_start >= end)
> +	if (tmp->vm_start >= end)
>  		return 0;
> 
>  	/*
> @@ -2723,7 +2733,7 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
>  	 * unmapped vm_area_struct will remain in use: so lower split_vma
>  	 * places tmp vma above, and higher split_vma places tmp vma below.
>  	 */
> -	if (start > vma->vm_start) {
> +	if (start > tmp->vm_start) {
>  		int error;
> 
>  		/*
> @@ -2731,13 +2741,14 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
>  		 * not exceed its limit; but let map_count go just above
>  		 * its limit temporarily, to help free resources as expected.
>  		 */
> -		if (end < vma->vm_end && mm->map_count >= sysctl_max_map_count)
> +		if (end < tmp->vm_end &&
> +		    mm->map_count > sysctl_max_map_count)
>  			return -ENOMEM;
> 
> -		error = __split_vma(mm, vma, start, 0);
> +		error = __split_vma(mm, tmp, start, 0);
>  		if (error)
>  			return error;
> -		prev = vma;
> +		*prev = tmp;
>  	}
> 
>  	/* Does it split the last one? */
> @@ -2747,7 +2758,48 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
>  		if (error)
>  			return error;
>  	}
> -	vma = prev ? prev->vm_next : mm->mmap;
> +
> +	*vma = *prev ? (*prev)->vm_next : mm->mmap;
> +
> +	return 1;
> +}
> +
> +static inline void munmap_mlock_vma(struct vm_area_struct *vma,
> +				    unsigned long end)
> +{
> +	struct vm_area_struct *tmp = vma;
> +
> +	while (tmp && tmp->vm_start < end) {
> +		if (tmp->vm_flags & VM_LOCKED) {
> +			vma->vm_mm->locked_vm -= vma_pages(tmp);
> +			munlock_vma_pages_all(tmp);
> +		}
> +		tmp = tmp->vm_next;
> +	}
> +}
> +
> +/* Munmap is split into 2 main parts -- this part which finds
> + * what needs doing, and the areas themselves, which do the
> + * work.  This now handles partial unmappings.
> + * Jeremy Fitzhardinge <jeremy@goop.org>
> + */
> +int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
> +	      struct list_head *uf)
> +{
> +	unsigned long end;
> +	struct vm_area_struct *vma = NULL, *prev;
> +	int ret = 0;
> +
> +	if (!munmap_addr_sanity(start, len))
> +		return -EINVAL;
> +
> +	len = PAGE_ALIGN(len);
> +
> +	end = start + len;
> +
> +	ret = munmap_lookup_vma(mm, &vma, &prev, start, end);
> +	if (ret != 1)
> +		return ret;
> 
>  	if (unlikely(uf)) {
>  		/*
> @@ -2759,24 +2811,16 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
>  		 * split, despite we could. This is unlikely enough
>  		 * failure that it's not worth optimizing it for.
>  		 */
> -		int error = userfaultfd_unmap_prep(vma, start, end, uf);
> -		if (error)
> -			return error;
> +		ret = userfaultfd_unmap_prep(vma, start, end, uf);
> +		if (ret)
> +			return ret;
>  	}
> 
>  	/*
>  	 * unlock any mlock()ed ranges before detaching vmas
>  	 */
> -	if (mm->locked_vm) {
> -		struct vm_area_struct *tmp = vma;
> -		while (tmp && tmp->vm_start < end) {
> -			if (tmp->vm_flags & VM_LOCKED) {
> -				mm->locked_vm -= vma_pages(tmp);
> -				munlock_vma_pages_all(tmp);
> -			}
> -			tmp = tmp->vm_next;
> -		}
> -	}
> +	if (mm->locked_vm)
> +		munmap_mlock_vma(vma, end);
> 
>  	/*
>  	 * Remove the vma's, and unmap the actual pages
> 

