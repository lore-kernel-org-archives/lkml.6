Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF740C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EE8D20652
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="VTG9g92E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EE8D20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbeIGM01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 08:26:27 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41570 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbeIGM00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 08:26:26 -0400
Received: by mail-lf1-f65.google.com with SMTP id l26-v6so11273713lfc.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 00:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Xae1vLN5TCyHnrzDeiLfXPJiftORjKN4z8WIfgTNiTU=;
        b=VTG9g92EFMtXijjWUJs0O2M1lG/8plRMQSvo/+YETbS2+U6dtF7kL+vH9HfxBwii0u
         OZ/k54RkwnzxgnSdYjtZo2J9lyCGtc2hrhTM39G43wZ4J1E8teDn+6fb6/LwCBshQaoW
         7rN2XBxMi3+ospNtTMDPapmCEXNSmdSPw+VuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Xae1vLN5TCyHnrzDeiLfXPJiftORjKN4z8WIfgTNiTU=;
        b=iEyPej/mRtvZmZR/yeTemlusbvMqAEHAxrX1Bbhwo10AlQdLtP/HTCrbN9jBVgU6yn
         oA9P+rbs4G+Aeog+LoHgHl8ms4rPhM0r4Gh57lC1uaxZlnPgSX8XT0gKRthOul1+vrqg
         xcxzHLigAOyGTZY+h/vtrMIjj1h+pVHFHXhGYYc5HifZ502IE3MM3d8a3ZaxdEPj13Zn
         pWCqd48xIM/I02Mq6sNfxRnlToA+EbyRDOzxF/206ndyGhZjurCdPVu3ty16LEl3uduh
         NXruWWnYaI9VDBr9SIac6S5sHrPm68D9GdCkypLy2R/kbbu4Q03pa2K2AYv6QGqo6cO7
         HclQ==
X-Gm-Message-State: APzg51AKdMYPJZahJdOFDmSBbrFUOhMa8SGLMf8BTIVqPE6slGLlPoZ+
        I9BiDuFo2nnpBtUWLMDOFPhvWw==
X-Google-Smtp-Source: ANB0Vdbf96+qVz3cWXSMjaGPodrgx6YeeWA2jSzKABvAM9NidHkyBDwVwGIA9+TTKcvquWdezireTg==
X-Received: by 2002:a19:4a09:: with SMTP id x9-v6mr4342389lfa.80.1536306404315;
        Fri, 07 Sep 2018 00:46:44 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 96-v6sm1183005lfu.40.2018.09.07.00.46.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Sep 2018 00:46:43 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 1/2] string: make kmemdup_nul take and return void*, not char*
Date:   Fri,  7 Sep 2018 09:46:39 +0200
Message-Id: <20180907074640.27348-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows kmemdup_nul to be used in cases where the source pointer is
not a char* or const char*, but the result should nevertheless have a
nul char after the memcpy'ed data.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/string.h | 2 +-
 mm/util.c              | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index 4a5a0eb7df51..b44a2254bc6b 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -169,7 +169,7 @@ extern char *kstrdup(const char *s, gfp_t gfp) __malloc;
 extern const char *kstrdup_const(const char *s, gfp_t gfp);
 extern char *kstrndup(const char *s, size_t len, gfp_t gfp);
 extern void *kmemdup(const void *src, size_t len, gfp_t gfp);
-extern char *kmemdup_nul(const char *s, size_t len, gfp_t gfp);
+extern void *kmemdup_nul(const void *s, size_t len, gfp_t gfp);
 
 extern char **argv_split(gfp_t gfp, const char *str, int *argcp);
 extern void argv_free(char **argv);
diff --git a/mm/util.c b/mm/util.c
index 9e3ebd2ef65f..15ef23f1176e 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -128,7 +128,7 @@ EXPORT_SYMBOL(kmemdup);
  * @len: The size of the data
  * @gfp: the GFP mask used in the kmalloc() call when allocating memory
  */
-char *kmemdup_nul(const char *s, size_t len, gfp_t gfp)
+void *kmemdup_nul(const void *s, size_t len, gfp_t gfp)
 {
 	char *buf;
 
-- 
2.16.4

