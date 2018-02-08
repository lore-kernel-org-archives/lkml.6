Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751963AbeBHWj3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 17:39:29 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:57880 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750750AbeBHWj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 17:39:28 -0500
Date: Thu, 8 Feb 2018 14:39:26 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Yang Shi <yang.shi@linux.alibaba.com>
Cc: kirill.shutemov@linux.intel.com, gavin.dg@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: thp: fix potential clearing to referenced flag in
 page_idle_clear_pte_refs_one()
Message-Id: <20180208143926.5484e8fd75a56ff35b778bcc@linux-foundation.org>
In-Reply-To: <1517875596-76350-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1517875596-76350-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  6 Feb 2018 08:06:36 +0800 Yang Shi <yang.shi@linux.alibaba.com> wrote:

> For PTE-mapped THP, the compound THP has not been split to normal 4K
> pages yet, the whole THP is considered referenced if any one of sub
> page is referenced.
> 
> When walking PTE-mapped THP by pvmw, all relevant PTEs will be checked
> to retrieve referenced bit. But, the current code just returns the
> result of the last PTE. If the last PTE has not referenced, the
> referenced flag will be cleared.
> 
> So, here just break pvmw walk once referenced PTE is found if the page
> is a part of THP.
> 
> ...
>
> --- a/mm/page_idle.c
> +++ b/mm/page_idle.c
> @@ -67,6 +67,14 @@ static bool page_idle_clear_pte_refs_one(struct page *page,
>  		if (pvmw.pte) {
>  			referenced = ptep_clear_young_notify(vma, addr,
>  					pvmw.pte);
> +			/*
> +			 * For PTE-mapped THP, one sub page is referenced,
> +			 * the whole THP is referenced.
> +			 */
> +			if (referenced && PageTransCompound(pvmw.page)) {
> +				page_vma_mapped_walk_done(&pvmw);
> +				break;
> +			}

This means that the function will no longer clear the referenced bits
in all the ptes.  What effect does this have and should we document
this in some fashion?

>  		} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
>  			referenced = pmdp_clear_young_notify(vma, addr,
>  					pvmw.pmd);
