Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FF9C43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 15:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2DF124C47
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 15:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="IQ5tHNPA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2DF124C47
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751871AbeFWPiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 11:38:14 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:44639 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751471AbeFWPiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 11:38:13 -0400
Received: from grover.sesame (FL1-125-199-20-195.osk.mesh.ad.jp [125.199.20.195]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id w5NFbn1q014816;
        Sun, 24 Jun 2018 00:37:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w5NFbn1q014816
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1529768269;
        bh=20tIt5P+vv0w6f8CBJuocH4+NLH1ZY1zldB9Ok3JUDI=;
        h=From:To:Cc:Subject:Date:From;
        b=IQ5tHNPAlEs0BN1nmyxDFHnLLrAmLl/Hgb6MXsWTbX4yPZ9YPP65PkvH4B0aJhOX3
         y8PeoG7BI6QkM8h5Rb4KCP9yvjLzsQ+VT5OK8Q3mGyjujjRo67HvtsdaTjdlu5qgz6
         860tiT1bL9N4cHjONqDxeUizvV342OAGbVHikxv49apBBkHQ4Vanr5KzwBvrWhpaDx
         96FKWESSRKqAxqp6kzST1dwxdgWbnLe0RCd00M5Cd9+WvWE0ZXFiTfV63kQYigKeKF
         4xESO8J0nRLxL7xeHX1lZSOsy+B/vOVII3+LPSKAb01AmZD1IcuTNJvCoEx49icWl8
         mpOUDo/xwcsIw==
X-Nifty-SrcIP: [125.199.20.195]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] module: replace VMLINUX_SYMBOL_STR() with __stringify() or string literal
Date:   Sun, 24 Jun 2018 00:37:44 +0900
Message-Id: <1529768264-10199-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the special case handling for Blackfin and Metag was removed by
commit 94e58e0ac312 ("export.h: remove code for prefixing symbols with
underscore"), VMLINUX_SYMBOL_STR() is now equivalent to __stringify().

Replace the remaining usages to prepare for the entire removal of
VMLINUX_SYMBOL_STR().

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 include/linux/module.h | 4 ++--
 kernel/module.c        | 6 ++----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index d44df9b..f807f15 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -266,7 +266,7 @@ extern int modules_disabled; /* for sysctl */
 /* Get/put a kernel symbol (calls must be symmetric) */
 void *__symbol_get(const char *symbol);
 void *__symbol_get_gpl(const char *symbol);
-#define symbol_get(x) ((typeof(&x))(__symbol_get(VMLINUX_SYMBOL_STR(x))))
+#define symbol_get(x) ((typeof(&x))(__symbol_get(__stringify(x))))
 
 /* modules using other modules: kdb wants to see this. */
 struct module_use {
@@ -575,7 +575,7 @@ extern void __noreturn __module_put_and_exit(struct module *mod,
 #ifdef CONFIG_MODULE_UNLOAD
 int module_refcount(struct module *mod);
 void __symbol_put(const char *symbol);
-#define symbol_put(x) __symbol_put(VMLINUX_SYMBOL_STR(x))
+#define symbol_put(x) __symbol_put(__stringify(x))
 void symbol_put_addr(void *addr);
 
 /* Sometimes we know we already have a refcount, and it's easier not
diff --git a/kernel/module.c b/kernel/module.c
index f475f30..624d2c0 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -1339,14 +1339,12 @@ static inline int check_modstruct_version(const struct load_info *info,
 	 * locking is necessary -- use preempt_disable() to placate lockdep.
 	 */
 	preempt_disable();
-	if (!find_symbol(VMLINUX_SYMBOL_STR(module_layout), NULL,
-			 &crc, true, false)) {
+	if (!find_symbol("module_layout", NULL, &crc, true, false)) {
 		preempt_enable();
 		BUG();
 	}
 	preempt_enable();
-	return check_version(info, VMLINUX_SYMBOL_STR(module_layout),
-			     mod, crc);
+	return check_version(info, "module_layout", mod, crc);
 }
 
 /* First part is kernel version, which we ignore if module has crcs. */
-- 
2.7.4

