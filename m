Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52C7C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76CBB20835
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="BFxiTGGY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76CBB20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbeJISg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:36:59 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36917 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbeJISg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:36:57 -0400
Received: by mail-ed1-f66.google.com with SMTP id c22-v6so1325991edc.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1dmxuBxCgU6KKlTmBRdOGbIg3KtJFU9xe9M2897JByA=;
        b=BFxiTGGYZr6JT8+R5agDFjJh0jBbh3AaEhzQOPOvzXjur1BpcewnXC5HgH+3KKL0JA
         oU2PsLtewMpXGnc0OrKTfaiiDDPy1hxbiLazi5OCulNSOxglI6JPTnSya/jK2i/JVE05
         vFv4SdttcSK49585fsUxBQ3SPbjinByVI0b7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1dmxuBxCgU6KKlTmBRdOGbIg3KtJFU9xe9M2897JByA=;
        b=OSSyQqIpBSvIKwORyVscvN5sszXKBYDp3Ga5tx1i2mzhfKKMpGCfEsOTNi+BjGasJg
         yLQAwY1m9mE6ejAPMLtBh3Chu1wM+uWIx4Q0MFSlUKCxTFOG0stn7vu69e75JYYy6hIK
         7trekuFEVvuybMlr5ywXjmrbud6dSeP6Fsn29kVHSYH3lFYWLjYlfbr2wVbc59xd7U34
         ZqJ8PdpvFFyhOm2ZCn2PyWUjt4ahimjVigQXFCX0A5kXDlPRsx7sqodVxFeO/KHL1QKn
         Ov33qP6UDcjDBg8YFtlhFBDDOjguFEaijdPrM9QWVPkMfr911falsYukbZlH5qEz2XqI
         zjKg==
X-Gm-Message-State: ABuFfogvrmB/oBmm5zty8bbPJT//sdeoXth5seoSGd3nB+NR6JI0LhG6
        QzTSK0UiGSsHt5h/7hsRhJ2gsWcgcR8=
X-Google-Smtp-Source: ACcGV61VOIJMMUZulL5iaGrfiWb+vUp8QHBAtAdF2P8csQMCtjbnWa4FgXiCQNndCB5n+F9eQz/51A==
X-Received: by 2002:a50:ba3c:: with SMTP id g57-v6mr34312564edc.214.1539084027500;
        Tue, 09 Oct 2018 04:20:27 -0700 (PDT)
Received: from prevas-ravi.vestasvisitor.net ([193.47.71.171])
        by smtp.gmail.com with ESMTPSA id n23-v6sm3595821eja.41.2018.10.09.04.20.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Oct 2018 04:20:26 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 07/23] dynamic_debug: consolidate DEFINE_DYNAMIC_DEBUG_METADATA definitions
Date:   Tue,  9 Oct 2018 13:19:57 +0200
Message-Id: <20181009112013.14238-8-linux@rasmusvillemoes.dk>
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
2.19.1.3.g1d92a00e68

