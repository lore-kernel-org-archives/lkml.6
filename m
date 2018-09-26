Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1326AC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA0A421533
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:49:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA0A421533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbeI0FFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 01:05:00 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:49938 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726186AbeI0FFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 01:05:00 -0400
Received: from mr5.cc.vt.edu (mr5.cc.ipv6.vt.edu [IPv6:2607:b400:92:8400:0:72:232:758b])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id w8QMnksi004108
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 18:49:46 -0400
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        by mr5.cc.vt.edu (8.14.7/8.14.7) with ESMTP id w8QMnffD008744
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 18:49:46 -0400
Received: by mail-qk1-f197.google.com with SMTP id 17-v6so693799qkj.19
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 15:49:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:mime-version:date:message-id;
        bh=s+4DODPYq3XlxXA/Wuyzxp5KZT1vdyoEe9bMkQmO5Ac=;
        b=XKNBcnWTWyPuOPf19qiWhjzc7IOS+ii9p7dGrv9UJUW7BvQkrp1z3X1cbpVzEd6gk8
         Un73WkuKqBhhXkLVso2YZ/a0Mtj3qhnDQwxTYPCYQ7T2TFuJMeW7fZiyaDERnn8gxrle
         WJYFZZ4EHTlevnCu3VUzAgqitNESrfFPQkNmvwSt/cbti6RT6AKPNWV5tHxYXY578WTA
         udzPVsLF5bqOyHJ4z+PfyKWg7CXHYqJxSF2bcFBC48UxPTheNnzozg5xefckHiFkFxCd
         H192UQIZDx1leUpZgVL2umN1i+4EYwhBUuVBeOXpyybLndNAqw+I2dGfN2lr2p4MZ2dy
         +ffg==
X-Gm-Message-State: ABuFfojqDpGx0r2viydEcddjq6fSjMm4kaJYTp8QQzeRH946A82njh0i
        1rvo/TZIn8hp926d3G/hHO8A4AroGpKFLcicR46lHlnlswGpO5lXbo8+XMsMurCxlAnVIyJmlOd
        i6BuC2FdDyJBB9Xn2fMvLdrXiHtIs1pSiI+g=
X-Received: by 2002:a0c:a281:: with SMTP id g1-v6mr5952452qva.60.1538002181740;
        Wed, 26 Sep 2018 15:49:41 -0700 (PDT)
X-Google-Smtp-Source: ACcGV61qTl6U+l9Mrf45pSW6UiKrBaSOFcaO/gBqIgNFuoyBHqlQ25Qk597nBwcRUqFuhQjN992NrQ==
X-Received: by 2002:a0c:a281:: with SMTP id g1-v6mr5952394qva.60.1538002180255;
        Wed, 26 Sep 2018 15:49:40 -0700 (PDT)
Received: from turing-police.cc.vt.edu (turing-police.cc.ipv6.vt.edu. [2001:468:c80:2103:f21f:afff:fe0c:8ada])
        by smtp.gmail.com with ESMTPSA id o2-v6sm237352qkl.63.2018.09.26.15.49.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 15:49:39 -0700 (PDT)
X-Mailer: exmh version 2.8.0 04/21/2017 with nmh-1.7+dev
From:   valdis.kletnieks@vt.edu
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] crypto/morus(640,1280) - make crypto_...-algs static
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Wed, 26 Sep 2018 18:49:38 -0400
Message-ID: <113445.1538002178@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sparse complains thusly:

  CHECK   arch/x86/crypto/morus640-sse2-glue.c
arch/x86/crypto/morus640-sse2-glue.c:38:1: warning: symbol 'crypto_morus640_sse2_algs' was not declared. Should it be static?
  CHECK   arch/x86/crypto/morus1280-sse2-glue.c
arch/x86/crypto/morus1280-sse2-glue.c:38:1: warning: symbol 'crypto_morus1280_sse2_algs' was not declared. Should it be static?
  CHECK   arch/x86/crypto/morus1280-avx2-glue.c
arch/x86/crypto/morus1280-avx2-glue.c:38:1: warning: symbol 'crypto_morus1280_avx2_algs' was not declared. Should it be static?

and sparse is correct - these don't need to be global and polluting the namespace.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
---
diff --git a/include/crypto/morus1280_glue.h b/include/crypto/morus1280_glue.h
index b26dd70efd9a..ba782e10065e 100644
--- a/include/crypto/morus1280_glue.h
+++ b/include/crypto/morus1280_glue.h
@@ -82,7 +82,7 @@ void cryptd_morus1280_glue_exit_tfm(struct crypto_aead *aead);
 	{ \
 	} \
 	\
-	struct aead_alg crypto_morus1280_##id##_algs[] = {\
+	static struct aead_alg crypto_morus1280_##id##_algs[] = {\
 		{ \
 			.setkey = crypto_morus1280_glue_setkey, \
 			.setauthsize = crypto_morus1280_glue_setauthsize, \
diff --git a/include/crypto/morus640_glue.h b/include/crypto/morus640_glue.h
index 90c8db07e740..27fa790a2362 100644
--- a/include/crypto/morus640_glue.h
+++ b/include/crypto/morus640_glue.h
@@ -82,7 +82,7 @@ void cryptd_morus640_glue_exit_tfm(struct crypto_aead *aead);
 	{ \
 	} \
 	\
-	struct aead_alg crypto_morus640_##id##_algs[] = {\
+	static struct aead_alg crypto_morus640_##id##_algs[] = {\
 		{ \
 			.setkey = crypto_morus640_glue_setkey, \
 			.setauthsize = crypto_morus640_glue_setauthsize, \

