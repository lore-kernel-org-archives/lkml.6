Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE83BC61CE4
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 02:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFAD620896
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 02:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ve7uMo/W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730093AbfATCnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 21:43:11 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42631 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbfATCnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 21:43:11 -0500
Received: by mail-pl1-f196.google.com with SMTP id y1so8095755plp.9
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 18:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BF0HO+6QfeFEmeGaUgC9N9Nw569CU5Sf/OjrZdT31Wg=;
        b=ve7uMo/WkBW5ujSWYk+nN5+VSlRR2lfzFGtil22YGCIoR4mFc1H4ycwzUrksmeSCmB
         RarIj+S+Qc7rqJtHbHBRO1nYLdwhDjxAOaqPAmQnOOGHS1IdLCIwrDSFgbTWCaln8MZs
         bWyyqSyCPpMLsFgdlOFxxLSlxOUXPZdGCNE5mgjrkvuFAmPC8arCyTC+kbOAeiwzDjXt
         q2ESNsJrtH1s/dFv3EdnwxHs+cFNHW6si7TTQFYdfg7HkCCiRExo/7thTpe5VBP5xlBq
         XDk6zVTqwNPEahQ58U/hVUf3e2E2oyRBbLyca+tZwOricxgotO9ErTNNokApwhGqykG8
         VRbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BF0HO+6QfeFEmeGaUgC9N9Nw569CU5Sf/OjrZdT31Wg=;
        b=kK4MVktXAopiygS4vbV8pCa1Am6nO5fyQFpOoKSK8KNbsb+5evDUOuXq1SseJCFjKA
         LEvbh2zrzZ222eejx6VddR5OQGwHkpmgJwdw08yE326fDOC2MYWznJO82V7EvGkU9K6b
         8ubNtQvpDcXVNYEf+pzKs9dxy3Y+W/S+5P7JcA3qFJlU+vVNPIophuGwPpHajYwoe0ux
         jdwqdj174v2N2b1sZn2P1iHNcMWfoKk1PaeZfNUgQoENzQ0fbZugAl0yySXOrSWgn9SC
         dM+lNXA6i6XVA/BqXbR5nFHi2yOW+K/Uo8PsCZWTlVApgHwEjsaAnI6rYuI9CNDqb3P5
         NVzQ==
X-Gm-Message-State: AJcUukcD9UzLrZNpzlG9QFzCoIdQ7nDnJf5x12M1mPnOEpuMCT6bm7hz
        xLIemtbUYg1+11EJWL+xSYc=
X-Google-Smtp-Source: ALg8bN7ZtgzavMun3yAyKxR+7y4PL4IqxrsURKlQG8mJ2G3W6aSTG9mtKyeOMt55UoILIzxB+OPOpQ==
X-Received: by 2002:a17:902:50e:: with SMTP id 14mr24538529plf.141.1547952190466;
        Sat, 19 Jan 2019 18:43:10 -0800 (PST)
Received: from localhost.localdomain ([207.246.99.41])
        by smtp.gmail.com with ESMTPSA id j197sm12208228pgc.76.2019.01.19.18.43.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 18:43:09 -0800 (PST)
From:   Changbin Du <changbin.du@gmail.com>
To:     akpm@linux-foundation.org
Cc:     yamada.masahiro@socionext.com, mingo@kernel.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH] mm/page_owner: move config option to mm/Kconfig.debug
Date:   Sun, 20 Jan 2019 10:42:54 +0800
Message-Id: <20190120024254.6270-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the PAGE_OWNER option from submenu "Compile-time checks and compiler
options" to dedicated submenu "Memory Debugging".

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 lib/Kconfig.debug | 17 -----------------
 mm/Kconfig.debug  | 17 +++++++++++++++++
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index d4df5b24d75e..e43cfdc86fd6 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -266,23 +266,6 @@ config UNUSED_SYMBOLS
 	  you really need it, and what the merge plan to the mainline kernel for
 	  your module is.
 
-config PAGE_OWNER
-	bool "Track page owner"
-	depends on DEBUG_KERNEL && STACKTRACE_SUPPORT
-	select DEBUG_FS
-	select STACKTRACE
-	select STACKDEPOT
-	select PAGE_EXTENSION
-	help
-	  This keeps track of what call chain is the owner of a page, may
-	  help to find bare alloc_page(s) leaks. Even if you include this
-	  feature on your build, it is disabled in default. You should pass
-	  "page_owner=on" to boot parameter in order to enable it. Eats
-	  a fair amount of memory if enabled. See tools/vm/page_owner_sort.c
-	  for user-space helper.
-
-	  If unsure, say N.
-
 config DEBUG_FS
 	bool "Debug Filesystem"
 	help
diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index 9a7b8b049d04..e3df921208c0 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -39,6 +39,23 @@ config DEBUG_PAGEALLOC_ENABLE_DEFAULT
 	  Enable debug page memory allocations by default? This value
 	  can be overridden by debug_pagealloc=off|on.
 
+config PAGE_OWNER
+	bool "Track page owner"
+	depends on DEBUG_KERNEL && STACKTRACE_SUPPORT
+	select DEBUG_FS
+	select STACKTRACE
+	select STACKDEPOT
+	select PAGE_EXTENSION
+	help
+	  This keeps track of what call chain is the owner of a page, may
+	  help to find bare alloc_page(s) leaks. Even if you include this
+	  feature on your build, it is disabled in default. You should pass
+	  "page_owner=on" to boot parameter in order to enable it. Eats
+	  a fair amount of memory if enabled. See tools/vm/page_owner_sort.c
+	  for user-space helper.
+
+	  If unsure, say N.
+
 config PAGE_POISONING
 	bool "Poison pages after freeing"
 	select PAGE_POISONING_NO_SANITY if HIBERNATION
-- 
2.17.1

