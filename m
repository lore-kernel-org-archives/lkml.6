Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17ED0C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDACD214C5
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:18:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDACD214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732712AbeIXSUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:20:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56190 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730495AbeIXSUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:20:43 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 35EED107E;
        Mon, 24 Sep 2018 12:18:51 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthew Garrett <mjg59@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 114/173] evm: Dont deadlock if a crypto algorithm is unavailable
Date:   Mon, 24 Sep 2018 13:52:28 +0200
Message-Id: <20180924113124.452089693@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113114.334025954@linuxfoundation.org>
References: <20180924113114.334025954@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthew Garrett <mjg59@google.com>

[ Upstream commit e2861fa71641c6414831d628a1f4f793b6562580 ]

When EVM attempts to appraise a file signed with a crypto algorithm the
kernel doesn't have support for, it will cause the kernel to trigger a
module load. If the EVM policy includes appraisal of kernel modules this
will in turn call back into EVM - since EVM is holding a lock until the
crypto initialisation is complete, this triggers a deadlock. Add a
CRYPTO_NOLOAD flag and skip module loading if it's set, and add that flag
in the EVM case in order to fail gracefully with an error message
instead of deadlocking.

Signed-off-by: Matthew Garrett <mjg59@google.com>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 crypto/api.c                        |    2 +-
 include/linux/crypto.h              |    5 +++++
 security/integrity/evm/evm_crypto.c |    3 ++-
 3 files changed, 8 insertions(+), 2 deletions(-)

--- a/crypto/api.c
+++ b/crypto/api.c
@@ -215,7 +215,7 @@ struct crypto_alg *crypto_larval_lookup(
 	mask &= ~(CRYPTO_ALG_LARVAL | CRYPTO_ALG_DEAD);
 
 	alg = crypto_alg_lookup(name, type, mask);
-	if (!alg) {
+	if (!alg && !(mask & CRYPTO_NOLOAD)) {
 		request_module("crypto-%s", name);
 
 		if (!((type ^ CRYPTO_ALG_NEED_FALLBACK) & mask &
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -112,6 +112,11 @@
 #define CRYPTO_ALG_OPTIONAL_KEY		0x00004000
 
 /*
+ * Don't trigger module loading
+ */
+#define CRYPTO_NOLOAD			0x00008000
+
+/*
  * Transform masks and values (for crt_flags).
  */
 #define CRYPTO_TFM_NEED_KEY		0x00000001
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -94,7 +94,8 @@ static struct shash_desc *init_desc(char
 		mutex_lock(&mutex);
 		if (*tfm)
 			goto out;
-		*tfm = crypto_alloc_shash(algo, 0, CRYPTO_ALG_ASYNC);
+		*tfm = crypto_alloc_shash(algo, 0,
+					  CRYPTO_ALG_ASYNC | CRYPTO_NOLOAD);
 		if (IS_ERR(*tfm)) {
 			rc = PTR_ERR(*tfm);
 			pr_err("Can not allocate %s (reason: %ld)\n", algo, rc);


