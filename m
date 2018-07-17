Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECCCECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC46C208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="boTGbVA6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC46C208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729708AbeGQEwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 00:52:38 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:40726 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729693AbeGQEwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 00:52:37 -0400
Received: by mail-pf0-f196.google.com with SMTP id e13-v6so13998856pff.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 21:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BYgigRdBSanSiafl9f2cJhj28CjRYh2SZJXlKmlCU5M=;
        b=boTGbVA656Ee2MqExYdAZwc6efsq5cnzqsMfRI7dSqaBUdgDIJk4mx5TVSFuQwb6ze
         1PvCTMv8baLMZv27nKvUKApnJhaxTIVEvsg56WPkJsyX6immayrZjKxdHR0h96yCp8NT
         /7DqK+gsGLIx5fkr9YZi7btyy7QHuwai1XOvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BYgigRdBSanSiafl9f2cJhj28CjRYh2SZJXlKmlCU5M=;
        b=W/9mynT2/EwgwsCn+nWzgIDLuGg9jntSxShbrOKogNYzGxFG8YGCFbLgk0YqFdywwK
         DiBb9bdRfKfAWWPXN5DP6qPnnlmVCn9vadkbnQULz6shrBXqsvqcOidx6WMUwM+Jc/2B
         pU8LP5gxCAwOcTT6LPIB+432mLH3RGQt61mYSVbUeigHybIKgdTwSkcvv+/iVTR1p+Z1
         WQor9Dsmr2NQ+ARHQlj4ujp8IKx9WBb3x7IJgLfByUVFH5rRdPObWNCGUdlTok5jrPAF
         YDOAOrFc/E66wJtxLloZzIMiz8jpSEiaFvE1S7dvzNnD+f35mQbOfjuWS0ww8UR0pFOX
         vUZg==
X-Gm-Message-State: AOUpUlHjQWycDJWQheS1isDmdl6+SZecG+js2JcwxofGjF8XY6OaYZpc
        4pchNSmmHg7EpG6RXVpQDDfgcg==
X-Google-Smtp-Source: AAOMgpeSXwPG4RVm4ZDf8N2c1OOAFDJamKIYAtZIiwk/iv7HsPunntRAKJs2bwnmguPB+Ek6/eVEnw==
X-Received: by 2002:a63:5815:: with SMTP id m21-v6mr36861pgb.78.1531801322090;
        Mon, 16 Jul 2018 21:22:02 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id t8-v6sm37838381pfj.165.2018.07.16.21.21.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 21:21:58 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alasdair Kergon <agk@redhat.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lars Persson <larper@axis.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        linux-crypto@vger.kernel.org, qat-linux@intel.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH v5 08/11] crypto: qat: Remove VLA usage
Date:   Mon, 16 Jul 2018 21:21:47 -0700
Message-Id: <20180717042150.37761-9-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180717042150.37761-1-keescook@chromium.org>
References: <20180717042150.37761-1-keescook@chromium.org>
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

