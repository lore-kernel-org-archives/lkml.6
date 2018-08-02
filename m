Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5526C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DCE121566
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ArXnwvE6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DCE121566
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732475AbeHBXoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 19:44:34 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38748 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732424AbeHBXod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 19:44:33 -0400
Received: by mail-pf1-f195.google.com with SMTP id x17-v6so2067370pfh.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 14:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ex5q3pWlaMghoCiNAR9ZvyMImtOdE/brEoh2ElYtJV0=;
        b=ArXnwvE6pSwr1ZMDyOhdQrbZNp/hddHh9mlnzSrBS9kLearpFl363Fga2ttjx2y9B3
         xNT/Bd2jR8Y31+sc4ds3C6a4eDRpaubkEIL5X2lLtaUqfaqcPefT4BquFbBq2bj1S5VO
         4uIdt+sBsh5QvUIzNw5MwvfmKz5iRWU94sa94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ex5q3pWlaMghoCiNAR9ZvyMImtOdE/brEoh2ElYtJV0=;
        b=ZJAJ4XIpzeG01wR/22iTiuwitM+lwwJHsWveUJQ3MuRyIb/Un+DY4hGS5kh/YEM1jZ
         H+DxKmWkJ4QkcTXeq4xyBwWon9ZcyRfHOdnm6kb8K5p1efcAoDES9NmZtCs4S6KquZKq
         zJAi+1jcS2oVv4OCIw4niJjaTYxCxHKzfRDd9h8Gw/91AhdA4LRgChjRZA/k1aZ0EGmh
         b9SK5Ue4vFoWvbVnsnAjjSgtdmwt0ErkW2gUXrdexzxKBMJCzguTdKL5SydPK78P+rqi
         pLO65gJtcAOc3UYWbCldIIy/hs40GOKG70m3Cdvpn6N/I7pTd2eFQn7SDvQsZ5hyvnyL
         RlOg==
X-Gm-Message-State: AOUpUlHpfDZ8Wkzl4GIDJiLkd7Xfcbaex2blXnkmaxqbQ5W5n9CnbNTa
        jp1l+w7HNpOyttMhRO5WAKLMrA==
X-Google-Smtp-Source: AAOMgpccoOzFayd/tSMFlQQN3CSCTxAJ1l8hPXhxk7kbrqjkyAg7gWABcY6MEBO8RhXIzixJtLIPdA==
X-Received: by 2002:aa7:84c2:: with SMTP id x2-v6mr1291077pfn.220.1533246690713;
        Thu, 02 Aug 2018 14:51:30 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id x65-v6sm4796297pfk.140.2018.08.02.14.51.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 14:51:28 -0700 (PDT)
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
Subject: [PATCH 7/9] crypto, lz4: Implement zbufsize()
Date:   Thu,  2 Aug 2018 14:51:16 -0700
Message-Id: <20180802215118.17752-8-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180802215118.17752-1-keescook@chromium.org>
References: <20180802215118.17752-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This implements the worst-case compression size querying interface for
lz4, based on the logic originally used by pstore.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 crypto/lz4.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/crypto/lz4.c b/crypto/lz4.c
index 2ce2660d3519..42003d080967 100644
--- a/crypto/lz4.c
+++ b/crypto/lz4.c
@@ -117,6 +117,24 @@ static int lz4_decompress_crypto(struct crypto_tfm *tfm, const u8 *src,
 	return __lz4_decompress_crypto(src, slen, dst, dlen, NULL);
 }
 
+static int __lz4_zbufsize_crypto(unsigned int slen, unsigned int *dlen)
+{
+	*dlen = LZ4_compressBound(slen);
+	return 0;
+}
+
+static int lz4_szbufsize(struct crypto_scomp *tfm, unsigned int slen,
+			 unsigned int *dlen, void *ctx)
+{
+	return __lz4_zbufsize_crypto(slen, dlen);
+}
+
+static int lz4_zbufsize_crypto(struct crypto_tfm *tfm, unsigned int slen,
+			       unsigned int *dlen)
+{
+	return __lz4_zbufsize_crypto(slen, dlen);
+}
+
 static struct crypto_alg alg_lz4 = {
 	.cra_name		= "lz4",
 	.cra_flags		= CRYPTO_ALG_TYPE_COMPRESS,
@@ -127,7 +145,8 @@ static struct crypto_alg alg_lz4 = {
 	.cra_exit		= lz4_exit,
 	.cra_u			= { .compress = {
 	.coa_compress		= lz4_compress_crypto,
-	.coa_decompress		= lz4_decompress_crypto } }
+	.coa_decompress		= lz4_decompress_crypto,
+	.coa_zbufsize		= lz4_zbufsize_crypto } }
 };
 
 static struct scomp_alg scomp = {
@@ -135,6 +154,7 @@ static struct scomp_alg scomp = {
 	.free_ctx		= lz4_free_ctx,
 	.compress		= lz4_scompress,
 	.decompress		= lz4_sdecompress,
+	.zbufsize		= lz4_szbufsize,
 	.base			= {
 		.cra_name	= "lz4",
 		.cra_driver_name = "lz4-scomp",
-- 
2.17.1

