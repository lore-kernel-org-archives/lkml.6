Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8261C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27CA32080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731084AbeLNVWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 16:22:48 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51036 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730928AbeLNVWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 16:22:47 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A9A94AE7;
        Fri, 14 Dec 2018 21:22:46 +0000 (UTC)
Date:   Fri, 14 Dec 2018 13:22:39 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>
Subject: Re: [PATCH 0/3] hugetlbfs: use i_mmap_rwsem for better
 synchronization
Message-Id: <20181214132239.9b74e2ca4bc4e38a409736dc@linux-foundation.org>
In-Reply-To: <20181203200850.6460-1-mike.kravetz@oracle.com>
References: <20181203200850.6460-1-mike.kravetz@oracle.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  3 Dec 2018 12:08:47 -0800 Mike Kravetz <mike.kravetz@oracle.com> wrote:

> These patches are a follow up to the RFC,
> http://lkml.kernel.org/r/20181024045053.1467-1-mike.kravetz@oracle.com
> Comments made by Naoya were addressed.
> 
> There are two primary issues addressed here:
> 1) For shared pmds, huge PE pointers returned by huge_pte_alloc can become
>    invalid via a call to huge_pmd_unshare by another thread.
> 2) hugetlbfs page faults can race with truncation causing invalid global
>    reserve counts and state.
> Both issues are addressed by expanding the use of i_mmap_rwsem.
> 
> These issues have existed for a long time.  They can be recreated with a
> test program that causes page fault/truncation races.  For simple mappings,
> this results in a negative HugePages_Rsvd count.  If racing with mappings
> that contain shared pmds, we can hit "BUG at fs/hugetlbfs/inode.c:444!" or
> Oops! as the result of an invalid memory reference.
> 
> I broke up the larger RFC into separate patches addressing each issue.
> Hopefully, this is easier to understand/review.

Three patches tagged for -stable and no reviewers yet.  Could people
please take a close look?

