Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5E0C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E0020811
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298965;
	bh=mUjuyG5x8O8H2jaaQW6uERta2Ow/KvXx0VcoF348hew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1puWt4HaVYDMw983kgl1tLVdgam+PoJzOJi8Y0vzl9vf0HhzCvlcoyXbVSsqMj28/
	 4zAW1N+Ztv5dg5X7G+sqzGXUAQIfqNYKmF/7gFkv3fjCjDRYDnSgVS0ATj6KzlUfxX
	 6M6DVo7zkPz8uJjuM6ZPZGBRMBFt6gFCz55MDSyo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387463AbeLTJmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:42:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:51502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731567AbeLTJXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:23:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE1AF20656;
        Thu, 20 Dec 2018 09:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297793;
        bh=mUjuyG5x8O8H2jaaQW6uERta2Ow/KvXx0VcoF348hew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J5U2FjBhd6WgSLEmg7airfPrKQuDM8tA2RBy3TDKkK1S9Hr+Gp5cH5v7crZSKwFTd
         dMX6/+WvV/lheiUkvNZDza+qbTdw5WRsl9EGVzGYCa3FTIVI6JEJCBml5pvJYkfwjZ
         KmE1+IUUpZoHMU1Z9kBA1ZrHe/OL2B1xpkTNq92E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 06/61] lib/interval_tree_test.c: allow users to limit scope of endpoint
Date:   Thu, 20 Dec 2018 10:18:06 +0100
Message-Id: <20181220085843.986680797@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085843.743900603@linuxfoundation.org>
References: <20181220085843.743900603@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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



