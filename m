Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC7CC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 19:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F073214DC
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 19:43:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F073214DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sembritzki.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbeHOWg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 18:36:56 -0400
Received: from mail.sembritzki.me ([5.45.101.249]:60556 "EHLO
        mail.sembritzki.me" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727619AbeHOWg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 18:36:56 -0400
Received: from yannik-laptop.fritz.box (x4dbb4132.dyn.telefonica.de [77.187.65.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.sembritzki.me (Postfix) with ESMTPSA id 08433A7A8E;
        Wed, 15 Aug 2018 21:43:23 +0200 (CEST)
From:   Yannik Sembritzki <yannik@sembritzki.me>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        "Justin M. Forbes" <jforbes@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Matthew Garrett <mjg59@google.com>,
        Vivek Goyal <vgoyal@redhat.com>
Cc:     Yannik Sembritzki <yannik@sembritzki.me>
Subject: [PATCH 2/2] Replace magic for trusting the secondary keyring with #define
Date:   Wed, 15 Aug 2018 21:42:44 +0200
Message-Id: <20180815194244.29564-3-yannik@sembritzki.me>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180815194244.29564-1-yannik@sembritzki.me>
References: <20180815194244.29564-1-yannik@sembritzki.me>
In-Reply-To: <CA+55aFxXzfW+85Xf5OmNCsp2YRQqN3zJT5NhobauK=yn44_xiQ@mail.gmail.com>
References: <CA+55aFxXzfW+85Xf5OmNCsp2YRQqN3zJT5NhobauK=yn44_xiQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Yannik Sembritzki <yannik@sembritzki.me>
---
 arch/x86/kernel/kexec-bzimage64.c       | 2 +-
 certs/system_keyring.c                  | 3 ++-
 crypto/asymmetric_keys/pkcs7_key_type.c | 2 +-
 include/linux/verification.h            | 4 ++++
 4 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 74628275..97d199a3 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -532,7 +532,7 @@ static int bzImage64_cleanup(void *loader_data)
 static int bzImage64_verify_sig(const char *kernel, unsigned long kernel_len)
 {
 	return verify_pefile_signature(kernel, kernel_len,
-				       ((struct key *)1UL),
+				       TRUST_SECONDARY_KEYRING,
 				       VERIFYING_KEXEC_PE_SIGNATURE);
 }
 #endif
diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 6251d1b2..777ac7d2 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -15,6 +15,7 @@
 #include <linux/cred.h>
 #include <linux/err.h>
 #include <linux/slab.h>
+#include <linux/verification.h>
 #include <keys/asymmetric-type.h>
 #include <keys/system_keyring.h>
 #include <crypto/pkcs7.h>
@@ -230,7 +231,7 @@ int verify_pkcs7_signature(const void *data, size_t len,
 
 	if (!trusted_keys) {
 		trusted_keys = builtin_trusted_keys;
-	} else if (trusted_keys == (void *)1UL) {
+	} else if (trusted_keys == TRUST_SECONDARY_KEYRING) {
 #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
 		trusted_keys = secondary_trusted_keys;
 #else
diff --git a/crypto/asymmetric_keys/pkcs7_key_type.c b/crypto/asymmetric_keys/pkcs7_key_type.c
index e284d9cb..0783e555 100644
--- a/crypto/asymmetric_keys/pkcs7_key_type.c
+++ b/crypto/asymmetric_keys/pkcs7_key_type.c
@@ -63,7 +63,7 @@ static int pkcs7_preparse(struct key_preparsed_payload *prep)
 
 	return verify_pkcs7_signature(NULL, 0,
 				      prep->data, prep->datalen,
-				      (void *)1UL, usage,
+				      TRUST_SECONDARY_KEYRING, usage,
 				      pkcs7_view_content, prep);
 }
 
diff --git a/include/linux/verification.h b/include/linux/verification.h
index a10549a6..5a7f2053 100644
--- a/include/linux/verification.h
+++ b/include/linux/verification.h
@@ -12,6 +12,10 @@
 #ifndef _LINUX_VERIFICATION_H
 #define _LINUX_VERIFICATION_H
 
+// Allow both builtin trusted keys and secondary trusted keys
+#ifndef TRUST_SECONDARY_KEYRING
+#define TRUST_SECONDARY_KEYRING ((struct key *)1UL)
+
 /*
  * The use to which an asymmetric key is being put.
  */
-- 
2.17.1

