Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE061ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0A2A2089C
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bqCFx0Ji"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0A2A2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388738AbeGXR5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:57:19 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36581 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388706AbeGXR5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:57:18 -0400
Received: by mail-pg1-f195.google.com with SMTP id s7-v6so3301776pgv.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 09:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+KSRUj/0qvL/pmvBGcl9scVjMMFqpRubuQt1mN2b+58=;
        b=bqCFx0Jik8X9JYE3Y5uDzvqC3mHEdtYjbzng4JyAov2RxzBQcjptIhXxzO8PH3RJn3
         eH+cKtotdFhdJ1lNh7ImCkjMXCRI9ivBMArWL1hC+97ZlE4aE89Zkztl1xeUeTQ4/v7e
         kDvXrJMlU19+S4jxmNmKqlPfgNAHLRm4Jg90k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+KSRUj/0qvL/pmvBGcl9scVjMMFqpRubuQt1mN2b+58=;
        b=YAop0BKqtaPdTFbCg5ZwF6TvSESqZKX4Lnwz07bMkYtYEZMzwDGV3XzHvch3Gh04IP
         /ZuIRbFdJwEyELaGNUjTiKc6eINDk5aRrwvQPY29QXw4vANaELWORmY4a6WBNG/VOxdS
         SY+ZzjDNaOAlEaYnMW++H0tRX8F3vthVQIiLvA4amoxlUgRni50vkJlDGRG/zE9w889F
         ie6MuIfxeLI1i7FABtMDOFiWpkPVB431eoB7iNXnx7CzT2N7CxNXhqMYacDCi7o8WNQ1
         WL0MhZAxLzjaULzrBlGwQJshirjiJ4Cx9vWniPTbqY8VGpcIbc8Jfr19fJpkD/UAb5te
         98AA==
X-Gm-Message-State: AOUpUlF943SWlxh5umUWLPgdrJslqBJGdtX4OGKEkcjdHoVN7nAwfo4z
        GPA57AvoPGS2iC6vJ2VmHnK9XA==
X-Google-Smtp-Source: AAOMgpeXBCzKp+W+s1UuSZoP5kLT0BLIUEg2hNBm/TGpDGYB9h6deRtHnOkdF2k7HOrKSf/4MbakMw==
X-Received: by 2002:a63:790b:: with SMTP id u11-v6mr16888983pgc.111.1532450997108;
        Tue, 24 Jul 2018 09:49:57 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id j83-v6sm25798959pfj.71.2018.07.24.09.49.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 09:49:54 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alasdair Kergon <agk@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Howells <dhowells@redhat.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Tudor-Dan Ambarus <tudor.ambarus@microchip.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Will Deacon <will.deacon@arm.com>, dm-devel@redhat.com,
        linux-pm@vger.kernel.org, linux-crypto@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        qat-linux@intel.com, linux-ppp@vger.kernel.org,
        netdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-afs@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 13/18] wireless/lib80211: Convert from ahash to shash
Date:   Tue, 24 Jul 2018 09:49:31 -0700
Message-Id: <20180724164936.37477-14-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180724164936.37477-1-keescook@chromium.org>
References: <20180724164936.37477-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparing to remove all stack VLA usage from the kernel[1], this
removes the discouraged use of AHASH_REQUEST_ON_STACK in favor of
the smaller SHASH_DESC_ON_STACK by converting from ahash-wrapped-shash
to direct shash. By removing a layer of indirection this both improves
performance and reduces stack usage. The stack allocation will be made
a fixed size in a later patch to the crypto subsystem.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 net/wireless/lib80211_crypt_tkip.c | 58 +++++++++++++++---------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/net/wireless/lib80211_crypt_tkip.c b/net/wireless/lib80211_crypt_tkip.c
index ba0a1f398ce5..21040aba3a81 100644
--- a/net/wireless/lib80211_crypt_tkip.c
+++ b/net/wireless/lib80211_crypt_tkip.c
@@ -65,9 +65,9 @@ struct lib80211_tkip_data {
 	int key_idx;
 
 	struct crypto_skcipher *rx_tfm_arc4;
-	struct crypto_ahash *rx_tfm_michael;
+	struct crypto_shash *rx_tfm_michael;
 	struct crypto_skcipher *tx_tfm_arc4;
-	struct crypto_ahash *tx_tfm_michael;
+	struct crypto_shash *tx_tfm_michael;
 
 	/* scratch buffers for virt_to_page() (crypto API) */
 	u8 rx_hdr[16], tx_hdr[16];
@@ -106,8 +106,7 @@ static void *lib80211_tkip_init(int key_idx)
 		goto fail;
 	}
 
-	priv->tx_tfm_michael = crypto_alloc_ahash("michael_mic", 0,
-						  CRYPTO_ALG_ASYNC);
+	priv->tx_tfm_michael = crypto_alloc_shash("michael_mic", 0, 0);
 	if (IS_ERR(priv->tx_tfm_michael)) {
 		priv->tx_tfm_michael = NULL;
 		goto fail;
@@ -120,8 +119,7 @@ static void *lib80211_tkip_init(int key_idx)
 		goto fail;
 	}
 
-	priv->rx_tfm_michael = crypto_alloc_ahash("michael_mic", 0,
-						  CRYPTO_ALG_ASYNC);
+	priv->rx_tfm_michael = crypto_alloc_shash("michael_mic", 0, 0);
 	if (IS_ERR(priv->rx_tfm_michael)) {
 		priv->rx_tfm_michael = NULL;
 		goto fail;
@@ -131,9 +129,9 @@ static void *lib80211_tkip_init(int key_idx)
 
       fail:
 	if (priv) {
-		crypto_free_ahash(priv->tx_tfm_michael);
+		crypto_free_shash(priv->tx_tfm_michael);
 		crypto_free_skcipher(priv->tx_tfm_arc4);
-		crypto_free_ahash(priv->rx_tfm_michael);
+		crypto_free_shash(priv->rx_tfm_michael);
 		crypto_free_skcipher(priv->rx_tfm_arc4);
 		kfree(priv);
 	}
@@ -145,9 +143,9 @@ static void lib80211_tkip_deinit(void *priv)
 {
 	struct lib80211_tkip_data *_priv = priv;
 	if (_priv) {
-		crypto_free_ahash(_priv->tx_tfm_michael);
+		crypto_free_shash(_priv->tx_tfm_michael);
 		crypto_free_skcipher(_priv->tx_tfm_arc4);
-		crypto_free_ahash(_priv->rx_tfm_michael);
+		crypto_free_shash(_priv->rx_tfm_michael);
 		crypto_free_skcipher(_priv->rx_tfm_arc4);
 	}
 	kfree(priv);
@@ -510,29 +508,31 @@ static int lib80211_tkip_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
 	return keyidx;
 }
 
-static int michael_mic(struct crypto_ahash *tfm_michael, u8 * key, u8 * hdr,
-		       u8 * data, size_t data_len, u8 * mic)
+static int michael_mic(struct crypto_shash *tfm_michael, u8 *key, u8 *hdr,
+		       u8 *data, size_t data_len, u8 *mic)
 {
-	AHASH_REQUEST_ON_STACK(req, tfm_michael);
-	struct scatterlist sg[2];
+	SHASH_DESC_ON_STACK(desc, tfm_michael);
 	int err;
 
-	if (tfm_michael == NULL) {
-		pr_warn("%s(): tfm_michael == NULL\n", __func__);
-		return -1;
-	}
-	sg_init_table(sg, 2);
-	sg_set_buf(&sg[0], hdr, 16);
-	sg_set_buf(&sg[1], data, data_len);
+	desc->tfm = tfm_michael;
+	desc->flags = 0;
 
-	if (crypto_ahash_setkey(tfm_michael, key, 8))
+	if (crypto_shash_setkey(tfm_michael, key, 8))
 		return -1;
 
-	ahash_request_set_tfm(req, tfm_michael);
-	ahash_request_set_callback(req, 0, NULL, NULL);
-	ahash_request_set_crypt(req, sg, mic, data_len + 16);
-	err = crypto_ahash_digest(req);
-	ahash_request_zero(req);
+	err = crypto_shash_init(desc);
+	if (err)
+		goto out;
+	err = crypto_shash_update(desc, hdr, 16);
+	if (err)
+		goto out;
+	err = crypto_shash_update(desc, data, data_len);
+	if (err)
+		goto out;
+	err = crypto_shash_final(desc, mic);
+
+out:
+	shash_desc_zero(desc);
 	return err;
 }
 
@@ -654,9 +654,9 @@ static int lib80211_tkip_set_key(void *key, int len, u8 * seq, void *priv)
 {
 	struct lib80211_tkip_data *tkey = priv;
 	int keyidx;
-	struct crypto_ahash *tfm = tkey->tx_tfm_michael;
+	struct crypto_shash *tfm = tkey->tx_tfm_michael;
 	struct crypto_skcipher *tfm2 = tkey->tx_tfm_arc4;
-	struct crypto_ahash *tfm3 = tkey->rx_tfm_michael;
+	struct crypto_shash *tfm3 = tkey->rx_tfm_michael;
 	struct crypto_skcipher *tfm4 = tkey->rx_tfm_arc4;
 
 	keyidx = tkey->key_idx;
-- 
2.17.1

