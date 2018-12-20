Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C827C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44431218FE
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389838AbeLTVGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 16:06:45 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51114 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389712AbeLTVGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 16:06:44 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 810D5DAB;
        Thu, 20 Dec 2018 21:06:43 +0000 (UTC)
Date:   Thu, 20 Dec 2018 13:06:42 -0800
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
Subject: Re: [PATCH v2 0/2] hugetlbfs: use i_mmap_rwsem for better
 synchronization
Message-Id: <20181220130642.e43bee30cf572c5a9a3a8557@linux-foundation.org>
In-Reply-To: <20181218223557.5202-1-mike.kravetz@oracle.com>
References: <20181218223557.5202-1-mike.kravetz@oracle.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Dec 2018 14:35:55 -0800 Mike Kravetz <mike.kravetz@oracle.com> wrote:

> There are two primary issues addressed here:
> 1) For shared pmds, huge PTE pointers returned by huge_pte_alloc can become
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

Still no reviewers or ackers :(

I'll queue these for 4.21-rc1.  The Fixes: commits are over a decade
old so I assume things aren't super-urgent and the cc:stable will do
its work.

