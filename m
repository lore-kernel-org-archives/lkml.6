Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90AF1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 18:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EA26213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 18:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbfBYSuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 13:50:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35428 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726765AbfBYSue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 13:50:34 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1PIifVg053388
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 13:50:33 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qvkjyrahv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 13:50:33 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Mon, 25 Feb 2019 18:50:30 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Feb 2019 18:50:25 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1PIoOGF58130614
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Feb 2019 18:50:24 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A385AE051;
        Mon, 25 Feb 2019 18:50:24 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1AEC3AE055;
        Mon, 25 Feb 2019 18:50:20 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.205.26])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 25 Feb 2019 18:50:19 +0000 (GMT)
Date:   Mon, 25 Feb 2019 20:50:15 +0200
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
Subject: Re: [PATCH v2 18/26] khugepaged: skip collapse if uffd-wp detected
References: <20190212025632.28946-1-peterx@redhat.com>
 <20190212025632.28946-19-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212025632.28946-19-peterx@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19022518-0020-0000-0000-0000031B173B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022518-0021-0000-0000-0000216C796A
Message-Id: <20190225185015.GK24917@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-25_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902250136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 10:56:24AM +0800, Peter Xu wrote:
> Don't collapse the huge PMD if there is any userfault write protected
> small PTEs.  The problem is that the write protection is in small page
> granularity and there's no way to keep all these write protection
> information if the small pages are going to be merged into a huge PMD.
> 
> The same thing needs to be considered for swap entries and migration
> entries.  So do the check as well disregarding khugepaged_max_ptes_swap.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  include/trace/events/huge_memory.h |  1 +
>  mm/khugepaged.c                    | 23 +++++++++++++++++++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
> index dd4db334bd63..2d7bad9cb976 100644
> --- a/include/trace/events/huge_memory.h
> +++ b/include/trace/events/huge_memory.h
> @@ -13,6 +13,7 @@
>  	EM( SCAN_PMD_NULL,		"pmd_null")			\
>  	EM( SCAN_EXCEED_NONE_PTE,	"exceed_none_pte")		\
>  	EM( SCAN_PTE_NON_PRESENT,	"pte_non_present")		\
> +	EM( SCAN_PTE_UFFD_WP,		"pte_uffd_wp")			\
>  	EM( SCAN_PAGE_RO,		"no_writable_page")		\
>  	EM( SCAN_LACK_REFERENCED_PAGE,	"lack_referenced_page")		\
>  	EM( SCAN_PAGE_NULL,		"page_null")			\
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 4f017339ddb2..396c7e4da83e 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -29,6 +29,7 @@ enum scan_result {
>  	SCAN_PMD_NULL,
>  	SCAN_EXCEED_NONE_PTE,
>  	SCAN_PTE_NON_PRESENT,
> +	SCAN_PTE_UFFD_WP,
>  	SCAN_PAGE_RO,
>  	SCAN_LACK_REFERENCED_PAGE,
>  	SCAN_PAGE_NULL,
> @@ -1123,6 +1124,15 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
>  		pte_t pteval = *_pte;
>  		if (is_swap_pte(pteval)) {
>  			if (++unmapped <= khugepaged_max_ptes_swap) {
> +				/*
> +				 * Always be strict with uffd-wp
> +				 * enabled swap entries.  Please see
> +				 * comment below for pte_uffd_wp().
> +				 */
> +				if (pte_swp_uffd_wp(pteval)) {
> +					result = SCAN_PTE_UFFD_WP;
> +					goto out_unmap;
> +				}
>  				continue;
>  			} else {
>  				result = SCAN_EXCEED_SWAP_PTE;
> @@ -1142,6 +1152,19 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
>  			result = SCAN_PTE_NON_PRESENT;
>  			goto out_unmap;
>  		}
> +		if (pte_uffd_wp(pteval)) {
> +			/*
> +			 * Don't collapse the page if any of the small
> +			 * PTEs are armed with uffd write protection.
> +			 * Here we can also mark the new huge pmd as
> +			 * write protected if any of the small ones is
> +			 * marked but that could bring uknown
> +			 * userfault messages that falls outside of
> +			 * the registered range.  So, just be simple.
> +			 */
> +			result = SCAN_PTE_UFFD_WP;
> +			goto out_unmap;
> +		}
>  		if (pte_write(pteval))
>  			writable = true;
> 
> -- 
> 2.17.1
> 

-- 
Sincerely yours,
Mike.

