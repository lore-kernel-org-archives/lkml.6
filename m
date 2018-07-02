Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BACC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A8FA208AF
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWVdrOme"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A8FA208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965646AbeGBLT3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 07:19:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:57416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753800AbeGBLTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 07:19:25 -0400
Received: from linux-5o07.suse.de (nat.nue.novell.com [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C107A208AF;
        Mon,  2 Jul 2018 11:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530530364;
        bh=YBxVu2iOj4dFFvbYhwdkC5j21fG0juGbR2BgXM+e5Nk=;
        h=From:To:Cc:Subject:Date:From;
        b=hWVdrOmeHhoIZMymS/Otd6icx6ZU5yqSNuH52zWCKAyoWX4jMzSRqB/P1rjLXFJM3
         dupNDKGyLgeIceUAMkmjIUfugYroONIi5k2QkpedQ5ZmV9kDLhu09ctbjvCvIHZRu+
         k3wjloPGeYt6ATWWEILNZsHEAh4PQgOQVVbtA1oQ=
From:   Jessica Yu <jeyu@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>, Joe Perches <joe@perches.com>,
        Jessica Yu <jeyu@kernel.org>
Subject: [PATCH v2] modsign: log module name in the event of an error
Date:   Mon,  2 Jul 2018 13:18:31 +0200
Message-Id: <20180702111831.4699-1-jeyu@kernel.org>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have the load_info struct all initialized (including
info->name, which contains the name of the module) before
module_sig_check(), make the load_info struct and hence module name
available to mod_verify_sig() so that we can log the module name in the
event of an error.

Signed-off-by: Jessica Yu <jeyu@kernel.org>
---
v2:
 - remove _modlen argument and just use the passed info struct

 kernel/module-internal.h | 25 ++++++++++++++++++++++++-
 kernel/module.c          | 22 +---------------------
 kernel/module_signing.c  | 12 +++++++-----
 3 files changed, 32 insertions(+), 27 deletions(-)

diff --git a/kernel/module-internal.h b/kernel/module-internal.h
index 915e123a430f..79c9be2dbbe9 100644
--- a/kernel/module-internal.h
+++ b/kernel/module-internal.h
@@ -9,4 +9,27 @@
  * 2 of the Licence, or (at your option) any later version.
  */
 
-extern int mod_verify_sig(const void *mod, unsigned long *_modlen);
+#include <linux/elf.h>
+#include <asm/module.h>
+
+struct load_info {
+	const char *name;
+	/* pointer to module in temporary copy, freed at end of load_module() */
+	struct module *mod;
+	Elf_Ehdr *hdr;
+	unsigned long len;
+	Elf_Shdr *sechdrs;
+	char *secstrings, *strtab;
+	unsigned long symoffs, stroffs;
+	struct _ddebug *debug;
+	unsigned int num_debug;
+	bool sig_ok;
+#ifdef CONFIG_KALLSYMS
+	unsigned long mod_kallsyms_init_off;
+#endif
+	struct {
+		unsigned int sym, str, mod, vers, info, pcpu;
+	} index;
+};
+
+extern int mod_verify_sig(const void *mod, struct load_info *info);
diff --git a/kernel/module.c b/kernel/module.c
index ba45a84e4287..8a45986fd728 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -307,26 +307,6 @@ int unregister_module_notifier(struct notifier_block *nb)
 }
 EXPORT_SYMBOL(unregister_module_notifier);
 
-struct load_info {
-	const char *name;
-	/* pointer to module in temporary copy, freed at end of load_module() */
-	struct module *mod;
-	Elf_Ehdr *hdr;
-	unsigned long len;
-	Elf_Shdr *sechdrs;
-	char *secstrings, *strtab;
-	unsigned long symoffs, stroffs;
-	struct _ddebug *debug;
-	unsigned int num_debug;
-	bool sig_ok;
-#ifdef CONFIG_KALLSYMS
-	unsigned long mod_kallsyms_init_off;
-#endif
-	struct {
-		unsigned int sym, str, mod, vers, info, pcpu;
-	} index;
-};
-
 /*
  * We require a truly strong try_module_get(): 0 means success.
  * Otherwise an error is returned due to ongoing or failed
@@ -2778,7 +2758,7 @@ static int module_sig_check(struct load_info *info, int flags)
 	    memcmp(mod + info->len - markerlen, MODULE_SIG_STRING, markerlen) == 0) {
 		/* We truncate the module to discard the signature */
 		info->len -= markerlen;
-		err = mod_verify_sig(mod, &info->len);
+		err = mod_verify_sig(mod, info);
 	}
 
 	if (!err) {
diff --git a/kernel/module_signing.c b/kernel/module_signing.c
index 937c844bee4a..f2075ce8e4b3 100644
--- a/kernel/module_signing.c
+++ b/kernel/module_signing.c
@@ -45,10 +45,10 @@ struct module_signature {
 /*
  * Verify the signature on a module.
  */
-int mod_verify_sig(const void *mod, unsigned long *_modlen)
+int mod_verify_sig(const void *mod, struct load_info *info)
 {
 	struct module_signature ms;
-	size_t modlen = *_modlen, sig_len;
+	size_t sig_len, modlen = info->len;
 
 	pr_devel("==>%s(,%zu)\n", __func__, modlen);
 
@@ -62,10 +62,11 @@ int mod_verify_sig(const void *mod, unsigned long *_modlen)
 	if (sig_len >= modlen)
 		return -EBADMSG;
 	modlen -= sig_len;
-	*_modlen = modlen;
+	info->len = modlen;
 
 	if (ms.id_type != PKEY_ID_PKCS7) {
-		pr_err("Module is not signed with expected PKCS#7 message\n");
+		pr_err("%s: Module is not signed with expected PKCS#7 message\n",
+		       info->name);
 		return -ENOPKG;
 	}
 
@@ -76,7 +77,8 @@ int mod_verify_sig(const void *mod, unsigned long *_modlen)
 	    ms.__pad[0] != 0 ||
 	    ms.__pad[1] != 0 ||
 	    ms.__pad[2] != 0) {
-		pr_err("PKCS#7 signature info has unexpected non-zero params\n");
+		pr_err("%s: PKCS#7 signature info has unexpected non-zero params\n",
+		       info->name);
 		return -EBADMSG;
 	}
 
-- 
2.16.4

