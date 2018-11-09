Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495E6C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0251F20855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="LnD4YQ42"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0251F20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbeKJIyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 03:54:03 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44735 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728765AbeKJIyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 03:54:02 -0500
Received: by mail-lj1-f196.google.com with SMTP id k19-v6so2945635lji.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 15:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uNoGVf7Ddr77R5P/EQPIC/miS/nc7l5r4RHb00Kf/Yo=;
        b=LnD4YQ42GCIwbo+93Vyt7RcSEJlTcE7sH0hvPl2xRzqZv8ujMb1duNIiwzwuQr9iyo
         G9+enmFbh0wuV9Fbx5HBe3nfmLA3M05pE2OAEXFtqgr2GJWe/ZQ+aQqIFtlCee1CiS4j
         GcMxIrgJbnAJgdZKsY8mCaDn3BuWEBNwYRSU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uNoGVf7Ddr77R5P/EQPIC/miS/nc7l5r4RHb00Kf/Yo=;
        b=OhpclxLAG29hWefg4Fyx0sSHYZCAZdUmOgL/7LG7CBwagrTLOJQWuAnSur7RuppH7x
         7nGyDct6O6Dmtwb+y82mlO1BW3vrPQvrjn93lpkk9dkbh25BhxWSpRjN0Fc7/eA59mv0
         NG1F4VZshVmYPxvHfwyqrgj23JD5Dkl7x8/AGuE3K1xVHUTiO6Pj8WnTEZGI64aDqlGv
         +vLB5Arif/gHZmXDhF5HRVzwGIKhI3YmtC7DOjq/0Lv3PLIKTDlv0Et0ZpHruX9565Ak
         nl5DNqkCKHKmkOIAqvNu2SmljIxYgJtnNlWgGuYhlf2HiaTE6S4DNuTpp0zZB6hBO36F
         JZ6g==
X-Gm-Message-State: AGRZ1gIfR8e7M2cesmRu0W4SGd5CtskGgDMw2A42AJeT/XD/p93FbNg4
        BjACbQGx5H8X02jKaTKxCEQod93Bf9Xw5w==
X-Google-Smtp-Source: AJdET5cmGghbCvRNZ9T2lXy0xqH4jBC4Gru8INUhEKRHVbvtFz9UPsU3OvGFKSJGsyxGac+yTtCmcQ==
X-Received: by 2002:a2e:8643:: with SMTP id i3-v6mr5883593ljj.43.1541805075553;
        Fri, 09 Nov 2018 15:11:15 -0800 (PST)
Received: from prevas-ravi.prevas.se (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id x16sm1584012lff.26.2018.11.09.15.11.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Nov 2018 15:11:15 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v3 13/23] dynamic_debug: refactor dynamic_pr_debug and friends
Date:   Sat, 10 Nov 2018 00:10:11 +0100
Message-Id: <20181109231021.11658-14-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.gbde171bbf5
In-Reply-To: <20181109231021.11658-1-linux@rasmusvillemoes.dk>
References: <20181009112013.14238-1-linux@rasmusvillemoes.dk>
 <20181109231021.11658-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Acked-by: Jason Baron <jbaron@akamai.com>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/dynamic_debug.h | 72 +++++++++++++++++++++--------------
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
2.19.1.6.gbde171bbf5

