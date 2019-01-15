Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700F6C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 09:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4695A20657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 09:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728785AbfAOJqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 04:46:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41290 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbfAOJqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 04:46:52 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 478703DE03;
        Tue, 15 Jan 2019 09:46:52 +0000 (UTC)
Received: from kasong-desktop-nay-redhat-com.nay.redhat.com (unknown [10.66.128.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0736719940;
        Tue, 15 Jan 2019 09:46:42 +0000 (UTC)
From:   Kairui Song <kasong@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        jwboyer@fedoraproject.org, keyrings@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com,
        bauerman@linux.ibm.com, ebiggers@google.com, nayna@linux.ibm.com,
        dyoung@redhat.com, linux-integrity@vger.kernel.org,
        kexec@lists.infradead.org, Kairui Song <kasong@redhat.com>
Subject: [RFC PATCH v2 1/2] integrity, KEYS: add a reference to platform keyring
Date:   Tue, 15 Jan 2019 17:45:41 +0800
Message-Id: <20190115094542.17129-2-kasong@redhat.com>
In-Reply-To: <20190115094542.17129-1-kasong@redhat.com>
References: <20190115094542.17129-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 15 Jan 2019 09:46:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently when loading new kernel via kexec_file_load syscall, it is able
to verify the signed PE bzimage against .builtin_trusted_keys or
.secondary_trusted_keys. But the image could be signed with third part
keys which will be provided by platform or firmware as EFI variable (eg.
stored in MokListRT EFI variable), and the keys won't be available in
keyrings mentioned above.

After commit 9dc92c45177a ('integrity: Define a trusted platform keyring')
a .platform keyring is introduced to store the keys provided by platform
or firmware, this keyring is intended to be used for verifying kernel
images being loaded by kexec_file_load syscall. And with a few following
up commits, keys provided by firmware is being loaded into this keyring,
and IMA-appraisal is able to use the keyring to verify kernel images.
IMA is the currently the only user of that keyring.

This patch exposes the .platform, and makes it useable for other
components. For example, kexec_file_load could use this .platform
keyring to verify the kernel image's image.

Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Kairui Song <kasong@redhat.com>
---
 certs/system_keyring.c        | 9 +++++++++
 include/keys/system_keyring.h | 5 +++++
 security/integrity/digsig.c   | 6 ++++++
 3 files changed, 20 insertions(+)

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
index 359c2f936004..9e1b7849b6aa 100644
--- a/include/keys/system_keyring.h
+++ b/include/keys/system_keyring.h
@@ -61,5 +61,10 @@ static inline struct key *get_ima_blacklist_keyring(void)
 }
 #endif /* CONFIG_IMA_BLACKLIST_KEYRING */
 
+#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
+
+extern void __init set_platform_trusted_keys(struct key* keyring);
+
+#endif /* CONFIG_INTEGRITY_PLATFORM_KEYRING */
 
 #endif /* _KEYS_SYSTEM_KEYRING_H */
diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index f45d6edecf99..bfabc2a8111d 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -89,6 +89,12 @@ static int __integrity_init_keyring(const unsigned int id, key_perm_t perm,
 		keyring[id] = NULL;
 	}
 
+#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
+	if (id == INTEGRITY_KEYRING_PLATFORM) {
+		set_platform_trusted_keys(keyring[id]);
+	}
+#endif
+
 	return err;
 }
 
-- 
2.20.1

