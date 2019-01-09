Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78293C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D1C120859
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfAIQtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 11:49:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44268 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbfAIQtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 11:49:15 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DAA314E90B;
        Wed,  9 Jan 2019 16:49:14 +0000 (UTC)
Received: from kasong-desktop-nay-redhat-com.nay.redhat.com (unknown [10.66.128.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2CC8257BF;
        Wed,  9 Jan 2019 16:49:09 +0000 (UTC)
From:   Kairui Song <kasong@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        jwboyer@fedoraproject.org, keyrings@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com,
        bauerman@linux.ibm.com, ebiggers@google.com, nayna@linux.ibm.com,
        dyoung@redhat.com, linux-integrity@vger.kernel.org,
        kexec@lists.infradead.org, Kairui Song <kasong@redhat.com>
Subject: [RFC PATCH 2/2] kexec, KEYS: Make use of platform keyring for signature verify
Date:   Thu, 10 Jan 2019 00:48:24 +0800
Message-Id: <20190109164824.19708-3-kasong@redhat.com>
In-Reply-To: <20190109164824.19708-1-kasong@redhat.com>
References: <20190109164824.19708-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 09 Jan 2019 16:49:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kexec_file_load will need to verify the kernel signed with third part
keys, and the keys could be stored in firmware, then got loaded into
the .platform keyring. Now we have a .platform_trusted_keyring
as the reference to .platform keyring, this patch makes use if it and
allow kexec_file_load to verify the image against keys in .platform
keyring.

This commit adds a VERIFY_USE_PLATFORM_KEYRING similar to previous
VERIFY_USE_SECONDARY_KEYRING indicating that verify_pkcs7_signature
should verify the signature using platform keyring. Also, decrease
the error message log level when verification failed with -ENOKEY,
so that if called tried multiple time with different keyring it
won't generate extra noises.

Signed-off-by: Kairui Song <kasong@redhat.com>
---
 arch/x86/kernel/kexec-bzimage64.c | 13 ++++++++++---
 certs/system_keyring.c            |  7 ++++++-
 include/linux/verification.h      |  1 +
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 7d97e432cbbc..a8a5c1773ccc 100644
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
+			VERIFY_USE_SECONDARY_KEYRING,
+			VERIFYING_KEXEC_PE_SIGNATURE);
+	if (ret == -ENOKEY) {
+		ret = verify_pefile_signature(kernel, kernel_len,
+				VERIFY_USE_PLATFORM_KEYRING,
+				VERIFYING_KEXEC_PE_SIGNATURE);
+	}
+	return ret;
 }
 #endif
 
diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index a61b95390b80..7514e69e719f 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -18,6 +18,7 @@
 #include <linux/verification.h>
 #include <keys/asymmetric-type.h>
 #include <keys/system_keyring.h>
+#include <keys/platform_keyring.h>
 #include <crypto/pkcs7.h>
 
 static struct key *builtin_trusted_keys;
@@ -239,12 +240,16 @@ int verify_pkcs7_signature(const void *data, size_t len,
 		trusted_keys = secondary_trusted_keys;
 #else
 		trusted_keys = builtin_trusted_keys;
+#endif
+#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
+	} else if (trusted_keys == VERIFY_USE_PLATFORM_KEYRING) {
+		trusted_keys = platform_trusted_keys;
 #endif
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

