Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756064AbeEIGMg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 02:12:36 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36767 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753147AbeEIGMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 02:12:34 -0400
X-Google-Smtp-Source: AB8JxZqzWoz95NYkL9AD1luFdabee8qD0SipCTTsVxjYocMNZrZ5j3CRE21kbt1QBkfwswgQnwtvHw==
From: Jongseok Kim <ks77sj@gmail.com>
To: Vitaly Wool <vitalywool@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jongseok Kim <ks77sj@gmail.com>
Subject: Re: [PATCH v2] z3fold: fix reclaim lock-ups
Date: Wed,  9 May 2018 15:11:59 +0900
Message-Id: <1525846319-6179-1-git-send-email-ks77sj@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <CAMJBoFNdk3fRMmcBe46TFgk9=Q1T6eJEubZ86oASicLvEzj3ng@mail.gmail.com>
References: <CAMJBoFNdk3fRMmcBe46TFgk9=Q1T6eJEubZ86oASicLvEzj3ng@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Jongseok,

> I don't see how that is relevant, we don't use zhdr variable if the page is
headless anyway.

> Thanks, that is indeed a valid fix, but given the operation of eviction in
> zswap case, I'd prefer to release the page here and not in _free().
> Basically we should bail very early from z3fold_free() if the page is
> headless and UNDER_RECLAIM and keep the code intact in
> z3fold_reclaim_page().

> ~Vitaly

Hi, Vitaly. Thanks for your reply.
Then I think the below code is your preferred code.

And explaining about zhdr, this code don't mean that zhdr pointer is 
used as z3fold_header. Because it's headless like you said. 
Even though it is headless, however, 'zhdr', the pointer of z3fold_header,
is still used in _alloc and encode_handle as an address of a headless page.

So in pervious code, if eviction fails (it's not headless) and the selected page
in the next try loop is headless, then 'zhdr' will remain the value of the
previously failed page, which will cause a not headless page to be encoded
to headless. This is why a page that is not headless is encoded as HEADLESS 
in _map, which causes 'z3fold: unknown buddy id 0' warning.

And I have a one question. In z3fold_reclaim_page, is it because of 
performance that you added non-headless pages only to lru list
except buddy list?

~Jongseok

---
 mm/z3fold.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index d5b3f49..5f659ab 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -746,6 +746,9 @@ static void z3fold_free(struct z3fold_pool *pool, unsigned long handle)
 	}
 
 	if (bud == HEADLESS) {
+		if (test_bit(UNDER_RECLAIM, &page->private))
+			return;
+
 		spin_lock(&pool->lock);
 		list_del(&page->lru);
 		spin_unlock(&pool->lock);
@@ -836,11 +839,11 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
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
@@ -898,6 +901,7 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
 		if (test_bit(PAGE_HEADLESS, &page->private)) {
 			if (ret == 0) {
 				free_z3fold_page(page);
+				atomic64_dec(&pool->pages_nr);
 				return 0;
 			}
 			spin_lock(&pool->lock);
-- 
2.7.4
