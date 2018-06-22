Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DACC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EBAE23E88
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:00:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EBAE23E88
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751423AbeFVIAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 04:00:00 -0400
Received: from mga14.intel.com ([192.55.52.115]:32271 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751119AbeFVH76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 03:59:58 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2018 00:59:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,255,1526367600"; 
   d="scan'208";a="59316311"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Jun 2018 00:59:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 4DDBD143; Fri, 22 Jun 2018 10:59:58 +0300 (EEST)
Date:   Fri, 22 Jun 2018 10:59:58 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     yang.shi@linux.alibaba.com
Cc:     hughd@google.com, vbabka@suse.cz, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH 1/2] mm: thp: register mm for khugepaged when merging
 vma for shmem
Message-ID: <20180622075958.mzagr2ayufiuokea@black.fi.intel.com>
References: <1529622949-75504-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529622949-75504-1-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 11:15:48PM +0000, yang.shi@linux.alibaba.com wrote:
> When merging anonymous page vma, if the size of vma can fit in at least
> one hugepage, the mm will be registered for khugepaged for collapsing
> THP in the future.
> 
> But, it skips shmem vma. Doing so for shmem too, but not file-private
> mapping, when merging vma in order to increase the odd to collapse
> hugepage by khugepaged.
> 
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> ---
> v1 --> 2:
> * Exclude file-private mapping per Kirill's comment
> 
>  mm/khugepaged.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index d7b2a4b..9b0ec30 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -440,8 +440,12 @@ int khugepaged_enter_vma_merge(struct vm_area_struct *vma,
>  		 * page fault if needed.
>  		 */
>  		return 0;
> -	if (vma->vm_ops || (vm_flags & VM_NO_KHUGEPAGED))
> -		/* khugepaged not yet working on file or special mappings */
> +	if ((vma->vm_ops && (!shmem_file(vma->vm_file) || vma->anon_vma)) ||
> +	    (vm_flags & VM_NO_KHUGEPAGED))
> +		/*
> +		 * khugepaged not yet working on non-shmem file or special
> +		 * mappings. And, file-private shmem THP is not supported.
> +		 */
>  		return 0;

My point was that vma->anon_vma check above this one should not prevent
collapse for shmem.

Looking into this more, I think we should just replace all these checks
with hugepage_vma_check() call.

-- 
 Kirill A. Shutemov
