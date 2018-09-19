Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FAD1C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37CC621524
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="hB2ODxoW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37CC621524
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387456AbeITDpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 23:45:02 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45621 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733235AbeITDpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 23:45:02 -0400
Received: by mail-ed1-f66.google.com with SMTP id p52-v6so6145400eda.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 15:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fs5UFE/HY2e8DYvOOnhEO+Vn3hqK5fCSlLvW6URjl6I=;
        b=hB2ODxoWssQUoQ5/gKKy5JThiOKigOWQ80hRWs0puFOG/05a1bF+KQ0htM4Hg5h2Sf
         hFO5DTCpAXj0e2toQnV3qigiL53oGpAdFOOLTW1uLG6QCpHEmJw4PDRSTRFTdvBfNbWe
         +gzcanXOi9gC7JsOBbzBXyUrKNdA0+9tIXwUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fs5UFE/HY2e8DYvOOnhEO+Vn3hqK5fCSlLvW6URjl6I=;
        b=JHHs3XMarkaoNsa4M8Q3P1vzY0NgRRNUAmIPQM3YpzT+NaA8BBxZeY0E8KNt3L0b6I
         UECa0+VOGqIFGpJHJc8+SBk5Khr+duD0/l3nt56pX38+6+qMfQLXVxxZFWj2Zta+PzLY
         jQQc+9iWuUWoiiUEeyUCTq/SDrAY1vpSCsqrQucb9hnfmJ16yQLZ6+/4IB0GYimZGgvt
         keWfhq+GSTQ4i7MPPTgGIT74wXkBLylcMvQhgDoUxz6vgsUThKkIMvvrZ8ljwRCgfu1d
         Tu1mDADHLg5AFwHb5TASlrOyyFy7zNW2OpBXJLaFAV4z2BUMDa3y1ZkLCZNqjwNASwTC
         MmSw==
X-Gm-Message-State: APzg51B0+9ncl4pDGVcovlx3+FFD5N7ugQxK6SZkabzQM9HmpUrEqvdr
        wemOjLQMk4Lk+EPM2nooE1/vgA==
X-Google-Smtp-Source: ANB0Vday4qk23jjv/pBC4TFePWKDPmHwqxfhHuohhm+7xBNwh2K5I83kQxaTo/rSV5yuxnytj5FjkQ==
X-Received: by 2002:a50:d01a:: with SMTP id j26-v6mr63249314edf.15.1537394704261;
        Wed, 19 Sep 2018 15:05:04 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-115-161.cgn.ip.fibianet.dk. [5.186.115.161])
        by smtp.gmail.com with ESMTPSA id a9-v6sm2798edi.26.2018.09.19.15.05.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Sep 2018 15:05:03 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 12/22] dynamic_debug: add static inline stub for ddebug_add_module
Date:   Thu, 20 Sep 2018 00:04:34 +0200
Message-Id: <20180919220444.23190-13-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
References: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For symmetry with ddebug_remove_module, and to avoid a bit of ifdeffery
in module.c, move the declaration of ddebug_add_module inside #if
defined(CONFIG_DYNAMIC_DEBUG) and add a corresponding no-op stub in the
#else branch.

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
index 381f9bf282fe..be2727c5a003 100644
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
2.16.4

