Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4ECC43612
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F3B020874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547218743;
	bh=o68aytgP7SScS+w02QsX79bu8G8aH/a/MvpXxXtxH4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0+kSfF1MfsFBARQmT8IFCj6ruztmIGV9YpiGsMg2RwziY2xALGtbfF0hcRLhZpPc8
	 AI7mTNqfRL9IXyxEWNMdHNxwHx0aCcutEuCuS3DYV0IUbduH3uOAkLEBblOK1AyGvm
	 aUmVZIXJMiAuVzOnKLzfg8GLv7t3Bo62rNQNqIi4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389811AbfAKOeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:34:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:54198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389794AbfAKOd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:33:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C557B21848;
        Fri, 11 Jan 2019 14:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217237;
        bh=o68aytgP7SScS+w02QsX79bu8G8aH/a/MvpXxXtxH4U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EPFBGsJ6ft1isL3xF65li4iO0bDbP5i9lZvSFL2WW5UMJmszI1xrZFQEi5ns1MZR1
         sOT40bFNZFecSO9Zg2S6zWxPEKia5wdZ1NnAceM6hBgkMuj7NZj1gBUnumSrsYDSzA
         VolpFiFFqD93plSLSO139di+DoW3RL0ZCxpzk8Rw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Huang, Ying" <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Rik van Riel <riel@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Minchan Kim <minchan@kernel.org>, Shaohua Li <shli@kernel.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 066/105] mm, swap: fix swapoff with KSM pages
Date:   Fri, 11 Jan 2019 15:14:37 +0100
Message-Id: <20190111131108.555772233@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131102.899065735@linuxfoundation.org>
References: <20190111131102.899065735@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huang Ying <ying.huang@intel.com>

commit 7af7a8e19f0c5425ff639b0f0d2d244c2a647724 upstream.

KSM pages may be mapped to the multiple VMAs that cannot be reached from
one anon_vma.  So during swapin, a new copy of the page need to be
generated if a different anon_vma is needed, please refer to comments of
ksm_might_need_to_copy() for details.

During swapoff, unuse_vma() uses anon_vma (if available) to locate VMA and
virtual address mapped to the page, so not all mappings to a swapped out
KSM page could be found.  So in try_to_unuse(), even if the swap count of
a swap entry isn't zero, the page needs to be deleted from swap cache, so
that, in the next round a new page could be allocated and swapin for the
other mappings of the swapped out KSM page.

But this contradicts with the THP swap support.  Where the THP could be
deleted from swap cache only after the swap count of every swap entry in
the huge swap cluster backing the THP has reach 0.  So try_to_unuse() is
changed in commit e07098294adf ("mm, THP, swap: support to reclaim swap
space for THP swapped out") to check that before delete a page from swap
cache, but this has broken KSM swapoff too.

Fortunately, KSM is for the normal pages only, so the original behavior
for KSM pages could be restored easily via checking PageTransCompound().
That is how this patch works.

The bug is introduced by e07098294adf ("mm, THP, swap: support to reclaim
swap space for THP swapped out"), which is merged by v4.14-rc1.  So I
think we should backport the fix to from 4.14 on.  But Hugh thinks it may
be rare for the KSM pages being in the swap device when swapoff, so nobody
reports the bug so far.

Link: http://lkml.kernel.org/r/20181226051522.28442-1-ying.huang@intel.com
Fixes: e07098294adf ("mm, THP, swap: support to reclaim swap space for THP swapped out")
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Reported-by: Hugh Dickins <hughd@google.com>
Tested-by: Hugh Dickins <hughd@google.com>
Acked-by: Hugh Dickins <hughd@google.com>
Cc: Rik van Riel <riel@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Shaohua Li <shli@kernel.org>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/swapfile.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2218,7 +2218,8 @@ int try_to_unuse(unsigned int type, bool
 		 */
 		if (PageSwapCache(page) &&
 		    likely(page_private(page) == entry.val) &&
-		    !page_swapped(page))
+		    (!PageTransCompound(page) ||
+		     !swap_page_trans_huge_swapped(si, entry)))
 			delete_from_swap_cache(compound_head(page));
 
 		/*


