Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161730AbeCAUuh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 15:50:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:43954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161710AbeCAUub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 15:50:31 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C92E621742
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
Subject: [PATCH 3/4] crypto: s5p-sss: Remove useless check for non-null request
Date: Thu,  1 Mar 2018 21:50:12 +0100
Message-Id: <1519937413-24468-3-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519937413-24468-1-git-send-email-krzk@kernel.org>
References: <1519937413-24468-1-git-send-email-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ahash_request 'req' argument passed by the caller
s5p_hash_handle_queue() cannot be NULL here because it is obtained from
non-NULL pointer via container_of().

This fixes smatch warning:
    drivers/crypto/s5p-sss.c:1213 s5p_hash_prepare_request() warn: variable dereferenced before check 'req' (see line 1208)

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/crypto/s5p-sss.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/crypto/s5p-sss.c b/drivers/crypto/s5p-sss.c
index 5d64c08b7f47..d7c8163e5068 100644
--- a/drivers/crypto/s5p-sss.c
+++ b/drivers/crypto/s5p-sss.c
@@ -1210,9 +1210,6 @@ static int s5p_hash_prepare_request(struct ahash_request *req, bool update)
 	int xmit_len, hash_later, nbytes;
 	int ret;
 
-	if (!req)
-		return 0;
-
 	if (update)
 		nbytes = req->nbytes;
 	else
-- 
2.7.4
