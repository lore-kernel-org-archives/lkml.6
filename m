Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D300C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B6D3222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Q9zhvdp9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731982AbfBLVmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 16:42:11 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42438 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731680AbfBLVmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 16:42:08 -0500
Received: by mail-ed1-f67.google.com with SMTP id r15so152782eds.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 13:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7xdsz9pZ3Y/OLPGVvGjAhqbX8t953sV/2toSxlNKfvM=;
        b=Q9zhvdp9gQ8rf7qiupYhL2evsl5cHH9lrNvJXJAgL5FV9pF7q/rWKf44DS3HhqhrNH
         zrd7ApyvVJhG5UG5CuhpIpabY/dFR95MNAQC6utjJGVgkAYjE2hTJfUSIAFERwBG5H+i
         AxFiuJmwwv8xrPbZFKIwPPh/QyKB/FCk1lVKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7xdsz9pZ3Y/OLPGVvGjAhqbX8t953sV/2toSxlNKfvM=;
        b=k5AiZjpDpjWyDzTQpmA8N/1mD3dHZo/V5x0EAF9c0q8mfcYDQWaJa1dFqRcU+yDoDS
         B/yY3JiZVhYETmXcu74E78JrKMdyaF1cBOHD1kagl4ryhG5NWDAumjTcRLCz6uRJBH9G
         CCEADxz2zaabUN+BMqWkotr0XBU/07Qovh81Gpb/l7C48emfZpoDfg1/dG38NbT1aI7U
         GGD1OylaSjxGmWTZy3fCV8VUtPtSUtEwGRSSz+q5U2wJ34/MtFOrm9dPr+wajwQnn7l7
         ziWBWVMRqtNRLpLZZk6/bLoUqY5NrsfAZE5FUSpgaEHMmA2v4W4PfGao1H2oIcOygDqd
         rAgw==
X-Gm-Message-State: AHQUAubIBkpk8ko/8JiHDPnjRGpuu7ytta8PbmCq5EA7ZqolODIhRjpc
        U2QiNK4k2hNjOgnydqT0u1oqVQ==
X-Google-Smtp-Source: AHgI3IYv8NaeWDmMwo8YuOsfQPLebORSoBBU8UMJW4TW0giD9E5YbIBWhY6Jy5rAkqyAAvD1tsTjRw==
X-Received: by 2002:a17:906:745:: with SMTP id z5mr4211936ejb.54.1550007726322;
        Tue, 12 Feb 2019 13:42:06 -0800 (PST)
Received: from prevas-ravi.waoo.dk (ip-5-186-119-174.cgn.fibianet.dk. [5.186.119.174])
        by smtp.gmail.com with ESMTPSA id v1sm3697607eds.47.2019.02.12.13.42.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 13:42:05 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v4 09/14] dynamic_debug: add static inline stub for ddebug_add_module
Date:   Tue, 12 Feb 2019 22:41:45 +0100
Message-Id: <20190212214150.4807-10-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212214150.4807-1-linux@rasmusvillemoes.dk>
References: <20190212214150.4807-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For symmetry with ddebug_remove_module, and to avoid a bit of ifdeffery
in module.c, move the declaration of ddebug_add_module inside #if
defined(CONFIG_DYNAMIC_DEBUG) and add a corresponding no-op stub in the
#else branch.

Acked-by: Jason Baron <jbaron@akamai.com>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/dynamic_debug.h | 10 ++++++++--
 kernel/module.c               |  2 --
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index b17725400f75..3f8977cfa479 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -47,10 +47,10 @@ struct _ddebug {
 } __attribute__((aligned(8)));
 
 
-int ddebug_add_module(struct _ddebug *tab, unsigned int n,
-				const char *modname);
 
 #if defined(CONFIG_DYNAMIC_DEBUG)
+int ddebug_add_module(struct _ddebug *tab, unsigned int n,
+				const char *modname);
 extern int ddebug_remove_module(const char *mod_name);
 extern __printf(2, 3)
 void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...);
@@ -152,6 +152,12 @@ do {								\
 #include <linux/string.h>
 #include <linux/errno.h>
 
+static inline int ddebug_add_module(struct _ddebug *tab, unsigned int n,
+				    const char *modname)
+{
+	return 0;
+}
+
 static inline int ddebug_remove_module(const char *mod)
 {
 	return 0;
diff --git a/kernel/module.c b/kernel/module.c
index 7b1d437c1ea6..0b9aa8ab89f0 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2719,9 +2719,7 @@ static void dynamic_debug_setup(struct module *mod, struct _ddebug *debug, unsig
 {
 	if (!debug)
 		return;
-#ifdef CONFIG_DYNAMIC_DEBUG
 	ddebug_add_module(debug, num, mod->name);
-#endif
 }
 
 static void dynamic_debug_remove(struct module *mod, struct _ddebug *debug)
-- 
2.20.1

