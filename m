Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C5FC1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D54F520C0E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XuzogMug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D54F520C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389094AbeGKUoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 16:44:02 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:35293 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389957AbeGKUma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 16:42:30 -0400
Received: by mail-pl0-f68.google.com with SMTP id k1-v6so9649883plt.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 13:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JBfo1fF2PqSm7e4PfP+/dVxXoai8pEOtQGF0NnToX8o=;
        b=XuzogMugad7VfntrwqFlAbg699VmL688QYLzpI7JajgNZu4UDGBSKvZLyFV9bolsGE
         NNY/r6qVOfsEMiMrBrDDSBbSIwycjNIusJrG+eZYWcAuxq7pYpoVUCvJq2iYa4qQL17+
         rTXz2Y8zGziI6YwoR6J1cyZpgoA1ihpV8VZ2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JBfo1fF2PqSm7e4PfP+/dVxXoai8pEOtQGF0NnToX8o=;
        b=pmqxZXeJ3fRQ0Pg9YcbyhQTACuh1Mud5/FxdnFuiAiFPO5oaiqSjRopJf8fjSiPkbm
         3wCaVHNcbnWnCJXSF5sWDTsBCF1vhj0fvfUQXysTP+qpidBWFOP/UF/Pv3yw+zjEesei
         0w1oVBo862wOyBnFKfRZhU59Z7kLka0QN3tSnTTzv3jfnlJ0WvAehiMnZ5VxQeJw+0HN
         /4v06fo1ndsJ6OGqoJNCabziP8/KxQsrRUhRhZSjyy8Q3EwWeplJ/LBotYMYY2Eo1QbB
         eQQiMgXU+TM6y4ARqPTSTTuS+40R11kSj6XSZomq0vHML69sOJTAtrNxcaX9mfnQTYY5
         q7qQ==
X-Gm-Message-State: AOUpUlGzIrUIG3heRxu5/gwo0+HCqg592pbYTtnzgseIG7K0++4AYQq2
        8lqm2u0VTm3TJ8I5pCwkid7z0w==
X-Google-Smtp-Source: AAOMgpc6crFFXMtTNY+Tvcq/rd5+M87zPS+8kyt5D/1IK8oKZjsv9LEHOcz7AhHEFMzVG0y6iT3umw==
X-Received: by 2002:a17:902:d218:: with SMTP id t24-v6mr131327ply.63.1531341387061;
        Wed, 11 Jul 2018 13:36:27 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id f19-v6sm21047568pfd.147.2018.07.11.13.36.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 13:36:23 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        Alasdair Kergon <agk@redhat.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lars Persson <larper@axis.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-crypto@vger.kernel.org, qat-linux@intel.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/14] crypto: xcbc: Remove VLA usage
Date:   Wed, 11 Jul 2018 13:36:06 -0700
Message-Id: <20180711203619.1020-2-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180711203619.1020-1-keescook@chromium.org>
References: <20180711203619.1020-1-keescook@chromium.org>
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

