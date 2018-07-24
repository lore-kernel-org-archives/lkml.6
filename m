Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE2BECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 017F820875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hIU+xMH8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 017F820875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388723AbeGXR5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:57:18 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46943 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388671AbeGXR5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:57:17 -0400
Received: by mail-pg1-f193.google.com with SMTP id p23-v6so3286942pgv.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 09:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fd4CyuLW4EvKRKBdDvHFYcqX0s0Y10MBU0R0P+vSpn0=;
        b=hIU+xMH81mTgYVxwuWmSqAWn5A53bqOvWhpMEc7QMlhDhVn8zjoypa/Kwg4VQ4vc5n
         c0c5gXf+1K9cQbw4roO1CRdC7oMEfTerePZzwbkzYMz/DZyb/ZC52dNE0HdjuuP/Wb/O
         BaEZgLoloJry6pklEt9aFP+0gBy/O6s6Bm+Z0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fd4CyuLW4EvKRKBdDvHFYcqX0s0Y10MBU0R0P+vSpn0=;
        b=Igx2Iak6cvzI/368NaUteLk/qirnfNhkVVPVR2QEMp/erRq3mipNze/EB2ItaVIdZQ
         Wr9rDfVdWoCK/u3sxo8PGCxfNt6f6zEE3wgpKbKMC09NylkNYUu2Fv9pCHe3bAlB5xgh
         fOcfQaZk5s7uv4GinOPs28tcv82c2ZzJ21ex+6aV5+YY30zkLqFtUvRHWDM0g2wYuUlI
         GT594skL/tmbvift5yvv2skaanVBJ88KzZ2ZiLLQH9PgnsBqN9Dmd8XccLUpNZsBNHdp
         sp2VHI3hGbd3oghncQIrcRCzM6A98hPThLiHY01+UMaI4JlDqLR95DJThFbtdX0FblXV
         x9Rg==
X-Gm-Message-State: AOUpUlHOdTkFW18RVawCUlnolX6e+iiBIlMsDjQQiWNlMmpKOtqdzsEy
        xmdEq1draC4tXq6PhDnpV8mE6g==
X-Google-Smtp-Source: AAOMgpdsuohVnd0En4CIyFCHkNYnM+bIZqP+GRTUR5oDPu5dw2xRv0c+exBfpQVchJ3xnfdA0rHqBA==
X-Received: by 2002:a62:4083:: with SMTP id f3-v6mr18399882pfd.229.1532450996103;
        Tue, 24 Jul 2018 09:49:56 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id g184-v6sm19038443pgc.22.2018.07.24.09.49.47
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
Subject: [PATCH v6 14/18] staging: rtl8192u: ieee80211: Convert from ahash to shash
Date:   Tue, 24 Jul 2018 09:49:32 -0700
Message-Id: <20180724164936.37477-15-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180724164936.37477-1-keescook@chromium.org>
References: <20180724164936.37477-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an identical change to the wireless/lib80211 of the same name.
In preparing to remove all stack VLA usage from the kernel[1], this
removes the discouraged use of AHASH_REQUEST_ON_STACK in favor of
the smaller SHASH_DESC_ON_STACK by converting from ahash-wrapped-shash
to direct shash. By removing a layer of indirection this both improves
performance and reduces stack usage. The stack allocation will be made
a fixed size in a later patch to the crypto subsystem.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 .../rtl8192u/ieee80211/ieee80211_crypt_tkip.c | 57 +++++++++----------
 1 file changed, 28 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c
index a7efaae4e25a..1088fa0aee0e 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c
@@ -54,9 +54,9 @@ struct ieee80211_tkip_data {
 	int key_idx;
 
 	struct crypto_skcipher *rx_tfm_arc4;
-	struct crypto_ahash *rx_tfm_michael;
+	struct crypto_shash *rx_tfm_michael;
 	struct crypto_skcipher *tx_tfm_arc4;
-	struct crypto_ahash *tx_tfm_michael;
+	struct crypto_shash *tx_tfm_michael;
 
 	/* scratch buffers for virt_to_page() (crypto API) */
 	u8 rx_hdr[16], tx_hdr[16];
@@ -80,8 +80,7 @@ static void *ieee80211_tkip_init(int key_idx)
 		goto fail;
 	}
 
-	priv->tx_tfm_michael = crypto_alloc_ahash("michael_mic", 0,
-			CRYPTO_ALG_ASYNC);
+	priv->tx_tfm_michael = crypto_alloc_shash("michael_mic", 0, 0);
 	if (IS_ERR(priv->tx_tfm_michael)) {
 		printk(KERN_DEBUG "ieee80211_crypt_tkip: could not allocate "
 				"crypto API michael_mic\n");
@@ -98,8 +97,7 @@ static void *ieee80211_tkip_init(int key_idx)
 		goto fail;
 	}
 
-	priv->rx_tfm_michael = crypto_alloc_ahash("michael_mic", 0,
-			CRYPTO_ALG_ASYNC);
+	priv->rx_tfm_michael = crypto_alloc_shash("michael_mic", 0, 0);
 	if (IS_ERR(priv->rx_tfm_michael)) {
 		printk(KERN_DEBUG "ieee80211_crypt_tkip: could not allocate "
 				"crypto API michael_mic\n");
@@ -111,9 +109,9 @@ static void *ieee80211_tkip_init(int key_idx)
 
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
@@ -127,9 +125,9 @@ static void ieee80211_tkip_deinit(void *priv)
 	struct ieee80211_tkip_data *_priv = priv;
 
 	if (_priv) {
-		crypto_free_ahash(_priv->tx_tfm_michael);
+		crypto_free_shash(_priv->tx_tfm_michael);
 		crypto_free_skcipher(_priv->tx_tfm_arc4);
-		crypto_free_ahash(_priv->rx_tfm_michael);
+		crypto_free_shash(_priv->rx_tfm_michael);
 		crypto_free_skcipher(_priv->rx_tfm_arc4);
 	}
 	kfree(priv);
@@ -500,30 +498,31 @@ static int ieee80211_tkip_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
 	return keyidx;
 }
 
-static int michael_mic(struct crypto_ahash *tfm_michael, u8 *key, u8 *hdr,
+static int michael_mic(struct crypto_shash *tfm_michael, u8 *key, u8 *hdr,
 		       u8 *data, size_t data_len, u8 *mic)
 {
-	AHASH_REQUEST_ON_STACK(req, tfm_michael);
-	struct scatterlist sg[2];
+	SHASH_DESC_ON_STACK(desc, tfm_michael);
 	int err;
 
-	if (tfm_michael == NULL) {
-		printk(KERN_WARNING "michael_mic: tfm_michael == NULL\n");
-		return -1;
-	}
-
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
 
@@ -663,9 +662,9 @@ static int ieee80211_tkip_set_key(void *key, int len, u8 *seq, void *priv)
 {
 	struct ieee80211_tkip_data *tkey = priv;
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

