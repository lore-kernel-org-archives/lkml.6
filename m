Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42FBC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD9B208A1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cteLpY5P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FD9B208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754944AbeFTTGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 15:06:18 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:37167 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754759AbeFTTE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 15:04:28 -0400
Received: by mail-pf0-f193.google.com with SMTP id y5-v6so256946pfn.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 12:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9exG+auSNsqHVYr1/J0wLzVKyblg1tz++twhS5zFlMY=;
        b=cteLpY5P6Vom4UEI118zL6xuBlpK4xQ/p8mPXEm69sCeDnK7jyqdhz9SRjDbIqytDR
         iZHrWzE8vepf4HhrU2PkeZOjjqcvsoqwC9Mu3LjLwOemu8d1xUe0ETQKmOsgbU8YDGZn
         7h0Il9lItuxyos4hgtgUXY2+CelY2Ojo7riqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9exG+auSNsqHVYr1/J0wLzVKyblg1tz++twhS5zFlMY=;
        b=gVif9wmTNLzZU571fvCh6TGZxL09oa8FhpulLA2w522m6suaiKiKxgTumfQv0Rh3TD
         WM8j+rgsfwHMH3qgPZPR9oFYCTnSwboGSDFNhhipmC2WFFDher4nzCXXnB/+P9H1VP2V
         zjbIuigl4/BR8z0gYk+N8rRq245HSsHdLZmQYmNDb7U8GiwThhclMRvInwQd4cQGhuJg
         BIFcQJCzo5VKReBGSItEi8uoi72WhMDAyTE3sPC6wlm3FrBLu5BMKpovK3aifE6zYP2b
         opOte2W0cGCa5ReMZdq4QdbaS9q1N6+LrUD7cE4MLui0DGxEuYoRhNz90NB3qruvNbGU
         UVOQ==
X-Gm-Message-State: APt69E2zezojtVupyCpqQZOFvfK0l3gbbh+lZSFL38UjCdSUibh+IS+A
        THeVj8NGsrJX0cAroHpcdDOZIg==
X-Google-Smtp-Source: ADUXVKIgpx5iaMkj4H38Nhaqnb3VfWQddbY0K5vIEO0Ztos6tQOH3Sz10NDWi1YRMKT0Ay5JAEAxMA==
X-Received: by 2002:a62:c0cb:: with SMTP id g72-v6mr23975814pfk.226.1529521468250;
        Wed, 20 Jun 2018 12:04:28 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id z18-v6sm4093303pgc.0.2018.06.20.12.04.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 12:04:22 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alasdair Kergon <agk@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lars Persson <larper@axis.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, qat-linux@intel.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] crypto: qat: Remove VLA usage
Date:   Wed, 20 Jun 2018 12:04:05 -0700
Message-Id: <20180620190408.45104-9-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620190408.45104-1-keescook@chromium.org>
References: <20180620190408.45104-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this uses
the upper bound for the stack buffer. Also adds a sanity check. This
additionally raises the stack size limit during the build, to avoid
a compiler warning while keeping it reasonably close to expected stack
size. The warning was just exposing the existing max stack size, so there
is nothing new here; now that it is not hidden in a VLA, the compiler
can see how large it might get.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/crypto/qat/qat_common/Makefile   | 2 ++
 drivers/crypto/qat/qat_common/qat_algs.c | 8 ++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/qat/qat_common/Makefile b/drivers/crypto/qat/qat_common/Makefile
index 47a8e3d8b81a..c2a042023dde 100644
--- a/drivers/crypto/qat/qat_common/Makefile
+++ b/drivers/crypto/qat/qat_common/Makefile
@@ -19,3 +19,5 @@ intel_qat-objs := adf_cfg.o \
 intel_qat-$(CONFIG_DEBUG_FS) += adf_transport_debug.o
 intel_qat-$(CONFIG_PCI_IOV) += adf_sriov.o adf_pf2vf_msg.o \
 			       adf_vf2pf_msg.o adf_vf_isr.o
+
+CFLAGS_qat_algs.o := $(call cc-option,-Wframe-larger-than=2300)
diff --git a/drivers/crypto/qat/qat_common/qat_algs.c b/drivers/crypto/qat/qat_common/qat_algs.c
index 1138e41d6805..257269126601 100644
--- a/drivers/crypto/qat/qat_common/qat_algs.c
+++ b/drivers/crypto/qat/qat_common/qat_algs.c
@@ -153,8 +153,8 @@ static int qat_alg_do_precomputes(struct icp_qat_hw_auth_algo_blk *hash,
 	struct sha512_state sha512;
 	int block_size = crypto_shash_blocksize(ctx->hash_tfm);
 	int digest_size = crypto_shash_digestsize(ctx->hash_tfm);
-	char ipad[block_size];
-	char opad[block_size];
+	char ipad[CRYPTO_ALG_MAX_BLOCKSIZE];
+	char opad[CRYPTO_ALG_MAX_BLOCKSIZE];
 	__be32 *hash_state_out;
 	__be64 *hash512_state_out;
 	int i, offset;
@@ -164,6 +164,10 @@ static int qat_alg_do_precomputes(struct icp_qat_hw_auth_algo_blk *hash,
 	shash->tfm = ctx->hash_tfm;
 	shash->flags = 0x0;
 
+	if (WARN_ON(block_size > sizeof(ipad) ||
+		    sizeof(ipad) != sizeof(opad)))
+		return -EINVAL;
+
 	if (auth_keylen > block_size) {
 		int ret = crypto_shash_digest(shash, auth_key,
 					      auth_keylen, ipad);
-- 
2.17.1

