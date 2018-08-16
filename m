Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC7CC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 13:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0C2720C03
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 13:05:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0C2720C03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391603AbeHPQDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 12:03:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37598 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726062AbeHPQDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 12:03:47 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D684C407541A;
        Thu, 16 Aug 2018 13:05:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-130.rdu2.redhat.com [10.10.120.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2DFBF1010415;
        Thu, 16 Aug 2018 13:05:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 1/2] Replace magic for trusting the secondary keyring with
 #define
From:   David Howells <dhowells@redhat.com>
To:     yannik@sembritzki.me, torvalds@linux-foundation.org
Cc:     keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        dhowells@redhat.com, linux-kernel@vger.kernel.org,
        dyoung@redhat.com, James.Bottomley@HansenPartnership.com,
        gregkh@linuxfoundation.org
Date:   Thu, 16 Aug 2018 14:05:10 +0100
Message-ID: <153442471049.17751.3835342719465644394.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 16 Aug 2018 13:05:17 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 16 Aug 2018 13:05:17 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yannik Sembritzki <yannik@sembritzki.me>

Replace the use of a magic number that indicates that verify_*_signature()
should use the secondary keyring with a symbol.

Signed-off-by: Yannik Sembritzki <yannik@sembritzki.me>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: keyrings@vger.kernel.org
cc: linux-security-module@vger.kernel.org
---

 certs/system_keyring.c                  |    3 ++-
 crypto/asymmetric_keys/pkcs7_key_type.c |    2 +-
 include/linux/verification.h            |    6 ++++++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 6251d1b27f0c..81728717523d 100644
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
+	} else if (trusted_keys == VERIFY_USE_SECONDARY_KEYRING) {
 #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
 		trusted_keys = secondary_trusted_keys;
 #else
diff --git a/crypto/asymmetric_keys/pkcs7_key_type.c b/crypto/asymmetric_keys/pkcs7_key_type.c
index e284d9cb9237..5b2f6a2b5585 100644
--- a/crypto/asymmetric_keys/pkcs7_key_type.c
+++ b/crypto/asymmetric_keys/pkcs7_key_type.c
@@ -63,7 +63,7 @@ static int pkcs7_preparse(struct key_preparsed_payload *prep)
 
 	return verify_pkcs7_signature(NULL, 0,
 				      prep->data, prep->datalen,
-				      (void *)1UL, usage,
+				      VERIFY_USE_SECONDARY_KEYRING, usage,
 				      pkcs7_view_content, prep);
 }
 
diff --git a/include/linux/verification.h b/include/linux/verification.h
index a10549a6c7cd..cfa4730d607a 100644
--- a/include/linux/verification.h
+++ b/include/linux/verification.h
@@ -12,6 +12,12 @@
 #ifndef _LINUX_VERIFICATION_H
 #define _LINUX_VERIFICATION_H
 
+/*
+ * Indicate that both builtin trusted keys and secondary trusted keys
+ * should be used.
+ */
+#define VERIFY_USE_SECONDARY_KEYRING ((struct key *)1UL)
+
 /*
  * The use to which an asymmetric key is being put.
  */

