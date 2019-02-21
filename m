Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722A3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E7DC2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbfBUTrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 14:47:16 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:48046 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfBUTrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 14:47:16 -0500
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0E0D93BD2;
        Thu, 21 Feb 2019 19:47:15 +0000 (UTC)
Date:   Thu, 21 Feb 2019 11:47:13 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Davidlohr Bueso <dave@stgolabs.net>, stable@vger.kernel.org
Subject: Re: [PATCH] huegtlbfs: fix races and page leaks during migration
Message-Id: <20190221114713.ee2a38267f75ef1a2fd6de44@linux-foundation.org>
In-Reply-To: <7534d322-d782-8ac6-1c8d-a8dc380eb3ab@oracle.com>
References: <803d2349-8911-0b47-bc5b-4f2c6cc3f928@oracle.com>
        <20190212221400.3512-1-mike.kravetz@oracle.com>
        <20190220220910.265bff9a7695540ee4121b80@linux-foundation.org>
        <7534d322-d782-8ac6-1c8d-a8dc380eb3ab@oracle.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2019 11:11:06 -0800 Mike Kravetz <mike.kravetz@oracle.com> wrote:

> 
> Sorry for the churn.  As I find and fix one issue I seem to discover another.
> There is still at least one more issue with private pages when COW comes into
> play.  I continue to work that.  I wanted to send this patch earlier as it
> is pretty easy to hit the bugs if you try.  If you would prefer another
> approach, let me know.
> 

No probs, the bug doesn't seem to be causing a lot of bother out there
and it's cc:stable; there's time to get this right ;)

Here's the delta I queued:

--- a/mm/hugetlb.c~huegtlbfs-fix-races-and-page-leaks-during-migration-update
+++ a/mm/hugetlb.c
@@ -3729,6 +3729,7 @@ static vm_fault_t hugetlb_no_page(struct
 	pte_t new_pte;
 	spinlock_t *ptl;
 	unsigned long haddr = address & huge_page_mask(h);
+	bool new_page = false;
 
 	/*
 	 * Currently, we are forced to kill the process in the event the
@@ -3790,6 +3791,7 @@ retry:
 		}
 		clear_huge_page(page, address, pages_per_huge_page(h));
 		__SetPageUptodate(page);
+		new_page = true;
 
 		if (vma->vm_flags & VM_MAYSHARE) {
 			int err = huge_add_to_page_cache(page, mapping, idx);
@@ -3861,8 +3863,9 @@ retry:
 
 	spin_unlock(ptl);
 
-	/* May already be set if not newly allocated page */
-	set_page_huge_active(page);
+	/* Make newly allocated pages active */
+	if (new_page)
+		set_page_huge_active(page);
 
 	unlock_page(page);
 out:
--- a/mm/migrate.c~huegtlbfs-fix-races-and-page-leaks-during-migration-update
+++ a/mm/migrate.c
@@ -1315,6 +1315,16 @@ static int unmap_and_move_huge_page(new_
 		lock_page(hpage);
 	}
 
+	/*
+	 * Check for pages which are in the process of being freed.  Without
+	 * page_mapping() set, hugetlbfs specific move page routine will not
+	 * be called and we could leak usage counts for subpools.
+	 */
+	if (page_private(hpage) && !page_mapping(hpage)) {
+		rc = -EBUSY;
+		goto out_unlock;
+	}
+
 	if (PageAnon(hpage))
 		anon_vma = page_get_anon_vma(hpage);
 
@@ -1345,6 +1355,7 @@ put_anon:
 		put_new_page = NULL;
 	}
 
+out_unlock:
 	unlock_page(hpage);
 out:
 	if (rc != -EAGAIN)
_


