Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5574FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 18:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 352DF2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 18:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbfBYSYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 13:24:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56102 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726921AbfBYSYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 13:24:04 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1PINvl0027900
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 13:24:03 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qvju7s812-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 13:24:02 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Mon, 25 Feb 2019 18:21:12 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Feb 2019 18:21:07 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1PIL6uR23003248
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Feb 2019 18:21:06 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 56DE34203F;
        Mon, 25 Feb 2019 18:21:06 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C20642042;
        Mon, 25 Feb 2019 18:20:58 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.205.26])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 25 Feb 2019 18:20:58 +0000 (GMT)
Date:   Mon, 25 Feb 2019 20:20:45 +0200
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
Subject: Re: [PATCH v2 16/26] userfaultfd: wp: add pmd_swp_*uffd_wp() helpers
References: <20190212025632.28946-1-peterx@redhat.com>
 <20190212025632.28946-17-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212025632.28946-17-peterx@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19022518-0016-0000-0000-0000025ABC11
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022518-0017-0000-0000-000032B51AD2
Message-Id: <20190225182044.GH24917@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-25_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=990 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902250134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 10:56:22AM +0800, Peter Xu wrote:
> Adding these missing helpers for uffd-wp operations with pmd
> swap/migration entries.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  arch/x86/include/asm/pgtable.h     | 15 +++++++++++++++
>  include/asm-generic/pgtable_uffd.h | 15 +++++++++++++++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index 6863236e8484..18a815d6f4ea 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -1401,6 +1401,21 @@ static inline pte_t pte_swp_clear_uffd_wp(pte_t pte)
>  {
>  	return pte_clear_flags(pte, _PAGE_SWP_UFFD_WP);
>  }
> +
> +static inline pmd_t pmd_swp_mkuffd_wp(pmd_t pmd)
> +{
> +	return pmd_set_flags(pmd, _PAGE_SWP_UFFD_WP);
> +}
> +
> +static inline int pmd_swp_uffd_wp(pmd_t pmd)
> +{
> +	return pmd_flags(pmd) & _PAGE_SWP_UFFD_WP;
> +}
> +
> +static inline pmd_t pmd_swp_clear_uffd_wp(pmd_t pmd)
> +{
> +	return pmd_clear_flags(pmd, _PAGE_SWP_UFFD_WP);
> +}
>  #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_WP */
> 
>  #define PKRU_AD_BIT 0x1
> diff --git a/include/asm-generic/pgtable_uffd.h b/include/asm-generic/pgtable_uffd.h
> index 643d1bf559c2..828966d4c281 100644
> --- a/include/asm-generic/pgtable_uffd.h
> +++ b/include/asm-generic/pgtable_uffd.h
> @@ -46,6 +46,21 @@ static __always_inline pte_t pte_swp_clear_uffd_wp(pte_t pte)
>  {
>  	return pte;
>  }
> +
> +static inline pmd_t pmd_swp_mkuffd_wp(pmd_t pmd)
> +{
> +	return pmd;
> +}
> +
> +static inline int pmd_swp_uffd_wp(pmd_t pmd)
> +{
> +	return 0;
> +}
> +
> +static inline pmd_t pmd_swp_clear_uffd_wp(pmd_t pmd)
> +{
> +	return pmd;
> +}
>  #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_WP */
> 
>  #endif /* _ASM_GENERIC_PGTABLE_UFFD_H */
> -- 
> 2.17.1
> 

-- 
Sincerely yours,
Mike.

