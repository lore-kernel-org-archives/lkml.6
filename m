Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D760C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 13:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B87042176D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 13:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="GT6Z//4A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B87042176D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbeHRQYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 12:24:17 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44819 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbeHRQYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 12:24:16 -0400
Received: by mail-ed1-f68.google.com with SMTP id f23-v6so5961223edr.11
        for <linux-kernel@vger.kernel.org>; Sat, 18 Aug 2018 06:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M63R+bwjcWLJCYg9UZRlu8yvl1lNEOBNwlXK22wst8Y=;
        b=GT6Z//4A70u6ifsgqQUbz5Ylydxlz2PExDlJT6W12niNd+5ceEpiv7jFG4o3/apcHj
         2IFO647MeoNJublCmsA+5SGHKYL2hGES5IUULjIKDq/pZSefjOIfU4O5K3EbpTBoGSGK
         7Vt9/BG0VuACOGA8wkx09rGjO9fRr59NF65hU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M63R+bwjcWLJCYg9UZRlu8yvl1lNEOBNwlXK22wst8Y=;
        b=GZoBy/TuVM4+sUZlqXGg27xtGEFNdWKBlcuYdZy4iiMUCDREowZvdX0qWwBUJOcsgl
         gVxgwS+3HOsUri2J07U5vIKrmvS6pi7UR5s6kG7ZgprY0TnjpYeo1k2dQcIt5rA1Zym/
         UjtI5QSAjrKsSH3HO1Z15TuB7vP633lqCCY16L6At8M9DeDNQEMGR1wo0OJ+3hLwUith
         vRiWMETcYaTA0VO5ZrrVUbvv2J8tObRKoZ7JldZ8sqMQ04JBn7hIsK2aihly8SzEAAlg
         j2Fd3+A2nhjBkSliV6F4vpiDB5+vd4AEls4f2e+OZqJ5UkT10A8DRvqVZdI3hylTB/o/
         L3DQ==
X-Gm-Message-State: AOUpUlFKJWhNyKDNhdYetqayfr3Vuvd+MEer9MuOtQjkJ9IukUGGhpnS
        zOP1Drpih2NMyazt3mYZNeZx7Q==
X-Google-Smtp-Source: AA+uWPxKzre4XyIVhQvAk0YjbCPxDGcEsjZBW+HJmzOytJARM4ka8u5xO4SNZ3lcY+x9OwtC+0hHUQ==
X-Received: by 2002:a50:d54a:: with SMTP id f10-v6mr28315372edj.151.1534598194290;
        Sat, 18 Aug 2018 06:16:34 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-114-212.cgn.ip.fibianet.dk. [5.186.114.212])
        by smtp.gmail.com with ESMTPSA id r11-v6sm2821403edp.60.2018.08.18.06.16.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 18 Aug 2018 06:16:33 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <ynorov@caviumnetworks.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] lib/bitmap.c: fix remaining space computation in bitmap_print_to_pagebuf
Date:   Sat, 18 Aug 2018 15:16:22 +0200
Message-Id: <20180818131623.8755-7-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180818131623.8755-1-linux@rasmusvillemoes.dk>
References: <20180818131623.8755-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For various alignments of buf, the current expression computes

4096 ok
4095 ok
8190
8189
...
4097

i.e., if the caller has already written two bytes into the page buffer,
len is 8190 rather than 4094, because PTR_ALIGN aligns up to the next
boundary. So if the printed version of the bitmap is huge, scnprintf()
ends up writing beyond the page boundary.

I don't think any current callers actually write anything before
bitmap_print_to_pagebuf, but the API seems to be designed to allow it.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 lib/bitmap.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 1f73b2e52186..277c9a63a5ab 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -460,14 +460,15 @@ EXPORT_SYMBOL(bitmap_parse_user);
  * ranges if list is specified or hex digits grouped into comma-separated
  * sets of 8 digits/set. Returns the number of characters written to buf.
  *
- * It is assumed that @buf is a pointer into a PAGE_SIZE area and that
- * sufficient storage remains at @buf to accommodate the
- * bitmap_print_to_pagebuf() output.
+ * It is assumed that @buf is a pointer into a PAGE_SIZE, page-aligned
+ * area and that sufficient storage remains at @buf to accommodate the
+ * bitmap_print_to_pagebuf() output. Returns the number of characters
+ * actually printed to @buf, excluding terminating '\0'.
  */
 int bitmap_print_to_pagebuf(bool list, char *buf, const unsigned long *maskp,
 			    int nmaskbits)
 {
-	ptrdiff_t len = PTR_ALIGN(buf + PAGE_SIZE - 1, PAGE_SIZE) - buf;
+	ptrdiff_t len = PAGE_SIZE - ((unsigned long)buf & (PAGE_SIZE-1));
 	int n = 0;
 
 	if (len > 1)
-- 
2.16.4

