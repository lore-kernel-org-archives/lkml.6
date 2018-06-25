Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3DBC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9343A2614F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="In77wWpH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9343A2614F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755028AbeFYVKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 17:10:45 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:41877 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752319AbeFYVKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 17:10:41 -0400
Received: by mail-pf0-f196.google.com with SMTP id a11-v6so7017771pff.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 14:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7ME0G7lTirc+Q70W7JaZqb0CVXH7ajkdRGsBwyVxDuE=;
        b=In77wWpHfGgekfSot/fIO5Wv+8sozibFJpzjLHdh1tendjC/asJNa0+pV91T9fF9At
         HIdAwY4KC5kGgiBJKyX0Qcaou6AeobvmgpMBBxLilJa4CxCs2+HNA2+lmBs2n5j9ZUnR
         J+WKEaXWlAkhKpwSM3Mn9BxxOcx7FcShqPbl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7ME0G7lTirc+Q70W7JaZqb0CVXH7ajkdRGsBwyVxDuE=;
        b=PWH9tUocVnYxXB06ia101UMCG07uCu9kSl7skrmQ8A2NNFY0XCC81+9LYE225al6m6
         S93o9U5tgL7Hp47zzt6tUrAeBx5EwvLIco9xWkz1R8bcgkytzXpeGSL2CnDafmhhBfx+
         FMmxLphHh3mHPO/JUKHAK+KvYjmJSlgKpWkcif8bY4idftRRpJi9PmiA8mRjkxlVH6i8
         8zoqS5q4hGsOlo2wm06yxbVIFNCVsFVQmYT5dUki0XixVeDJrsZUMlMjm1xIphBSeNc3
         9MxxHuE/UgVIeKUXrN81zulHgP8J80pR0OUBhVnrGPRRp0fJt9auRBXXFUi3W4Qugewy
         VDtw==
X-Gm-Message-State: APt69E1r0pS5z51+w7c71zsvf6cQKwuhaGy00kGhadqyM1qSmsl7ZUN/
        YWokZWWUOvkGMsTWyr+kLzy1aQ==
X-Google-Smtp-Source: ADUXVKI/B3BZHOTsr0Xa7C4H8Z+6U6Wvv90RUPYXq8geA/bgV2J5ihEmPP4s0LNq0y76d2C8WmpoMA==
X-Received: by 2002:aa7:8058:: with SMTP id y24-v6mr14553361pfm.148.1529961040629;
        Mon, 25 Jun 2018 14:10:40 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id o13-v6sm10069589pgn.93.2018.06.25.14.10.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 14:10:35 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        Alasdair Kergon <agk@redhat.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lars Persson <larper@axis.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, qat-linux@intel.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/11] crypto: xcbc: Remove VLA usage
Date:   Mon, 25 Jun 2018 14:10:16 -0700
Message-Id: <20180625211026.15819-2-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180625211026.15819-1-keescook@chromium.org>
References: <20180625211026.15819-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this uses
the maximum blocksize and adds a sanity check. For xcbc, the blocksize
must always be 16, so use that, since it's already being enforced during
instantiation.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 crypto/xcbc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/crypto/xcbc.c b/crypto/xcbc.c
index 25c75af50d3f..7aa03beed795 100644
--- a/crypto/xcbc.c
+++ b/crypto/xcbc.c
@@ -57,6 +57,8 @@ struct xcbc_desc_ctx {
 	u8 ctx[];
 };
 
+#define XCBC_BLOCKSIZE	16
+
 static int crypto_xcbc_digest_setkey(struct crypto_shash *parent,
 				     const u8 *inkey, unsigned int keylen)
 {
@@ -65,7 +67,10 @@ static int crypto_xcbc_digest_setkey(struct crypto_shash *parent,
 	int bs = crypto_shash_blocksize(parent);
 	u8 *consts = PTR_ALIGN(&ctx->ctx[0], alignmask + 1);
 	int err = 0;
-	u8 key1[bs];
+	u8 key1[XCBC_BLOCKSIZE];
+
+	if (WARN_ON(bs > sizeof(key1)))
+		return -EINVAL;
 
 	if ((err = crypto_cipher_setkey(ctx->child, inkey, keylen)))
 		return err;
@@ -212,7 +217,7 @@ static int xcbc_create(struct crypto_template *tmpl, struct rtattr **tb)
 		return PTR_ERR(alg);
 
 	switch(alg->cra_blocksize) {
-	case 16:
+	case XCBC_BLOCKSIZE:
 		break;
 	default:
 		goto out_put_alg;
-- 
2.17.1

