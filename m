Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207E1C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2E552177B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545297748;
	bh=H3w6srhDiTuv5sxUpQKy9YYZV5Gimb7af/9a0cOMRk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mL4rlD8FXBktgoZrTZogGZVQuOQfOgitvkBaDJrJw+IQ3IWMs174XCcyUtvbbjcL3
	 xm1GCBdonLCW3pchYM8A/NIk5JeWUO0s99xf/fbVJZuyC6kk6mWgElNXpJ5qGgadCh
	 GiiGUvY3sepblQIdhg8cZ6H1O+OBRf5fpCJ1DSrI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731344AbeLTJW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:22:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:43192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731305AbeLTJWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:22:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E10320449;
        Thu, 20 Dec 2018 09:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297741;
        bh=H3w6srhDiTuv5sxUpQKy9YYZV5Gimb7af/9a0cOMRk8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tf5RX7EdHCGr1kMs6tCqqrXQ4gsGZqxiwEfaINnFH8TvktVtP/Pwpv0jskPwtQgpp
         EpV1jwomevTmh6SXp9v9pqgJEp95EHSYue5Tdm7GLF4XBilAdSQMHCKNT6WkgbRRhj
         zTDd+xv8rdKgaE0IdIBoVtLpr1C+5MFJB6V/+BG4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 05/40] lib/interval_tree_test.c: allow users to limit scope of endpoint
Date:   Thu, 20 Dec 2018 10:18:17 +0100
Message-Id: <20181220085826.702779648@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085826.212663515@linuxfoundation.org>
References: <20181220085826.212663515@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit a8ec14d4f6aa8e245efacc992c8ee6ea0464ce2a ]

Add a 'max_endpoint' parameter such that users may easily limit the size
of the intervals that are randomly generated.

Link: http://lkml.kernel.org/r/20170518174936.20265-4-dave@stgolabs.net
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/interval_tree_test.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/lib/interval_tree_test.c b/lib/interval_tree_test.c
index bababcf7ffdd..222c8010bda0 100644
--- a/lib/interval_tree_test.c
+++ b/lib/interval_tree_test.c
@@ -17,6 +17,7 @@ __param(int, nsearches, 100, "Number of searches to the interval tree");
 __param(int, search_loops, 1000, "Number of iterations searching the tree");
 __param(bool, search_all, false, "Searches will iterate all nodes in the tree");
 
+__param(uint, max_endpoint, ~0, "Largest value for the interval's endpoint");
 
 static struct rb_root root = RB_ROOT;
 static struct interval_tree_node *nodes = NULL;
@@ -41,18 +42,20 @@ static void init(void)
 	int i;
 
 	for (i = 0; i < nnodes; i++) {
-		u32 a = prandom_u32_state(&rnd);
-		u32 b = prandom_u32_state(&rnd);
-		if (a <= b) {
-			nodes[i].start = a;
-			nodes[i].last = b;
-		} else {
-			nodes[i].start = b;
-			nodes[i].last = a;
-		}
+		u32 b = (prandom_u32_state(&rnd) >> 4) % max_endpoint;
+		u32 a = (prandom_u32_state(&rnd) >> 4) % b;
+
+		nodes[i].start = a;
+		nodes[i].last = b;
 	}
+
+	/*
+	 * Limit the search scope to what the user defined.
+	 * Otherwise we are merely measuring empty walks,
+	 * which is pointless.
+	 */
 	for (i = 0; i < nsearches; i++)
-		queries[i] = prandom_u32_state(&rnd);
+		queries[i] = (prandom_u32_state(&rnd) >> 4) % max_endpoint;
 }
 
 static int interval_tree_test_init(void)
-- 
2.19.1



