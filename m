Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1E5C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEBD7214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GaWxCJtk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEBD7214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730943AbeISHqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 03:46:42 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36622 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730892AbeISHql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 03:46:41 -0400
Received: by mail-pf1-f193.google.com with SMTP id b11-v6so1919642pfo.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 19:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hwkPL0ZYuWobYJ2p0KIuxBRAKmWLxNc/NezeIPnQbXk=;
        b=GaWxCJtkWhH496IZyhfS5PzIxv9aHnlLttPIkFuwIfU73wdbGEr2Lk8mNxPhMX4YNL
         LWBafl/U8ME5OuDnx96B5cWp+kcDtAlEQUxxHIjxdr2dehTq4kvvzXGfOK5SAykqsVtZ
         uz5/eLc0xG4pkDKttA3GfGEmj626IyACOkWEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hwkPL0ZYuWobYJ2p0KIuxBRAKmWLxNc/NezeIPnQbXk=;
        b=AqVOPhWerk5fAA8zLJxoRquPKQaCuwvBYD9Mf6BqAl5vJ/sCEYeCAjBfdWLoCf+fEd
         146W+oRIC7d1xJpbDIQZbkFkV/ifuRm5dyj5BK9FRyAVCZtuydnhhszHZtUNoRzgioa2
         HNaBDtv3KhRawckz6lQOZRpz8CT/1oIQAxhW/e5IDJ2dXBg8mZx1xNlG0aNraIeWQqrJ
         fjI5+55tUKgkZd7gXwah3hI/SKmnmPnG7ncF/4XsRHtqB6R8gZgHZX/gZlLtbsAK+0jt
         dvuBwUSPLj4SIJVu+I1FFci3FmCIDwQ+/mIQejbGlN1Byb9qESa492KlRqSkHSwLeEPB
         hBRg==
X-Gm-Message-State: APzg51C/TzXGqPJZq8yknrqoQYW5Ndohbyf2KEtJ6JZN9mnyNMSigmpE
        9WAer718dX0URjb2+xNRvo9oyQ==
X-Google-Smtp-Source: ANB0VdaZupOgVvwTaGqTJ/pHIHBUyHlmAQyaO4TEXXba5hOmUuZSar9lF+r2iGhAMsGNKJnGQjQc2g==
X-Received: by 2002:a62:4dc1:: with SMTP id a184-v6mr33424032pfb.5.1537323074371;
        Tue, 18 Sep 2018 19:11:14 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id h132-v6sm27112806pfc.100.2018.09.18.19.11.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 19:11:10 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>,
        ceph-devel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH crypto-next 08/23] libceph: Remove VLA usage of skcipher
Date:   Tue, 18 Sep 2018 19:10:45 -0700
Message-Id: <20180919021100.3380-9-keescook@chromium.org>
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

Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: "Yan, Zheng" <zyan@redhat.com>
Cc: Sage Weil <sage@redhat.com>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 net/ceph/crypto.c | 12 ++++++------
 net/ceph/crypto.h |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/ceph/crypto.c b/net/ceph/crypto.c
index 02172c408ff2..5d6724cee38f 100644
--- a/net/ceph/crypto.c
+++ b/net/ceph/crypto.c
@@ -46,9 +46,9 @@ static int set_secret(struct ceph_crypto_key *key, void *buf)
 		goto fail;
 	}
 
-	/* crypto_alloc_skcipher() allocates with GFP_KERNEL */
+	/* crypto_alloc_sync_skcipher() allocates with GFP_KERNEL */
 	noio_flag = memalloc_noio_save();
-	key->tfm = crypto_alloc_skcipher("cbc(aes)", 0, CRYPTO_ALG_ASYNC);
+	key->tfm = crypto_alloc_sync_skcipher("cbc(aes)", 0, 0);
 	memalloc_noio_restore(noio_flag);
 	if (IS_ERR(key->tfm)) {
 		ret = PTR_ERR(key->tfm);
@@ -56,7 +56,7 @@ static int set_secret(struct ceph_crypto_key *key, void *buf)
 		goto fail;
 	}
 
-	ret = crypto_skcipher_setkey(key->tfm, key->key, key->len);
+	ret = crypto_sync_skcipher_setkey(key->tfm, key->key, key->len);
 	if (ret)
 		goto fail;
 
@@ -136,7 +136,7 @@ void ceph_crypto_key_destroy(struct ceph_crypto_key *key)
 	if (key) {
 		kfree(key->key);
 		key->key = NULL;
-		crypto_free_skcipher(key->tfm);
+		crypto_free_sync_skcipher(key->tfm);
 		key->tfm = NULL;
 	}
 }
@@ -216,7 +216,7 @@ static void teardown_sgtable(struct sg_table *sgt)
 static int ceph_aes_crypt(const struct ceph_crypto_key *key, bool encrypt,
 			  void *buf, int buf_len, int in_len, int *pout_len)
 {
-	SKCIPHER_REQUEST_ON_STACK(req, key->tfm);
+	SYNC_SKCIPHER_REQUEST_ON_STACK(req, key->tfm);
 	struct sg_table sgt;
 	struct scatterlist prealloc_sg;
 	char iv[AES_BLOCK_SIZE] __aligned(8);
@@ -232,7 +232,7 @@ static int ceph_aes_crypt(const struct ceph_crypto_key *key, bool encrypt,
 		return ret;
 
 	memcpy(iv, aes_iv, AES_BLOCK_SIZE);
-	skcipher_request_set_tfm(req, key->tfm);
+	skcipher_request_set_sync_tfm(req, key->tfm);
 	skcipher_request_set_callback(req, 0, NULL, NULL);
 	skcipher_request_set_crypt(req, sgt.sgl, sgt.sgl, crypt_len, iv);
 
diff --git a/net/ceph/crypto.h b/net/ceph/crypto.h
index bb45c7d43739..96ef4d860bc9 100644
--- a/net/ceph/crypto.h
+++ b/net/ceph/crypto.h
@@ -13,7 +13,7 @@ struct ceph_crypto_key {
 	struct ceph_timespec created;
 	int len;
 	void *key;
-	struct crypto_skcipher *tfm;
+	struct crypto_sync_skcipher *tfm;
 };
 
 int ceph_crypto_key_clone(struct ceph_crypto_key *dst,
-- 
2.17.1

