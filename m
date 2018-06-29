Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DA3C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 00:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50A6727986
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 00:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YKGDFhFt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50A6727986
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030395AbeF2Aa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 20:30:29 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:44720 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935851AbeF2A2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 20:28:53 -0400
Received: by mail-pf0-f193.google.com with SMTP id j3-v6so3355674pfh.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 17:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JBfo1fF2PqSm7e4PfP+/dVxXoai8pEOtQGF0NnToX8o=;
        b=YKGDFhFtacjeAovU5Uk0Oqx1NcPS9G3M4QG6MT9MJZ81Kfrqd2VEVw3+i+JNfuaNqy
         T0vrXko/VSVhVWhiuXOqofnq8ceG2iHGVZlCCv0CIKzeKHdmzwJeHEtf3crvGViOmRq3
         RVzZ4FQxSpFWe9iBaMUGl1J7KCHWj2Jkbw0zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JBfo1fF2PqSm7e4PfP+/dVxXoai8pEOtQGF0NnToX8o=;
        b=kT2+jbG3+Nerk65lQPHCMlFozwgIb0V/KesojpSs14ePF8qxi35H/sXXAu2awmUpIf
         rX3csCmx2lts+oPn/X+n+rayNpp/biszI+YKWgYLzd1VogKZ1DGwSRwU6rC27K5nrOWS
         mlOudKPnodpMyM+RQUb/85Ljo/6hb/0JBtMamwkKG0L772Qun+0a9cy5BbDVY2xP3Smf
         1OhE15S9+VG6y4xuEYrAyxc9tAAThhxzQIyRIvMoS7XlAoPCj8WtYoPX/SNFqP9fiySY
         KZo0fHNH54C0uNR7QnqTDBJ7+TZEmis+zTbdgm8WqlrUeO4s+sT9mT7JpncBIFFaZmhG
         ynLA==
X-Gm-Message-State: APt69E3ThAmCUcul5TScooMsUIFWwvAkknWuqZpoTAsZNaNubJbM38Dk
        uLL7B3vgI9iaJRcc+iVB7ABx2Q==
X-Google-Smtp-Source: ADUXVKLRNsCySqCqdXH+hYqh4aHDl3N0b/RtDwC6U4Ge74pLGInCT16JJPoaJP+g893whEIGyNNcuQ==
X-Received: by 2002:a63:384c:: with SMTP id h12-v6mr10576887pgn.230.1530232133416;
        Thu, 28 Jun 2018 17:28:53 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id b62-v6sm16125302pfm.24.2018.06.28.17.28.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Jun 2018 17:28:48 -0700 (PDT)
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
        linux-crypto@vger.kernel.org, qat-linux@intel.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/9] crypto: xcbc: Remove VLA usage
Date:   Thu, 28 Jun 2018 17:28:35 -0700
Message-Id: <20180629002843.31095-2-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180629002843.31095-1-keescook@chromium.org>
References: <20180629002843.31095-1-keescook@chromium.org>
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

