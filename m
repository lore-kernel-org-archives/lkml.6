Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC0FC0044C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 01:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CECD20862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 01:34:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CECD20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbeKFK51 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 05:57:27 -0500
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:50539 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbeKFK51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 05:57:27 -0500
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id wA61YR56019535
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 6 Nov 2018 10:34:27 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id wA61YRMI011113;
        Tue, 6 Nov 2018 10:34:27 +0900
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id wA61SHNF011778;
        Tue, 6 Nov 2018 10:34:27 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.150] [10.38.151.150]) by mail01b.kamome.nec.co.jp with ESMTP id BT-MMP-5230110; Tue, 6 Nov 2018 10:32:55 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC22GP.gisp.nec.co.jp ([10.38.151.150]) with mapi id 14.03.0319.002; Tue, 6
 Nov 2018 10:32:54 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        "Hugh Dickins" <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        "Andrew Morton" <akpm@linux-foundation.org>
Subject: Re: [PATCH] hugetlbfs: fix kernel BUG at fs/hugetlbfs/inode.c:444!
Thread-Topic: [PATCH] hugetlbfs: fix kernel BUG at fs/hugetlbfs/inode.c:444!
Thread-Index: AQHUdU3JjXuGjWq+bEy+AnZGH9gSfKVBX8qA
Date:   Tue, 6 Nov 2018 01:32:53 +0000
Message-ID: <20181106013253.GA23554@hori1.linux.bs1.fc.nec.co.jp>
References: <20181105212315.14125-1-mike.kravetz@oracle.com>
In-Reply-To: <20181105212315.14125-1-mike.kravetz@oracle.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.51.8.82]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <4C75139DA4D603429C61FE4CB6ABE3DA@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 01:23:15PM -0800, Mike Kravetz wrote:
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
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Reviewed-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
