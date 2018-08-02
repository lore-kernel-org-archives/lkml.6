Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04AF9C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B00BA2159F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nYio86Qu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B00BA2159F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732583AbeHBXpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 19:45:24 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42521 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732291AbeHBXoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 19:44:30 -0400
Received: by mail-pf1-f194.google.com with SMTP id l9-v6so2057055pff.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 14:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MvbNFc7J67UoB1P19UBzk47KUOfTw9hDrlQkJaXB1ws=;
        b=nYio86QuhOWHpnAL5T7WiLnnwS5QEEhFwEQ0zTGvAohb/EnkIwU4yAOk+mTGjOMsnv
         zq8Q2mLSV3Gz7fzVln8tDy4j+C8V/Nm+MFDQN4BHpY+uoyuI+lHj2rJdPGBr/O/zLcdX
         +h0Rv+oQ9m954BN4f3Znp0HJe/l6u5PfsN6lY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MvbNFc7J67UoB1P19UBzk47KUOfTw9hDrlQkJaXB1ws=;
        b=j104/s8pA7e6ZTaMdbVvm/0A+TlnpePuWh18K2nxMpVS0APC+FftxmYiDLU4DsPm4y
         h6Zm9GNCjH231VtbA6tBhPB2igKGApHZ6KHLmiypnwvcEO7lBvwQmfrbYn9G+yASnTa0
         oCiJRTjawxvtKfJx6oQI5WKvioR3vWQQWWBjjldwe4CG3M8M07iL7uDGhcVK4Xh3yULB
         dXUBg2EHxHX+SE3NvUkVsuuXIhYSAaFmgXqmGEbP1fakC9gliuky5cYGY1JpnUiHZ2f0
         0Y6ZXFjGtduayid8L2PYs0t/28mP2dCr7Kq4JxBu4B4HkmLmZkokjdg1slMlHBJNIzPZ
         INPg==
X-Gm-Message-State: AOUpUlGeGIEVYgy6dPykou2BhpVj2kXEqKEneol41S78nKCST36TZKD+
        d1FTP5CYmdvvCK360DAx9ejo4Q==
X-Google-Smtp-Source: AAOMgpcta7HkStKHr1CZCAhA1VwoeiRogr4gz2vXVehyew/VoH3h7vNgtlWoJd+dc6+9kLZToTjTZg==
X-Received: by 2002:a62:3ece:: with SMTP id y75-v6mr1290956pfj.7.1533246687428;
        Thu, 02 Aug 2018 14:51:27 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id t9-v6sm6624376pgi.87.2018.08.02.14.51.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 14:51:23 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        Geliang Tang <geliangtang@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Haren Myneni <haren@us.ibm.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] crypto: add zbufsize() interface
Date:   Thu,  2 Aug 2018 14:51:10 -0700
Message-Id: <20180802215118.17752-2-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180802215118.17752-1-keescook@chromium.org>
References: <20180802215118.17752-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When pstore was refactored to use the crypto compress API in:

  commit cb3bee0369bc ("pstore: Use crypto compress API")

nearly all the pstore-specific compression routines were replaced with
the existing crypto compression API. One case remained: calculating the
"worst case" compression sizes ahead of time so it could have a buffer
preallocated for doing compression (which was called "zbufsize").

To make pstore fully algorithm-agnostic, the compression API needs to
grow this functionality. This adds the interface to support querying the
"worst case" estimate, with a new "zbufsize" routine that each compressor
can implement. The per-compressor implementations come in later commits.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 crypto/compress.c                   |  9 +++++++++
 include/crypto/internal/scompress.h | 11 +++++++++++
 include/linux/crypto.h              | 12 ++++++++++++
 3 files changed, 32 insertions(+)

diff --git a/crypto/compress.c b/crypto/compress.c
index f2d522924a07..29a80bb3b9d3 100644
--- a/crypto/compress.c
+++ b/crypto/compress.c
@@ -33,12 +33,21 @@ static int crypto_decompress(struct crypto_tfm *tfm,
 	                                                   dlen);
 }
 
+static int crypto_zbufsize(struct crypto_tfm *tfm,
+			   unsigned int slen, unsigned int *dlen)
+{
+	if (!tfm->__crt_alg->cra_compress.coa_zbufsize)
+		return -ENOTSUPP;
+	return tfm->__crt_alg->cra_compress.coa_zbufsize(tfm, slen, dlen);
+}
+
 int crypto_init_compress_ops(struct crypto_tfm *tfm)
 {
 	struct compress_tfm *ops = &tfm->crt_compress;
 
 	ops->cot_compress = crypto_compress;
 	ops->cot_decompress = crypto_decompress;
+	ops->cot_zbufsize = crypto_zbufsize;
 
 	return 0;
 }
diff --git a/include/crypto/internal/scompress.h b/include/crypto/internal/scompress.h
index 0f6ddac1acfc..a4a2a55080ad 100644
--- a/include/crypto/internal/scompress.h
+++ b/include/crypto/internal/scompress.h
@@ -39,6 +39,8 @@ struct scomp_alg {
 	int (*decompress)(struct crypto_scomp *tfm, const u8 *src,
 			  unsigned int slen, u8 *dst, unsigned int *dlen,
 			  void *ctx);
+	int (*zbufsize)(struct crypto_scomp *tfm, unsigned int slen,
+			unsigned int *dlen, void *ctx);
 	struct crypto_alg base;
 };
 
@@ -94,6 +96,15 @@ static inline int crypto_scomp_decompress(struct crypto_scomp *tfm,
 						 ctx);
 }
 
+static inline int crypto_scomp_zbufsize(struct crypto_scomp *tfm,
+					unsigned int slen,
+					unsigned int *dlen, void *ctx)
+{
+	if (!crypto_scomp_alg(tfm)->zbufsize)
+		return -ENOTSUPP;
+	return crypto_scomp_alg(tfm)->zbufsize(tfm, slen, dlen, ctx);
+}
+
 int crypto_init_scomp_ops_async(struct crypto_tfm *tfm);
 struct acomp_req *crypto_acomp_scomp_alloc_ctx(struct acomp_req *req);
 void crypto_acomp_scomp_free_ctx(struct acomp_req *req);
diff --git a/include/linux/crypto.h b/include/linux/crypto.h
index 6eb06101089f..376c056447e7 100644
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -362,6 +362,8 @@ struct compress_alg {
 			    unsigned int slen, u8 *dst, unsigned int *dlen);
 	int (*coa_decompress)(struct crypto_tfm *tfm, const u8 *src,
 			      unsigned int slen, u8 *dst, unsigned int *dlen);
+	int (*coa_zbufsize)(struct crypto_tfm *tfm, unsigned int slen,
+			    unsigned int *dlen);
 };
 
 
@@ -578,6 +580,8 @@ struct compress_tfm {
 	int (*cot_decompress)(struct crypto_tfm *tfm,
 	                      const u8 *src, unsigned int slen,
 	                      u8 *dst, unsigned int *dlen);
+	int (*cot_zbufsize)(struct crypto_tfm *tfm,
+			    unsigned int slen, unsigned int *dlen);
 };
 
 #define crt_ablkcipher	crt_u.ablkcipher
@@ -1660,5 +1664,13 @@ static inline int crypto_comp_decompress(struct crypto_comp *tfm,
 						    src, slen, dst, dlen);
 }
 
+static inline int crypto_comp_zbufsize(struct crypto_comp *tfm,
+				       unsigned int slen,
+				       unsigned int *dlen)
+{
+	return crypto_comp_crt(tfm)->cot_zbufsize(crypto_comp_tfm(tfm),
+						  slen, dlen);
+}
+
 #endif	/* _LINUX_CRYPTO_H */
 
-- 
2.17.1

