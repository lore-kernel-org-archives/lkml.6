Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B52FC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 666B32085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:30:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 666B32085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388007AbeKFGvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 01:51:55 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:40428 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387441AbeKFGvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 01:51:55 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2B6BFB7A;
        Mon,  5 Nov 2018 21:30:14 +0000 (UTC)
Date:   Mon, 5 Nov 2018 13:30:13 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>
Subject: Re: [PATCH] hugetlbfs: fix kernel BUG at fs/hugetlbfs/inode.c:444!
Message-Id: <20181105133013.35fdb58c16d9318538fc0cb6@linux-foundation.org>
In-Reply-To: <20181105212315.14125-1-mike.kravetz@oracle.com>
References: <20181105212315.14125-1-mike.kravetz@oracle.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  5 Nov 2018 13:23:15 -0800 Mike Kravetz <mike.kravetz@oracle.com> wrote:

> This bug has been experienced several times by Oracle DB team.
> The BUG is in the routine remove_inode_hugepages() as follows:
> 	/*
> 	 * If page is mapped, it was faulted in after being
> 	 * unmapped in caller.  Unmap (again) now after taking
> 	 * the fault mutex.  The mutex will prevent faults
> 	 * until we finish removing the page.
> 	 *
> 	 * This race can only happen in the hole punch case.
> 	 * Getting here in a truncate operation is a bug.
> 	 */
> 	if (unlikely(page_mapped(page))) {
> 		BUG_ON(truncate_op);
> 
> In this case, the elevated map count is not the result of a race.
> Rather it was incorrectly incremented as the result of a bug in the
> huge pmd sharing code.  Consider the following:
> - Process A maps a hugetlbfs file of sufficient size and alignment
>   (PUD_SIZE) that a pmd page could be shared.
> - Process B maps the same hugetlbfs file with the same size and alignment
>   such that a pmd page is shared.
> - Process B then calls mprotect() to change protections for the mapping
>   with the shared pmd.  As a result, the pmd is 'unshared'.
> - Process B then calls mprotect() again to chage protections for the
>   mapping back to their original value.  pmd remains unshared.
> - Process B then forks and process C is created.  During the fork process,
>   we do dup_mm -> dup_mmap -> copy_page_range to copy page tables.  Copying
>   page tables for hugetlb mappings is done in the routine
>   copy_hugetlb_page_range.
> 
> In copy_hugetlb_page_range(), the destination pte is obtained by:
> 	dst_pte = huge_pte_alloc(dst, addr, sz);
> If pmd sharing is possible, the returned pointer will be to a pte in
> an existing page table.  In the situation above, process C could share
> with either process A or process B.  Since process A is first in the
> list, the returned pte is a pointer to a pte in process A's page table.
> 
> However, the following check for pmd sharing is in copy_hugetlb_page_range.
> 	/* If the pagetables are shared don't copy or take references */
> 	if (dst_pte == src_pte)
> 		continue;
> 
> Since process C is sharing with process A instead of process B, the above
> test fails.  The code in copy_hugetlb_page_range which follows assumes
> dst_pte points to a huge_pte_none pte.  It copies the pte entry from
> src_pte to dst_pte and increments this map count of the associated page.
> This is how we end up with an elevated map count.
> 
> To solve, check the dst_pte entry for huge_pte_none.  If !none, this
> implies PMD sharing so do not copy.
> 

Does it warrant a cc:stable?
