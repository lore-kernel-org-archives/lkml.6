Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1BCF0C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 10:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B97E8208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 10:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DyjxB2h+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B97E8208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935146AbeFMKg2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 06:36:28 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47093 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754462AbeFMKg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 06:36:26 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180613103623euoutp020a361e06392ba57ce990402aefceb2d6~3seI_vZK90753107531euoutp027;
        Wed, 13 Jun 2018 10:36:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180613103623euoutp020a361e06392ba57ce990402aefceb2d6~3seI_vZK90753107531euoutp027
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1528886183;
        bh=7zk9JQE3Mc1eDfbNZDPbkltsOOmk0R6hg4oT3jcfJwM=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=DyjxB2h+Tp7XD+fLTgeumoVfDwt3PehnSKOtK/QDgMqtyn3o+Ec0eQ7OIZtqwZCCH
         /ohZ/kF9lq8GNfXN4/uHNNPk6Ic1sN9lp+uWGUVqbCTktvqv6TRK00ze0+h5wDOA87
         E8ORkc2ylEEWJwLcoqu9HQO6WvfO9qoQw4qKOguI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180613103623eucas1p1afc127969b08f27f9b49db77f40037ec~3seIgKExc1352313523eucas1p1y;
        Wed, 13 Jun 2018 10:36:23 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id BD.77.10409.6A3F02B5; Wed, 13
        Jun 2018 11:36:22 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180613103622eucas1p1778ba2c2e5dd85ccb4c488bd0a38386d~3seHkliUy1352213522eucas1p17;
        Wed, 13 Jun 2018 10:36:22 +0000 (GMT)
X-AuditID: cbfec7f5-b5fff700000028a9-0a-5b20f3a62e2a
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 50.66.04183.6A3F02B5; Wed, 13
        Jun 2018 11:36:22 +0100 (BST)
Received: from AMDC2075.DIGITAL.local ([106.120.51.25]) by
        eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PA9004PRC4FWU70@eusync1.samsung.com>;
        Wed, 13 Jun 2018 11:36:22 +0100 (BST)
From:   Maciej Purski <m.purski@samsung.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        Carlos Hernandez <ceh@ti.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Maciej Purski <m.purski@samsung.com>
Subject: [PATCH v2] regulator: core: Enable voltage balancing
Date:   Wed, 13 Jun 2018 12:33:46 +0200
Message-id: <1528886026-9457-1-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <20180605044554.GC5738@atomide.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsWy7djPc7rLPitEG0w5Z2Ex9eETNot9fb/Z
        LDY9vsZqcXnXHDaL2Uv6WSwWvLzFYrH2yF12i/1XvBw4PL59ncTisWlVJ5vH5iX1Hn1bVjF6
        HL+xncnj8ya5ALYoLpuU1JzMstQifbsErowLe3uZCo6qVWx69pS1gbFNoYuRk0NCwETi9OFn
        TF2MXBxCAisYJRYefcYG4XxmlLi0fwsTTNXaTdfAbCGBZYwS86ZFQBT9Z5T433qFsYuRg4NN
        QEtiTXs8iCkioCJx96U9SAmzwG9GiTUbpjOC9AoL2EpMurWDGcRmEVCVaL97lh3E5hVwltjy
        vI0FYpecxM1znWA1nAIGEvuvLgW7TkJgCpvEyfYjUEUuErNWtTJD2MISr45vYYewZSQuT+6G
        qqmWWPlyOQtEcwOjxJe7l6EarCUOH7/ICmIzC/BJTNo2nRnkagkBXomONiEI00PiaW8pxI/N
        jBJ32nYxTmCUXMDIsIpRPLW0ODc9tdg4L7Vcrzgxt7g0L10vOT93EyMwGk//O/51B+O+P0mH
        GAU4GJV4eC22KkQLsSaWFVfmHmKU4GBWEuH1ewEU4k1JrKxKLcqPLyrNSS0+xCjNwaIkzhun
        URclJJCeWJKanZpakFoEk2Xi4JRqYDSsEtz6/cHckBWhM9dnHy2fPl9NlPe76qvY6d9CbrJJ
        Rzwvv9X7Z6lhz81V4ZwWZkcOuD0VW+ui8MqmbXdV8R97nv4lT70bdz76sThR7qmU+FW5glkT
        O7XyZ3/kW8p0e15Jw9G+kJ2n9Nq+vfL5W/Qx6s2HjMYTWtp8Lx6yL+2e/vvjTbm8A3uVWIoz
        Eg21mIuKEwGId0JSwgIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplluLIzCtJLcpLzFFi42I5/e/4Zd1lnxWiDR494reY+vAJm8W+vt9s
        FpseX2O1uLxrDpvF7CX9LBYLXt5isVh75C67xf4rXg4cHt++TmLx2LSqk81j85J6j74tqxg9
        jt/YzuTxeZNcAFsUl01Kak5mWWqRvl0CV8aFvb1MBUfVKjY9e8rawNim0MXIySEhYCKxdtM1
        JhBbSGAJo8SNqVpdjFxAdiOTROe2r+xdjBwcbAJaEmva40FMEQEVibsv7UFKmAV+M0pc+LGW
        FaRXWMBWYtKtHcwgNouAqkT73bPsIDavgLPEludtLBC75CRunusEq+EUMJDYf3Up1F59iR8r
        TzFNYORZwMiwilEktbQ4Nz232EivODG3uDQvXS85P3cTIzCQth37uWUHY9e74EOMAhyMSjy8
        Dy7KRwuxJpYVV+YeYpTgYFYS4fV7oRAtxJuSWFmVWpQfX1Sak1p8iFGag0VJnPe8QWWUkEB6
        YklqdmpqQWoRTJaJg1OqgdFMg+f0kx7Fd/5ebYsXcd4/oVfi0ZCw5t8hrZcTP6WfVbJ6Vus9
        b0bP8ll/DnifLNyrPvXz2fTNnnlHJq330moJ3aA8Z0mUy7FHaZMudfbc/3VmpbGc8f4Ldru3
        SyTvkP1ZfmSpiMxuEQHdrVYrp86JMZQTStYom8L8SNo08MndRrnOj2c7pHYqsRRnJBpqMRcV
        JwIAf78/QiACAAA=
X-CMS-MailID: 20180613103622eucas1p1778ba2c2e5dd85ccb4c488bd0a38386d
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180613103622eucas1p1778ba2c2e5dd85ccb4c488bd0a38386d
References: <20180605044554.GC5738@atomide.com>
        <CGME20180613103622eucas1p1778ba2c2e5dd85ccb4c488bd0a38386d@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call regulator_balance_voltage() instead of set_voltage_rdev()
in set_voltage_unlocked() and in enabling and disabling functions,
but only if the regulator is coupled.

Signed-off-by: Maciej Purski <m.purski@samsung.com>

---
Changes in v2:
- fix compile errors
- make debug messages more informative
---
 drivers/regulator/core.c | 38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 2a7ffb7..266f4eb 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1605,7 +1605,6 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 	struct device *dev = rdev->dev.parent;
 	int ret;
 
-	pr_err("%s: %d\n", __func__, __LINE__);
 	/* No supply to resovle? */
 	if (!rdev->supply_name)
 		return 0;
@@ -2246,7 +2245,7 @@ static int _regulator_enable(struct regulator_dev *rdev)
 {
 	int ret;
 
-	pr_err("%s: %d\n", __func__, __LINE__);
+	rdev_err(rdev, "%s: %d\n", __func__, __LINE__);
 	lockdep_assert_held_once(&rdev->mutex);
 
 	/* check voltage and requested load before enabling */
@@ -2295,7 +2294,12 @@ int regulator_enable(struct regulator *regulator)
 	struct regulator_dev *rdev = regulator->rdev;
 	int ret = 0;
 
-	pr_err("%s: %d\n", __func__, __LINE__);
+	rdev_err(rdev, "%s: %d\n", __func__, __LINE__);
+	if (rdev->coupling_desc.n_resolved != rdev->coupling_desc.n_coupled) {
+		rdev_err(rdev, "not all coupled regulators registered\n");
+		return -EPERM;
+	}
+
 	if (regulator->always_on)
 		return 0;
 
@@ -2307,12 +2311,15 @@ int regulator_enable(struct regulator *regulator)
 
 	regulator_lock_dependent(rdev);
 	ret = _regulator_enable(rdev);
+	/* balance only if there are regulators coupled */
+	if (rdev->coupling_desc.n_coupled > 1)
+		regulator_balance_voltage(rdev, PM_SUSPEND_ON);
 	regulator_unlock_dependent(rdev);
 
 	if (ret != 0 && rdev->supply)
 		regulator_disable(rdev->supply);
 
-	pr_err("%s: %d\n", __func__, __LINE__);
+	rdev_err(rdev, "%s: %d\n", __func__, __LINE__);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(regulator_enable);
@@ -2411,18 +2418,20 @@ int regulator_disable(struct regulator *regulator)
 	struct regulator_dev *rdev = regulator->rdev;
 	int ret = 0;
 
-	pr_err("%s: %d\n", __func__, __LINE__);
+	rdev_err(rdev, "%s: %d\n", __func__, __LINE__);
 	if (regulator->always_on)
 		return 0;
 
 	regulator_lock_dependent(rdev);
 	ret = _regulator_disable(rdev);
+	if (rdev->coupling_desc.n_coupled > 1)
+		regulator_balance_voltage(rdev, PM_SUSPEND_ON);
 	regulator_unlock_dependent(rdev);
 
 	if (ret == 0 && rdev->supply)
 		regulator_disable(rdev->supply);
 
-	pr_err("%s: %d\n", __func__, __LINE__);
+	rdev_err(rdev, "%s: %d\n", __func__, __LINE__);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(regulator_disable);
@@ -2470,6 +2479,8 @@ int regulator_force_disable(struct regulator *regulator)
 	regulator_lock_dependent(rdev);
 	regulator->uA_load = 0;
 	ret = _regulator_force_disable(regulator->rdev);
+	if (rdev->coupling_desc.n_coupled > 1)
+		regulator_balance_voltage(rdev, PM_SUSPEND_ON);
 	regulator_unlock_dependent(rdev);
 
 	if (rdev->supply)
@@ -2898,7 +2909,7 @@ static int _regulator_do_set_voltage(struct regulator_dev *rdev,
 	const struct regulator_ops *ops = rdev->desc->ops;
 	int old_uV = _regulator_get_voltage(rdev);
 
-	pr_err("%s: %d\n", __func__, __LINE__);
+	rdev_err(rdev, "%s: %d\n", __func__, __LINE__);
 	trace_regulator_set_voltage(rdev_get_name(rdev), min_uV, max_uV);
 
 	min_uV += rdev->constraints->uV_offset;
@@ -3031,7 +3042,13 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 	int old_min_uV, old_max_uV;
 	int current_uV;
 
-	pr_err("%s: %d\n", __func__, __LINE__);
+	rdev_err(rdev, "%s:  %d\n", __func__, __LINE__);
+	if (rdev->coupling_desc.n_resolved != rdev->coupling_desc.n_coupled) {
+		rdev_err(rdev, "not all coupled regulators registered\n");
+		ret = -EPERM;
+		goto out;
+	}
+
 	/* If we're setting the same range as last time the change
 	 * should be a noop (some cpufreq implementations use the same
 	 * voltage for multiple frequencies, for example).
@@ -3074,7 +3091,8 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 	if (ret < 0)
 		goto out2;
 
-	ret = regulator_set_voltage_rdev(rdev, min_uV, max_uV, state);
+	/* for not coupled regulators this will just set the voltage */
+	ret = regulator_balance_voltage(rdev, state);
 	if (ret < 0)
 		goto out2;
 
@@ -3360,7 +3378,7 @@ int regulator_set_voltage(struct regulator *regulator, int min_uV, int max_uV)
 {
 	int ret = 0;
 
-	pr_err("%s: %d\n", __func__, __LINE__);
+	rdev_err(regulator->rdev, "%s: %d\n", __func__, __LINE__);
 	regulator_lock_dependent(regulator->rdev);
 
 	ret = regulator_set_voltage_unlocked(regulator, min_uV, max_uV,
-- 
2.7.4

