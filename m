Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BCBC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17E452075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:13:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17E452075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbeIHB4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:56:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40704 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbeIHB4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:56:00 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1AA86F81;
        Fri,  7 Sep 2018 21:13:13 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yannik Sembritzki <yannik@sembritzki.me>,
        David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.18 024/145] Replace magic for trusting the secondary keyring with #define
Date:   Fri,  7 Sep 2018 23:08:10 +0200
Message-Id: <20180907210905.585422810@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210903.617721278@linuxfoundation.org>
References: <20180907210903.617721278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yannik Sembritzki <yannik@sembritzki.me>

commit 817aef260037f33ee0f44c17fe341323d3aebd6d upstream.

Replace the use of a magic number that indicates that verify_*_signature()
should use the secondary keyring with a symbol.

Signed-off-by: Yannik Sembritzki <yannik@sembritzki.me>
Signed-off-by: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 certs/system_keyring.c                  |    3 ++-
 crypto/asymmetric_keys/pkcs7_key_type.c |    2 +-
 include/linux/verification.h            |    6 ++++++
 3 files changed, 9 insertions(+), 2 deletions(-)

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
@@ -230,7 +231,7 @@ int verify_pkcs7_signature(const void *d
 
 	if (!trusted_keys) {
 		trusted_keys = builtin_trusted_keys;
-	} else if (trusted_keys == (void *)1UL) {
+	} else if (trusted_keys == VERIFY_USE_SECONDARY_KEYRING) {
 #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
 		trusted_keys = secondary_trusted_keys;
 #else
--- a/crypto/asymmetric_keys/pkcs7_key_type.c
+++ b/crypto/asymmetric_keys/pkcs7_key_type.c
@@ -63,7 +63,7 @@ static int pkcs7_preparse(struct key_pre
 
 	return verify_pkcs7_signature(NULL, 0,
 				      prep->data, prep->datalen,
-				      (void *)1UL, usage,
+				      VERIFY_USE_SECONDARY_KEYRING, usage,
 				      pkcs7_view_content, prep);
 }
 
--- a/include/linux/verification.h
+++ b/include/linux/verification.h
@@ -13,6 +13,12 @@
 #define _LINUX_VERIFICATION_H
 
 /*
+ * Indicate that both builtin trusted keys and secondary trusted keys
+ * should be used.
+ */
+#define VERIFY_USE_SECONDARY_KEYRING ((struct key *)1UL)
+
+/*
  * The use to which an asymmetric key is being put.
  */
 enum key_being_used_for {


