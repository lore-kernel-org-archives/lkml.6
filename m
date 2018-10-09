Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BDBC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA7A20835
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="S4gdm2YN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABA7A20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbeJISia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:38:30 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46106 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbeJIShE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:37:04 -0400
Received: by mail-ed1-f67.google.com with SMTP id g32-v6so1301486edg.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rvKmC7FklvNFll3vbldHb5MerHtw+/nEmhldJ96QI9U=;
        b=S4gdm2YNye4gGYMutZ4DnGfRAm+F4823fzVKobPsc30qSE1ORBSSaCUB6rjcRxIIfF
         p4XKicMP0/bs7gAzE21tFWYjo40fNmp9bxAsI0sneadYodL69Xo0Zp76tQBMuDV4cokl
         a7VxYDbHq6vcnfnQheTw8ym1SynED1AVQkfwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rvKmC7FklvNFll3vbldHb5MerHtw+/nEmhldJ96QI9U=;
        b=IXoih6Z+X5AAiuuRN/woAZxzhqlqq4CaK4LNOUeGH3FqJJ85D5fKEuZ2SdXyMVhUf1
         ppndtOA4zauSNtuhW+XUm+Pq3uI/vu+18LoAqmQjKTngPy22SGkEwI+amyF/5HjsXLNf
         bnsHe9ImSGevlfzxSUIiMvVhPvgsI1v7mtQd+Tm/M0/YjiJLKEEc9GtNybva91ZfoOjS
         SrxjDfYHCxrb4Jl9AOxswWLVstX0fsBUC8nc963RzoSNBQgtbDTBb9HITgE3NxoDqKT2
         Fkz5kgsu8m7guvdGA1ydh7pTDX57cjvzfSN8go2xeTvI9pMNOFv2/H35upK//aUBOeac
         83og==
X-Gm-Message-State: ABuFfohgqhzoCdU7CoGFaNq4LIa7Ade5JT2jkJMtyTmlHnAuACVq3T0T
        dCM9s4aPuUW4ZduETe4f9pMtVA==
X-Google-Smtp-Source: ACcGV636B/ZuBe/WP6kA6ruBksO+OFze8DqZxHAloSg/D75b4CcpAQJkltLOeZhw4g+a4IA2vqq4wA==
X-Received: by 2002:a50:89ab:: with SMTP id g40-v6mr33348805edg.257.1539084033376;
        Tue, 09 Oct 2018 04:20:33 -0700 (PDT)
Received: from prevas-ravi.vestasvisitor.net ([193.47.71.171])
        by smtp.gmail.com with ESMTPSA id n23-v6sm3595821eja.41.2018.10.09.04.20.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Oct 2018 04:20:33 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 13/23] dynamic_debug: refactor dynamic_pr_debug and friends
Date:   Tue,  9 Oct 2018 13:20:03 +0200
Message-Id: <20181009112013.14238-14-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.4.g721af0fda3
In-Reply-To: <20181009112013.14238-1-linux@rasmusvillemoes.dk>
References: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
 <20181009112013.14238-1-linux@rasmusvillemoes.dk>
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
2.19.1.3.g1d92a00e68

