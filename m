Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52580C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF8A20875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X3kCdf0U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AF8A20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388567AbeGXSDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 14:03:42 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35030 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388533AbeGXSDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 14:03:42 -0400
Received: by mail-pg1-f194.google.com with SMTP id e6-v6so3312500pgv.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 09:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SXSUe20DYbH44YyT3AXD6Igiq+2PNNXg+ovqiA/boxo=;
        b=X3kCdf0Uj63XqAnAuieU1YsZS8JiiKErKvsj99jp4RKXC93FHBkqibyLChQHlXi7Vg
         vn5ozP+TKXJymsuETeBbDnK3EqeHB5k+DWPvr18ZQ6skGgedc/wZdm1WBHKPVQBSqL/X
         Lc/BlOuZzIHXkUIzWZbM0u99uEHbW/wsxeLCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SXSUe20DYbH44YyT3AXD6Igiq+2PNNXg+ovqiA/boxo=;
        b=OC5ABNORxeauGd4bF3WsMy/xsy9fdbDXnOhfEZtWMGm9NeCnfhQzFEtx/HxOeL9zws
         CvV5QGMRULcUaoiB8/qzDEt/W7g3GfO8KZOL2SfXtsdSWVbTfVfLEJRy4YpWkjGqr50Y
         MFNCpEQOOBDG4rlVsqYnAEYNiWf2UCeP2kIGvq4tAaKz5FVyiBxiqaHIbRVuofwHj+Wy
         5nivXPlL+t3cmsPahLoHDCCpJIdTLAel+Ioou12b9WaeTSsq8KhwD7hMl4eFUuVPLlKM
         8GJAOtNP9gMUUVXX8ueA0Hoo0FYVSbu3MPkfsQp7nihHzNIF0WMARPLyzliBPiSko6Er
         zZsA==
X-Gm-Message-State: AOUpUlE9DaU9px225rZzpA9W0VJQnpjqvNxEk3D3IUR49MG2GevOgm2p
        xNPFqr3L65Ff78ivgsJKsLGv5Q==
X-Google-Smtp-Source: AAOMgpddHoILTxA1pmdfiJJbwrLlV21a44LIGXnVTGqBwS4fr6cqOWabudmShtMReuuLuLA5JZVXyw==
X-Received: by 2002:a63:2506:: with SMTP id l6-v6mr16840145pgl.237.1532451378306;
        Tue, 24 Jul 2018 09:56:18 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id d145-v6sm18467198pfd.52.2018.07.24.09.56.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 09:56:16 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
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
Subject: [PATCH v6 17/18] crypto: ccm: Remove VLA usage
Date:   Tue, 24 Jul 2018 09:49:35 -0700
Message-Id: <20180724164936.37477-18-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180724164936.37477-1-keescook@chromium.org>
References: <20180724164936.37477-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

In the quest to remove all stack VLA usage from the kernel[1], this
drops AHASH_REQUEST_ON_STACK by preallocated the ahash request area
with the skcipher area (which are not used at the same time).

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 crypto/ccm.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/crypto/ccm.c b/crypto/ccm.c
index 0a083342ec8c..b242fd0d3262 100644
--- a/crypto/ccm.c
+++ b/crypto/ccm.c
@@ -50,7 +50,10 @@ struct crypto_ccm_req_priv_ctx {
 	u32 flags;
 	struct scatterlist src[3];
 	struct scatterlist dst[3];
-	struct skcipher_request skreq;
+	union {
+		struct ahash_request ahreq;
+		struct skcipher_request skreq;
+	};
 };
 
 struct cbcmac_tfm_ctx {
@@ -181,7 +184,7 @@ static int crypto_ccm_auth(struct aead_request *req, struct scatterlist *plain,
 	struct crypto_ccm_req_priv_ctx *pctx = crypto_ccm_reqctx(req);
 	struct crypto_aead *aead = crypto_aead_reqtfm(req);
 	struct crypto_ccm_ctx *ctx = crypto_aead_ctx(aead);
-	AHASH_REQUEST_ON_STACK(ahreq, ctx->mac);
+	struct ahash_request *ahreq = &pctx->ahreq;
 	unsigned int assoclen = req->assoclen;
 	struct scatterlist sg[3];
 	u8 *odata = pctx->odata;
@@ -427,7 +430,7 @@ static int crypto_ccm_init_tfm(struct crypto_aead *tfm)
 	crypto_aead_set_reqsize(
 		tfm,
 		align + sizeof(struct crypto_ccm_req_priv_ctx) +
-		crypto_skcipher_reqsize(ctr));
+		max(crypto_ahash_reqsize(mac), crypto_skcipher_reqsize(ctr)));
 
 	return 0;
 
-- 
2.17.1

