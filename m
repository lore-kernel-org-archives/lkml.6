Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D03C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B9C620672
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvGvBgG8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B9C620672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407043AbeKWGgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 01:36:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:35008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733189AbeKWGgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 01:36:04 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD18A20672;
        Thu, 22 Nov 2018 19:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542916512;
        bh=9qd1Ftiv9e8SPIBQg6VCgYe4qsENaZtytXLajQXqohc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LvGvBgG85p64P3y515BEmWkIjRD10PBK37FaT7B20BDBafYMt7lyIrZPcZCRDEpcN
         8PPKjzF1AgiwXXx5HxTCwMa4jfgfXD070MrfeuXu8shvZVA5ROxY/zeMo+lkgxQrGt
         0SQuNNxTU9DGfmXyrorQ8MGS4istfIZOdOcfdhVI=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>, linux-crypto@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 06/21] crypto: simd - correctly take reqsize of wrapped skcipher into account
Date:   Thu, 22 Nov 2018 14:54:37 -0500
Message-Id: <20181122195452.13520-6-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181122195452.13520-1-sashal@kernel.org>
References: <20181122195452.13520-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

[ Upstream commit 508a1c4df085a547187eed346f1bfe5e381797f1 ]

The simd wrapper's skcipher request context structure consists
of a single subrequest whose size is taken from the subordinate
skcipher. However, in simd_skcipher_init(), the reqsize that is
retrieved is not from the subordinate skcipher but from the
cryptd request structure, whose size is completely unrelated to
the actual wrapped skcipher.

Reported-by: Qian Cai <cai@gmx.us>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Tested-by: Qian Cai <cai@gmx.us>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/simd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/crypto/simd.c b/crypto/simd.c
index 88203370a62f..894c62944106 100644
--- a/crypto/simd.c
+++ b/crypto/simd.c
@@ -126,8 +126,9 @@ static int simd_skcipher_init(struct crypto_skcipher *tfm)
 
 	ctx->cryptd_tfm = cryptd_tfm;
 
-	reqsize = sizeof(struct skcipher_request);
-	reqsize += crypto_skcipher_reqsize(&cryptd_tfm->base);
+	reqsize = crypto_skcipher_reqsize(cryptd_skcipher_child(cryptd_tfm));
+	reqsize = max(reqsize, crypto_skcipher_reqsize(&cryptd_tfm->base));
+	reqsize += sizeof(struct skcipher_request);
 
 	crypto_skcipher_set_reqsize(tfm, reqsize);
 
-- 
2.17.1

