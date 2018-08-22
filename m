Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B81C04AB9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 11:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4139F214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 11:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="LkAqiOCM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4139F214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbeHVOYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 10:24:44 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43754 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728603AbeHVOYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 10:24:43 -0400
Received: by mail-lj1-f196.google.com with SMTP id m84-v6so1089675lje.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 04:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=paRhIBVvA98M1YaFRDxC/cTAcsVACbmzPnLIVkrTfM4=;
        b=LkAqiOCM8aejFFzeAx6ieICxHf2PC+ZjflLE5Ypz58L6u372iikvG1VGjC3xlb2oqL
         elce+TGMO/LtzCVXkc0wzS3RPqJJyjlfX/NTaxwWoXUt7EHqi40Fk9b/zKxqTGSiEOcD
         6UmVQWuki/l8ndnI3qDYs018pbbqa6PDTmsLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=paRhIBVvA98M1YaFRDxC/cTAcsVACbmzPnLIVkrTfM4=;
        b=iGxwlivqLnf3AV/XDbeqaBYWYRRKm3fQanzGOcwUx2G1tEOb2OOgysCsvoCv/Xpb6c
         rSjSXCkU0XLLaJX6N8WjADOZfuyZxsMFwZpReedrEjvPN6qCDmoR99Y+8FlomnzYQEKs
         +jSXVKQbeSKiNcRtPY3J4ulf0wAWRQS6agfhITNttuz3B/gSstsCc9BVEXKr/bqXGzVz
         /ASW52smtVvR2nS+nsyCaBvvxfVj2PHbVm2+O80VTGdkVObAd8VhpMUk9dcKm29nkgU3
         T0v1z255BWNP2YgmFD5sSI1CXUZ67wuRyyJgoNNC/C243UUXWAiH8lOr6VSADhADCUbo
         yz7w==
X-Gm-Message-State: AOUpUlHaadTRdEpxhuoK7epzLwZW43D1TJtZkZ1fL7F23MsGAIWbMlzG
        lXBP+dtWl7WKPLt+w1kJCrynMw==
X-Google-Smtp-Source: AA+uWPxPHIC3YhD7yY3VZPherXzSXYr4Nl8JafCDnwNPwSywfhMscjTyjYAemlM9K0E4uBlMFYx64Q==
X-Received: by 2002:a2e:b007:: with SMTP id y7-v6mr17679017ljk.22.1534935616799;
        Wed, 22 Aug 2018 04:00:16 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id y5-v6sm234273ljj.75.2018.08.22.04.00.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 22 Aug 2018 04:00:16 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 3/4] lib/, include/: avoid const-laundering warnings
Date:   Wed, 22 Aug 2018 13:00:08 +0200
Message-Id: <20180822110009.17583-3-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180822110009.17583-1-linux@rasmusvillemoes.dk>
References: <20180822110009.17583-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even though str*() launders the const away for us, we should and do not
modify the buffer through the returned pointer, so might as well declare
it const.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/cpumask.h | 2 +-
 lib/bitmap.c            | 2 +-
 lib/parser.c            | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 147bdec42215..82f4e39b4dc6 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -633,7 +633,7 @@ static inline int cpumask_parselist_user(const char __user *buf, int len,
  */
 static inline int cpumask_parse(const char *buf, struct cpumask *dstp)
 {
-	char *nl = strchr(buf, '\n');
+	const char *nl = strchr(buf, '\n');
 	unsigned int len = nl ? (unsigned int)(nl - buf) : strlen(buf);
 
 	return bitmap_parse(buf, len, cpumask_bits(dstp), nr_cpumask_bits);
diff --git a/lib/bitmap.c b/lib/bitmap.c
index 730969c681cb..de47d7ebbb5f 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -620,7 +620,7 @@ static int __bitmap_parselist(const char *buf, unsigned int buflen,
 
 int bitmap_parselist(const char *bp, unsigned long *maskp, int nmaskbits)
 {
-	char *nl  = strchrnul(bp, '\n');
+	const char *nl  = strchrnul(bp, '\n');
 	int len = nl - bp;
 
 	return __bitmap_parselist(bp, len, 0, maskp, nmaskbits);
diff --git a/lib/parser.c b/lib/parser.c
index 3278958b472a..ffb09e9cc8f4 100644
--- a/lib/parser.c
+++ b/lib/parser.c
@@ -25,7 +25,7 @@
  */
 static int match_one(char *s, const char *p, substring_t args[])
 {
-	char *meta;
+	const char *meta;
 	int argc = 0;
 
 	if (!p)
-- 
2.16.4

