Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBEEECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35C6B20673
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35C6B20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731650AbeGRRNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 13:13:02 -0400
Received: from mga04.intel.com ([192.55.52.120]:51996 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731570AbeGRRNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 13:13:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jul 2018 09:34:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,371,1526367600"; 
   d="scan'208";a="57520063"
Received: from sandybridge-desktop.sh.intel.com ([10.239.160.116])
  by orsmga007.jf.intel.com with ESMTP; 18 Jul 2018 09:34:09 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     linux-pm@vger.kernel.org
Cc:     Rui Zhang <rui.zhang@intel.com>,
        "Gu, Kookoo" <kookoo.gu@intel.com>, Chen Yu <yu.c.chen@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        "Lee, Chun-Yi" <jlee@suse.com>, Eric Biggers <ebiggers@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Stephan Mueller <smueller@chronox.de>,
        Denis Kenzior <denkenz@gmail.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4][RFC v2] PM / hibernate: Install crypto hooks for hibernation encryption
Date:   Thu, 19 Jul 2018 00:39:54 +0800
Message-Id: <e4bdc8b835c0c53bc750307ea42912bb9ec16307.1531924968.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1531924968.git.yu.c.chen@intel.com>
References: <cover.1531924968.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The encryption helper functions are installed into hibernation
framework for later use.

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>
Cc: "Lee, Chun-Yi" <jlee@suse.com>
Cc: Eric Biggers <ebiggers@google.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Stephan Mueller <smueller@chronox.de>
Cc: Denis Kenzior <denkenz@gmail.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 include/linux/suspend.h           | 40 +++++++++++++++++++++++
 kernel/power/crypto_hibernation.c | 10 ++++++
 kernel/power/hibernate.c          | 67 +++++++++++++++++++++++++++++++++++++++
 kernel/power/power.h              |  2 ++
 4 files changed, 119 insertions(+)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 440b62f..b45a857 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -391,6 +391,46 @@ extern void hibernation_set_ops(const struct platform_hibernation_ops *ops);
 extern int hibernate(void);
 extern bool system_entering_hibernation(void);
 extern bool hibernation_available(void);
+#if IS_ENABLED(CONFIG_CRYPTO_HIBERNATION)
+struct hibernation_crypto_ops {
+	int (*crypto_data)(
+		const char *inbuf, int inlen,
+		char *outbuf, int outlen,
+		unsigned int cmd,
+		int page_idx);
+	void (*save)(void *buf);
+	void (*restore)(void *buf);
+	int (*init)(bool suspend);
+};
+
+extern void hibernation_set_crypto_ops(
+		const struct hibernation_crypto_ops *ops);
+extern int hibernation_crypto_data(
+		const char *inbuf,
+		int inlen,
+		char *outbuf,
+		int outlen,
+		unsigned int cmd,
+		int page_idx);
+extern void hibernation_crypto_save(void *outbuf);
+extern void hibernation_crypto_restore(void *inbuf);
+extern int hibernation_crypto_init(bool suspend);
+extern int hibernation_crypto_mode;
+#else
+static inline int hibernation_crypto_data(
+		const char *inbuf,
+		int inlen,
+		char *outbuf,
+		int outlen,
+		unsigned int cmd,
+		int page_idx) { return 0; }
+static inline void hibernation_crypto_save(void *outbuf) {}
+static inline void hibernation_crypto_restore(void *inbuf) {}
+static inline int hibernation_crypto_init(bool suspend)
+{
+	return 0;
+}
+#endif
 asmlinkage int swsusp_save(void);
 extern struct pbe *restore_pblist;
 #else /* CONFIG_HIBERNATION */
diff --git a/kernel/power/crypto_hibernation.c b/kernel/power/crypto_hibernation.c
index 406bb0c..845eb54 100644
--- a/kernel/power/crypto_hibernation.c
+++ b/kernel/power/crypto_hibernation.c
@@ -36,6 +36,7 @@
 #include <linux/moduleparam.h>
 #include <linux/cdev.h>
 #include <linux/major.h>
+#include <linux/suspend.h>
 #include <crypto/skcipher.h>
 #include <crypto/akcipher.h>
 #include <crypto/aes.h>
@@ -288,6 +289,13 @@ static int crypto_init(bool suspend)
 	return 0;
 }
 
+static const struct hibernation_crypto_ops crypto_ops = {
+	.crypto_data = crypto_data,
+	.save = crypto_save,
+	.restore = crypto_restore,
+	.init = crypto_init,
+};
+
 /* key/salt probing via ioctl. */
 dev_t crypto_dev;
 static struct class *crypto_dev_class;
@@ -384,6 +392,8 @@ static int crypto_hibernate_init(void)
 	/* generate the random salt */
 	get_random_bytes(get_salt_ptr(), HIBERNATE_MAX_SALT_BYTES);
 
+	hibernation_set_crypto_ops(&crypto_ops);
+
 	return 0;
 
  r_device:
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 9c85c78..a9e82f8 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -59,6 +59,16 @@ enum {
 	/* keep last */
 	__HIBERNATION_AFTER_LAST
 };
+
+#if IS_ENABLED(CONFIG_CRYPTO_HIBERNATION)
+enum {
+	HIBERNATION_ENCRYPT,
+	HIBERNATION_SIGNATURE,
+	HIBERNATION_ENCRYPT_SIGNATURE,
+};
+int hibernation_crypto_mode = HIBERNATION_ENCRYPT;
+#endif
+
 #define HIBERNATION_MAX (__HIBERNATION_AFTER_LAST-1)
 #define HIBERNATION_FIRST (HIBERNATION_INVALID + 1)
 
@@ -96,6 +106,63 @@ void hibernation_set_ops(const struct platform_hibernation_ops *ops)
 }
 EXPORT_SYMBOL_GPL(hibernation_set_ops);
 
+#if IS_ENABLED(CONFIG_CRYPTO_HIBERNATION)
+/* Install encryption/decryption/signature hooks. */
+static const struct hibernation_crypto_ops *hibernation_crypto_ops;
+
+void hibernation_set_crypto_ops(const struct hibernation_crypto_ops *ops)
+{
+	hibernation_crypto_ops = ops;
+}
+EXPORT_SYMBOL_GPL(hibernation_set_crypto_ops);
+
+int hibernation_crypto_data(
+		const char *inbuf,
+		int inlen,
+		char *outbuf,
+		int outlen,
+		unsigned int mode,
+		int page_idx)
+{
+	if (hibernation_crypto_ops &&
+	    hibernation_crypto_ops->crypto_data)
+		return hibernation_crypto_ops->crypto_data(inbuf,
+			inlen, outbuf, outlen, mode, page_idx);
+	else
+		return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(hibernation_crypto_data);
+
+/* Invoked before hibernate. */
+void hibernation_crypto_save(void *outbuf)
+{
+	if (hibernation_crypto_ops &&
+	    hibernation_crypto_ops->save)
+		hibernation_crypto_ops->save(outbuf);
+}
+EXPORT_SYMBOL_GPL(hibernation_crypto_save);
+
+/* Invoked before resumed. */
+void hibernation_crypto_restore(void *inbuf)
+{
+	if (hibernation_crypto_ops &&
+	    hibernation_crypto_ops->restore)
+		hibernation_crypto_ops->restore(inbuf);
+}
+EXPORT_SYMBOL_GPL(hibernation_crypto_restore);
+
+/* Initialization for crypto helper facilities. */
+int hibernation_crypto_init(bool suspend)
+{
+	if (hibernation_crypto_ops &&
+	    hibernation_crypto_ops->init)
+		return hibernation_crypto_ops->init(suspend);
+	else
+		return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(hibernation_crypto_init);
+
+#endif
 static bool entering_platform_hibernation;
 
 bool system_entering_hibernation(void)
diff --git a/kernel/power/power.h b/kernel/power/power.h
index a539bdb..ba3b24c 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -107,6 +107,8 @@ struct hibernation_crypto {
 	struct hibernation_crypto_keys keys;
 };
 
+extern void hibernation_set_crypto_ops(
+	const struct hibernation_crypto_ops *ops);
 #else
 #define HIBERNATE_MAX_SALT_BYTES	0
 #endif
-- 
2.7.4

