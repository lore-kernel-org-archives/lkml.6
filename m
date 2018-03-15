Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752821AbeCOPkb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 11:40:31 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60493 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752792AbeCOPk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 11:40:29 -0400
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: herbert@gondor.apana.org.au, davem@davemloft.net
Cc: Antoine Tenart <antoine.tenart@bootlin.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, oferh@marvell.com, igall@marvell.com
Subject: [PATCH 03/12] crypto: inside-secure - wait for the request to complete if in the backlog
Date: Thu, 15 Mar 2018 16:38:42 +0100
Message-Id: <20180315153851.9958-4-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180315153851.9958-1-antoine.tenart@bootlin.com>
References: <20180315153851.9958-1-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the safexcel_hmac_init_pad() function to also wait
for completion when the digest return code is -EBUSY, as it would mean
the request is in the backlog to be processed later.

Fixes: 1b44c5a60c13 ("crypto: inside-secure - add SafeXcel EIP197 crypto engine driver")
Suggested-by: Ofer Heifetz <oferh@marvell.com>
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/crypto/inside-secure/safexcel_hash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/inside-secure/safexcel_hash.c b/drivers/crypto/inside-secure/safexcel_hash.c
index 4953a2a86c10..77268c9f1620 100644
--- a/drivers/crypto/inside-secure/safexcel_hash.c
+++ b/drivers/crypto/inside-secure/safexcel_hash.c
@@ -842,7 +842,7 @@ static int safexcel_hmac_init_pad(struct ahash_request *areq,
 		init_completion(&result.completion);
 
 		ret = crypto_ahash_digest(areq);
-		if (ret == -EINPROGRESS) {
+		if (ret == -EINPROGRESS || ret == -EBUSY) {
 			wait_for_completion_interruptible(&result.completion);
 			ret = result.error;
 		}
-- 
2.14.3
