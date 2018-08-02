Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DF5C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 22:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2102521531
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 22:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UigPxuBm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2102521531
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732435AbeHCApj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 20:45:39 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45227 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732299AbeHCApU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 20:45:20 -0400
Received: by mail-pg1-f195.google.com with SMTP id f1-v6so1876714pgq.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 15:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BYgigRdBSanSiafl9f2cJhj28CjRYh2SZJXlKmlCU5M=;
        b=UigPxuBmykunqKnqzKm6827zR+OIUHu+pQcfKTB79/NYEvyqd31MiliHPuJtN5deOT
         +N9eKOPm4+oeOnMQ+MDJaJ/UzpjaG633esZqb11FZ+RSNlkQlUOUNhW4DtmCjOG2Mf5Q
         6AiymdEPWVD0qNC28a134xAZhwZosbRR2UCAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BYgigRdBSanSiafl9f2cJhj28CjRYh2SZJXlKmlCU5M=;
        b=McJvm2IFAnPIK2Hh5oMKWcz8huNxTGl30SJA5PV2fbCsj6LkWVTk42G+dnaSLA28dE
         VpV4ylgF9usGv/DzPjhjQT3prS+Dq+uNbcvQ9WWRkyIMbDKqMtr1845vXaWRkos7WGCC
         zR9iYLOZMrhHEYnk18x0YFeHLGTJzjjtCzLU5lJNl3PHD32RKkIBYSkYdUI2ELvpjNEl
         xaGmVunQtz0H6NNwflnsGBobMNcItQGFTnzBDIQGc6GW4ZUGi9k5xUrbgjrj03uoC/hx
         VWqGKGdq7XTEWcYmuCtHx/hsDv16Ovdaj8CcN+Hp/jTYOcotGa6LeYkTKKCE66FVq6+6
         olwg==
X-Gm-Message-State: AOUpUlHzO31fPkh/1YMxyTTz4+CMJ4HEiYmrPeu9e1AMfaew5yzCpLU0
        KOsr0EbDn7o/I0qG4RlU3TWKUQ==
X-Google-Smtp-Source: AAOMgpcsmlt5k1ouh7N1h9VGSIiu5UCKb8UkjRUwwxRPdVNfajQqQWMd397hcAqcnWnomxtvcYzX2g==
X-Received: by 2002:a62:5cc1:: with SMTP id q184-v6mr1455794pfb.241.1533250324318;
        Thu, 02 Aug 2018 15:52:04 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id s16-v6sm4033868pfm.114.2018.08.02.15.51.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 15:52:01 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Tudor-Dan Ambarus <tudor.ambarus@microchip.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, qat-linux@intel.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 7/9] crypto: qat: Remove VLA usage
Date:   Thu,  2 Aug 2018 15:51:50 -0700
Message-Id: <20180802225152.19194-8-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180802225152.19194-1-keescook@chromium.org>
References: <20180802225152.19194-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this uses
the new upper bound for the stack buffer. Also adds a sanity check.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/crypto/qat/qat_common/qat_algs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/qat/qat_common/qat_algs.c b/drivers/crypto/qat/qat_common/qat_algs.c
index 1138e41d6805..a28edf7b792f 100644
--- a/drivers/crypto/qat/qat_common/qat_algs.c
+++ b/drivers/crypto/qat/qat_common/qat_algs.c
@@ -153,8 +153,8 @@ static int qat_alg_do_precomputes(struct icp_qat_hw_auth_algo_blk *hash,
 	struct sha512_state sha512;
 	int block_size = crypto_shash_blocksize(ctx->hash_tfm);
 	int digest_size = crypto_shash_digestsize(ctx->hash_tfm);
-	char ipad[block_size];
-	char opad[block_size];
+	char ipad[MAX_ALGAPI_BLOCKSIZE];
+	char opad[MAX_ALGAPI_BLOCKSIZE];
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

