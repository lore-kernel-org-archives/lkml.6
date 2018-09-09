Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534A0C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 13:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7C7C20866
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 13:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=meituan.com header.i=@meituan.com header.b="ddAk+4gq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7C7C20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=meituan.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbeIISTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 14:19:17 -0400
Received: from mx-fe5-210.meituan.com ([103.37.138.210]:44087 "EHLO
        mx02.meituan.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726929AbeIISTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 14:19:17 -0400
X-Greylist: delayed 470 seconds by postgrey-1.27 at vger.kernel.org; Sun, 09 Sep 2018 14:19:14 EDT
Received: from localhost (localhost [127.0.0.1])
        by dx-it-mx02.dx.sankuai.com (Postfix) with ESMTP id 2D5AA297C475;
        Sun,  9 Sep 2018 21:21:31 +0800 (CST)
Received: from mx02.meituan.com ([127.0.0.1])
        by localhost (dx-it-mx02.dx.sankuai.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id UoZvdoxtktc3; Sun,  9 Sep 2018 21:21:29 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by dx-it-mx02.dx.sankuai.com (Postfix) with ESMTP id F3FB7297C46A;
        Sun,  9 Sep 2018 21:21:28 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 dx-it-mx02.dx.sankuai.com F3FB7297C46A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meituan.com;
        s=20130113; t=1536499289;
        bh=RGgnpuYQjJpjqPBY8lWvTUiTCoGVisbdsAJqt+Sf3Qw=;
        h=From:To:Subject:Date:Message-Id;
        b=ddAk+4gqbeb4rflM6d5y+FcZVVQtm3wRIDUy5AjrQlsf7q/DCxRrXhn2d7WFIowUC
         TwjVTZNtLr6yJFqTPfopZ2mhUA7DMWvQk4pWwF4YUGxS6Ngfou7RccCCv7+VYH2VCD
         gTgcKuS5ubqWDQwM7tEFoaRo2KnX/71dRrt3ekFQ=
X-Virus-Scanned: amavisd-new at dx-it-mx02.dx.sankuai.com
Received: from mx02.meituan.com ([127.0.0.1])
        by localhost (dx-it-mx02.dx.sankuai.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LvDQ1GMDhaXG; Sun,  9 Sep 2018 21:21:28 +0800 (CST)
Received: from localhost.yf.sankuai.com (unknown [103.37.142.38])
        by dx-it-mx02.dx.sankuai.com (Postfix) with ESMTPA id 3F79E297C470;
        Sun,  9 Sep 2018 21:21:05 +0800 (CST)
From:   Wang Long <wanglong19@meituan.com>
To:     willy@infradead.org, akpm@linux-foundation.org,
        wanglong19@meituan.com, zwisler@kernel.org
Cc:     linux-kernel@vger.kernel.org, jack@suse.cz, heguanjun@meituan.com
Subject: [PATCH] radix-tree: optimization for radix_tree_init_maxnodes
Date:   Sun,  9 Sep 2018 21:21:00 +0800
Message-Id: <1536499260-126634-1-git-send-email-wanglong19@meituan.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if i == 0, height_to_maxnodes[i] = 0,
if i >= 1, height_to_maxnodes[i] = height_to_maxnodes[i-1]
				+ __maxindex(i-1) + 1.

so delete height_to_maxindex and optimize the calculation of
height_to_maxnodes array.

Signed-off-by: Wang Long <wanglong19@meituan.com>
---
 lib/radix-tree.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index bc03ecc..af02b2c 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -2242,14 +2242,11 @@ static __init unsigned long __maxindex(unsigned int height)
 
 static __init void radix_tree_init_maxnodes(void)
 {
-	unsigned long height_to_maxindex[RADIX_TREE_MAX_PATH + 1];
-	unsigned int i, j;
-
-	for (i = 0; i < ARRAY_SIZE(height_to_maxindex); i++)
-		height_to_maxindex[i] = __maxindex(i);
-	for (i = 0; i < ARRAY_SIZE(height_to_maxnodes); i++) {
-		for (j = i; j > 0; j--)
-			height_to_maxnodes[i] += height_to_maxindex[j - 1] + 1;
+	unsigned int i;
+
+	for (i = 1; i < ARRAY_SIZE(height_to_maxnodes); i++) {
+		height_to_maxnodes[i] = height_to_maxnodes[i - 1]
+					+  __maxindex(i - 1) + 1;
 	}
 }
 
-- 
1.8.3.1

