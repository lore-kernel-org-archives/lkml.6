Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D551AC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CBC12502B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HsapTnSx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CBC12502B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936789AbeF2PyX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 11:54:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:59514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755116AbeF2PyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 11:54:20 -0400
Received: from linux-5o07.suse.de (nat.nue.novell.com [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBC6325023;
        Fri, 29 Jun 2018 15:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530287659;
        bh=Ql+5uzdwMGeDz6KzfclC+dxpLTeO8rIGh8w9fWQDKj0=;
        h=From:To:Cc:Subject:Date:From;
        b=HsapTnSx4gTxJnPSg02RL0vXcx6w2a2sJNROkkFHwYeyG+NYmUXLxjV1l2lpLycXY
         1cgFnSpumDOJ5v6yKg2eE7feA9MBb1p9ugqzYs+gBPHrxrGh9HJz4WXqyL+gOUQbP4
         7CJ7IZuH+yK+v9fdZ0MxWSl5fZH8aIXS0l7SO0Xc=
From:   Jessica Yu <jeyu@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>, Jessica Yu <jeyu@kernel.org>
Subject: [PATCH] modsign: log module name in the event of an error
Date:   Fri, 29 Jun 2018 17:53:29 +0200
Message-Id: <20180629155329.2076-1-jeyu@kernel.org>
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
 kernel/module-internal.h | 26 +++++++++++++++++++++++++-
 kernel/module.c          | 22 +---------------------
 kernel/module_signing.c  |  9 ++++++---
 3 files changed, 32 insertions(+), 25 deletions(-)

diff --git a/kernel/module-internal.h b/kernel/module-internal.h
index 915e123a430f..ddeb1241455c 100644
--- a/kernel/module-internal.h
+++ b/kernel/module-internal.h
@@ -9,4 +9,28 @@
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
+extern int mod_verify_sig(const void *mod, struct load_info *info,
+			  unsigned long *_modlen);
diff --git a/kernel/module.c b/kernel/module.c
index ba45a84e4287..8bdd7e255274 100644
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
+		err = mod_verify_sig(mod, info, &info->len);
 	}
 
 	if (!err) {
diff --git a/kernel/module_signing.c b/kernel/module_signing.c
index 937c844bee4a..caeea810242d 100644
--- a/kernel/module_signing.c
+++ b/kernel/module_signing.c
@@ -45,7 +45,8 @@ struct module_signature {
 /*
  * Verify the signature on a module.
  */
-int mod_verify_sig(const void *mod, unsigned long *_modlen)
+int mod_verify_sig(const void *mod, struct load_info *info,
+		   unsigned long *_modlen)
 {
 	struct module_signature ms;
 	size_t modlen = *_modlen, sig_len;
@@ -65,7 +66,8 @@ int mod_verify_sig(const void *mod, unsigned long *_modlen)
 	*_modlen = modlen;
 
 	if (ms.id_type != PKEY_ID_PKCS7) {
-		pr_err("Module is not signed with expected PKCS#7 message\n");
+		pr_err("%s: Module is not signed with expected PKCS#7 message\n",
+		       info->name);
 		return -ENOPKG;
 	}
 
@@ -76,7 +78,8 @@ int mod_verify_sig(const void *mod, unsigned long *_modlen)
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

