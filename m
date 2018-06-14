Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2937CC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3ACF208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNxqapyR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3ACF208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965745AbeFNOLD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:11:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:52090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965656AbeFNOLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:11:01 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6970C208DA;
        Thu, 14 Jun 2018 14:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985460;
        bh=dDUqxj9D7vyao0tvK20IKlWdxwTXJPjUG5rO5+jF/WE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bNxqapyRZTEKyawpbPTfBXkxtpF8cOGHQWBaxRbeqbSoimsK4Mp1LjpwnEGNbR82y
         Nggu4CzKGYidpKp4iTiqST4FCrR6KFuBcWTGkqx+N1q5Rd18d140PQym7J5yI+ecRk
         tqGdH6OrxwdT1RD12JNT4H8KKVRrMEZmYR0AXQJA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.14 34/36] crypto: vmx - Remove overly verbose printk from AES init routines
Date:   Thu, 14 Jun 2018 16:04:57 +0200
Message-Id: <20180614132158.821679324@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614132157.333004166@linuxfoundation.org>
References: <20180614132157.333004166@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ellerman <mpe@ellerman.id.au>

commit 1411b5218adbcf1d45ddb260db5553c52e8d917c upstream.

In the vmx AES init routines we do a printk(KERN_INFO ...) to report
the fallback implementation we're using.

However with a slow console this can significantly affect the speed of
crypto operations. Using 'cryptsetup benchmark' the removal of the
printk() leads to a ~5x speedup for aes-cbc decryption.

So remove them.

Fixes: 8676590a1593 ("crypto: vmx - Adding AES routines for VMX module")
Fixes: 8c755ace357c ("crypto: vmx - Adding CBC routines for VMX module")
Fixes: 4f7f60d312b3 ("crypto: vmx - Adding CTR routines for VMX module")
Fixes: cc333cd68dfa ("crypto: vmx - Adding GHASH routines for VMX module")
Cc: stable@vger.kernel.org # v4.1+
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/vmx/aes.c     |    2 --
 drivers/crypto/vmx/aes_cbc.c |    3 ---
 drivers/crypto/vmx/aes_ctr.c |    2 --
 drivers/crypto/vmx/ghash.c   |    2 --
 4 files changed, 9 deletions(-)

--- a/drivers/crypto/vmx/aes.c
+++ b/drivers/crypto/vmx/aes.c
@@ -48,8 +48,6 @@ static int p8_aes_init(struct crypto_tfm
 		       alg, PTR_ERR(fallback));
 		return PTR_ERR(fallback);
 	}
-	printk(KERN_INFO "Using '%s' as fallback implementation.\n",
-	       crypto_tfm_alg_driver_name((struct crypto_tfm *) fallback));
 
 	crypto_cipher_set_flags(fallback,
 				crypto_cipher_get_flags((struct
--- a/drivers/crypto/vmx/aes_cbc.c
+++ b/drivers/crypto/vmx/aes_cbc.c
@@ -52,9 +52,6 @@ static int p8_aes_cbc_init(struct crypto
 		       alg, PTR_ERR(fallback));
 		return PTR_ERR(fallback);
 	}
-	printk(KERN_INFO "Using '%s' as fallback implementation.\n",
-		crypto_skcipher_driver_name(fallback));
-
 
 	crypto_skcipher_set_flags(
 		fallback,
--- a/drivers/crypto/vmx/aes_ctr.c
+++ b/drivers/crypto/vmx/aes_ctr.c
@@ -48,8 +48,6 @@ static int p8_aes_ctr_init(struct crypto
 		       alg, PTR_ERR(fallback));
 		return PTR_ERR(fallback);
 	}
-	printk(KERN_INFO "Using '%s' as fallback implementation.\n",
-	       crypto_tfm_alg_driver_name((struct crypto_tfm *) fallback));
 
 	crypto_blkcipher_set_flags(
 		fallback,
--- a/drivers/crypto/vmx/ghash.c
+++ b/drivers/crypto/vmx/ghash.c
@@ -64,8 +64,6 @@ static int p8_ghash_init_tfm(struct cryp
 		       alg, PTR_ERR(fallback));
 		return PTR_ERR(fallback);
 	}
-	printk(KERN_INFO "Using '%s' as fallback implementation.\n",
-	       crypto_tfm_alg_driver_name(crypto_shash_tfm(fallback)));
 
 	crypto_shash_set_flags(fallback,
 			       crypto_shash_get_flags((struct crypto_shash


