Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7651C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80AC421871
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h17mYNWc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbfBZSmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 13:42:45 -0500
Received: from mail-qt1-f202.google.com ([209.85.160.202]:51375 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728996AbfBZSmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 13:42:44 -0500
Received: by mail-qt1-f202.google.com with SMTP id s8so12889669qth.18
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 10:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=v4WfsSw47DRlkp9YeYFf0nNx1o0W7a7PFh2stQvOZlw=;
        b=h17mYNWchKn5zBjHq56fo4f1DKtYRjAqAY1H9IrPa+r2X3csFFOW7SzOWpvbY61WN+
         M+p06LLo145QchAxtFuTWuajpS74KHCDmQnejJFrftQh6j763c7W5q+mDdbOzlM7EJHf
         8CbpvhrGjorvcK5RDgWZcjsyDAmsYy8wA7nIHrbF9WGUcFxQ0IeICcKAy+S+ojN6RygP
         BydpAZy7K+0dkvxKylakqNBXbhsuWLlhOpAOjTZ2Jf9yEKW9XuQckwx4M/Ux10MfJiQ9
         3W/O4MLOnEBeJ+qohZBMnuKh0lLa41dHpPW5DyBw7H1mpC0yRcbDlIC87xAY382eAo/g
         9dWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=v4WfsSw47DRlkp9YeYFf0nNx1o0W7a7PFh2stQvOZlw=;
        b=E01kpJA+vrooiCagOyf6KU2HldXy6SAYcqYIItolsdsfidf9nmv7laNkaEevaQ0GOV
         7S+pVaJkSjiv4J2Vc/a03pBaJsF4JxesV71EsCvELMmMDot6lejadPmzR9uqbthJ9+5e
         smjvqz2AJGQJAYa4NDldX/U00iau05KxBGyrJ3E9LznVHGG38ckVJMZfv3Pbg+pqgBnw
         kL/JT7KMcWqdhIxCesJPxdWkOh1Z4LL9zLR4I6F8zda4svUWeSrwMc5mU8vVBxRXNO9i
         btP9GMlA0zFBUkD4T66xIwmrENq+oqXV6tdYMTgddhcwvuUlJ35mwsi+9dKVJo21KCRh
         zcoQ==
X-Gm-Message-State: AHQUAua59ilen5fUtVaYN/SXjub0GSBfQeKkjqd9406s8/9ODzFCVqxt
        XKU1qgNH2WUbynlIpTdtcNsRLH6dtBzG7A==
X-Google-Smtp-Source: AHgI3IbUj3v71JL4V4v7antGtvxKB1RPZEAk0YIdOy9zjsiCJRZZMFW5eSxwFTe5TuWZXvMsvTkItC7j8I5JXw==
X-Received: by 2002:a0c:9678:: with SMTP id 53mr14835922qvy.16.1551206563846;
 Tue, 26 Feb 2019 10:42:43 -0800 (PST)
Date:   Tue, 26 Feb 2019 10:42:39 -0800
Message-Id: <20190226184239.49946-1-edumazet@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b-goog
Subject: [PATCH v2] iov_iter: optimize page_copy_sane()
From:   Eric Dumazet <edumazet@google.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        "David S . Miller" <davem@davemloft.net>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid cache line miss dereferencing struct page if we can.

page_copy_sane() mostly deals with order-0 pages.

Extra cache line miss is visible on TCP recvmsg() calls dealing
with GRO packets (typically 45 page frags are attached to one skb).

Bringing the 45 struct pages into cpu cache while copying the data
is not free, since the freeing of the skb (and associated
page frags put_page()) can happen after cache lines have been evicted.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index be4bd627caf060cd89aa41ac88208946da568035..4d6b19c1b1294e1c30f6bbb7137e98cca5121f13 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -861,8 +861,21 @@ EXPORT_SYMBOL(_copy_from_iter_full_nocache);
 
 static inline bool page_copy_sane(struct page *page, size_t offset, size_t n)
 {
-	struct page *head = compound_head(page);
-	size_t v = n + offset + page_address(page) - page_address(head);
+	struct page *head;
+	size_t v = n + offset;
+
+	/*
+	 * The general case needs to access the page order in order
+	 * to compute the page size.
+	 * However, we mostly deal with order-0 pages and thus can
+	 * avoid a possible cache line miss for requests that fit all
+	 * page orders.
+	 */
+	if (n <= v && v <= PAGE_SIZE)
+		return true;
+
+	head = compound_head(page);
+	v += (page - head) << PAGE_SHIFT;
 
 	if (likely(n <= v && v <= (PAGE_SIZE << compound_order(head))))
 		return true;
-- 
2.21.0.rc2.261.ga7da99ff1b-goog

