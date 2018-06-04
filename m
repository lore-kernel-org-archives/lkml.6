Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753518AbeFDOAC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 10:00:02 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:58846 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753063AbeFDN74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 09:59:56 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180604135954euoutp02ca88fcec5f6eb860424c6bdab3319dee~0_cQxeWak0818308183euoutp02V
X-AuditID: cbfec7f5-b5fff700000028a9-b9-5b1545d9ab42
From: Maciej Purski <m.purski@samsung.com>
To: Mark Brown <broonie@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, Carlos Hernandez <ceh@ti.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Maciej Purski <m.purski@samsung.com>
Subject: [PATCH 3/7] regulator: core: Use re-entrant locks
Date: Mon, 04 Jun 2018 15:59:20 +0200
Message-id: <1528120764-14316-4-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1528120764-14316-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsWy7djPc7o3XUWjDXZPN7WY+vAJm8W+vt9s
        FpseX2O1uLxrDpvF7CX9LBYLXt5isVh75C67xf4rXg4cHt++TmLx2LSqk81j85J6j74tqxg9
        jt/YzuTxeZNcAFsUl01Kak5mWWqRvl0CV8bHr5uZC27xVcye8YSlgXEdTxcjJ4eEgInEgYMv
        WLsYuTiEBFYwSuw4vRrK+cwo8f7ZP0aYql8rH7NDJJYxSpxfdg6q6j+jxNdfi5i7GDk42AS0
        JNa0x4M0iAi4SnzvOcsCUsMscINR4sqh82CThAWsJCb9uMcKYrMIqEqs2fOKBcTmFXCROHbn
        KRPENjmJm+c6mUFsTqBBb2dvYgQZJCEwhU1i0dspLBBFLhK9Lw9BnScs8er4FnYIW0bi8uRu
        qJp8idZnj6HiFRL7ek+zQtjWEoePXwSzmQX4JCZtmw72gIQAr0RHmxBEiYfEr9aJjBBP7mOU
        uNM6i2UCo+QCRoZVjOKppcW56anFxnmp5XrFibnFpXnpesn5uZsYgRF5+t/xrzsY9/1JOsQo
        wMGoxMOrYSUaLcSaWFZcmXuIUYKDWUmE97QFUIg3JbGyKrUoP76oNCe1+BCjNAeLkjhvnEZd
        lJBAemJJanZqakFqEUyWiYNTqoHRae+xya+9NwUlZk5ojSt/KNEqZeyrsvqevt775Z2nP59V
        Op2VJyoxd1fqhZK2V1vWr0482Ghz2FivwIEz8+GZ90UnA3fI9m3yzd8q1OmVvMuX4cmB+NOi
        nVluNufWJ1VWrXntcUTHtcNNpyCve92PBXF/vmyed+pp7Iljv8R9+lfmXXi4NIxPiaU4I9FQ
        i7moOBEAvvEBw8QCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjluLIzCtJLcpLzFFi42I5/e/4Nd2brqLRBi8v81hMffiEzWJf3282
        i02Pr7FaXN41h81i9pJ+FosFL2+xWKw9cpfdYv8VLwcOj29fJ7F4bFrVyeaxeUm9R9+WVYwe
        x29sZ/L4vEkugC2KyyYlNSezLLVI3y6BK+Pj183MBbf4KmbPeMLSwLiOp4uRk0NCwETi18rH
        7F2MXBxCAksYJa7/WcYIkhASaGSS+PhOtYuRg4NNQEtiTXs8SFhEwFXie89ZFpB6ZoFbjBLr
        Xx1lAUkIC1hJTPpxjxXEZhFQlViz5xVYnFfAReLYnadMEMvkJG6e62QGsTmBBr2dvQlqV5bE
        giuLmCcw8ixgZFjFKJJaWpybnltspFecmFtcmpeul5yfu4kRGErbjv3csoOx613wIUYBDkYl
        Ht4GG9FoIdbEsuLK3EOMEhzMSiK8py2AQrwpiZVVqUX58UWlOanFhxilOViUxHnPG1RGCQmk
        J5akZqemFqQWwWSZODilGhitHyaGTbt6aGvR5h1OXw7FfHINV5e5mXDwx8a6e+HNSz2qLjf0
        qH0rVk542WEz7YybqFXay0Wz52zaHhC012Lrp5g4sa66k2vC266XSLGytHIs3vHBbPLxW2Gx
        au+f/E98cWt5a3/HBfHQ500am3K3zH59TfROXt63p4cMSiaxq35ceWnLP+7HSizFGYmGWsxF
        xYkAi3/0CSECAAA=
X-CMS-MailID: 20180604135953eucas1p2f2c9dd9581cd114d323c3d64afe5c308
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180604135953eucas1p2f2c9dd9581cd114d323c3d64afe5c308
References: <20180530144505.GB5705@atomide.com>
        <1528120764-14316-1-git-send-email-m.purski@samsung.com>
        <CGME20180604135953eucas1p2f2c9dd9581cd114d323c3d64afe5c308@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-entrant locks were implemented in previous patches. They should
substitute all mutex_lock() and mutex_unlock() calls on regulators'
mutexes.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 drivers/regulator/core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 413a824..c5478d2 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2274,9 +2274,9 @@ int regulator_enable(struct regulator *regulator)
 			return ret;
 	}
 
-	mutex_lock(&rdev->mutex);
+	regulator_lock(rdev);
 	ret = _regulator_enable(rdev);
-	mutex_unlock(&rdev->mutex);
+	regulator_unlock(rdev);
 
 	if (ret != 0 && rdev->supply)
 		regulator_disable(rdev->supply);
@@ -2384,9 +2384,9 @@ int regulator_disable(struct regulator *regulator)
 	if (regulator->always_on)
 		return 0;
 
-	mutex_lock(&rdev->mutex);
+	regulator_lock(rdev);
 	ret = _regulator_disable(rdev);
-	mutex_unlock(&rdev->mutex);
+	regulator_unlock(rdev);
 
 	if (ret == 0 && rdev->supply)
 		regulator_disable(rdev->supply);
@@ -2436,10 +2436,10 @@ int regulator_force_disable(struct regulator *regulator)
 	struct regulator_dev *rdev = regulator->rdev;
 	int ret;
 
-	mutex_lock(&rdev->mutex);
+	regulator_lock(rdev);
 	regulator->uA_load = 0;
 	ret = _regulator_force_disable(regulator->rdev);
-	mutex_unlock(&rdev->mutex);
+	regulator_unlock(rdev);
 
 	if (rdev->supply)
 		while (rdev->open_count--)
@@ -2587,9 +2587,9 @@ int regulator_is_enabled(struct regulator *regulator)
 	if (regulator->always_on)
 		return 1;
 
-	mutex_lock(&regulator->rdev->mutex);
+	regulator_lock(regulator->rdev);
 	ret = _regulator_is_enabled(regulator->rdev);
-	mutex_unlock(&regulator->rdev->mutex);
+	regulator_unlock(regulator->rdev);
 
 	return ret;
 }
-- 
2.7.4
