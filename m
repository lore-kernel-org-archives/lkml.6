Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A1CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C0BA20840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391742AbfAPKRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 05:17:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:23078 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389537AbfAPKRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 05:17:43 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7832237E66;
        Wed, 16 Jan 2019 10:17:42 +0000 (UTC)
Received: from kasong-desktop-nay-redhat-com.nay.redhat.com (unknown [10.66.128.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 245DE60BEC;
        Wed, 16 Jan 2019 10:17:36 +0000 (UTC)
From:   Kairui Song <kasong@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        jwboyer@fedoraproject.org, keyrings@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com,
        bauerman@linux.ibm.com, ebiggers@google.com, nayna@linux.ibm.com,
        dyoung@redhat.com, linux-integrity@vger.kernel.org,
        kexec@lists.infradead.org, Kairui Song <kasong@redhat.com>
Subject: [PATCH v3 2/2] kexec, KEYS: Make use of platform keyring for signature verify
Date:   Wed, 16 Jan 2019 18:16:54 +0800
Message-Id: <20190116101654.7288-3-kasong@redhat.com>
In-Reply-To: <20190116101654.7288-1-kasong@redhat.com>
References: <20190116101654.7288-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 16 Jan 2019 10:17:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With KEXEC_BZIMAGE_VERIFY_SIG enabled, kexec_file_load will need to
verify the kernel image. The image might be signed with third part keys,
and the keys could be stored in firmware, then got loaded into the
.platform keyring. Now we have a symbol .platform_trusted_keyring as the
reference to .platform keyring, this patch makes use if it and allow
kexec_file_load to verify the image against keys in .platform keyring.

This commit adds a VERIFY_USE_PLATFORM_KEYRING similar to previous
VERIFY_USE_SECONDARY_KEYRING indicating that verify_pkcs7_signature
should verify the signature using platform keyring. Also, decrease
the error message log level when verification failed with -ENOKEY,
so that if called tried multiple time with different keyring it
won't generate extra noises.

Signed-off-by: Kairui Song <kasong@redhat.com>
---
 arch/x86/kernel/kexec-bzimage64.c | 13 ++++++++++---
 certs/system_keyring.c            | 13 ++++++++++++-
 include/linux/verification.h      |  1 +
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 7d97e432cbbc..2c007abd3d40 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -534,9 +534,16 @@ static int bzImage64_cleanup(void *loader_data)
 #ifdef CONFIG_KEXEC_BZIMAGE_VERIFY_SIG
 static int bzImage64_verify_sig(const char *kernel, unsigned long kernel_len)
 {
-	return verify_pefile_signature(kernel, kernel_len,
-				       VERIFY_USE_SECONDARY_KEYRING,
-				       VERIFYING_KEXEC_PE_SIGNATURE);
+	int ret;
+	ret = verify_pefile_signature(kernel, kernel_len,
+				      VERIFY_USE_SECONDARY_KEYRING,
+				      VERIFYING_KEXEC_PE_SIGNATURE);
+	if (ret == -ENOKEY && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING)) {
+		ret = verify_pefile_signature(kernel, kernel_len,
+					      VERIFY_USE_PLATFORM_KEYRING,
+					      VERIFYING_KEXEC_PE_SIGNATURE);
+	}
+	return ret;
 }
 #endif
 
diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 4690ef9cda8a..7085c286f4bd 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -240,11 +240,22 @@ int verify_pkcs7_signature(const void *data, size_t len,
 #else
 		trusted_keys = builtin_trusted_keys;
 #endif
+	} else if (trusted_keys == VERIFY_USE_PLATFORM_KEYRING) {
+#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
+		trusted_keys = platform_trusted_keys;
+#else
+		trusted_keys = NULL;
+#endif
+		if (!trusted_keys) {
+			ret = -ENOKEY;
+			pr_devel("PKCS#7 platform keyring is not available\n");
+			goto error;
+		}
 	}
 	ret = pkcs7_validate_trust(pkcs7, trusted_keys);
 	if (ret < 0) {
 		if (ret == -ENOKEY)
-			pr_err("PKCS#7 signature not signed with a trusted key\n");
+			pr_devel("PKCS#7 signature not signed with a trusted key\n");
 		goto error;
 	}
 
diff --git a/include/linux/verification.h b/include/linux/verification.h
index cfa4730d607a..018fb5f13d44 100644
--- a/include/linux/verification.h
+++ b/include/linux/verification.h
@@ -17,6 +17,7 @@
  * should be used.
  */
 #define VERIFY_USE_SECONDARY_KEYRING ((struct key *)1UL)
+#define VERIFY_USE_PLATFORM_KEYRING  ((struct key *)2UL)
 
 /*
  * The use to which an asymmetric key is being put.
-- 
2.20.1

