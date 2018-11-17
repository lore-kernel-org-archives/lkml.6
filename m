Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B858C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 01:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AE732148E
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 01:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YoOFKaeQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AE732148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730949AbeKQLnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 06:43:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:51770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729948AbeKQLne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 06:43:34 -0500
Received: from ebiggers.mtv.corp.google.com (unknown [104.132.1.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8479B20989;
        Sat, 17 Nov 2018 01:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542418129;
        bh=CSwsE0kpVtvEmLVf4WwakB/GXFTCzwqC/yTAkI0RlG0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YoOFKaeQ05AZZs0hrDoUe8uhuLN+nPLg5XJo7f7X+j9AS5Llq9N9gJGfnt9RjVjgJ
         rwFg3MLGFeLlGUoaf5icu6rN5BZY9mF8MwALeu7B6TN8tPak70Zs8stSCucVDi4NOp
         n9grDHu89B1nsQJp/rHuZx5DfyG6iWZW0OaVtb+Q=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-fscrypt@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Crowley <paulcrowley@google.com>,
        Greg Kaiser <gkaiser@google.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Samuel Neves <samuel.c.p.neves@gmail.com>,
        Tomer Ashur <tomer.ashur@esat.kuleuven.be>,
        Eric Biggers <ebiggers@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Martin Willi <martin@strongswan.org>
Subject: [PATCH v4 02/14] crypto: chacha20-generic - don't unnecessarily use atomic walk
Date:   Fri, 16 Nov 2018 17:26:19 -0800
Message-Id: <20181117012631.23528-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
In-Reply-To: <20181117012631.23528-1-ebiggers@kernel.org>
References: <20181117012631.23528-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

chacha20-generic doesn't use SIMD instructions or otherwise disable
preemption, so passing atomic=true to skcipher_walk_virt() is
unnecessary.

Suggested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Martin Willi <martin@strongswan.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 crypto/chacha20_generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/chacha20_generic.c b/crypto/chacha20_generic.c
index 3ae96587caf9..3529521d72a4 100644
--- a/crypto/chacha20_generic.c
+++ b/crypto/chacha20_generic.c
@@ -81,7 +81,7 @@ int crypto_chacha20_crypt(struct skcipher_request *req)
 	u32 state[16];
 	int err;
 
-	err = skcipher_walk_virt(&walk, req, true);
+	err = skcipher_walk_virt(&walk, req, false);
 
 	crypto_chacha20_init(state, ctx, walk.iv);
 
-- 
2.19.1.1215.g8438c0b245-goog

