Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55DCECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B6E6208AD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="knOVwr0r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B6E6208AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbeGQEwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 00:52:31 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38541 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728610AbeGQEwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 00:52:31 -0400
Received: by mail-pf0-f196.google.com with SMTP id v15-v6so7366129pff.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 21:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JBfo1fF2PqSm7e4PfP+/dVxXoai8pEOtQGF0NnToX8o=;
        b=knOVwr0roqnXAKtlTHb7XAMk5VLliXiuGd9cuAi7L/twaZKhjp8poE7lC+t9P+biTz
         U7FUbqfYZYM3eLHubjWkEoRUMChEoeGVwyvAPlhQCmS/DHPf6bA9k1CjJM3vc1S2l25S
         Z/6t+gNbhX81wFUNewuypl3FvE393C/fcEx04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JBfo1fF2PqSm7e4PfP+/dVxXoai8pEOtQGF0NnToX8o=;
        b=SA72Ja08kF1Fq0GRvR/TKhWObO1t655I6NltS3u6YsNxXDpGTe/3VFYE10E5fJKKiq
         0YPGsYV2lU/Tfc57FFmA+1sg793BV49O9eph3Mj0enO9bIEXwoZjlRVcjdA/kpWDsoJr
         MHYlVS8oMACSEIGILXJtL+QmLXxEiwvINB6Ep+GLK5GRBpAK3xXlxgSkd6JXicI1Lz6z
         n5XDw5NUr6Lb/vc1qoh07UeX9w06tw9wZ210GUsa4Xx0PSYWHMbIcrCfFBmSZTsy5FFb
         rQOf1JQoBlap6cpGbQpAAz8n09B4wgPEvc5SJ7fSkbKxpOEk4Sq4bDuiznwpFX5KnDHp
         rQHg==
X-Gm-Message-State: AOUpUlEW1zEmVVIUwOwP+dE4TV+LsHlsFyITpYIpKYQSqh8rCsPvyTsM
        OdmLKxy/P04Dghct4kdM4PCcgA==
X-Google-Smtp-Source: AAOMgpf20YArsCbLOxYePDloTnxUh+BWNIRi/cFMFrC7HuxNQPCbv2tXE8u8+jgIjjN5MXzvGmGLwg==
X-Received: by 2002:a65:4107:: with SMTP id w7-v6mr18876pgp.302.1531801316383;
        Mon, 16 Jul 2018 21:21:56 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id p3-v6sm24884590pfo.130.2018.07.16.21.21.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 21:21:53 -0700 (PDT)
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
Subject: [PATCH v5 01/11] crypto: xcbc: Remove VLA usage
Date:   Mon, 16 Jul 2018 21:21:40 -0700
Message-Id: <20180717042150.37761-2-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180717042150.37761-1-keescook@chromium.org>
References: <20180717042150.37761-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this uses
the maximum blocksize and adds a sanity check. For xcbc, the blocksize
must always be 16, so use that, since it's already being enforced during
instantiation.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

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

