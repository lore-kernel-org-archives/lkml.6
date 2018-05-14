Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpUnX6RBwKr7lH9AzL0EnHngnd2KxjLV+tNR6j1K4JPH/2SCSLwLVh6ATUTF3She2iksP2s
ARC-Seal: i=1; a=rsa-sha256; t=1526281056; cv=none;
        d=google.com; s=arc-20160816;
        b=NapX0H20s9jmSivNyFj4WcBKbRBcb5kBSU4WH83CCkm3ogYPtfJ/WYfCiwzQyk81LM
         1SakVVX1veeGZrBgb4MJKhYD6FSmJMyr8FQy43dp2M8Oofo6sZqjc7+MUx9OBTMMLraI
         hQAroGr4DiWGi90L7iuBkye6W24y32SZGJShysBXSbiQ2WXcnXz73yjMTnhRB5XW8gaW
         6grelBfclHsXv/8Iy9HDGezM+so06B9RtTIjFMScYEV73siQtppVWy5A82ep9dUOe4bI
         ZY8J/gqmJCU7pZYLMstCkIvNAqEYG7gSjIR1FsYbkqcVxyhL7hHPJ36Lugm17waI327S
         Usjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=n1LgfNHX8qJyo0RsDF02WY3H9lKjVA198N7+7J9NgAU=;
        b=qCQ8+niT66PkjBe39KMTbGp3mcCoI3DI/PDmp4BtSR0fB86el52O3ETHwlhFqZlHq8
         xQWRScVmN08E7gaYN99sQnRJse23YVwaTaAz5+iEJyB9oNy/f2dtv1+1Dqp+4G5zypCr
         1dx834GNJjay6qZwTNDNoiJHnjXu2tHJsXyRk2NiSlwxttNbSVp/8hQFdAm3LwX04osk
         1s6DreY/lLmRGKR+QLx7o5yV3Qw8LRchWKXtdhNJZDtlyRe19oqPJznpbXvboIaIRH03
         7OYkY2yphaKbfYtjncy5w9Q/g2BATLIuALNr+5ydaiqhhOa/w2+unxIsv10LIzqpDZfu
         XPWg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=GzOs4d8F;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=GzOs4d8F;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Vitaly Wool <vitaly.vul@sony.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Oleksiy.Avramchenko@sony.com,
	Matthew Wilcox <mawilcox@microsoft.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 30/62] z3fold: fix reclaim lock-ups
Date: Mon, 14 May 2018 08:48:46 +0200
Message-Id: <20180514064818.027481786@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064816.436958006@linuxfoundation.org>
References: <20180514064816.436958006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421685280567411?=
X-GMAIL-MSGID: =?utf-8?q?1600421685280567411?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vitaly Wool <vitalywool@gmail.com>

commit 6098d7e136692f9c6e23ae362c62ec822343e4d5 upstream.

Do not try to optimize in-page object layout while the page is under
reclaim.  This fixes lock-ups on reclaim and improves reclaim
performance at the same time.

[akpm@linux-foundation.org: coding-style fixes]
Link: http://lkml.kernel.org/r/20180430125800.444cae9706489f412ad12621@gmail.com
Signed-off-by: Vitaly Wool <vitaly.vul@sony.com>
Reported-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Cc: <Oleksiy.Avramchenko@sony.com>
Cc: Matthew Wilcox <mawilcox@microsoft.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/z3fold.c |   42 ++++++++++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 12 deletions(-)

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
@@ -173,6 +174,7 @@ static struct z3fold_header *init_z3fold
 	clear_bit(MIDDLE_CHUNK_MAPPED, &page->private);
 	clear_bit(NEEDS_COMPACTING, &page->private);
 	clear_bit(PAGE_STALE, &page->private);
+	clear_bit(UNDER_RECLAIM, &page->private);
 
 	spin_lock_init(&zhdr->page_lock);
 	kref_init(&zhdr->refcount);
@@ -748,6 +750,10 @@ static void z3fold_free(struct z3fold_po
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
@@ -832,6 +838,8 @@ static int z3fold_reclaim_page(struct z3
 			kref_get(&zhdr->refcount);
 			list_del_init(&zhdr->buddy);
 			zhdr->cpu = -1;
+			set_bit(UNDER_RECLAIM, &page->private);
+			break;
 		}
 
 		list_del_init(&page->lru);
@@ -879,25 +887,35 @@ static int z3fold_reclaim_page(struct z3
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
+			if (kref_put(&zhdr->refcount,
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
