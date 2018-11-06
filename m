Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D611C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 08:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2C7320862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 08:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Xk0QhRfX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2C7320862
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387595AbeKFRxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 12:53:16 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38617 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387469AbeKFRxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 12:53:16 -0500
Received: by mail-pg1-f193.google.com with SMTP id f8-v6so5492592pgq.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 00:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=XRirKOLagPIVrlyYmzESmAHM53TbQ1gxtghv7KZj5gQ=;
        b=Xk0QhRfXxpi+JgkX9EKyDt11ObFY+dGDv4hTQNQjNX8SQJK3q+66KhEredm8ANIu/3
         4QY8OrP+ZgICAWDGQ+8Cdi6k2EsBgfRFqjv/x8uBFmvi56nRDuwqrd8uujcJxq9Dv/Jx
         Md4pwzLabuDgWLpOl0ckbfGoLXA/8HXhOAdGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XRirKOLagPIVrlyYmzESmAHM53TbQ1gxtghv7KZj5gQ=;
        b=ksXNLPB5yn9SyFwq5H91EC9GTxe/eaRaHTWNFJ6Hbrv5B/H8JwzpNDnRxl91MQzona
         ZoB0Lclr4LCo5bLHBWNItZGNHlC0ZsqUfIPCLW+TGcE6j8iysAAyg9TA6qid/zfYIG1S
         cB+jQ9/Hh7ykA5PXBPDJRIOb8Sy4W1NgoUGVE2c5y8eCXaP9Xv4ClTiUdmCLP8wALxsr
         7rOBbsX9inpwJZku4tU0X/SaaT+boFdKIuARI86ytcYy7TFkrAZGCQ2edlTUv0uSOcQS
         3c921cEaTHMwx9wFBjfCAwumUN5NAT014AHffomm3J8sO6du68kRxyTIHb4OABbuEP/2
         CWnA==
X-Gm-Message-State: AGRZ1gIB+WFcAOGNig5Ds2YbUqrqzePQ61BjxFoEzQABVsXCY9CGUm/q
        w+uj6PWsd7kUX0DLj4/1AyFqzw==
X-Google-Smtp-Source: AJdET5cn/69AUgpGpJ/3Dzam2Rk9L3wrGMXzj90O5zPNHtExlnLtr6E4bZbap6u/1MUh20jRfIMoEw==
X-Received: by 2002:a63:1f4e:: with SMTP id q14mr5787453pgm.88.1541492951272;
        Tue, 06 Nov 2018 00:29:11 -0800 (PST)
Received: from rpadasal-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id u5-v6sm35583131pgk.46.2018.11.06.00.29.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Nov 2018 00:29:10 -0800 (PST)
From:   Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@google.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
Subject: [PATCH] crypto: bcm: fix normal/non key hash algorithm failure
Date:   Tue,  6 Nov 2018 13:58:58 +0530
Message-Id: <1541492938-29261-1-git-send-email-raveendra.padasalagi@broadcom.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove setkey() callback handler for normal/non key
hash algorithms and keep it for AES-CBC/CMAC which needs key.

Signed-off-by: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
---
 drivers/crypto/bcm/cipher.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/bcm/cipher.c b/drivers/crypto/bcm/cipher.c
index 2d1f1db..4d67e22 100644
--- a/drivers/crypto/bcm/cipher.c
+++ b/drivers/crypto/bcm/cipher.c
@@ -4652,12 +4652,16 @@ static int spu_register_ahash(struct iproc_alg_s *driver_alg)
 	hash->halg.statesize = sizeof(struct spu_hash_export_s);
 
 	if (driver_alg->auth_info.mode != HASH_MODE_HMAC) {
-		hash->setkey = ahash_setkey;
 		hash->init = ahash_init;
 		hash->update = ahash_update;
 		hash->final = ahash_final;
 		hash->finup = ahash_finup;
 		hash->digest = ahash_digest;
+		if ((driver_alg->auth_info.alg == HASH_ALG_AES) &&
+		    ((driver_alg->auth_info.mode == HASH_MODE_XCBC) ||
+		    (driver_alg->auth_info.mode == HASH_MODE_CMAC))) {
+			hash->setkey = ahash_setkey;
+		}
 	} else {
 		hash->setkey = ahash_hmac_setkey;
 		hash->init = ahash_hmac_init;
-- 
1.9.1

