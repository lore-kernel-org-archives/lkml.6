Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABD3C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0AAD20835
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="dRiRLrkK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0AAD20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbeJIShC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:37:02 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33664 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbeJIShC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:37:02 -0400
Received: by mail-ed1-f66.google.com with SMTP id h13-v6so1341721edq.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=agJw5LvNZW1WGXi3lrrxi7wM1p2zlYIhPfa8TKWvT9k=;
        b=dRiRLrkKa6wqfaIa/WEXHfI3cdFfFIVU2pU4D7sHh3H9BajWPUFrUpAUVetrcbC0lN
         3KahslnUEnmCF1PY/OcJ8/XAdi+xbTzM2Pi6FxHS/pILTlQEoifIkI7Qii0rklSmt8da
         m6tpJojS5nURDAGp0Rio5oXHmZN7d2NWRR4RQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=agJw5LvNZW1WGXi3lrrxi7wM1p2zlYIhPfa8TKWvT9k=;
        b=fe+5PxL045zVrbOiNHxV5L+D2l2/xPcBWc9GbsDq9grR8NgUYdtawrOOs30p8jKhrr
         435ag5KmyD0sX+ktn4eHC5EucGf08hmgJ9srPlgh2XUinQAUQACFcBaa5CxA302zV2ff
         kqzI7UREX35hyyFRQ/tjLVjy+1HAZIicMxdAWk1UJhzmJGSK2PEOLlymt8MGeIFkg40i
         TdLfEfK628uYZyNmMZ86NT3eZxiVQNpMPRASv3tsiccdVWdp9FoG+uJVtbIX0a+ndEx8
         D1/GuL5Pn9PQ1iERbDWhQ4gcOsiaDyDJbr+ogUGzx/znlUqJ4af26y/nxNGvLYa4FB3S
         xRlg==
X-Gm-Message-State: ABuFfoisFAYkc/wiqbS+L50+SOOLC+M1vx5GppVvywIPe8Mx3S0Zwjwj
        UTPhFVViJp9POKUaOTWsZEli6NLV0Dg=
X-Google-Smtp-Source: ACcGV61B5BoFYXWBGNrnD8YRS9oqq1W14O1Sm/QGhQjtDAw7Jsg2hXtkVNRSfmtLFRdMOyic4vsZVg==
X-Received: by 2002:a50:86ba:: with SMTP id r55-v6mr34009751eda.87.1539084031632;
        Tue, 09 Oct 2018 04:20:31 -0700 (PDT)
Received: from prevas-ravi.vestasvisitor.net ([193.47.71.171])
        by smtp.gmail.com with ESMTPSA id n23-v6sm3595821eja.41.2018.10.09.04.20.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Oct 2018 04:20:31 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 11/23] dynamic_debug: move pr_err from module.c to ddebug_add_module
Date:   Tue,  9 Oct 2018 13:20:01 +0200
Message-Id: <20181009112013.14238-12-linux@rasmusvillemoes.dk>
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
index 6746c85511fe..381f9bf282fe 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2716,9 +2716,7 @@ static void dynamic_debug_setup(struct module *mod, struct _ddebug *debug, unsig
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
index f1de45a100fa..e90459dca34b 100644
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
2.19.1.3.g1d92a00e68

