Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FCEC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D09B2150B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BSRyD3jF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D09B2150B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731115AbeISHsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 03:48:04 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43669 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730890AbeISHqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 03:46:40 -0400
Received: by mail-pg1-f194.google.com with SMTP id q19-v6so1077940pgn.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 19:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DInXt2vSOmIL9OTMoezsciUOBSCf6CUqco9YDUIBOqw=;
        b=BSRyD3jFcNmp6pnmIBWpkRXPEmmaVHKzQsckwdvd0dDT0FEcde+t5PYdBfXmpCpuy9
         KJ2Lwzg+TaR4YEpI6HXcWuYIOEbnztZOddMTbdO355111jFH0X7ZPgBpxOIb2qpHAD1a
         Lp/D0LZA7ECfgM5ETR6eAA2Q+NsF2OWGD/Brk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DInXt2vSOmIL9OTMoezsciUOBSCf6CUqco9YDUIBOqw=;
        b=sBcb8DHlwI6Pdo22zwaVpauDgyIik3HY0+UvmGl4huZLanI7VB8AD5EVZDjo4hYhyv
         3SBETaMrmwE6uzHbI38Kooz50phNo/nDD6ROCAtUW6o1lx38SH0Ori58yZc9pUL/vM7G
         SuO8d/+Ct8uPVRE3m9nEPxUNHkdsoFw5StB1GmyAEYfaoZLFyqxu38lS/2EnzA0QpRLp
         DfRlGKoWM8k1CKXXzmXmKxnzzZU4s2Y3acq3/zM+1lkclucvONI1Bnw6977PmYjJly5w
         1q/wMg6oFlCAIKU+rp9hUPyQp9i46lEgPvTkBM0heUWKB4oWNojsnIpcQltyEBu3pY08
         UNbQ==
X-Gm-Message-State: APzg51AtrsXnDYsUsX925u9cvoq1Oc+BF9oRh9EX805n8RVe7YzXGwAk
        26pqquOVPzWwQfpfJoYaEhv8Tw==
X-Google-Smtp-Source: ANB0VdaCHMUFXdpSyoQ0bc3mslk7pYL4TXz5Y/ywvtFbggaibzrUDN+QS0eV1z1pQ5+0tcFqBzRH6g==
X-Received: by 2002:a62:571b:: with SMTP id l27-v6mr33431544pfb.29.1537323072563;
        Tue, 18 Sep 2018 19:11:12 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id c1-v6sm32084957pfg.25.2018.09.18.19.11.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 19:11:10 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH crypto-next 07/23] block: cryptoloop: Remove VLA usage of skcipher
Date:   Tue, 18 Sep 2018 19:10:44 -0700
Message-Id: <20180919021100.3380-8-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180919021100.3380-1-keescook@chromium.org>
References: <20180919021100.3380-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this
replaces struct crypto_skcipher and SKCIPHER_REQUEST_ON_STACK() usage
with struct crypto_sync_skcipher and SYNC_SKCIPHER_REQUEST_ON_STACK(),
which uses a fixed stack size.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/block/cryptoloop.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/block/cryptoloop.c b/drivers/block/cryptoloop.c
index 7033a4beda66..254ee7d54e91 100644
--- a/drivers/block/cryptoloop.c
+++ b/drivers/block/cryptoloop.c
@@ -45,7 +45,7 @@ cryptoloop_init(struct loop_device *lo, const struct loop_info64 *info)
 	char cms[LO_NAME_SIZE];			/* cipher-mode string */
 	char *mode;
 	char *cmsp = cms;			/* c-m string pointer */
-	struct crypto_skcipher *tfm;
+	struct crypto_sync_skcipher *tfm;
 
 	/* encryption breaks for non sector aligned offsets */
 
@@ -80,13 +80,13 @@ cryptoloop_init(struct loop_device *lo, const struct loop_info64 *info)
 	*cmsp++ = ')';
 	*cmsp = 0;
 
-	tfm = crypto_alloc_skcipher(cms, 0, CRYPTO_ALG_ASYNC);
+	tfm = crypto_alloc_sync_skcipher(cms, 0, 0);
 	if (IS_ERR(tfm))
 		return PTR_ERR(tfm);
 
-	err = crypto_skcipher_setkey(tfm, info->lo_encrypt_key,
-				     info->lo_encrypt_key_size);
-	
+	err = crypto_sync_skcipher_setkey(tfm, info->lo_encrypt_key,
+					  info->lo_encrypt_key_size);
+
 	if (err != 0)
 		goto out_free_tfm;
 
@@ -94,7 +94,7 @@ cryptoloop_init(struct loop_device *lo, const struct loop_info64 *info)
 	return 0;
 
  out_free_tfm:
-	crypto_free_skcipher(tfm);
+	crypto_free_sync_skcipher(tfm);
 
  out:
 	return err;
@@ -109,8 +109,8 @@ cryptoloop_transfer(struct loop_device *lo, int cmd,
 		    struct page *loop_page, unsigned loop_off,
 		    int size, sector_t IV)
 {
-	struct crypto_skcipher *tfm = lo->key_data;
-	SKCIPHER_REQUEST_ON_STACK(req, tfm);
+	struct crypto_sync_skcipher *tfm = lo->key_data;
+	SYNC_SKCIPHER_REQUEST_ON_STACK(req, tfm);
 	struct scatterlist sg_out;
 	struct scatterlist sg_in;
 
@@ -119,7 +119,7 @@ cryptoloop_transfer(struct loop_device *lo, int cmd,
 	unsigned in_offs, out_offs;
 	int err;
 
-	skcipher_request_set_tfm(req, tfm);
+	skcipher_request_set_sync_tfm(req, tfm);
 	skcipher_request_set_callback(req, CRYPTO_TFM_REQ_MAY_SLEEP,
 				      NULL, NULL);
 
@@ -175,9 +175,9 @@ cryptoloop_ioctl(struct loop_device *lo, int cmd, unsigned long arg)
 static int
 cryptoloop_release(struct loop_device *lo)
 {
-	struct crypto_skcipher *tfm = lo->key_data;
+	struct crypto_sync_skcipher *tfm = lo->key_data;
 	if (tfm != NULL) {
-		crypto_free_skcipher(tfm);
+		crypto_free_sync_skcipher(tfm);
 		lo->key_data = NULL;
 		return 0;
 	}
-- 
2.17.1

