Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5E0C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEF07222C1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="SZWZqLHw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731710AbfBLVmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 16:42:50 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46905 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731366AbfBLVmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 16:42:07 -0500
Received: by mail-ed1-f67.google.com with SMTP id f2so133938edy.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 13:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wAskKXvHGZWuIubyuQ1KCShKFFxrR/PeyUmA6RLhZXQ=;
        b=SZWZqLHw3lruue5LH97yArtEuIKBx1Uqktb+JKtWblB6hZPmpdzCpzv04VyhdVP5Tb
         ghhHCafArBJwzV6GeihGOOkGvcii3K2uYvy5PlzeFNrAoKXzuly2Vbwof7jm3jLJt5Pu
         gnNbf2eibWlLJs+gLB16Pik7mtN5BqmzheCTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wAskKXvHGZWuIubyuQ1KCShKFFxrR/PeyUmA6RLhZXQ=;
        b=gFEAr2TsXjb6iW57uTGfY5ETNbZHUvFEztaVpBstR+Xq8OHKPNZGAYTVadFZ+yhRzk
         LSPzgVY/6VORbCHfxHV2P12KrgaabMzDv4OBv7gUbWteT6XjUjN9hzrXvNCkz1MKXo5S
         wuuqlj/xJm4RJhJbrQBDLudY+RBiYBd5C/rsB/juB/roCsq9hi5ddRvIVHpzNzGvACuj
         /zSDufB3Qqfwsk2NewznWMAPONnEAUITsVk2gCnRxTk92AHaF8lD31zRK51QLXLPyvNa
         jUyQf8VeLWo2nJIn2u7bSLsiuxhp9g/xZF1rZCU9En/bkdFMXzBmtJRB9r9mK0UTiFtJ
         1VPA==
X-Gm-Message-State: AHQUAuZkwz8d0gtQJ6wDeAUVvfdDf6VCBvmfKlfg1KcfRw5tct/6kuBj
        20UHIyJwND42JEk5gvUD2GUMlg==
X-Google-Smtp-Source: AHgI3IZJB33kAkDko/Q4ArGEVBW7sl/otSKL4cyCjGOqiaCt9NVMHVJcOpNB69FkG4nh+oIbCRY8zw==
X-Received: by 2002:a17:906:5e01:: with SMTP id n1mr3954885eju.99.1550007725366;
        Tue, 12 Feb 2019 13:42:05 -0800 (PST)
Received: from prevas-ravi.waoo.dk (ip-5-186-119-174.cgn.fibianet.dk. [5.186.119.174])
        by smtp.gmail.com with ESMTPSA id v1sm3697607eds.47.2019.02.12.13.42.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 13:42:04 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v4 08/14] dynamic_debug: move pr_err from module.c to ddebug_add_module
Date:   Tue, 12 Feb 2019 22:41:44 +0100
Message-Id: <20190212214150.4807-9-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212214150.4807-1-linux@rasmusvillemoes.dk>
References: <20190212214150.4807-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This serves two purposes: First, we get a diagnostic if (though
extremely unlikely), any of the calls of ddebug_add_module for built-in
code fails, effectively disabling dynamic_debug. Second, I want to make
struct _ddebug opaque, and avoid accessing any of its members outside
dynamic_debug.[ch].

Acked-by: Jason Baron <jbaron@akamai.com>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 kernel/module.c     | 4 +---
 lib/dynamic_debug.c | 4 +++-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 2ad1b5239910..7b1d437c1ea6 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2720,9 +2720,7 @@ static void dynamic_debug_setup(struct module *mod, struct _ddebug *debug, unsig
 	if (!debug)
 		return;
 #ifdef CONFIG_DYNAMIC_DEBUG
-	if (ddebug_add_module(debug, num, mod->name))
-		pr_err("dynamic debug error adding module: %s\n",
-			debug->modname);
+	ddebug_add_module(debug, num, mod->name);
 #endif
 }
 
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 7b76f43edaef..7bdf98c37e91 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -849,8 +849,10 @@ int ddebug_add_module(struct _ddebug *tab, unsigned int n,
 	struct ddebug_table *dt;
 
 	dt = kzalloc(sizeof(*dt), GFP_KERNEL);
-	if (dt == NULL)
+	if (dt == NULL) {
+		pr_err("error adding module: %s\n", name);
 		return -ENOMEM;
+	}
 	/*
 	 * For built-in modules, name lives in .rodata and is
 	 * immortal. For loaded modules, name points at the name[]
-- 
2.20.1

