Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AB5C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE8C20835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOQXAX0z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EE8C20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbeH3XvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 19:51:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:32886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726959AbeH3XvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 19:51:00 -0400
Received: from ebiggers-linuxstation.kir.corp.google.com (unknown [104.132.51.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F009320835;
        Thu, 30 Aug 2018 19:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535658434;
        bh=nJx1YFbqzFO2ldmbySm5PaxUfELXfcSHP4Jm53miU0k=;
        h=From:To:Cc:Subject:Date:From;
        b=FOQXAX0z9i2nIu/kOgyzPQOkqXxR2AIsZJZKXGG2bNBetg7O+jsUKCZePbKQRLQYx
         fDeRFhcENCvxhwQn9614Bzb16O92ha0W3+l4EeMrWnargDbbuLDhsxiI7YdF28jslV
         nyjCpeGaQ+cRmZYKBQS4b5UnXfiSmltpwtzVO73w=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH] lib/parser.c: switch match_strdup() over to use kmemdup_nul()
Date:   Thu, 30 Aug 2018 12:44:36 -0700
Message-Id: <20180830194436.188867-1-ebiggers@kernel.org>
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
 lib/parser.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/lib/parser.c b/lib/parser.c
index 3278958b472a..0142ef28f0eb 100644
--- a/lib/parser.c
+++ b/lib/parser.c
@@ -327,10 +327,6 @@ EXPORT_SYMBOL(match_strlcpy);
  */
 char *match_strdup(const substring_t *s)
 {
-	size_t sz = s->to - s->from + 1;
-	char *p = kmalloc(sz, GFP_KERNEL);
-	if (p)
-		match_strlcpy(p, s, sz);
-	return p;
+	return kmemdup_nul(s->from, s->to - s->from, GFP_KERNEL);
 }
 EXPORT_SYMBOL(match_strdup);
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

