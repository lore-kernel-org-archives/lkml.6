Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1875C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84EF5208B1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="eAoIwcEj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84EF5208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934667AbeFROJF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 10:09:05 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:39358 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933947AbeFROJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 10:09:01 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180618140859euoutp01d7f3943203e44b791daba2b167bbf898~5RmL4aB5G2207922079euoutp01d;
        Mon, 18 Jun 2018 14:08:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180618140859euoutp01d7f3943203e44b791daba2b167bbf898~5RmL4aB5G2207922079euoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1529330939;
        bh=rFEBv/JABDm7Ib8T0DBNhrMA2CpU5MwKHJRWYpGdB/k=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=eAoIwcEjE+50QkGMiXdBX8rDD6B4xu2Heschgcxx/S4aFtejUU9H9E6TyJy4YKvNv
         V2EjWnjASVRCyVuY7n37vkcTsU4oRZ/sdU1ETTmwQERR7pUZ86JLOl6eC7DFeNJcuz
         j4zekjY5kfCAkZhvnnP+yMf9esRF9NdrMDye0fZA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180618140858eucas1p14dff7f2b08dcb46a5c5177d5640112af~5RmKv0Rw50206902069eucas1p1b;
        Mon, 18 Jun 2018 14:08:58 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id D9.DA.05700.9FCB72B5; Mon, 18
        Jun 2018 15:08:57 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180618140856eucas1p281619f9bf003655a3c2eac356216ab25~5RmJbLnnj0170101701eucas1p2q;
        Mon, 18 Jun 2018 14:08:56 +0000 (GMT)
X-AuditID: cbfec7f2-1c1ff70000011644-a4-5b27bcf95d48
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id BE.F8.04178.8FCB72B5; Mon, 18
        Jun 2018 15:08:56 +0100 (BST)
Received: from AMDC2075.DIGITAL.local ([106.120.51.25]) by
        eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PAI00JWAVASVL60@eusync4.samsung.com>;
        Mon, 18 Jun 2018 15:08:56 +0100 (BST)
From:   Maciej Purski <m.purski@samsung.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        Carlos Hernandez <ceh@ti.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Maciej Purski <m.purski@samsung.com>
Subject: [PATCH] regulator: core: Pass max_uV value to
 regulator_set_voltage_rdev
Date:   Mon, 18 Jun 2018 16:08:33 +0200
Message-id: <1529330913-11152-1-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <20180615112916.GK112168@atomide.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsWy7djPc7o/96hHG0zZrmYx9eETNot9fb/Z
        LDY9vsZqcXnXHDaL2Uv6WSwWvLzFYrH2yF12i/1XvBw4PL59ncTisWlVJ5vH5iX1Hn1bVjF6
        HL+xncnj8ya5ALYoLpuU1JzMstQifbsEroxLlysKfitXbH5wgqmB8ZdMFyMHh4SAicSzCxld
        jFwcQgIrGCUuX5rGCuF8ZpRYO+cycxcjJ1jR57P72SESyxgl1l26BFX1n1Hi5cc7rCCj2AS0
        JNa0x4OYIgIqEndf2oOUMAv8ZpRYs2E6I8ggYYFgibPLJ7GB2CwCqhJt064wgdi8Ai4SR6ad
        YoRYJidx81wn2GJOASOJv+ePMIMMkhCYwiZx4ckjqCIXiQ1XZrBA2MISr45vYYewZSQ6Ow4y
        QdjVEitfLmeBaG5glPhyF+Yda4nDxy+ygtjMAnwSk7ZNZ4aEBa9ER5sQRImHxMZnPVAftzJK
        3LjwjHECo+QCRoZVjOKppcW56anFhnmp5XrFibnFpXnpesn5uZsYgdF4+t/xTzsYv15KOsQo
        wMGoxMPbsFE9Wog1say4MvcQowQHs5II76JtQCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8cRp1
        UUIC6YklqdmpqQWpRTBZJg5OqQbGdOdFTdfOakxYv+HWBuOiqAtPZs1foL/ihe06l1lv3kz8
        VdHgZ+0yodblvvlnI6/tpmfOd36tSDp3WDJG/9+Huyn7r2yW+ioceH9CW+njjVv3aLWbKk/+
        nsfjdIo1p7aK8/CvV5Pj73Osnih86MKrqYqXur84LXvd3HKU4+65kqA/134f1NJnKVJiKc5I
        NNRiLipOBAD93YHDwgIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplluLIzCtJLcpLzFFi42I5/e/4Nd0fe9SjDY6t0bSY+vAJm8W+vt9s
        FpseX2O1uLxrDpvF7CX9LBYLXt5isVh75C67xf4rXg4cHt++TmLx2LSqk81j85J6j74tqxg9
        jt/YzuTxeZNcAFsUl01Kak5mWWqRvl0CV8alyxUFv5UrNj84wdTA+Eumi5GTQ0LAROLz2f3s
        XYxcHEICSxglOs7/hHIamSTmPJrN3MXIwcEmoCWxpj0exBQRUJG4+9IepIRZ4DejxIUfa1lB
        BgkLBEucXT6JDcRmEVCVaJt2hQnE5hVwkTgy7RQjxDI5iZvnOplBbE4BI4m/54+A2UIChhKN
        C1axTWDkWcDIsIpRJLW0ODc9t9hQrzgxt7g0L10vOT93EyMwkLYd+7l5B+OljcGHGAU4GJV4
        eBs2qkcLsSaWFVfmHmKU4GBWEuFdtA0oxJuSWFmVWpQfX1Sak1p8iFGag0VJnPe8QWWUkEB6
        YklqdmpqQWoRTJaJg1OqgVHZ5XvXViu/uRcrZ4rcff91aZKnxOvWTynvt3/3VJNmdep0Sp17
        VOHtnVVte60WsxXc5BXRWnjd0fDTroNlJxgP7Nv2+bXg2W9Hf8pIqpTkHtzXcmD/IeUZR+/I
        m5ss1Z4uHfKaS/aK9t/gTSdK7u2a/Hvnxwezry3YImY3o837sHpy0SPLRvfJSizFGYmGWsxF
        xYkAJvootCACAAA=
X-CMS-MailID: 20180618140856eucas1p281619f9bf003655a3c2eac356216ab25
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180618140856eucas1p281619f9bf003655a3c2eac356216ab25
References: <20180615112916.GK112168@atomide.com>
        <CGME20180618140856eucas1p281619f9bf003655a3c2eac356216ab25@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the regulator is not coupled, balance_voltage() should preserve
its desired max uV, instead of setting the exact value like in
coupled regulators case.

Remove debugs, which are not necessary for now.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 drivers/regulator/core.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 266f4eb..9894f4e 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2245,7 +2245,6 @@ static int _regulator_enable(struct regulator_dev *rdev)
 {
 	int ret;
 
-	rdev_err(rdev, "%s: %d\n", __func__, __LINE__);
 	lockdep_assert_held_once(&rdev->mutex);
 
 	/* check voltage and requested load before enabling */
@@ -2294,7 +2293,6 @@ int regulator_enable(struct regulator *regulator)
 	struct regulator_dev *rdev = regulator->rdev;
 	int ret = 0;
 
-	rdev_err(rdev, "%s: %d\n", __func__, __LINE__);
 	if (rdev->coupling_desc.n_resolved != rdev->coupling_desc.n_coupled) {
 		rdev_err(rdev, "not all coupled regulators registered\n");
 		return -EPERM;
@@ -2319,7 +2317,6 @@ int regulator_enable(struct regulator *regulator)
 	if (ret != 0 && rdev->supply)
 		regulator_disable(rdev->supply);
 
-	rdev_err(rdev, "%s: %d\n", __func__, __LINE__);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(regulator_enable);
@@ -2418,7 +2415,6 @@ int regulator_disable(struct regulator *regulator)
 	struct regulator_dev *rdev = regulator->rdev;
 	int ret = 0;
 
-	rdev_err(rdev, "%s: %d\n", __func__, __LINE__);
 	if (regulator->always_on)
 		return 0;
 
@@ -2431,7 +2427,6 @@ int regulator_disable(struct regulator *regulator)
 	if (ret == 0 && rdev->supply)
 		regulator_disable(rdev->supply);
 
-	rdev_err(rdev, "%s: %d\n", __func__, __LINE__);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(regulator_disable);
@@ -3112,6 +3107,8 @@ static int regulator_set_voltage_rdev(struct regulator_dev *rdev, int min_uV,
 	int supply_change_uV = 0;
 	int ret;
 
+	rdev_err(rdev, "%s: %d\n", __func__, __LINE__);
+
 	if (rdev->supply &&
 	    regulator_ops_is_valid(rdev->supply->rdev,
 				   REGULATOR_CHANGE_VOLTAGE) &&
@@ -3175,7 +3172,8 @@ static int regulator_set_voltage_rdev(struct regulator_dev *rdev, int min_uV,
 	return ret;
 }
 
-static int regulator_get_optimal_voltage(struct regulator_dev *rdev)
+static int
+regulator_get_optimal_voltage(struct regulator_dev *rdev, int *max_uV)
 {
 	struct coupling_desc *c_desc = &rdev->coupling_desc;
 	struct regulator_dev **c_rdevs = c_desc->coupled_rdevs;
@@ -3200,6 +3198,7 @@ static int regulator_get_optimal_voltage(struct regulator_dev *rdev)
 	 */
 	if (n_coupled == 1) {
 		ret = desired_min_uV;
+		*max_uV = desired_max_uV;
 		goto out;
 	}
 
@@ -3274,6 +3273,7 @@ static int regulator_get_optimal_voltage(struct regulator_dev *rdev)
 		goto out;
 	}
 	ret = possible_uV;
+	*max_uV = ret;
 
 out:
 	return ret;
@@ -3303,6 +3303,8 @@ static int regulator_balance_voltage(struct regulator_dev *rdev,
 	 * if there isn't any possible change.
 	 */
 	while (1) {
+		int max_uV;
+
 		best_delta = 0;
 		best_uV = 0;
 		best_rdev = NULL;
@@ -3318,9 +3320,9 @@ static int regulator_balance_voltage(struct regulator_dev *rdev,
 			 * max_spread constraint in order to balance
 			 * the coupled voltages.
 			 */
-			int optimal_uV, current_uV;
+			int optimal_uV, current_uV;;
 
-			optimal_uV = regulator_get_optimal_voltage(c_rdevs[i]);
+			optimal_uV = regulator_get_optimal_voltage(c_rdevs[i], &max_uV);
 			if (optimal_uV < 0) {
 				ret = optimal_uV;
 				goto out;
@@ -3337,6 +3339,10 @@ static int regulator_balance_voltage(struct regulator_dev *rdev,
 				best_rdev = c_rdevs[i];
 				best_uV = optimal_uV;
 			}
+
+			rdev_err(rdev,
+				"optimal uV: %d current uV: %d, max uV: %d\n",
+				 optimal_uV, current_uV, max_uV);
 		}
 
 		/* Nothing to change, return successfully */
@@ -3346,7 +3352,7 @@ static int regulator_balance_voltage(struct regulator_dev *rdev,
 		}
 
 		ret = regulator_set_voltage_rdev(best_rdev, best_uV,
-						 best_uV, state);
+						 max_uV, state);
 
 		if (ret < 0)
 			goto out;
@@ -3378,7 +3384,7 @@ int regulator_set_voltage(struct regulator *regulator, int min_uV, int max_uV)
 {
 	int ret = 0;
 
-	rdev_err(regulator->rdev, "%s: %d\n", __func__, __LINE__);
+	dev_err(regulator->dev, "%s: %d\n", __func__, __LINE__);
 	regulator_lock_dependent(regulator->rdev);
 
 	ret = regulator_set_voltage_unlocked(regulator, min_uV, max_uV,
-- 
2.7.4

