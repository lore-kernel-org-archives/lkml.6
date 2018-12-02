Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AC8C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 11:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AEEB2082F
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 11:13:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AEEB2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725843AbeLBLNg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 06:13:36 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47906 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725776AbeLBLNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 06:13:35 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wB2B9PZW105808
        for <linux-kernel@vger.kernel.org>; Sun, 2 Dec 2018 06:13:32 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2p482s2ctw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 06:13:32 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Sun, 2 Dec 2018 11:13:30 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 2 Dec 2018 11:13:19 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wB2BDIJg3277230
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 2 Dec 2018 11:13:19 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA75B42045;
        Sun,  2 Dec 2018 11:13:18 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC8B042041;
        Sun,  2 Dec 2018 11:13:15 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.204.137])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun,  2 Dec 2018 11:13:15 +0000 (GMT)
Date:   Sun, 2 Dec 2018 13:13:13 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        kirill.shutemov@linux.intel.com, vbabka@suse.cz, riel@surriel.com,
        sfr@canb.auug.org.au, rppt@linux.vnet.ibm.com,
        peterz@infradead.org, linux@armlinux.org.uk, robin.murphy@arm.com,
        iamjoonsoo.kim@lge.com, treding@nvidia.com, keescook@chromium.org,
        m.szyprowski@samsung.com, stefanr@s5r6.in-berlin.de,
        hjc@rock-chips.com, heiko@sntech.de, airlied@linux.ie,
        oleksandr_andrushchenko@epam.com, joro@8bytes.org,
        pawel@osciak.com, kyungmin.park@samsung.com, mchehab@kernel.org,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linux1394-devel@lists.sourceforge.net,
        dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, xen-devel@lists.xen.org,
        iommu@lists.linux-foundation.org, linux-media@vger.kernel.org
Subject: Re: [PATCH v2 1/9] mm: Introduce new vm_insert_range API
References: <20181202061944.GA3094@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181202061944.GA3094@jordon-HP-15-Notebook-PC>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18120211-0020-0000-0000-000002F0E7FC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120211-0021-0000-0000-00002140544B
Message-Id: <20181202111313.GC6959@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-02_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812020110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 02, 2018 at 11:49:44AM +0530, Souptick Joarder wrote:
> Previouly drivers have their own way of mapping range of
> kernel pages/memory into user vma and this was done by
> invoking vm_insert_page() within a loop.
> 
> As this pattern is common across different drivers, it can
> be generalized by creating a new function and use it across
> the drivers.
> 
> vm_insert_range is the new API which will be used to map a
> range of kernel memory/pages to user vma.
> 
> This API is tested by Heiko for Rockchip drm driver, on rk3188,
> rk3288, rk3328 and rk3399 with graphics.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Reviewed-by: Matthew Wilcox <willy@infradead.org>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  include/linux/mm_types.h |  3 +++
>  mm/memory.c              | 38 ++++++++++++++++++++++++++++++++++++++
>  mm/nommu.c               |  7 +++++++
>  3 files changed, 48 insertions(+)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 5ed8f62..15ae24f 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -523,6 +523,9 @@ extern void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
>  extern void tlb_finish_mmu(struct mmu_gather *tlb,
>  				unsigned long start, unsigned long end);
> 
> +int vm_insert_range(struct vm_area_struct *vma, unsigned long addr,
> +			struct page **pages, unsigned long page_count);
> +

This seem to belong to include/linux/mm.h, near vm_insert_page()

>  static inline void init_tlb_flush_pending(struct mm_struct *mm)
>  {
>  	atomic_set(&mm->tlb_flush_pending, 0);
> diff --git a/mm/memory.c b/mm/memory.c
> index 15c417e..84ea46c 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1478,6 +1478,44 @@ static int insert_page(struct vm_area_struct *vma, unsigned long addr,
>  }
> 
>  /**
> + * vm_insert_range - insert range of kernel pages into user vma
> + * @vma: user vma to map to
> + * @addr: target user address of this page
> + * @pages: pointer to array of source kernel pages
> + * @page_count: number of pages need to insert into user vma
> + *
> + * This allows drivers to insert range of kernel pages they've allocated
> + * into a user vma. This is a generic function which drivers can use
> + * rather than using their own way of mapping range of kernel pages into
> + * user vma.
> + *
> + * If we fail to insert any page into the vma, the function will return
> + * immediately leaving any previously-inserted pages present.  Callers
> + * from the mmap handler may immediately return the error as their caller
> + * will destroy the vma, removing any successfully-inserted pages. Other
> + * callers should make their own arrangements for calling unmap_region().
> + *
> + * Context: Process context. Called by mmap handlers.
> + * Return: 0 on success and error code otherwise
> + */
> +int vm_insert_range(struct vm_area_struct *vma, unsigned long addr,
> +			struct page **pages, unsigned long page_count)
> +{
> +	unsigned long uaddr = addr;
> +	int ret = 0, i;
> +
> +	for (i = 0; i < page_count; i++) {
> +		ret = vm_insert_page(vma, uaddr, pages[i]);
> +		if (ret < 0)
> +			return ret;
> +		uaddr += PAGE_SIZE;
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(vm_insert_range);
> +
> +/**
>   * vm_insert_page - insert single page into user vma
>   * @vma: user vma to map to
>   * @addr: target user address of this page
> diff --git a/mm/nommu.c b/mm/nommu.c
> index 749276b..d6ef5c7 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -473,6 +473,13 @@ int vm_insert_page(struct vm_area_struct *vma, unsigned long addr,
>  }
>  EXPORT_SYMBOL(vm_insert_page);
> 
> +int vm_insert_range(struct vm_area_struct *vma, unsigned long addr,
> +			struct page **pages, unsigned long page_count)
> +{
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL(vm_insert_range);
> +
>  /*
>   *  sys_brk() for the most part doesn't need the global kernel
>   *  lock, except when an application is doing something nasty
> -- 
> 1.9.1
> 

-- 
Sincerely yours,
Mike.

