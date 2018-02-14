Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031649AbeBNVkg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 16:40:36 -0500
Received: from mout.web.de ([212.227.15.4]:40361 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031455AbeBNVke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 16:40:34 -0500
Subject: [PATCH 2/2] crypto: bcm: One function call less in do_shash() after
 error detection
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-crypto@vger.kernel.org, Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Rice <rob.rice@broadcom.com>, Steve Lin <steven.lin1@broadcom.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <68946b12-83d6-ab74-fd54-71b23cf9b7ef@users.sourceforge.net>
Message-ID: <55bdcf76-f1c9-180d-6798-959e617b10ac@users.sourceforge.net>
Date: Wed, 14 Feb 2018 22:40:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <68946b12-83d6-ab74-fd54-71b23cf9b7ef@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:cvcOAkDMzLmPq1i0KvCjqGrMttGJPNENznKZFsQRYfulFQQqWch
 4GoDOZunAH2PDjm4fJrAzYXbnCp+LSw14uo7AaY3b+x+u/CTD5aDQUYgvYPZyz2NQztllgS
 Ice/6NXv5J9oAThLEXTrngqgYt+6mCp8KRxEwZDrVIh4d2MKqC1tUjVbfmmT4+KyTizkwsJ
 xr5I0uk9jGz6u0+uOOJxw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oxT/3ob+ulE=:5jfHN9RSqSIliB4alksj+L
 TVJyRCqBIsweYyQklXUY81YFB5ZGYroNngvUt+M2LzwKhj3Q67v/V5cEyKPCoD7h9531qIi8K
 JKb15rwjtKvUH52iQ8GV1kz/8qrrIe5sgE1ehQOwDeFhmfkCobwm6CgtVgt4tpAaMTYFVu9Ng
 JHjUbgRwoJyJK9bZ3L7SbHJEcUY3F20a9wZMrvEXvBMAs6U4Jrq47SjrbzEluNL+1E+2xUbVa
 Ks9zKTrmULcoUzI6yAv1Uj+4fBMgMtaoesWNveIuFcXVrIWWG5Bzper5fxhmFFn6+GtibsgRy
 cnS0DuM+2P4zgf4xR15gp8oxMsVswP2zLaGQ5eJBAbDQQyceTkOfYqA3E8bZo6I/329WY+c7x
 4LdVAB4rNM6DZftrTd0BdzT+X5xg/9B+QMWAqduzdaOccsWAdveVgtnpDJYtum2G4bCOlfMiH
 yzi6acqJLhD6Q8+fzrx4ljkM4jkOpK3VmWyAQq4hC5H1TSXQOVzIPavnJQrtUvTYXWHP3BGtg
 BuE26I0EYWQSafVxPpWEC5AwhtPKQNt7Abs5LMuui9ORwiFUlvSq+Yv8xE/hl0ssYUgTMbSQ5
 DZeTjjxuN1ullilQ38DAFpDCDeD+TS1rT+obAuXu6R32QTydG1+pXnILo8K0JOap72+rGK/XT
 KTEbkav8N9Ak7ixpWpWVp0Dey+ecjDAyj1LFNIW8eWE9K821c3Q52Ajb99AuWOdqGPIjsm88I
 k6jmFt+POLiEHlfExZKDDiOKWkynYDOePoX9YqSwY455TJuVrovJ27aEw35vtFTxn5gV9l9Dk
 hOlVWrLoMS+jUdBBZm/HgbL6ksJEugmBFH5ac4YIkeT2T3c1pE=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 14 Feb 2018 22:22:20 +0100

The kfree() function was called in one case by the do_shash() function
during error handling even if the passed variable contained a null pointer.

* Reorder two function calls at the end.

* Add a jump target.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/crypto/bcm/util.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/bcm/util.c b/drivers/crypto/bcm/util.c
index a912c6ad3e85..c141a0242223 100644
--- a/drivers/crypto/bcm/util.c
+++ b/drivers/crypto/bcm/util.c
@@ -279,7 +279,7 @@ int do_shash(unsigned char *name, unsigned char *result,
 	sdesc = kmalloc(size, GFP_KERNEL);
 	if (!sdesc) {
 		rc = -ENOMEM;
-		goto do_shash_err;
+		goto free_shash;
 	}
 	sdesc->shash.tfm = hash;
 	sdesc->shash.flags = 0x0;
@@ -314,9 +314,9 @@ int do_shash(unsigned char *name, unsigned char *result,
 		pr_err("%s: Could not generate %s hash\n", __func__, name);
 
 do_shash_err:
-	crypto_free_shash(hash);
 	kfree(sdesc);
-
+free_shash:
+	crypto_free_shash(hash);
 	return rc;
 }
 
-- 
2.16.1
