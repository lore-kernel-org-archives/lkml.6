Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C280C67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0615220671
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:25:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0615220671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbeJXLv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 07:51:28 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:45954 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbeJXLv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 07:51:28 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 2AC1A72CC64;
        Wed, 24 Oct 2018 06:25:17 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id F275A4A4A16;
        Wed, 24 Oct 2018 06:25:16 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vitaly Chikunov <vt@altlinux.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] crypto: streebog - register Streebog in hash info for IMA
Date:   Wed, 24 Oct 2018 06:23:50 +0300
Message-Id: <20181024032356.3388-3-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181024032356.3388-1-vt@altlinux.org>
References: <20181024032356.3388-1-vt@altlinux.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register Streebog hash function in Hash Info arrays to let IMA use
it for its purposes.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 crypto/hash_info.c             | 4 ++++
 include/crypto/hash_info.h     | 1 +
 include/uapi/linux/hash_info.h | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/crypto/hash_info.c b/crypto/hash_info.c
index 7b1e0b188ce6..b0b91eb0973a 100644
--- a/crypto/hash_info.c
+++ b/crypto/hash_info.c
@@ -32,6 +32,8 @@ const char *const hash_algo_name[HASH_ALGO__LAST] = {
 	[HASH_ALGO_TGR_160]	= "tgr160",
 	[HASH_ALGO_TGR_192]	= "tgr192",
 	[HASH_ALGO_SM3_256]	= "sm3-256",
+	[HASH_ALGO_SB256]	= "sb256",
+	[HASH_ALGO_SB512]	= "sb512",
 };
 EXPORT_SYMBOL_GPL(hash_algo_name);
 
@@ -54,5 +56,7 @@ const int hash_digest_size[HASH_ALGO__LAST] = {
 	[HASH_ALGO_TGR_160]	= TGR160_DIGEST_SIZE,
 	[HASH_ALGO_TGR_192]	= TGR192_DIGEST_SIZE,
 	[HASH_ALGO_SM3_256]	= SM3256_DIGEST_SIZE,
+	[HASH_ALGO_SB256]	= STREEBOG256_DIGEST_SIZE,
+	[HASH_ALGO_SB512]	= STREEBOG512_DIGEST_SIZE,
 };
 EXPORT_SYMBOL_GPL(hash_digest_size);
diff --git a/include/crypto/hash_info.h b/include/crypto/hash_info.h
index 56f217d41f12..91786b68dbdb 100644
--- a/include/crypto/hash_info.h
+++ b/include/crypto/hash_info.h
@@ -15,6 +15,7 @@
 
 #include <crypto/sha.h>
 #include <crypto/md5.h>
+#include <crypto/streebog.h>
 
 #include <uapi/linux/hash_info.h>
 
diff --git a/include/uapi/linux/hash_info.h b/include/uapi/linux/hash_info.h
index eea5d02c58de..5e8b8d952ba0 100644
--- a/include/uapi/linux/hash_info.h
+++ b/include/uapi/linux/hash_info.h
@@ -33,6 +33,8 @@ enum hash_algo {
 	HASH_ALGO_TGR_160,
 	HASH_ALGO_TGR_192,
 	HASH_ALGO_SM3_256,
+	HASH_ALGO_SB256,
+	HASH_ALGO_SB512,
 	HASH_ALGO__LAST
 };
 
-- 
2.11.0

