Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570F6C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CDB92077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:56:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CDB92077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbeIFC2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:28:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47452 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727592AbeIFC2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:28:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5959C40241DE;
        Wed,  5 Sep 2018 21:55:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 769111049471;
        Wed,  5 Sep 2018 21:55:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 15/22] KEYS: trusted: Expose common functionality
From:   David Howells <dhowells@redhat.com>
To:     jmorris@namei.org
Cc:     denkenz@gmail.com, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 05 Sep 2018 22:55:57 +0100
Message-ID: <153618455698.7946.4164892881649814591.stgit@warthog.procyon.org.uk>
In-Reply-To: <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk>
References: <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 05 Sep 2018 21:55:58 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 05 Sep 2018 21:55:58 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Kenzior <denkenz@gmail.com>

This patch exposes some common functionality needed to send TPM
commands.  The current approach is a complete hack and needs to be
addressed properly.  This commit just show-cases what functionality
would need to be moved to a shared location or exposed in some other
manner.

Signed-off-by: Denis Kenzior <denkenz@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 crypto/asymmetric_keys/Kconfig |    1 +
 security/keys/trusted.c        |   12 ++++++++----
 security/keys/trusted.h        |   14 +++++++++++++-
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/crypto/asymmetric_keys/Kconfig b/crypto/asymmetric_keys/Kconfig
index 88353a9ebc9b..be70ca6c85d3 100644
--- a/crypto/asymmetric_keys/Kconfig
+++ b/crypto/asymmetric_keys/Kconfig
@@ -24,6 +24,7 @@ config ASYMMETRIC_PUBLIC_KEY_SUBTYPE
 config ASYMMETRIC_TPM_KEY_SUBTYPE
 	tristate "Asymmetric TPM backed private key subtype"
 	depends on TCG_TPM
+	depends on TRUSTED_KEYS
 	select CRYPTO_HMAC
 	select CRYPTO_SHA1
 	select CRYPTO_HASH_INFO
diff --git a/security/keys/trusted.c b/security/keys/trusted.c
index b69d3b1777c2..1c025fdfe0e0 100644
--- a/security/keys/trusted.c
+++ b/security/keys/trusted.c
@@ -121,7 +121,7 @@ static int TSS_rawhmac(unsigned char *digest, const unsigned char *key,
 /*
  * calculate authorization info fields to send to TPM
  */
-static int TSS_authhmac(unsigned char *digest, const unsigned char *key,
+int TSS_authhmac(unsigned char *digest, const unsigned char *key,
 			unsigned int keylen, unsigned char *h1,
 			unsigned char *h2, unsigned char h3, ...)
 {
@@ -168,11 +168,12 @@ static int TSS_authhmac(unsigned char *digest, const unsigned char *key,
 	kzfree(sdesc);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(TSS_authhmac);
 
 /*
  * verify the AUTH1_COMMAND (Seal) result from TPM
  */
-static int TSS_checkhmac1(unsigned char *buffer,
+int TSS_checkhmac1(unsigned char *buffer,
 			  const uint32_t command,
 			  const unsigned char *ononce,
 			  const unsigned char *key,
@@ -249,6 +250,7 @@ static int TSS_checkhmac1(unsigned char *buffer,
 	kzfree(sdesc);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(TSS_checkhmac1);
 
 /*
  * verify the AUTH2_COMMAND (unseal) result from TPM
@@ -355,7 +357,7 @@ static int TSS_checkhmac2(unsigned char *buffer,
  * For key specific tpm requests, we will generate and send our
  * own TPM command packets using the drivers send function.
  */
-static int trusted_tpm_send(unsigned char *cmd, size_t buflen)
+int trusted_tpm_send(unsigned char *cmd, size_t buflen)
 {
 	int rc;
 
@@ -367,6 +369,7 @@ static int trusted_tpm_send(unsigned char *cmd, size_t buflen)
 		rc = -EPERM;
 	return rc;
 }
+EXPORT_SYMBOL_GPL(trusted_tpm_send);
 
 /*
  * Lock a trusted key, by extending a selected PCR.
@@ -425,7 +428,7 @@ static int osap(struct tpm_buf *tb, struct osapsess *s,
 /*
  * Create an object independent authorisation protocol (oiap) session
  */
-static int oiap(struct tpm_buf *tb, uint32_t *handle, unsigned char *nonce)
+int oiap(struct tpm_buf *tb, uint32_t *handle, unsigned char *nonce)
 {
 	int ret;
 
@@ -442,6 +445,7 @@ static int oiap(struct tpm_buf *tb, uint32_t *handle, unsigned char *nonce)
 	       TPM_NONCE_SIZE);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(oiap);
 
 struct tpm_digests {
 	unsigned char encauth[SHA1_DIGEST_SIZE];
diff --git a/security/keys/trusted.h b/security/keys/trusted.h
index 8d5fe9eafb22..adbcb6817826 100644
--- a/security/keys/trusted.h
+++ b/security/keys/trusted.h
@@ -3,7 +3,7 @@
 #define __TRUSTED_KEY_H
 
 /* implementation specific TPM constants */
-#define MAX_BUF_SIZE			512
+#define MAX_BUF_SIZE			1024
 #define TPM_GETRANDOM_SIZE		14
 #define TPM_OSAP_SIZE			36
 #define TPM_OIAP_SIZE			10
@@ -36,6 +36,18 @@ enum {
 	SRK_keytype = 4
 };
 
+int TSS_authhmac(unsigned char *digest, const unsigned char *key,
+			unsigned int keylen, unsigned char *h1,
+			unsigned char *h2, unsigned char h3, ...);
+int TSS_checkhmac1(unsigned char *buffer,
+			  const uint32_t command,
+			  const unsigned char *ononce,
+			  const unsigned char *key,
+			  unsigned int keylen, ...);
+
+int trusted_tpm_send(unsigned char *cmd, size_t buflen);
+int oiap(struct tpm_buf *tb, uint32_t *handle, unsigned char *nonce);
+
 #define TPM_DEBUG 0
 
 #if TPM_DEBUG

