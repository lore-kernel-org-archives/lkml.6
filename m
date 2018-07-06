Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D750C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B64AD24061
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNqN7leF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B64AD24061
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932236AbeGFFLa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:11:30 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38158 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932158AbeGFFL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:11:29 -0400
Received: by mail-pf0-f193.google.com with SMTP id j17-v6so7371873pfn.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 22:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QefmJMg/TbWqvSsSmZgKfnbT6B5TaKOfp1HBZ4HNxV4=;
        b=XNqN7leFurlMlRpj5GSATxO9qF5C3knIkThz/q1GJXZCzoXYKjGOsO6lfQzZl+YUll
         AdppTWSuxaYRY0YVgBpZ/TNBlN+WX0RYduUsUIf/jw4wfUBK/aOihw65kYn+58yIioV2
         J3WUpz+2N63XAmwyVISjYd0JcBJaH5QaJTAV40mWxer6Wi1dpQ02HRvT+EQfqhRv54QD
         w6hPzzmdczW7Im+Rz5mRhxM0rkX3A7bVOpnnRw7F/DehKzTf/c5A8SFz/Lo72WyOpoii
         OPS6Itty+on4uyyQRMTSD8YUL3avqHtsgN/XM1kfcz/ckKN5XU/pegTWyQlIoQLhpB1J
         0Ssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QefmJMg/TbWqvSsSmZgKfnbT6B5TaKOfp1HBZ4HNxV4=;
        b=lKyDHFTwVIzfchufDeD0tzkd1oMZWLJ5oCeRJ2ekq57QhYl3RRgV0Fk/UKizzxZDH7
         n6QkqlKEYV9zDopGljvgiaeh+twuu908H/7C1E08jfQ67QjnLrc9N+3JfLos9MHBeYgY
         2YgAgcdYdYF4V6KREjqOKavVjAHpz243D1BGHaTSkEe9tHvjgNS1elkYMmS6wvpscrJJ
         fRDaexB0Ci+bm1l7VhTRLF1FMpWrg6zCps8CkKI+zz3qbpQNXNsWCys57jetxgflSyuO
         ggRfDKVnYk5rT4hn8X48kqiTyMtTAL2Q9TUvH4HrVuFaBzHHl14892f3vtnQT3kSJQnr
         UNlg==
X-Gm-Message-State: APt69E1600pPKd9pLmzNw0sKq1YtvmQ2icErfjlmOUiGn2/dmePW55lx
        hUCbY5fd4MV7jmeo7gHPJks=
X-Google-Smtp-Source: AAOMgpcM8TQj3OTN7Gd6kdk2BD6xkc8Alan7ZdJ02ysCInH9evRePdxzyS7s6aXkLTLD3CFuNaWlFA==
X-Received: by 2002:a65:450a:: with SMTP id n10-v6mr7848385pgq.392.1530853888951;
        Thu, 05 Jul 2018 22:11:28 -0700 (PDT)
Received: from localhost.localdomain ([115.145.179.108])
        by smtp.googlemail.com with ESMTPSA id v15-v6sm11460443pff.120.2018.07.05.22.11.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Jul 2018 22:11:27 -0700 (PDT)
From:   Jongseok Kim <ks77sj@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Vitaly Wool <vitalywool@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jongseok Kim <ks77sj@gmail.com>
Subject: [PATCH] z3fold: fix wrong handling of headless pages
Date:   Fri,  6 Jul 2018 14:10:46 +0900
Message-Id: <1530853846-30215-1-git-send-email-ks77sj@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During the processing of headless pages in z3fold_reclaim_page(),
there was a problem that the zhdr pointed to another page
or a page was already released in z3fold_free(). So, the wrong page
is encoded in headless, or test_bit does not work properly
in z3fold_reclaim_page(). This patch fixed these problems.

Signed-off-by: Jongseok Kim <ks77sj@gmail.com>
---
 mm/z3fold.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 4b366d1..201a8ac 100644
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
@@ -836,20 +839,20 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
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

