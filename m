Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4849C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A50721479
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bxecst1V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A50721479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387621AbeK3Bcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:32:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:32904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731824AbeK3Bcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:32:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75E6D2145D;
        Thu, 29 Nov 2018 14:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501632;
        bh=ofNV4QAPxgtnBTl5XdVIjMNGIWLTVnaFw7h7XYnYt0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bxecst1VZ2DXg6InrXvrOu7abNB5FrUDN4XaBQU5o47UOU9OwT+V5LNtFfCgCGqWx
         q0CSUrURMxRzwh6iuZeyVui5U88RT4jLkxewavqfr8/o4Dk05LkqoSgNSArvplkykh
         lQ8F5hpIamWGzudogzQjX8FsJqqjmVhC7L8XHx6M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qian Cai <cai@gmx.us>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 050/100] crypto: simd - correctly take reqsize of wrapped skcipher into account
Date:   Thu, 29 Nov 2018 15:12:20 +0100
Message-Id: <20181129140103.531566501@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140058.768942700@linuxfoundation.org>
References: <20181129140058.768942700@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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



