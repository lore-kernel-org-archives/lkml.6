Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD489C10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 893B720C01
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbfBYRMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 12:12:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53714 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728314AbfBYRMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 12:12:30 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1PHAuLn075177
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 12:12:29 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qvkjdkemv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 12:12:28 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Mon, 25 Feb 2019 17:12:26 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Feb 2019 17:12:20 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1PHCJg534013366
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Feb 2019 17:12:19 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 41269A4055;
        Mon, 25 Feb 2019 17:12:19 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6BCCCA4040;
        Mon, 25 Feb 2019 17:12:17 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.205.26])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 25 Feb 2019 17:12:17 +0000 (GMT)
Date:   Mon, 25 Feb 2019 19:12:15 +0200
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
Subject: Re: [PATCH v2 09/26] userfaultfd: wp: userfaultfd_pte/huge_pmd_wp()
 helpers
References: <20190212025632.28946-1-peterx@redhat.com>
 <20190212025632.28946-10-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212025632.28946-10-peterx@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19022517-0012-0000-0000-000002F9FF50
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022517-0013-0000-0000-00002131A072
Message-Id: <20190225171214.GE24917@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-25_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902250126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 10:56:15AM +0800, Peter Xu wrote:
> From: Andrea Arcangeli <aarcange@redhat.com>
> 
> Implement helpers methods to invoke userfaultfd wp faults more
> selectively: not only when a wp fault triggers on a vma with
> vma->vm_flags VM_UFFD_WP set, but only if the _PAGE_UFFD_WP bit is set
> in the pagetable too.
> 
> Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  include/linux/userfaultfd_k.h | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> index 38f748e7186e..c6590c58ce28 100644
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h
> @@ -14,6 +14,8 @@
>  #include <linux/userfaultfd.h> /* linux/include/uapi/linux/userfaultfd.h */
> 
>  #include <linux/fcntl.h>
> +#include <linux/mm.h>
> +#include <asm-generic/pgtable_uffd.h>
> 
>  /*
>   * CAREFUL: Check include/uapi/asm-generic/fcntl.h when defining
> @@ -55,6 +57,18 @@ static inline bool userfaultfd_wp(struct vm_area_struct *vma)
>  	return vma->vm_flags & VM_UFFD_WP;
>  }
> 
> +static inline bool userfaultfd_pte_wp(struct vm_area_struct *vma,
> +				      pte_t pte)
> +{
> +	return userfaultfd_wp(vma) && pte_uffd_wp(pte);
> +}
> +
> +static inline bool userfaultfd_huge_pmd_wp(struct vm_area_struct *vma,
> +					   pmd_t pmd)
> +{
> +	return userfaultfd_wp(vma) && pmd_uffd_wp(pmd);
> +}
> +
>  static inline bool userfaultfd_armed(struct vm_area_struct *vma)
>  {
>  	return vma->vm_flags & (VM_UFFD_MISSING | VM_UFFD_WP);
> @@ -104,6 +118,19 @@ static inline bool userfaultfd_wp(struct vm_area_struct *vma)
>  	return false;
>  }
> 
> +static inline bool userfaultfd_pte_wp(struct vm_area_struct *vma,
> +				      pte_t pte)
> +{
> +	return false;
> +}
> +
> +static inline bool userfaultfd_huge_pmd_wp(struct vm_area_struct *vma,
> +					   pmd_t pmd)
> +{
> +	return false;
> +}
> +
> +
>  static inline bool userfaultfd_armed(struct vm_area_struct *vma)
>  {
>  	return false;
> -- 
> 2.17.1
> 

-- 
Sincerely yours,
Mike.

