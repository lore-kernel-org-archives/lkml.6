Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A34C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 23:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5B222147D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 23:32:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5B222147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbeKFIyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 03:54:11 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:46018 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbeKFIyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 03:54:11 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1B5FF904;
        Mon,  5 Nov 2018 23:32:00 +0000 (UTC)
Date:   Mon, 5 Nov 2018 15:31:59 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vitaly Wool <vitalywool@gmail.com>
Cc:     Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Oleksiy.Avramchenko@sony.com, Guenter Roeck <linux@roeck-us.net>,
        snild@sony.com, Jongseok Kim <ks77sj@gmail.com>
Subject: Re: [PATCH] z3fold: fix possible reclaim races
Message-Id: <20181105153159.0c1825bcb956c53a1d02a6ca@linux-foundation.org>
In-Reply-To: <20181105162225.74e8837d03583a9b707cf559@gmail.com>
References: <20181105162225.74e8837d03583a9b707cf559@gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Nov 2018 16:22:25 +0100 Vitaly Wool <vitalywool@gmail.com> wrote:

> Reclaim and free can race on an object which is basically fine but
> in order for reclaim to be able to  map "freed" object we need to
> encode object length in the handle. handle_to_chunks() is then
> introduced to extract object length from a handle and use it during
> mapping.
> 
> Moreover, to avoid racing on a z3fold "headless" page release, we
> should not try to free that page in z3fold_free() if the reclaim
> bit is set. Also, in the unlikely case of trying to reclaim a page
> being freed, we should not proceed with that page.
> 
> While at it, fix the page accounting in reclaim function.
> 
> This patch supersedes "[PATCH] z3fold: fix reclaim lock-ups".

This conflicts with z3fold-fix-wrong-handling-of-headless-pages.patch,
below.  What should we do?

(I think we're still awaiting your input on this one.  Or I might have
missed an amail.)



From: Jongseok Kim <ks77sj@gmail.com>
Subject: mm/z3fold.c: fix wrong handling of headless pages

During the processing of headless pages in z3fold_reclaim_page(), there
was a problem that the zhdr pointed to another page or a page was already
released in z3fold_free().  So, the wrong page is encoded in headless, or
test_bit does not work properly in z3fold_reclaim_page().  This patch
fixed these problems.

Link: http://lkml.kernel.org/r/1530853846-30215-1-git-send-email-ks77sj@gmail.com
Signed-off-by: Jongseok Kim <ks77sj@gmail.com>
Cc: Vitaly Wool <vitalywool@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/z3fold.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/mm/z3fold.c~z3fold-fix-wrong-handling-of-headless-pages
+++ a/mm/z3fold.c
@@ -746,6 +746,9 @@ static void z3fold_free(struct z3fold_po
 	}
 
 	if (bud == HEADLESS) {
+		if (test_bit(UNDER_RECLAIM, &page->private))
+			return;
+
 		spin_lock(&pool->lock);
 		list_del(&page->lru);
 		spin_unlock(&pool->lock);
@@ -836,20 +839,20 @@ static int z3fold_reclaim_page(struct z3
 		}
 		list_for_each_prev(pos, &pool->lru) {
 			page = list_entry(pos, struct page, lru);
+			zhdr = page_address(page);
 			if (test_bit(PAGE_HEADLESS, &page->private))
 				/* candidate found */
 				break;
 
-			zhdr = page_address(page);
 			if (!z3fold_page_trylock(zhdr))
 				continue; /* can't evict at this point */
 			kref_get(&zhdr->refcount);
 			list_del_init(&zhdr->buddy);
 			zhdr->cpu = -1;
-			set_bit(UNDER_RECLAIM, &page->private);
 			break;
 		}
 
+		set_bit(UNDER_RECLAIM, &page->private);
 		list_del_init(&page->lru);
 		spin_unlock(&pool->lock);
 
@@ -898,6 +901,7 @@ next:
 		if (test_bit(PAGE_HEADLESS, &page->private)) {
 			if (ret == 0) {
 				free_z3fold_page(page);
+				atomic64_dec(&pool->pages_nr);
 				return 0;
 			}
 			spin_lock(&pool->lock);
_

