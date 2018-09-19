Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A618EC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57159214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CunrNz7O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57159214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730999AbeISHr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 03:47:26 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36630 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730967AbeISHqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 03:46:46 -0400
Received: by mail-pf1-f194.google.com with SMTP id b11-v6so1919724pfo.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 19:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8oNl/e9uTp41NIGJYGi79JHHDmF9+QFZKwzGixSKESY=;
        b=CunrNz7OuS/C/Vor9xnjWZnofRwOJg3CbCmk4yez1Yjn5gXxf2JQulpUX4y8NV3+en
         YgTa8mclnxwt5btJdIqlrKkMsk8aa8WlKOhw2USQFp51+oyU4hpospC3J1cyRI/CT9YR
         YHb1YZhJCeaE7VB5dVJmnjPpXzcK5GVfnMV2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8oNl/e9uTp41NIGJYGi79JHHDmF9+QFZKwzGixSKESY=;
        b=Sl6khSRLTfuwOTo6Iz9rbdTaOjYy0RcB/ah0vYV7UJ5DpGhlN6sFpXD6w0D4/LoTeX
         z8bd+xOF+QDX+2MTXOpJc/hL1swtOw/Mm4CAex7Y/YaR42/xg5Y4rArxST95xANz2RZA
         jK4PPqckXr9pW4CsXF07obEzhzFswhrILtW+fm5fsAaM2bgzvycCbu4Ku/r1bU9oNTY+
         Ll/B2pet9FSIb7qe9zGooHS/93faO8QUGSc+51TuKVNtXfUQ7dlspbDlAdR9WFn2RyhO
         3In8cuSckFpL5Y5MzkfEvOqjgkE7LsG7sZmJwMs9uIiUcW2Wx5+hDBK9z2QW9k0R2N8f
         fiMQ==
X-Gm-Message-State: APzg51BVlG1b+BwFt8Nu/gdQUK43iz1D2+cedaiJ305JILe2EUn3LDi/
        wjdPTEMNlyaOal+fKbFAJG61kQ==
X-Google-Smtp-Source: ANB0VdYMWFZlvu8PfeEo6xNjTWXrtKIaUIAVkTDS9Rd3bnxaSEgfjvUm6bgkan8W6tAJ+KyD1ohUQg==
X-Received: by 2002:a62:1d54:: with SMTP id d81-v6mr33652235pfd.139.1537323078902;
        Tue, 18 Sep 2018 19:11:18 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id y7-v6sm25063370pge.8.2018.09.18.19.11.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 19:11:17 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-usb@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH crypto-next 11/23] wusb: Remove VLA usage of skcipher
Date:   Tue, 18 Sep 2018 19:10:48 -0700
Message-Id: <20180919021100.3380-12-keescook@chromium.org>
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

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: Johan Hovold <johan@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/usb/wusbcore/crypto.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/wusbcore/crypto.c b/drivers/usb/wusbcore/crypto.c
index aff50eb09ca9..68ddee86a886 100644
--- a/drivers/usb/wusbcore/crypto.c
+++ b/drivers/usb/wusbcore/crypto.c
@@ -189,7 +189,7 @@ struct wusb_mac_scratch {
  * NOTE: blen is not aligned to a block size, we'll pad zeros, that's
  *       what sg[4] is for. Maybe there is a smarter way to do this.
  */
-static int wusb_ccm_mac(struct crypto_skcipher *tfm_cbc,
+static int wusb_ccm_mac(struct crypto_sync_skcipher *tfm_cbc,
 			struct crypto_cipher *tfm_aes,
 			struct wusb_mac_scratch *scratch,
 			void *mic,
@@ -198,7 +198,7 @@ static int wusb_ccm_mac(struct crypto_skcipher *tfm_cbc,
 			size_t blen)
 {
 	int result = 0;
-	SKCIPHER_REQUEST_ON_STACK(req, tfm_cbc);
+	SYNC_SKCIPHER_REQUEST_ON_STACK(req, tfm_cbc);
 	struct scatterlist sg[4], sg_dst;
 	void *dst_buf;
 	size_t dst_size;
@@ -224,7 +224,7 @@ static int wusb_ccm_mac(struct crypto_skcipher *tfm_cbc,
 	if (!dst_buf)
 		goto error_dst_buf;
 
-	iv = kzalloc(crypto_skcipher_ivsize(tfm_cbc), GFP_KERNEL);
+	iv = kzalloc(crypto_sync_skcipher_ivsize(tfm_cbc), GFP_KERNEL);
 	if (!iv)
 		goto error_iv;
 
@@ -251,7 +251,7 @@ static int wusb_ccm_mac(struct crypto_skcipher *tfm_cbc,
 	sg_set_page(&sg[3], ZERO_PAGE(0), zero_padding, 0);
 	sg_init_one(&sg_dst, dst_buf, dst_size);
 
-	skcipher_request_set_tfm(req, tfm_cbc);
+	skcipher_request_set_sync_tfm(req, tfm_cbc);
 	skcipher_request_set_callback(req, 0, NULL, NULL);
 	skcipher_request_set_crypt(req, sg, &sg_dst, dst_size, iv);
 	result = crypto_skcipher_encrypt(req);
@@ -298,19 +298,19 @@ ssize_t wusb_prf(void *out, size_t out_size,
 {
 	ssize_t result, bytes = 0, bitr;
 	struct aes_ccm_nonce n = *_n;
-	struct crypto_skcipher *tfm_cbc;
+	struct crypto_sync_skcipher *tfm_cbc;
 	struct crypto_cipher *tfm_aes;
 	struct wusb_mac_scratch *scratch;
 	u64 sfn = 0;
 	__le64 sfn_le;
 
-	tfm_cbc = crypto_alloc_skcipher("cbc(aes)", 0, CRYPTO_ALG_ASYNC);
+	tfm_cbc = crypto_alloc_sync_skcipher("cbc(aes)", 0, 0);
 	if (IS_ERR(tfm_cbc)) {
 		result = PTR_ERR(tfm_cbc);
 		printk(KERN_ERR "E: can't load CBC(AES): %d\n", (int)result);
 		goto error_alloc_cbc;
 	}
-	result = crypto_skcipher_setkey(tfm_cbc, key, 16);
+	result = crypto_sync_skcipher_setkey(tfm_cbc, key, 16);
 	if (result < 0) {
 		printk(KERN_ERR "E: can't set CBC key: %d\n", (int)result);
 		goto error_setkey_cbc;
@@ -351,7 +351,7 @@ ssize_t wusb_prf(void *out, size_t out_size,
 	crypto_free_cipher(tfm_aes);
 error_alloc_aes:
 error_setkey_cbc:
-	crypto_free_skcipher(tfm_cbc);
+	crypto_free_sync_skcipher(tfm_cbc);
 error_alloc_cbc:
 	return result;
 }
-- 
2.17.1

