Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9214BC43610
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5845120827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="clIVjBt6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5845120827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbeKJIxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 03:53:54 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46162 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728672AbeKJIxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 03:53:54 -0500
Received: by mail-lf1-f67.google.com with SMTP id f23so2475916lfc.13
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 15:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LVz7hfanUPgs/5gBPKjIjySKCUfWEDRpiem0HF6a6m8=;
        b=clIVjBt6OpmKBsU0pzTekzgB/Ad0qy0fO0EdIRFzxx0dwgZgX8G87nWrjpgASqUncR
         dwttDx7PMpFsW5IdzS9oOXrrFbZ9lxb0l7TeR3EYOL8l2s9+TokME6tnC8mXtDBME3bl
         Rs0phbI9Cjv1JCguM1J/RpSZlEpUflKn1G03g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LVz7hfanUPgs/5gBPKjIjySKCUfWEDRpiem0HF6a6m8=;
        b=q25bB6FGqbNzVqNngDHSz3vWjAhDyvC/bx3SnRnOC4Bs7DaX3SN0I2F560vvC8flqD
         AfPvixOEFN6D0si0DWoX8vDOmXbe96f8MWkYRHB4Poe/2VseWuJctBhX1e+ejP3HCUcM
         6sGsC/qkkSkw3Gudy/urdV1I1dfW8aSpQmkCnyNgfyvaW4M3rxVXN5q7nBJJ37nb2Jwq
         FbqBywox91Y7lgIp9+0Pc9aDcjgouVoK3evhG8N+JGLQr6RJJ4jw5lrv7PhEJN2PqfR0
         f6SL8PPOd+JvnIV8/uxMoONvPFsKw0Nd+3/Gw/T9ceg4NeQRZYQoIYM00fWhvHsXs+9c
         Iyyg==
X-Gm-Message-State: AGRZ1gK+unnKjeLkE2GmvdERCVGpfogz+iGWv+lV65rW2z1qMkkTz4K4
        BXhJ843eYuOFX9ABRWC/grPnKA==
X-Google-Smtp-Source: AJdET5fAHSnkM1UWXjONqv8OEeZQkWJOk7yARJXr0IFyl2xwso7jUh2bGqch3PH60EALzdjS14QB6g==
X-Received: by 2002:a19:59c2:: with SMTP id n185mr6125020lfb.118.1541805068344;
        Fri, 09 Nov 2018 15:11:08 -0800 (PST)
Received: from prevas-ravi.prevas.se (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id x16sm1584012lff.26.2018.11.09.15.11.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Nov 2018 15:11:07 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v3 07/23] dynamic_debug: consolidate DEFINE_DYNAMIC_DEBUG_METADATA definitions
Date:   Sat, 10 Nov 2018 00:10:05 +0100
Message-Id: <20181109231021.11658-8-linux@rasmusvillemoes.dk>
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

Instead of defining DEFINE_DYNAMIC_DEBUG_METADATA in terms of a helper
DEFINE_DYNAMIC_DEBUG_METADATA_KEY, that needs another helper
dd_key_init to be properly defined, just make the various #ifdef
branches define a _DPRINTK_KEY_INIT that can be used directly, similar
to _DPRINTK_FLAGS_DEFAULT.

Acked-by: Jason Baron <jbaron@akamai.com>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/dynamic_debug.h | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 2fd8006153c3..0a643316597c 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -71,7 +71,7 @@ void __dynamic_netdev_dbg(struct _ddebug *descriptor,
 			  const struct net_device *dev,
 			  const char *fmt, ...);
 
-#define DEFINE_DYNAMIC_DEBUG_METADATA_KEY(name, fmt, key, init)	\
+#define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)		\
 	static struct _ddebug  __aligned(8)			\
 	__attribute__((section("__verbose"))) name = {		\
 		.modname = KBUILD_MODNAME,			\
@@ -80,35 +80,27 @@ void __dynamic_netdev_dbg(struct _ddebug *descriptor,
 		.format = (fmt),				\
 		.lineno = __LINE__,				\
 		.flags = _DPRINTK_FLAGS_DEFAULT,		\
-		dd_key_init(key, init)				\
+		_DPRINTK_KEY_INIT				\
 	}
 
 #ifdef HAVE_JUMP_LABEL
 
-#define dd_key_init(key, init) key = (init)
-
 #ifdef DEBUG
-#define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt) \
-	DEFINE_DYNAMIC_DEBUG_METADATA_KEY(name, fmt, .key.dd_key_true, \
-					  (STATIC_KEY_TRUE_INIT))
+
+#define _DPRINTK_KEY_INIT .key.dd_key_true = (STATIC_KEY_TRUE_INIT)
 
 #define DYNAMIC_DEBUG_BRANCH(descriptor) \
 	static_branch_likely(&descriptor.key.dd_key_true)
 #else
-#define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt) \
-	DEFINE_DYNAMIC_DEBUG_METADATA_KEY(name, fmt, .key.dd_key_false, \
-					  (STATIC_KEY_FALSE_INIT))
+#define _DPRINTK_KEY_INIT .key.dd_key_false = (STATIC_KEY_FALSE_INIT)
 
 #define DYNAMIC_DEBUG_BRANCH(descriptor) \
 	static_branch_unlikely(&descriptor.key.dd_key_false)
 #endif
 
-#else
-
-#define dd_key_init(key, init)
+#else /* !HAVE_JUMP_LABEL */
 
-#define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt) \
-	DEFINE_DYNAMIC_DEBUG_METADATA_KEY(name, fmt, 0, 0)
+#define _DPRINTK_KEY_INIT
 
 #ifdef DEBUG
 #define DYNAMIC_DEBUG_BRANCH(descriptor) \
-- 
2.19.1.6.gbde171bbf5

