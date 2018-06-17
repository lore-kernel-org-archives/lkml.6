Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8CCC433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 17:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61D9420863
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 17:50:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61D9420863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754340AbeFQRuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 13:50:16 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:38946 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752077AbeFQRuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 13:50:13 -0400
Received: by mail-lf0-f68.google.com with SMTP id t2-v6so14904982lfd.6;
        Sun, 17 Jun 2018 10:50:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZRPW0j7eYlNHkO+1KvWJIKyhGIGkZcpi/U+p/Zbuqjo=;
        b=frQfeJ20lPWv7GxONsYaNPevMyGZ+o3Eq4iFOWmzsJ13egojRgLB0XOPS7l6JYhDJT
         gGJe68kfS5ZghZFwe1cQCYtUM8RIRR2WaSnCm5zRh4Myy8tFhe4bDpVKg8nEoaTQjofr
         ilmT09TxW4xL4vNiqsRiBW5jJXhqM64lFXwbr4s70fV0rMrNL2LhsQ4eiafxYd6yOtdC
         fO+LBGhnuct/GovSMAtBvAME1U9150awbyiJc20MU6vmYjFT5waRO0vFClrwrDlwzXBX
         Y/91OV2ny2UXzE2c0zAa0+JBp3xZi72vqwQJGHcIgRnE9dzFN3z27JCpwRvMwGiigDlb
         XI3A==
X-Gm-Message-State: APt69E0a9InvCjXZirE3GBcmKoc80JfYd/cnGCQgijB6e5Q4+gkqdu5I
        9awsbVe4n7EIXfbDX4Loszc=
X-Google-Smtp-Source: ADUXVKIq8YpHWREAEo7zta5h6JZrIviKxx8XAWaR+Jx3c+medonZROf8cmkY9QXPZj87h22POI+6Uw==
X-Received: by 2002:a19:188a:: with SMTP id 10-v6mr5843315lfy.26.1529257812389;
        Sun, 17 Jun 2018 10:50:12 -0700 (PDT)
Received: from green.intra.ispras.ru (bran.ispras.ru. [83.149.199.196])
        by smtp.googlemail.com with ESMTPSA id p28-v6sm2431487lfh.24.2018.06.17.10.50.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Jun 2018 10:50:11 -0700 (PDT)
From:   efremov@linux.com
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org, Denis Efremov <efremov@linux.com>
Subject: [PATCH] crypto: skcipher: remove static declaration of export function
Date:   Sun, 17 Jun 2018 20:49:59 +0300
Message-Id: <20180617174959.29864-1-efremov@linux.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function skcipher_walk_next declared as static and marked as
EXPORT_SYMBOL. It's a bit confusing since export symbol means that
we want others to use this function. The area of visibility for such
function is its .c file and all other modules. Other *.c files of the
same module can't use it, despite all other modules can. Relying on
that such behavior was not the original intention, the patch just
removes the static keyword.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 crypto/skcipher.c                  | 4 +---
 include/crypto/internal/skcipher.h | 1 +
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/crypto/skcipher.c b/crypto/skcipher.c
index 0fe2a2923ad0..d28d2f2be562 100644
--- a/crypto/skcipher.c
+++ b/crypto/skcipher.c
@@ -44,8 +44,6 @@ struct skcipher_walk_buffer {
 	u8 buffer[];
 };
 
-static int skcipher_walk_next(struct skcipher_walk *walk);
-
 static inline void skcipher_unmap(struct scatter_walk *walk, void *vaddr)
 {
 	if (PageHighMem(scatterwalk_page(walk)))
@@ -335,7 +333,7 @@ static int skcipher_next_fast(struct skcipher_walk *walk)
 	return 0;
 }
 
-static int skcipher_walk_next(struct skcipher_walk *walk)
+int skcipher_walk_next(struct skcipher_walk *walk)
 {
 	unsigned int bsize;
 	unsigned int n;
diff --git a/include/crypto/internal/skcipher.h b/include/crypto/internal/skcipher.h
index e42f7063f245..8602684d912b 100644
--- a/include/crypto/internal/skcipher.h
+++ b/include/crypto/internal/skcipher.h
@@ -154,6 +154,7 @@ int skcipher_walk_aead_encrypt(struct skcipher_walk *walk,
 int skcipher_walk_aead_decrypt(struct skcipher_walk *walk,
 			       struct aead_request *req, bool atomic);
 void skcipher_walk_complete(struct skcipher_walk *walk, int err);
+int skcipher_walk_next(struct skcipher_walk *walk);
 
 static inline void ablkcipher_request_complete(struct ablkcipher_request *req,
 					       int err)
-- 
2.17.1

