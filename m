Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753320AbeDRIN0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 04:13:26 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:43186 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752592AbeDRINW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 04:13:22 -0400
X-Google-Smtp-Source: AIpwx48U3rS+jbgdL83L8RTP+KgHEKi9wFtfCKc0yuI92Sw9t64Hza9CgwD0a4zT0PHAlFF6qoA8jQ==
Date: Wed, 18 Apr 2018 10:13:17 +0200
From: Vitaly Wool <vitalywool@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, mawilcox@microsoft.com,
        asavery@chromium.org, gwendal@chromium.org
Subject: Re: Crashes/hung tasks with z3pool under memory pressure
Message-ID: <20180418101317.74abe632@seldlx21914.corpusers.net>
In-Reply-To: <20180417160032.46915216@seldlx21914.corpusers.net>
References: <20180417160032.46915216@seldlx21914.corpusers.net>
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Den tis 17 apr. 2018 kl 18:35 skrev Guenter Roeck <linux@roeck-us.net>:

<snip>

> Getting better; the log is much less noisy. Unfortunately, there are still
> locking problems, resulting in a hung task. I copied the log message to [1].
> This is with [2] applied on top of v4.17-rc1.

Now this version (this is a full patch to be applied instead of the previous one) should have the above problem resolved too:

diff --git a/mm/z3fold.c b/mm/z3fold.c
index c0bca6153b95..901c0b07cbda 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -144,7 +144,8 @@ enum z3fold_page_flags {
 	PAGE_HEADLESS = 0,
 	MIDDLE_CHUNK_MAPPED,
 	NEEDS_COMPACTING,
-	PAGE_STALE
+	PAGE_STALE,
+	UNDER_RECLAIM
 };
 
 /*****************
@@ -173,6 +174,7 @@ static struct z3fold_header *init_z3fold_page(struct page *page,
 	clear_bit(MIDDLE_CHUNK_MAPPED, &page->private);
 	clear_bit(NEEDS_COMPACTING, &page->private);
 	clear_bit(PAGE_STALE, &page->private);
+	clear_bit(UNDER_RECLAIM, &page->private);
 
 	spin_lock_init(&zhdr->page_lock);
 	kref_init(&zhdr->refcount);
@@ -756,6 +758,10 @@ static void z3fold_free(struct z3fold_pool *pool, unsigned long handle)
 		atomic64_dec(&pool->pages_nr);
 		return;
 	}
+	if (test_bit(UNDER_RECLAIM, &page->private)) {
+		z3fold_page_unlock(zhdr);
+		return;
+	}
 	if (test_and_set_bit(NEEDS_COMPACTING, &page->private)) {
 		z3fold_page_unlock(zhdr);
 		return;
@@ -840,6 +846,8 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
 			kref_get(&zhdr->refcount);
 			list_del_init(&zhdr->buddy);
 			zhdr->cpu = -1;
+			set_bit(UNDER_RECLAIM, &page->private);
+			break;
 		}
 
 		list_del_init(&page->lru);
@@ -887,25 +895,35 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
 				goto next;
 		}
 next:
-		spin_lock(&pool->lock);
 		if (test_bit(PAGE_HEADLESS, &page->private)) {
 			if (ret == 0) {
-				spin_unlock(&pool->lock);
 				free_z3fold_page(page);
 				return 0;
 			}
-		} else if (kref_put(&zhdr->refcount, release_z3fold_page)) {
-			atomic64_dec(&pool->pages_nr);
+			spin_lock(&pool->lock);
+			list_add(&page->lru, &pool->lru);
+			spin_unlock(&pool->lock);
+		} else {
+			z3fold_page_lock(zhdr);
+			clear_bit(UNDER_RECLAIM, &page->private);
+			 if (kref_put(&zhdr->refcount,
+					release_z3fold_page_locked)) {
+				atomic64_dec(&pool->pages_nr);
+				return 0;
+			}
+			/*
+			 * if we are here, the page is still not completely
+			 * free. Take the global pool lock then to be able
+			 * to add it back to the lru list
+			 */
+			spin_lock(&pool->lock);
+			list_add(&page->lru, &pool->lru);
 			spin_unlock(&pool->lock);
-			return 0;
+			z3fold_page_unlock(zhdr);
 		}
 
-		/*
-		 * Add to the beginning of LRU.
-		 * Pool lock has to be kept here to ensure the page has
-		 * not already been released
-		 */
-		list_add(&page->lru, &pool->lru);
+		/* We started off locked to we need to lock the pool back */
+		spin_lock(&pool->lock);
 	}
 	spin_unlock(&pool->lock);
 	return -EAGAIN;
