Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064EAC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3FA820837
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRiCgK4M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3FA820837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbeH3Xvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 19:51:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:33182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726959AbeH3Xvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 19:51:55 -0400
Received: from ebiggers-linuxstation.kir.corp.google.com (unknown [104.132.51.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6640120835;
        Thu, 30 Aug 2018 19:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535658488;
        bh=uDaG1NibEmP1EMiY7RFieIzm5sODN1XntoPdI5Ze0zM=;
        h=From:To:Cc:Subject:Date:From;
        b=FRiCgK4Ms7JQRsG5b++x4Gb4vGMqg6j7O6iYMYz5daCbtD2GneUHPioxN0DQo/aLM
         XuHnmsVfjyIeI+hP953ASn9It5jEjSxOlYqfe4Nlauy4OyBLIM96VfmQN2jIYx9rYI
         PcTwHHissprNIE7UI1EMGZaqkML4M4J6lsBb277o=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH] lib/parser.c: switch match_number() over to use match_strdup()
Date:   Thu, 30 Aug 2018 12:47:27 -0700
Message-Id: <20180830194727.191555-1-ebiggers@kernel.org>
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
index 0142ef28f0eb..96656a6dd59b 100644
--- a/lib/parser.c
+++ b/lib/parser.c
@@ -131,13 +131,10 @@ static int match_number(substring_t *s, int *result, int base)
 	char *buf;
 	int ret;
 	long val;
-	size_t len = s->to - s->from;
 
-	buf = kmalloc(len + 1, GFP_KERNEL);
+	buf = match_strdup(s);
 	if (!buf)
 		return -ENOMEM;
-	memcpy(buf, s->from, len);
-	buf[len] = '\0';
 
 	ret = 0;
 	val = simple_strtol(buf, &endp, base);
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

