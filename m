Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044B0C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C879C224E0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:45:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C879C224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbeKMBiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 20:38:46 -0500
Received: from mga11.intel.com ([192.55.52.93]:50229 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726981AbeKMBiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 20:38:46 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Nov 2018 07:44:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,495,1534834800"; 
   d="scan'208";a="88685885"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga007.jf.intel.com with ESMTP; 12 Nov 2018 07:44:58 -0800
Date:   Mon, 12 Nov 2018 08:41:27 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     john.hubbard@gmail.com
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v2 1/6] mm/gup: finish consolidating error handling
Message-ID: <20181112154127.GA8247@localhost.localdomain>
References: <20181110085041.10071-1-jhubbard@nvidia.com>
 <20181110085041.10071-2-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181110085041.10071-2-jhubbard@nvidia.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, 2018 at 12:50:36AM -0800, john.hubbard@gmail.com wrote:
> From: John Hubbard <jhubbard@nvidia.com>
> 
> An upcoming patch wants to be able to operate on each page that
> get_user_pages has retrieved. In order to do that, it's best to
> have a common exit point from the routine. Most of this has been
> taken care of by commit df06b37ffe5a4 ("mm/gup: cache dev_pagemap while
> pinning pages"), but there was one case remaining.
> 
> Also, there was still an unnecessary shadow declaration (with a
> different type) of the "ret" variable, which this commit removes.
> 
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  mm/gup.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index f76e77a2d34b..55a41dee0340 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -696,12 +696,11 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
>  		if (!vma || start >= vma->vm_end) {
>  			vma = find_extend_vma(mm, start);
>  			if (!vma && in_gate_area(mm, start)) {
> -				int ret;
>  				ret = get_gate_page(mm, start & PAGE_MASK,
>  						gup_flags, &vma,
>  						pages ? &pages[i] : NULL);
>  				if (ret)
> -					return i ? : ret;
> +					goto out;
>  				ctx.page_mask = 0;
>  				goto next_page;
>  			}

This also fixes a potentially leaked dev_pagemap reference count if a
failure occurs when an iteration crosses a vma boundary. I don't think
it's normal to have different vma's on a users mapped zone device memory,
but good to fix anyway.

Reviewed-by: Keith Busch <keith.busch@intel.com>
