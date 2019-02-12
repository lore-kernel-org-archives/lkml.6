Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623E8C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 216D2222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="P5juK3zS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732022AbfBLVmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 16:42:12 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42439 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731676AbfBLVmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 16:42:09 -0500
Received: by mail-ed1-f66.google.com with SMTP id r15so152810eds.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 13:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=85vvFN2kaHL03HAGXK2CD9rX/wTyoy7q0CdAo1TKtSM=;
        b=P5juK3zSsaANB2V0jcvndYD2I2w84L+gKAdgX5lGHLKhllxN1OklLBKRz/q2KuLvrd
         Z/k9WXx0LJsMqBfLBOtCDuIqRXvwoZBC7DSaKAYe/QolDI1/Ypnl16OH5eRxPja//+tM
         1NwcvNETe2i3xSDNPoDL85+HHxmOtfA+xMapA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=85vvFN2kaHL03HAGXK2CD9rX/wTyoy7q0CdAo1TKtSM=;
        b=ovRZBd8+P0ZIHjkrC7T6pOrM+rr/VCxUeEZpOQnE5O6IEpEtyzMUx12Tq4IqrcgRMs
         CSp1eNYmPLKek2ZDMujxLZf0B1Xz+LFed0tSRyOoGzKIFkVNZwMY1KlTlt5+/I+h5Eue
         s39iIbgpO3eOxhcfo3K2EEkcVEdiLL9RK3VtGh+3pMhg9gsVrN/lx6khelsnyvnf3IAj
         s66TvScAmD1X9pbsAty5uWkzP9wo5ls07uBpd9M6DmpItyqp5QQnWdd+LP9yezUlvkaX
         7optJZvVfrjJAt6jOsk9B4jLPtU6Y32bk2WAX9/0G6GRkYMQA7GITjiXq9ErEKA/kpKf
         XMEw==
X-Gm-Message-State: AHQUAualQJr+aenWOVtDWpZaXU/aiMyPtQMRjZfJJaEtcB02r+Sp30F9
        l2eYFgpSYCouHBGUCMBqDU25uQ==
X-Google-Smtp-Source: AHgI3Ib4xYQ2cVfwvRnXPnYQIEKmWbvmkM3UKQAno/9ldBlQLAABV6hz7trZdF3yaO8BGl5ssalkiA==
X-Received: by 2002:a17:906:b7c3:: with SMTP id fy3mr4260766ejb.5.1550007727289;
        Tue, 12 Feb 2019 13:42:07 -0800 (PST)
Received: from prevas-ravi.waoo.dk (ip-5-186-119-174.cgn.fibianet.dk. [5.186.119.174])
        by smtp.gmail.com with ESMTPSA id v1sm3697607eds.47.2019.02.12.13.42.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 13:42:06 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v4 10/14] dynamic_debug: refactor dynamic_pr_debug and friends
Date:   Tue, 12 Feb 2019 22:41:46 +0100
Message-Id: <20190212214150.4807-11-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212214150.4807-1-linux@rasmusvillemoes.dk>
References: <20190212214150.4807-1-linux@rasmusvillemoes.dk>
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
index 3f8977cfa479..c2be029b9b53 100644
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
2.20.1

