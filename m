Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60765C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CC8E222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="ACTppdO8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731654AbfBLVnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 16:43:06 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39108 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730907AbfBLVmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 16:42:02 -0500
Received: by mail-ed1-f65.google.com with SMTP id b14so166150edt.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 13:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JhCt5ZB1SxgbEOqP/6ZCtiO8Oyl/niEug/drLmIuD+U=;
        b=ACTppdO8tp0V6f3IeX2IZVwbN7JolCimLLY9GZmG4OjmoWi+7oO90VlKbI9JgJ9Kdq
         2WPh6+V7LCvDxp/6nHl4U1r9s4zYUsisGlfnh+fAx8SpzxXoLFeeifTez5f+vhe/0iLV
         +peoeNOYO6ElCebgEC84zv7pQ4/8yki4nAGRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JhCt5ZB1SxgbEOqP/6ZCtiO8Oyl/niEug/drLmIuD+U=;
        b=UUlNnrPl9SdYXqTGfrcRUpualU7prOVg/riwPCFuyqIq7VsvZqyjzx1O6wnzq2jk7E
         ZNt/1CLTOotQ1MdSCnEJJAiwESk3HcjWT9h+7joC2PBT+1E55W6p97dEJMjjYxKKddKZ
         jva1JyH12lfAEVI4YZCI6HfEpGqB8WwqEXHOugE3ACMaXSl0vQIAhV6MUyxwMWkhQPr8
         ePwSsBbB2tGwiOd11SJnbuxXfI8BQ3favXve74l8JCiQk3p/Fu2ORJluwnhLgQlJfpTz
         jy0mZkmIPCpkXaSHOsO4Wt5AXEI7BCFt7V69XKD7p/wmMlOyd7H+DKFPld7Swhx30TKX
         z5Ow==
X-Gm-Message-State: AHQUAubYbDF70hQ+uWmPe6/glicbitEsYOq78zTfU2SOPtv0f24+ESPm
        i77EF3sJfA+CavVeq3S26PWoSA==
X-Google-Smtp-Source: AHgI3IbRRYxkm8oORen21OaA/PFTwzDH1Vuetupx4Ybzg+Nbl9KVFPNqwFEGsWwg860yIPXMCidUOA==
X-Received: by 2002:a17:906:82c2:: with SMTP id a2mr4263439ejy.8.1550007720819;
        Tue, 12 Feb 2019 13:42:00 -0800 (PST)
Received: from prevas-ravi.waoo.dk (ip-5-186-119-174.cgn.fibianet.dk. [5.186.119.174])
        by smtp.gmail.com with ESMTPSA id v1sm3697607eds.47.2019.02.12.13.41.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 13:42:00 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v4 04/14] dynamic_debug: consolidate DEFINE_DYNAMIC_DEBUG_METADATA definitions
Date:   Tue, 12 Feb 2019 22:41:40 +0100
Message-Id: <20190212214150.4807-5-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212214150.4807-1-linux@rasmusvillemoes.dk>
References: <20190212214150.4807-1-linux@rasmusvillemoes.dk>
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
index b3419da1a776..b17725400f75 100644
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
 
 #ifdef CONFIG_JUMP_LABEL
 
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
2.20.1

