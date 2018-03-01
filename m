Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161711AbeCAUub (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 15:50:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:43906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161539AbeCAUuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 15:50:25 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70D4321742
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kamil Konieczny <k.konieczny@partner.samsung.com>,
        Tero Kristo <t-kristo@ti.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: [PATCH 1/4] crypto: omap-sham: Remove useless check for non-null request
Date: Thu,  1 Mar 2018 21:50:10 +0100
Message-Id: <1519937413-24468-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ahash_request 'req' argument passed by the caller
omap_sham_handle_queue() cannot be NULL here because it is obtained from
non-NULL pointer via container_of().

This fixes smatch warning:
    drivers/crypto/omap-sham.c:812 omap_sham_prepare_request() warn: variable dereferenced before check 'req' (see line 805)

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/crypto/omap-sham.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/crypto/omap-sham.c b/drivers/crypto/omap-sham.c
index 86b89ace836f..7650b1b449bb 100644
--- a/drivers/crypto/omap-sham.c
+++ b/drivers/crypto/omap-sham.c
@@ -809,9 +809,6 @@ static int omap_sham_prepare_request(struct ahash_request *req, bool update)
 	bool final = rctx->flags & BIT(FLAGS_FINUP);
 	int xmit_len, hash_later;
 
-	if (!req)
-		return 0;
-
 	bs = get_block_size(rctx);
 
 	if (update)
-- 
2.7.4
