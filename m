Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2780DECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D154521522
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="YzJimOq6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D154521522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733288AbeITDo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 23:44:57 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40368 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733235AbeITDo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 23:44:56 -0400
Received: by mail-ed1-f67.google.com with SMTP id j62-v6so6155398edd.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 15:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5hRs0F8yFzfLeczWfzzmi4cq2PW0kMy83G5r2MyB2J8=;
        b=YzJimOq6meAJRx/nREwvVhM6NiL+hRHguwSvBvDj4+5TjOMZcNWTXLUn9pi67901ME
         r2pP4apCw1L0VZln+WafBWVuBgqIF3vSicDNmGv82EgwP1fXtspP05wGcSQNQ201wV6r
         s71A38NR+ZxrPavMOAHlmxpjUVCfNe/hqY+1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5hRs0F8yFzfLeczWfzzmi4cq2PW0kMy83G5r2MyB2J8=;
        b=UAX7y6/VV1qAkKRsGZhw+vEIJP4bxYQ3rn8bupiy1FwUEZ0Jk+f+GuqcOeZJZWIwyM
         IDGINY7n7MG08zi3uypYk42RW/yAjjz+Ta5ouLCJI3kzYBI+4FnA0+NTMHJzLE4EKsYs
         /Vr2staPAfKHP+9fzw/2QsL39NM48F1ZQKK5NTRizaV0lIiMQ7NZoc0BgWTJ7kM1sJGh
         vQHNxNHIGscs16vX84DnlhGmodpCvEInTjWfexkquhXyXFO5TGSNqrJxCgge0wMwXg7b
         eK8sfGr82Mg09a6I1ECxPaN0alHt4xatrjfsK0kip0l6pqOGVt39+CAbapveURYnUp1e
         ICHg==
X-Gm-Message-State: APzg51CpHXuFLwLOhGKo8woW0k/cN9J/bLhDFl2xppdc3LUSZiNSVY+w
        +tF3OvyrfvH/y2XELfQ8pj8MEw==
X-Google-Smtp-Source: ANB0VdY5l1R7RMyAlTvpyrIVILliBIE4ZNRgCSQd1S3M3VW+plXAyQ0T0pD3lsbmbHuOaY+QdBlS2Q==
X-Received: by 2002:a50:fa8b:: with SMTP id w11-v6mr60036024edr.59.1537394698727;
        Wed, 19 Sep 2018 15:04:58 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-115-161.cgn.ip.fibianet.dk. [5.186.115.161])
        by smtp.gmail.com with ESMTPSA id a9-v6sm2798edi.26.2018.09.19.15.04.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Sep 2018 15:04:58 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 07/22] dynamic_debug: consolidate DEFINE_DYNAMIC_DEBUG_METADATA definitions
Date:   Thu, 20 Sep 2018 00:04:29 +0200
Message-Id: <20180919220444.23190-8-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
References: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of defining DEFINE_DYNAMIC_DEBUG_METADATA in terms of a helper
DEFINE_DYNAMIC_DEBUG_METADATA_KEY, that needs another helper
dd_key_init to be properly defined, just make the various #ifdef
branches define a _DPRINTK_KEY_INIT that can be used directly, similar
to _DPRINTK_FLAGS_DEFAULT.

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
2.16.4

