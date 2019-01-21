Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353C9C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0894820870
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbfAUKAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 05:00:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34096 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726003AbfAUKAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 05:00:14 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 61F6CC073D78;
        Mon, 21 Jan 2019 10:00:13 +0000 (UTC)
Received: from kasong-desktop-nay-redhat-com.nay.redhat.com (unknown [10.66.128.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B2FAB6012D;
        Mon, 21 Jan 2019 10:00:04 +0000 (UTC)
From:   Kairui Song <kasong@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        jwboyer@fedoraproject.org, keyrings@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com,
        bauerman@linux.ibm.com, ebiggers@google.com, nayna@linux.ibm.com,
        dyoung@redhat.com, linux-integrity@vger.kernel.org,
        kexec@lists.infradead.org, Kairui Song <kasong@redhat.com>
Subject: [PATCH v5 1/2] integrity, KEYS: add a reference to platform keyring
Date:   Mon, 21 Jan 2019 17:59:28 +0800
Message-Id: <20190121095929.26915-2-kasong@redhat.com>
In-Reply-To: <20190121095929.26915-1-kasong@redhat.com>
References: <20190121095929.26915-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 21 Jan 2019 10:00:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 9dc92c45177a ('integrity: Define a trusted platform keyring')
introduced a .platform keyring for storing preboot keys, used for
verifying kernel images' signature. Currently only IMA-appraisal is able
to use the keyring to verify kernel images that have their signature
stored in xattr.

This patch exposes the .platform keyring, making it
accessible for verifying PE signed kernel images as well.

Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Kairui Song <kasong@redhat.com>
---
 certs/system_keyring.c        | 9 +++++++++
 include/keys/system_keyring.h | 9 +++++++++
 security/integrity/digsig.c   | 3 +++
 3 files changed, 21 insertions(+)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 81728717523d..4690ef9cda8a 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -24,6 +24,9 @@ static struct key *builtin_trusted_keys;
 #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
 static struct key *secondary_trusted_keys;
 #endif
+#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
+static struct key *platform_trusted_keys;
+#endif
 
 extern __initconst const u8 system_certificate_list[];
 extern __initconst const unsigned long system_certificate_list_size;
@@ -265,4 +268,10 @@ int verify_pkcs7_signature(const void *data, size_t len,
 }
 EXPORT_SYMBOL_GPL(verify_pkcs7_signature);
 
+#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
+void __init set_platform_trusted_keys(struct key *keyring) {
+	platform_trusted_keys = keyring;
+}
+#endif
+
 #endif /* CONFIG_SYSTEM_DATA_VERIFICATION */
diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
index 359c2f936004..df766ef8f03c 100644
--- a/include/keys/system_keyring.h
+++ b/include/keys/system_keyring.h
@@ -61,5 +61,14 @@ static inline struct key *get_ima_blacklist_keyring(void)
 }
 #endif /* CONFIG_IMA_BLACKLIST_KEYRING */
 
+#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
+
+extern void __init set_platform_trusted_keys(struct key* keyring);
+
+#else
+
+static inline void set_platform_trusted_keys(struct key* keyring) { };
+
+#endif /* CONFIG_INTEGRITY_PLATFORM_KEYRING */
 
 #endif /* _KEYS_SYSTEM_KEYRING_H */
diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index f45d6edecf99..e19c2eb72c51 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -87,6 +87,9 @@ static int __integrity_init_keyring(const unsigned int id, key_perm_t perm,
 		pr_info("Can't allocate %s keyring (%d)\n",
 			keyring_name[id], err);
 		keyring[id] = NULL;
+	} else {
+		if (id == INTEGRITY_KEYRING_PLATFORM)
+			set_platform_trusted_keys(keyring[id]);
 	}
 
 	return err;
-- 
2.20.1

