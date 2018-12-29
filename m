Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EC8C43444
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 01:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F0E621901
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 01:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oWZw0X59"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbeL2Bb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 20:31:59 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:55586 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbeL2Bb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 20:31:58 -0500
Received: by mail-pg1-f202.google.com with SMTP id g188so20927769pgc.22
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 17:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=jCn6C/cpRHtM9VQxY+22Xn56ZeUCdkzguW82dVDfWug=;
        b=oWZw0X59mBgdk8cEHTvD73zbKXKCYhLL4ihzdBP1B+abwCrZZrRxPH9mQ77369eLc5
         i/L6QPcKcCEJuOqRkMvL94x9fmmXFhR8ADtmXqh0Fr1LYndK6ZgQZXW9fzzAkLGjqch0
         A0a8iunsmq2eiIPriGrm0mAbYCJID1ctyfiz5hgu/fvv9GHGTHaFcnUMlaF8USWx+sdb
         vYEWgoICKdl6xN4iSB+rEXyZr7VVESWAxSdck3rEdb6/frweUGnaqbMErjJ9w84amCNm
         ct99MgKNuXyHeRipm/rVz7RfdspV+sOod4b5U4J3lhEAnq4iXygvARafU8dFuDP7Fp77
         vabw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=jCn6C/cpRHtM9VQxY+22Xn56ZeUCdkzguW82dVDfWug=;
        b=LVzSW8btqhsp/vWQXGonUpRa/2Oo2ijHv8FR+LYwZbNVTCTqy19lujfTlsa5rzA4Yu
         BpnMn47kageFoaOpAjr7ZD1aMZ/uluFq5zao1neeTo1M4GmL+j0/D3YBXWrWbYDedk08
         kfhhDXEhtlZX0Y9IQMz4u0J4KIZQrNziEQB4cXQnmJbwCeDMc1UXVdaJMMH9ZoVZLObp
         WQXhm2Gj1cNEF9/BuJcgXpIrJ7ZFNToOqvgjl4lSMQnbNwbDJFLGR5TPdS6K7W9SU1bS
         OONFVJIZbqRxGg1nyZ2sbtyn/TqOmFxJwGzclrFDA2o856PxrxwMrSC/Bbpg5Yhu9K0e
         MOhA==
X-Gm-Message-State: AJcUukeQ3IaB9mVTKeKKKkpn6E13psoG5UAf1WSpQ6WXEj8AHZ9D9uw9
        PTYP8g/feQ2YFD2ColFcRShDotRqylTGQA==
X-Google-Smtp-Source: ALg8bN5AHRIe6jH1ZAHDzOHvD4iJTPGLBhxndrma8kZubs7W9wNjBNoBepBopB0KsdmeyudMuKPsujqEwtslqg==
X-Received: by 2002:a63:3f41:: with SMTP id m62mr13692380pga.8.1546047116752;
 Fri, 28 Dec 2018 17:31:56 -0800 (PST)
Date:   Fri, 28 Dec 2018 17:31:47 -0800
Message-Id: <20181229013147.211079-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
Subject: [PATCH] percpu: plumb gfp flag to pcpu_get_pages
From:   Shakeel Butt <shakeelb@google.com>
To:     Tejun Heo <tj@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__alloc_percpu_gfp() can be called from atomic context, so, make
pcpu_get_pages use the gfp provided to the higher layer.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 mm/percpu-vm.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/percpu-vm.c b/mm/percpu-vm.c
index d8078de912de..4f42c4c5c902 100644
--- a/mm/percpu-vm.c
+++ b/mm/percpu-vm.c
@@ -21,6 +21,7 @@ static struct page *pcpu_chunk_page(struct pcpu_chunk *chunk,
 
 /**
  * pcpu_get_pages - get temp pages array
+ * @gfp: allocation flags passed to the underlying allocator
  *
  * Returns pointer to array of pointers to struct page which can be indexed
  * with pcpu_page_idx().  Note that there is only one array and accesses
@@ -29,7 +30,7 @@ static struct page *pcpu_chunk_page(struct pcpu_chunk *chunk,
  * RETURNS:
  * Pointer to temp pages array on success.
  */
-static struct page **pcpu_get_pages(void)
+static struct page **pcpu_get_pages(gfp_t gfp)
 {
 	static struct page **pages;
 	size_t pages_size = pcpu_nr_units * pcpu_unit_pages * sizeof(pages[0]);
@@ -37,7 +38,7 @@ static struct page **pcpu_get_pages(void)
 	lockdep_assert_held(&pcpu_alloc_mutex);
 
 	if (!pages)
-		pages = pcpu_mem_zalloc(pages_size, GFP_KERNEL);
+		pages = pcpu_mem_zalloc(pages_size, gfp);
 	return pages;
 }
 
@@ -278,7 +279,7 @@ static int pcpu_populate_chunk(struct pcpu_chunk *chunk,
 {
 	struct page **pages;
 
-	pages = pcpu_get_pages();
+	pages = pcpu_get_pages(gfp);
 	if (!pages)
 		return -ENOMEM;
 
@@ -316,7 +317,7 @@ static void pcpu_depopulate_chunk(struct pcpu_chunk *chunk,
 	 * successful population attempt so the temp pages array must
 	 * be available now.
 	 */
-	pages = pcpu_get_pages();
+	pages = pcpu_get_pages(GFP_KERNEL);
 	BUG_ON(!pages);
 
 	/* unmap and free */
-- 
2.20.1.415.g653613c723-goog

