Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AAE5C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBD382085B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nCDFwcWp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBD382085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729952AbeKFAmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 19:42:42 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46439 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729430AbeKFAml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 19:42:41 -0500
Received: by mail-lj1-f194.google.com with SMTP id x3-v6so8341691lji.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 07:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=u0yyA1W2KMF2mBPnxO39hGAhOsYu28DbBMo8SZUUdTE=;
        b=nCDFwcWp4w8mbq9XNvPu92p8rrVZcuzg0f2eS0boApTIlBaucJDPsESPaz4xIIxym4
         RWtbaYmLX5uPygl5MNi4no6ReLt/AWlPTzbicxPrnW26ZMkbQj95wdgmnMAhbhmH8NCc
         +jAcq4NccakjMAbDW9BkMWzfxsRGC74w2mtIFoa2bHAZheNTnekhhJdWfBl1NFD3Iojr
         JRAPtus0tE4djMadSo+bx4xgn0A05YA/tlSMcYSUmkjVpS58QATE4AyL9gIWxwPleDWg
         VYjK7ACYr1ry9iIF1xPMRKK70CF3MUDQt2rHlXqFUNWHgEAbMdhhQFlMlFLtCbEQurxW
         BhTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=u0yyA1W2KMF2mBPnxO39hGAhOsYu28DbBMo8SZUUdTE=;
        b=YPlA/0uY8rRHuehrZIZ/xiRCoYzoWhQLZkfuQLUwHuO87UgMsTXn/ztQEIG43Q4pVE
         h7wLFHjC6V2jz01JAs/LTFZLyOB5UaCuHR3javcY+N3bX8YgGMC/vEa1yJAM+FuP4Bhs
         wt1nuedqJaXcmntHnW2mhAvZHoznbZ9YnYcsG4ZAuvSL/4bZqoM4ge0ddKU6qPivqyYj
         +rEObvH+SLmbi2L8Bl/GNTBJCfIqNKVbDyCpIBPlWq6gz0x+yrzVzuyXabqDa3nHyUxp
         DUKtEiyUrAfZda+yFt92oJfbRJz3Tx+QORqaY+mgoKFG7LAksF6DUvmtj/Yvk1qV8Y7f
         8f8w==
X-Gm-Message-State: AGRZ1gJmORdWCrUZ7H3OArpGmkPs3mLfSE4iK6AVY8CBYqYDuTCbRJ8k
        Psef4UgCmqnc6xCRUyNgcr0=
X-Google-Smtp-Source: AJdET5ee+/ikYEu6osnmvSMwnHbI22WNzeY33dGO5lDnT+FtZTj8X8XIVmblctz07NtwVMZj1OWv0Q==
X-Received: by 2002:a2e:9c08:: with SMTP id s8-v6mr12333005lji.149.1541431347221;
        Mon, 05 Nov 2018 07:22:27 -0800 (PST)
Received: from seldlx21914.corpusers.net ([37.139.156.40])
        by smtp.gmail.com with ESMTPSA id f15-v6sm2805919lfc.9.2018.11.05.07.22.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 07:22:26 -0800 (PST)
Date:   Mon, 5 Nov 2018 16:22:25 +0100
From:   Vitaly Wool <vitalywool@gmail.com>
To:     Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oleksiy.Avramchenko@sony.com, Guenter Roeck <linux@roeck-us.net>,
        snild@sony.com
Subject: [PATCH] z3fold: fix possible reclaim races
Message-Id: <20181105162225.74e8837d03583a9b707cf559@gmail.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reclaim and free can race on an object which is basically fine but
in order for reclaim to be able to  map "freed" object we need to
encode object length in the handle. handle_to_chunks() is then
introduced to extract object length from a handle and use it during
mapping.

Moreover, to avoid racing on a z3fold "headless" page release, we
should not try to free that page in z3fold_free() if the reclaim
bit is set. Also, in the unlikely case of trying to reclaim a page
being freed, we should not proceed with that page.

While at it, fix the page accounting in reclaim function.

This patch supersedes "[PATCH] z3fold: fix reclaim lock-ups".

Signed-off-by: Vitaly Wool <vitaly.vul@sony.com>
Reviewed-by: Snild Dolkow <snild@sony.com>

---
 mm/z3fold.c | 101 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 62 insertions(+), 39 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index ff73ef8124bf..5999727ee17c 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -99,6 +99,7 @@ struct z3fold_header {
 #define NCHUNKS		((PAGE_SIZE - ZHDR_SIZE_ALIGNED) >> CHUNK_SHIFT)
 
 #define BUDDY_MASK	(0x3)
+#define BUDDY_SHIFT	2
 
 /**
  * struct z3fold_pool - stores metadata for each z3fold pool
@@ -145,7 +146,7 @@ enum z3fold_page_flags {
 	MIDDLE_CHUNK_MAPPED,
 	NEEDS_COMPACTING,
 	PAGE_STALE,
-	UNDER_RECLAIM
+	PAGE_CLAIMED, /* by either reclaim or free */
 };
 
 /*****************
@@ -174,7 +175,7 @@ static struct z3fold_header *init_z3fold_page(struct page *page,
 	clear_bit(MIDDLE_CHUNK_MAPPED, &page->private);
 	clear_bit(NEEDS_COMPACTING, &page->private);
 	clear_bit(PAGE_STALE, &page->private);
-	clear_bit(UNDER_RECLAIM, &page->private);
+	clear_bit(PAGE_CLAIMED, &page->private);
 
 	spin_lock_init(&zhdr->page_lock);
 	kref_init(&zhdr->refcount);
@@ -223,8 +224,11 @@ static unsigned long encode_handle(struct z3fold_header *zhdr, enum buddy bud)
 	unsigned long handle;
 
 	handle = (unsigned long)zhdr;
-	if (bud != HEADLESS)
-		handle += (bud + zhdr->first_num) & BUDDY_MASK;
+	if (bud != HEADLESS) {
+		handle |= (bud + zhdr->first_num) & BUDDY_MASK;
+		if (bud == LAST)
+			handle |= (zhdr->last_chunks << BUDDY_SHIFT);
+	}
 	return handle;
 }
 
@@ -234,6 +238,12 @@ static struct z3fold_header *handle_to_z3fold_header(unsigned long handle)
 	return (struct z3fold_header *)(handle & PAGE_MASK);
 }
 
+/* only for LAST bud, returns zero otherwise */
+static unsigned short handle_to_chunks(unsigned long handle)
+{
+	return (handle & ~PAGE_MASK) >> BUDDY_SHIFT;
+}
+
 /*
  * (handle & BUDDY_MASK) < zhdr->first_num is possible in encode_handle
  *  but that doesn't matter. because the masking will result in the
@@ -720,37 +730,39 @@ static void z3fold_free(struct z3fold_pool *pool, unsigned long handle)
 	page = virt_to_page(zhdr);
 
 	if (test_bit(PAGE_HEADLESS, &page->private)) {
-		/* HEADLESS page stored */
-		bud = HEADLESS;
-	} else {
-		z3fold_page_lock(zhdr);
-		bud = handle_to_buddy(handle);
-
-		switch (bud) {
-		case FIRST:
-			zhdr->first_chunks = 0;
-			break;
-		case MIDDLE:
-			zhdr->middle_chunks = 0;
-			zhdr->start_middle = 0;
-			break;
-		case LAST:
-			zhdr->last_chunks = 0;
-			break;
-		default:
-			pr_err("%s: unknown bud %d\n", __func__, bud);
-			WARN_ON(1);
-			z3fold_page_unlock(zhdr);
-			return;
+		/* if a headless page is under reclaim, just leave.
+		 * NB: we use test_and_set_bit for a reason: if the bit
+		 * has not been set before, we release this page
+		 * immediately so we don't care about its value any more.
+		 */
+		if (!test_and_set_bit(PAGE_CLAIMED, &page->private)) {
+			spin_lock(&pool->lock);
+			list_del(&page->lru);
+			spin_unlock(&pool->lock);
+			free_z3fold_page(page);
+			atomic64_dec(&pool->pages_nr);
 		}
+		return;
 	}
 
-	if (bud == HEADLESS) {
-		spin_lock(&pool->lock);
-		list_del(&page->lru);
-		spin_unlock(&pool->lock);
-		free_z3fold_page(page);
-		atomic64_dec(&pool->pages_nr);
+	/* Non-headless case */
+	z3fold_page_lock(zhdr);
+	bud = handle_to_buddy(handle);
+
+	switch (bud) {
+	case FIRST:
+		zhdr->first_chunks = 0;
+		break;
+	case MIDDLE:
+		zhdr->middle_chunks = 0;
+		break;
+	case LAST:
+		zhdr->last_chunks = 0;
+		break;
+	default:
+		pr_err("%s: unknown bud %d\n", __func__, bud);
+		WARN_ON(1);
+		z3fold_page_unlock(zhdr);
 		return;
 	}
 
@@ -758,7 +770,7 @@ static void z3fold_free(struct z3fold_pool *pool, unsigned long handle)
 		atomic64_dec(&pool->pages_nr);
 		return;
 	}
-	if (test_bit(UNDER_RECLAIM, &page->private)) {
+	if (test_bit(PAGE_CLAIMED, &page->private)) {
 		z3fold_page_unlock(zhdr);
 		return;
 	}
@@ -836,20 +848,30 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
 		}
 		list_for_each_prev(pos, &pool->lru) {
 			page = list_entry(pos, struct page, lru);
+
+			/* this bit could have been set by free, in which case
+			 * we pass over to the next page in the pool.
+			 */
+			if (test_and_set_bit(PAGE_CLAIMED, &page->private))
+				continue;
+
+			zhdr = page_address(page);
 			if (test_bit(PAGE_HEADLESS, &page->private))
-				/* candidate found */
 				break;
 
-			zhdr = page_address(page);
-			if (!z3fold_page_trylock(zhdr))
+			if (!z3fold_page_trylock(zhdr)) {
+				zhdr = NULL;
 				continue; /* can't evict at this point */
+			}
 			kref_get(&zhdr->refcount);
 			list_del_init(&zhdr->buddy);
 			zhdr->cpu = -1;
-			set_bit(UNDER_RECLAIM, &page->private);
 			break;
 		}
 
+		if (!zhdr)
+			break;
+
 		list_del_init(&page->lru);
 		spin_unlock(&pool->lock);
 
@@ -898,6 +920,7 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
 		if (test_bit(PAGE_HEADLESS, &page->private)) {
 			if (ret == 0) {
 				free_z3fold_page(page);
+				atomic64_dec(&pool->pages_nr);
 				return 0;
 			}
 			spin_lock(&pool->lock);
@@ -905,7 +928,7 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
 			spin_unlock(&pool->lock);
 		} else {
 			z3fold_page_lock(zhdr);
-			clear_bit(UNDER_RECLAIM, &page->private);
+			clear_bit(PAGE_CLAIMED, &page->private);
 			if (kref_put(&zhdr->refcount,
 					release_z3fold_page_locked)) {
 				atomic64_dec(&pool->pages_nr);
@@ -964,7 +987,7 @@ static void *z3fold_map(struct z3fold_pool *pool, unsigned long handle)
 		set_bit(MIDDLE_CHUNK_MAPPED, &page->private);
 		break;
 	case LAST:
-		addr += PAGE_SIZE - (zhdr->last_chunks << CHUNK_SHIFT);
+		addr += PAGE_SIZE - (handle_to_chunks(handle) << CHUNK_SHIFT);
 		break;
 	default:
 		pr_err("unknown buddy id %d\n", buddy);
-- 
2.17.1
