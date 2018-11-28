Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E24C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD0D52081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD0D52081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbeK2JN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 04:13:59 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:34858 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbeK2JN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 04:13:59 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0317DB76;
        Wed, 28 Nov 2018 22:10:51 +0000 (UTC)
Date:   Wed, 28 Nov 2018 14:10:51 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V2 4/5] mm/hugetlb: Add prot_modify_start/commit
 sequence for hugetlb update
Message-Id: <20181128141051.ff38f23023f652759b06f828@linux-foundation.org>
In-Reply-To: <20181128143438.29458-5-aneesh.kumar@linux.ibm.com>
References: <20181128143438.29458-1-aneesh.kumar@linux.ibm.com>
        <20181128143438.29458-5-aneesh.kumar@linux.ibm.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Nov 2018 20:04:37 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:

> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Some explanation of the motivation would be useful.

>  include/linux/hugetlb.h | 18 ++++++++++++++++++
>  mm/hugetlb.c            |  8 +++++---
>  2 files changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 087fd5f48c91..e2a3b0c854eb 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -543,6 +543,24 @@ static inline void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr
>  	set_huge_pte_at(mm, addr, ptep, pte);
>  }
>  #endif
> +
> +#ifndef huge_ptep_modify_prot_start
> +static inline pte_t huge_ptep_modify_prot_start(struct vm_area_struct *vma,
> +						unsigned long addr, pte_t *ptep)
> +{
> +	return huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
> +}
> +#endif

#define huge_ptep_modify_prot_start huge_ptep_modify_prot_start

> +#ifndef huge_ptep_modify_prot_commit
> +static inline void huge_ptep_modify_prot_commit(struct vm_area_struct *vma,
> +						unsigned long addr, pte_t *ptep,
> +						pte_t old_pte, pte_t pte)
> +{
> +	set_huge_pte_at(vma->vm_mm, addr, ptep, pte);
> +}
> +#endif

#define huge_ptep_modify_prot_commit huge_ptep_modify_prot_commit


