Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA6CC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB70620835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VmC2MrW6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB70620835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbeH3Xw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 19:52:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:33278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726959AbeH3Xw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 19:52:29 -0400
Received: from ebiggers-linuxstation.kir.corp.google.com (unknown [104.132.51.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 734D620835;
        Thu, 30 Aug 2018 19:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535658522;
        bh=dvXcfjB+pVfG66yrRH0xI+DG7Hnf7VlOAIQfpSMyThY=;
        h=From:To:Cc:Subject:Date:From;
        b=VmC2MrW6BxRzgbOfk3+LYdn2Kw+1bUAarxJcUEdeYdgLp9y0st7A4XvnTn4OlV37V
         1qTU4/r6jNiuI00sLMPvMGHjY6xkFcA4ue+qAw5ZuIRhVltgXzXupf61nL0zYpTTHB
         VnowZfEApG+2SrI6fpmpVPpB175XKVPWcF1XcPuE=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH] lib/parser.c: switch match_u64int() over to use match_strdup()
Date:   Thu, 30 Aug 2018 12:48:14 -0700
Message-Id: <20180830194814.192880-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

This simplifies the code.  No change in behavior.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 lib/parser.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/lib/parser.c b/lib/parser.c
index 96656a6dd59b..dd70e5e6c9e2 100644
--- a/lib/parser.c
+++ b/lib/parser.c
@@ -163,13 +163,10 @@ static int match_u64int(substring_t *s, u64 *result, int base)
 	char *buf;
 	int ret;
 	u64 val;
-	size_t len = s->to - s->from;
 
-	buf = kmalloc(len + 1, GFP_KERNEL);
+	buf = match_strdup(s);
 	if (!buf)
 		return -ENOMEM;
-	memcpy(buf, s->from, len);
-	buf[len] = '\0';
 
 	ret = kstrtoull(buf, base, &val);
 	if (!ret)
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

