Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E512C0044C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7DE620855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="RHlju/zR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7DE620855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbeKJIyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 03:54:00 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45990 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728855AbeKJIyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 03:54:00 -0500
Received: by mail-lf1-f65.google.com with SMTP id b20so2478147lfa.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 15:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ma+lxBCA2CpseQJJYksxRIwFv7yA4sEA2SwTd1R6FIs=;
        b=RHlju/zR3LbvhFpgR3p972xuYkJwCnyqEYxX9wZfICGVa/09ivKQKRJx/svs6UYciD
         7CRRiCJLPgabUfPAZUI9NR/jsU069GfBaF+tKG5LWRwAyX6ZSwd0m2fIBhCFxfUz2916
         ez7dh8Vnb/f36T1xaqOe996vq0TS0AEb8PRhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ma+lxBCA2CpseQJJYksxRIwFv7yA4sEA2SwTd1R6FIs=;
        b=XgtxL6vlfaPiL0pNilnFaEJFczHTSd5AKoePJ9aJazQE3SUQzwF/xYP2bo5IvVj39Q
         LiVYEk08FS/ztUyy5fFvmhPMMc1Jzg5sCm3M3Nb6aXp3OBquyCcmJ1WAR2+j0cgVw5mq
         H4+wCiCDT0leMY8b1G3ObEbucyFGl6djWpqiwZwBcJSiNoBDpOcbMLf52l7AWHl2wGWF
         uh+asMBH2hBe/BAx9XhGpBdEBbk3wgr8RnfUUKyUTT3pKpqTUvM/ueb6Ar+auATU5JP5
         1s5ueGWqlZZg5upH1TfV0Z4ZaLvjEyW+fre/r+5RtwjoXUaXoMHqBcbPSJ29ppLfjfDX
         GXUw==
X-Gm-Message-State: AGRZ1gKpfU2m2PtCs/JBL8oCNl8/XggleptJgoC3y2kMNBWQCvJv2O8J
        QU4cHqI9ld967vAqLSC9HM0gqA==
X-Google-Smtp-Source: AJdET5ef2mXd06c8GUfcKXiHXNA+4NxMbun9bnDP1vuI4UlfsRSg8kZIhxBzqPkeSyX70NjVcMr3RA==
X-Received: by 2002:a19:1f46:: with SMTP id f67mr76140lff.1.1541805074307;
        Fri, 09 Nov 2018 15:11:14 -0800 (PST)
Received: from prevas-ravi.prevas.se (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id x16sm1584012lff.26.2018.11.09.15.11.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Nov 2018 15:11:13 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v3 12/23] dynamic_debug: add static inline stub for ddebug_add_module
Date:   Sat, 10 Nov 2018 00:10:10 +0100
Message-Id: <20181109231021.11658-13-linux@rasmusvillemoes.dk>
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
index 0a643316597c..6a002b789d51 100644
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
index 80ede55db25a..208422b47b08 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2715,9 +2715,7 @@ static void dynamic_debug_setup(struct module *mod, struct _ddebug *debug, unsig
 {
 	if (!debug)
 		return;
-#ifdef CONFIG_DYNAMIC_DEBUG
 	ddebug_add_module(debug, num, mod->name);
-#endif
 }
 
 static void dynamic_debug_remove(struct module *mod, struct _ddebug *debug)
-- 
2.19.1.6.gbde171bbf5

