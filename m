Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A27ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 21:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 372BC2082B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 21:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="X9a1aedA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 372BC2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbeJ0F7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 01:59:15 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36174 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbeJ0F7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 01:59:15 -0400
Received: by mail-ed1-f67.google.com with SMTP id x2-v6so2477558eds.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 14:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yijrGjtWfqaCC8K0USssat5k1rwBf/Jz2uIgpUPQEXg=;
        b=X9a1aedAZsntn1Wz9bhfgwsacl8F7zHaTiipYHb79K9qjs4SI7WBjdmn8v+c/Vm8t5
         vIML/Ns7YuN5rBcD4dHh3W2mPvvTQKpevbXvCGlJhsiF2AS9uLzuedLmCNSQbJxxep6V
         MhjSQ5YiLmMjUkqvTqiK5KQUZK1KnwaK7N3T8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yijrGjtWfqaCC8K0USssat5k1rwBf/Jz2uIgpUPQEXg=;
        b=lr9AfV/4i6Qdh/XqkreUDDXcUglshkCQQhPRq3BNu1RuJCNcbf85eJUdgbQyqRufoH
         GZjlMoMEPxugxUIIQlphC+heaHIorZHIG6PNHeOn0qKD8cmVsMjKn5s/QYzGsyHFVyAF
         pCijYUykDozjttqkRkbUOBgtsFyUOTBP1n4LotcBGlW6gEl6H1XAsgZ5sLHh5TNm0jFQ
         XXBeHiroWsOxHulPGqrxLI0ljrT8y1P6jaCobloe5bVxuTuRw7VRX2bPSQAbXKevpsbi
         ebRf2v+dT8OxhkUAf0U9mZn731X63BL+O0VMc/nWCQqnoWJxNLA/6sMrkC1VudcVjx9Y
         RYHA==
X-Gm-Message-State: AGRZ1gLuFyivvNuTWQNJZqjwjnHS7SJpXbasAcniSj4iTSxas7/PF5jy
        j3BhMZ8bKBz5kEfQQkWGYsCcDw==
X-Google-Smtp-Source: AJdET5dYYKX+nUzTpHymtU9ak8RM3rPgDrxSClFwknTqC0Grf7tGeoBwKNNYYwES2Yjp7VbU1hkddA==
X-Received: by 2002:a17:906:7c52:: with SMTP id g18-v6mr3443373ejp.77.1540588837657;
        Fri, 26 Oct 2018 14:20:37 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id dv2-v6sm2423353ejb.10.2018.10.26.14.20.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Oct 2018 14:20:37 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH] fs: proc: move linux_proc_banner to where it is used
Date:   Fri, 26 Oct 2018 23:20:34 +0200
Message-Id: <20181026212034.5491-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.gbde171bbf5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With -Wformat-literal, gcc complains

fs/proc/version.c:11:16: warning: format not a string literal, argument types not checked [-Wformat-nonliteral]
  seq_printf(m, linux_proc_banner,

linux_proc_banner is only used in this one place, so move the definition
here, to allow the compiler to complain in the unlikely case one of the
LINUX_* strings ended up containing a %. This also avoids compiling it
in for !CONFIG_PROC_FS.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 fs/proc/version.c      | 6 ++++++
 include/linux/printk.h | 1 -
 init/version.c         | 5 -----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/proc/version.c b/fs/proc/version.c
index b449f186577f..40a33e1434d7 100644
--- a/fs/proc/version.c
+++ b/fs/proc/version.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <generated/compile.h>
 #include <linux/fs.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -6,6 +7,11 @@
 #include <linux/seq_file.h>
 #include <linux/utsname.h>
 
+#define linux_proc_banner \
+	"%s version %s" \
+	" (" LINUX_COMPILE_BY "@" LINUX_COMPILE_HOST ")" \
+	" (" LINUX_COMPILER ") %s\n"
+
 static int version_proc_show(struct seq_file *m, void *v)
 {
 	seq_printf(m, linux_proc_banner,
diff --git a/include/linux/printk.h b/include/linux/printk.h
index cf3eccfe1543..c7edf4398e4d 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -9,7 +9,6 @@
 #include <linux/cache.h>
 
 extern const char linux_banner[];
-extern const char linux_proc_banner[];
 
 #define PRINTK_MAX_SINGLE_HEADER_LEN 2
 
diff --git a/init/version.c b/init/version.c
index ef4012ec4375..ead5e21fa3a3 100644
--- a/init/version.c
+++ b/init/version.c
@@ -46,9 +46,4 @@ const char linux_banner[] =
 	"Linux version " UTS_RELEASE " (" LINUX_COMPILE_BY "@"
 	LINUX_COMPILE_HOST ") (" LINUX_COMPILER ") " UTS_VERSION "\n";
 
-const char linux_proc_banner[] =
-	"%s version %s"
-	" (" LINUX_COMPILE_BY "@" LINUX_COMPILE_HOST ")"
-	" (" LINUX_COMPILER ") %s\n";
-
 BUILD_SALT;
-- 
2.19.1.6.gbde171bbf5

