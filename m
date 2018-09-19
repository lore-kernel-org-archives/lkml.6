Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FFEECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D101D21522
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Kz3jOFqO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D101D21522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387472AbeITDpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 23:45:05 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37982 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733235AbeITDpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 23:45:04 -0400
Received: by mail-ed1-f66.google.com with SMTP id h33-v6so6182816edb.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 15:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NUlRhFFUn+OBNdcKE38oMHBd/eRPdho70t2mDPjGSPY=;
        b=Kz3jOFqOe4w9HYjNpf0N5dD/BXdzDYiU5Kwf/d2NcYFql/dbDA+Za0/LeBu8vu2/uX
         rWkZwiPXJD4ov0VVPUPcW5Rkm0ydfrJmb9pKJKWrmjBZyPRrxd/gOzaq1e8u386g3EEi
         +aMme/Nxu721aIjkKex6vOJm6YUEroFxzAaV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NUlRhFFUn+OBNdcKE38oMHBd/eRPdho70t2mDPjGSPY=;
        b=ndRqkzvzCqA28OS+Ver32v25l+AGf0jgvvcgMVztlUafWR5NrjoJ/QzStH3BX6HG42
         ARSBeZhsSTp+Ns6ARGxghsODcg0UIp+nNuWOFFLjE11wtL4bXrw9QtATZFvPcS3ZsWHR
         4HEKtYPN+aCGaudya5ws+bVQ72UqR7ZNmr3dVQbziU5xQSu0LUBYiOxWd9C2AanKqiFd
         YwbyxOGAWffeCeqAcYME4Ta22unay0DKSEVurvuRTPxw5nZfBMjYZ/KDZekGU6ZZHH+z
         mLaHmFrLr3Rre+s3NSAA3MudAFBjrgwsknFJzupdUl0/F2FMdAUVKLiH7DnTCFK0XNY4
         Sakw==
X-Gm-Message-State: APzg51BhXSVI6tlh5lAFHOxU/l1mixColJCU8/LUdOhaqNfxohHBMF4y
        x2X9DrMVS/bmQy5lhEuFZsjzZQ==
X-Google-Smtp-Source: ANB0VdYK52gHsKiDxURTJVlHgt7fWwMN/XFs8p1XaB3BC4uLadIAzPD4GKgY1hZGZva1OoGOmm9DEQ==
X-Received: by 2002:a50:fd10:: with SMTP id i16-v6mr22514445eds.253.1537394706312;
        Wed, 19 Sep 2018 15:05:06 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-115-161.cgn.ip.fibianet.dk. [5.186.115.161])
        by smtp.gmail.com with ESMTPSA id a9-v6sm2798edi.26.2018.09.19.15.05.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Sep 2018 15:05:05 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 13/22] dynamic_debug: refactor dynamic_pr_debug and friends
Date:   Thu, 20 Sep 2018 00:04:35 +0200
Message-Id: <20180919220444.23190-14-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
References: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the upcoming 'define the _ddebug descriptor in assembly', we need
all the descriptors in a translation unit to have distinct
names (because asm does not understand C scope). The easiest way to
achieve that is as usual with an extra level of macros, passing the
identifier to use to the innermost macro, generating it via __UNIQUE_ID
or something.

However, instead of repeating that exercise for dynamic_pr_debug,
dynamic_dev_dbg, dynamic_netdev_dbg and dynamic_hex_dump separately, we
can use the similarity between their bodies to implement them via a
common macro, _dynamic_func_call - though the hex_dump case requires
a slight variant, since print_hex_dump does not take the _ddebug
descriptor. We'll also get to use that variant elsewhere (btrfs).

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/dynamic_debug.h | 72 ++++++++++++++++++++++++++-----------------
 1 file changed, 43 insertions(+), 29 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 6a002b789d51..b9424097df37 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -112,40 +112,54 @@ void __dynamic_netdev_dbg(struct _ddebug *descriptor,
 
 #endif
 
-#define dynamic_pr_debug(fmt, ...)				\
-do {								\
-	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);		\
-	if (DYNAMIC_DEBUG_BRANCH(descriptor))			\
-		__dynamic_pr_debug(&descriptor, pr_fmt(fmt),	\
-				   ##__VA_ARGS__);		\
+#define __dynamic_func_call(id, fmt, func, ...) do {	\
+	DEFINE_DYNAMIC_DEBUG_METADATA(id, fmt);		\
+	if (DYNAMIC_DEBUG_BRANCH(id))			\
+		func(&id, ##__VA_ARGS__);		\
 } while (0)
 
-#define dynamic_dev_dbg(dev, fmt, ...)				\
-do {								\
-	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);		\
-	if (DYNAMIC_DEBUG_BRANCH(descriptor))			\
-		__dynamic_dev_dbg(&descriptor, dev, fmt,	\
-				  ##__VA_ARGS__);		\
+#define __dynamic_func_call_no_desc(id, fmt, func, ...) do {	\
+	DEFINE_DYNAMIC_DEBUG_METADATA(id, fmt);			\
+	if (DYNAMIC_DEBUG_BRANCH(id))				\
+		func(__VA_ARGS__);				\
 } while (0)
 
-#define dynamic_netdev_dbg(dev, fmt, ...)			\
-do {								\
-	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);		\
-	if (DYNAMIC_DEBUG_BRANCH(descriptor))			\
-		__dynamic_netdev_dbg(&descriptor, dev, fmt,	\
-				     ##__VA_ARGS__);		\
-} while (0)
+/*
+ * "Factory macro" for generating a call to func, guarded by a
+ * DYNAMIC_DEBUG_BRANCH. The dynamic debug decriptor will be
+ * initialized using the fmt argument. The function will be called with
+ * the address of the descriptor as first argument, followed by all
+ * the varargs. Note that fmt is repeated in invocations of this
+ * macro.
+ */
+#define _dynamic_func_call(fmt, func, ...)				\
+	__dynamic_func_call(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
+/*
+ * A variant that does the same, except that the descriptor is not
+ * passed as the first argument to the function; it is only called
+ * with precisely the macro's varargs.
+ */
+#define _dynamic_func_call_no_desc(fmt, func, ...)	\
+	__dynamic_func_call_no_desc(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
 
-#define dynamic_hex_dump(prefix_str, prefix_type, rowsize,	\
-			 groupsize, buf, len, ascii)		\
-do {								\
-	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor,		\
-		__builtin_constant_p(prefix_str) ? prefix_str : "hexdump");\
-	if (DYNAMIC_DEBUG_BRANCH(descriptor))			\
-		print_hex_dump(KERN_DEBUG, prefix_str,		\
-			       prefix_type, rowsize, groupsize,	\
-			       buf, len, ascii);		\
-} while (0)
+#define dynamic_pr_debug(fmt, ...)				\
+	_dynamic_func_call(fmt,	__dynamic_pr_debug,		\
+			   pr_fmt(fmt), ##__VA_ARGS__)
+
+#define dynamic_dev_dbg(dev, fmt, ...)				\
+	_dynamic_func_call(fmt,__dynamic_dev_dbg, 		\
+			   dev, fmt, ##__VA_ARGS__)
+
+#define dynamic_netdev_dbg(dev, fmt, ...)			\
+	_dynamic_func_call(fmt, __dynamic_netdev_dbg,		\
+			   dev, fmt, ##__VA_ARGS__)
+
+#define dynamic_hex_dump(prefix_str, prefix_type, rowsize,		\
+			 groupsize, buf, len, ascii)			\
+	_dynamic_func_call_no_desc(__builtin_constant_p(prefix_str) ? prefix_str : "hexdump", \
+				   print_hex_dump,			\
+				   KERN_DEBUG, prefix_str, prefix_type,	\
+				   rowsize, groupsize, buf, len, ascii)
 
 #else
 
-- 
2.16.4

