Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCC4C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74BFF205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544544060;
	bh=vW3i6k1dGNRMAGtGCQSbwYbSPeoH9MyeB3H25d9C/CE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RG2hs98//CZL1laddC69SocJ69x4Z5mQOT7d3PbJ5ZDF29LkAu6Ih++H2LxHBV3Hd
	 9g8cMskTRKqbWg1DSyGnqpqN3tVbXrjz4GYvvqmKhEFj/j8WBPZAnOTD4qhvwWtOAx
	 mclpmu0TezoeTy8OIFOFdPiX/Iq0gjbYJU7iSnC0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74BFF205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730967AbeLKQA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:00:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:46960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730910AbeLKP5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:57:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 103032086D;
        Tue, 11 Dec 2018 15:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543871;
        bh=vW3i6k1dGNRMAGtGCQSbwYbSPeoH9MyeB3H25d9C/CE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hrAYY3xpMyesgAHdLOJE8Gz/B4qRaknQZzuqo/5Mn/9EHCdUStI8Ze1jcoJZ+ieSw
         sqo11GRDEq9JGCSmW23WYxIAbY0H5lSCo91RAluHuteEo7biM3UD1EUQ6sgCrpBsOt
         XDKSyeAiLK7/1xtZkfvr9cdk270Btczqvqv79ZS4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pan Bian <bianpan2016@163.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.19 096/118] crypto: do not free algorithm before using
Date:   Tue, 11 Dec 2018 16:41:55 +0100
Message-Id: <20181211151648.142392381@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pan Bian <bianpan2016@163.com>

commit e5bde04ccce64d808f8b00a489a1fe5825d285cb upstream.

In multiple functions, the algorithm fields are read after its reference
is dropped through crypto_mod_put. In this case, the algorithm memory
may be freed, resulting in use-after-free bugs. This patch delays the
put operation until the algorithm is never used.

Fixes: 79c65d179a40 ("crypto: cbc - Convert to skcipher")
Fixes: a7d85e06ed80 ("crypto: cfb - add support for Cipher FeedBack mode")
Fixes: 043a44001b9e ("crypto: pcbc - Convert to skcipher")
Cc: <stable@vger.kernel.org>
Signed-off-by: Pan Bian <bianpan2016@163.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/cbc.c  |    6 ++++--
 crypto/cfb.c  |    6 ++++--
 crypto/pcbc.c |    6 ++++--
 3 files changed, 12 insertions(+), 6 deletions(-)

--- a/crypto/cbc.c
+++ b/crypto/cbc.c
@@ -140,9 +140,8 @@ static int crypto_cbc_create(struct cryp
 	spawn = skcipher_instance_ctx(inst);
 	err = crypto_init_spawn(spawn, alg, skcipher_crypto_instance(inst),
 				CRYPTO_ALG_TYPE_MASK);
-	crypto_mod_put(alg);
 	if (err)
-		goto err_free_inst;
+		goto err_put_alg;
 
 	err = crypto_inst_setname(skcipher_crypto_instance(inst), "cbc", alg);
 	if (err)
@@ -174,12 +173,15 @@ static int crypto_cbc_create(struct cryp
 	err = skcipher_register_instance(tmpl, inst);
 	if (err)
 		goto err_drop_spawn;
+	crypto_mod_put(alg);
 
 out:
 	return err;
 
 err_drop_spawn:
 	crypto_drop_spawn(spawn);
+err_put_alg:
+	crypto_mod_put(alg);
 err_free_inst:
 	kfree(inst);
 	goto out;
--- a/crypto/cfb.c
+++ b/crypto/cfb.c
@@ -286,9 +286,8 @@ static int crypto_cfb_create(struct cryp
 	spawn = skcipher_instance_ctx(inst);
 	err = crypto_init_spawn(spawn, alg, skcipher_crypto_instance(inst),
 				CRYPTO_ALG_TYPE_MASK);
-	crypto_mod_put(alg);
 	if (err)
-		goto err_free_inst;
+		goto err_put_alg;
 
 	err = crypto_inst_setname(skcipher_crypto_instance(inst), "cfb", alg);
 	if (err)
@@ -317,12 +316,15 @@ static int crypto_cfb_create(struct cryp
 	err = skcipher_register_instance(tmpl, inst);
 	if (err)
 		goto err_drop_spawn;
+	crypto_mod_put(alg);
 
 out:
 	return err;
 
 err_drop_spawn:
 	crypto_drop_spawn(spawn);
+err_put_alg:
+	crypto_mod_put(alg);
 err_free_inst:
 	kfree(inst);
 	goto out;
--- a/crypto/pcbc.c
+++ b/crypto/pcbc.c
@@ -244,9 +244,8 @@ static int crypto_pcbc_create(struct cry
 	spawn = skcipher_instance_ctx(inst);
 	err = crypto_init_spawn(spawn, alg, skcipher_crypto_instance(inst),
 				CRYPTO_ALG_TYPE_MASK);
-	crypto_mod_put(alg);
 	if (err)
-		goto err_free_inst;
+		goto err_put_alg;
 
 	err = crypto_inst_setname(skcipher_crypto_instance(inst), "pcbc", alg);
 	if (err)
@@ -275,12 +274,15 @@ static int crypto_pcbc_create(struct cry
 	err = skcipher_register_instance(tmpl, inst);
 	if (err)
 		goto err_drop_spawn;
+	crypto_mod_put(alg);
 
 out:
 	return err;
 
 err_drop_spawn:
 	crypto_drop_spawn(spawn);
+err_put_alg:
+	crypto_mod_put(alg);
 err_free_inst:
 	kfree(inst);
 	goto out;


