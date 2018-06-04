Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753614AbeFDOBS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 10:01:18 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:41140 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753291AbeFDN75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 09:59:57 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180604135955euoutp01418a39d74bff3d24f05384546403de57~0_cRyq1rl2381723817euoutp01J
X-AuditID: cbfec7f5-f95739c0000028a9-bc-5b1545daf0e7
From: Maciej Purski <m.purski@samsung.com>
To: Mark Brown <broonie@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, Carlos Hernandez <ceh@ti.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Maciej Purski <m.purski@samsung.com>
Subject: [PATCH 5/7] regulator: core: Lock dependent regulators
Date: Mon, 04 Jun 2018 15:59:22 +0200
Message-id: <1528120764-14316-6-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1528120764-14316-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsWy7djPc7q3XEWjDTZdlLaY+vAJm8W+vt9s
        FpseX2O1uLxrDpvF7CX9LBYLXt5isVh75C67xf4rXg4cHt++TmLx2LSqk81j85J6j74tqxg9
        jt/YzuTxeZNcAFsUl01Kak5mWWqRvl0CV8aOp2dZCqYrVXzdeYKtgfGLdBcjJ4eEgInEja0z
        2bsYuTiEBFYwSkxreAjlfGaUOP1qNxNM1YoLp6ASyxglfi/+DuX8Z5T4+msRcxcjBwebgJbE
        mvZ4kAYRAVeJ7z1nWUBqmAVuMEpcOXSeESQhLGAvcfDPeXYQm0VAVeJKzz5WEJtXwEXi9dWb
        rBDb5CRunutkBrE5gQa9nb2JESI+hU3i4C5BCNtFouHveajrhCVeHd/CDmHLSHR2HISK50u0
        PnsMFa+Q2Nd7Gmq+tcTh4xfBbGYBPolJ26aD3S8hwCvR0SYEUeIhseItyFqQH/cxSmw/tYBx
        AqPkAkaGVYziqaXFuempxcZ5qeV6xYm5xaV56XrJ+bmbGIHxePrf8a87GPf9STrEKMDBqMTD
        q2ElGi3EmlhWXJl7iFGCg1lJhPe0BVCINyWxsiq1KD++qDQntfgQozQHi5I4b5xGXZSQQHpi
        SWp2ampBahFMlomDU6qBMb/Qrm4Pyy7tl0mORjMtvvl5Lmnjqt49KVGWz87rvGhA/8EDDxUY
        BV71y6g+r6qIKFNtUZVnLi+7e2GXC7eFrn1GQ3G4j3ZY6Lo5AuvDrRS/ZVsF6S6Zuvz5o1it
        +F+Jek4CR7x/3YjLi85STOSadzUiveiqR5K8b5TIVINLhhvfdf5ad1WJpTgj0VCLuag4EQAD
        f49wwwIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjluLIzCtJLcpLzFFi42I5/e/4Nd1brqLRBg/aGS2mPnzCZrGv7zeb
        xabH11gtLu+aw2Yxe0k/i8WCl7dYLNYeuctusf+KlwOHx7evk1g8Nq3qZPPYvKTeo2/LKkaP
        4ze2M3l83iQXwBbFZZOSmpNZllqkb5fAlbHj6VmWgulKFV93nmBrYPwi3cXIySEhYCKx4sIp
        9i5GLg4hgSWMEls6fzKCJIQEGpkkPr5T7WLk4GAT0JJY0x4PEhYRcJX43nOWBaSeWeAWo8T6
        V0dZQBLCAvYSB/+cZwexWQRUJa707GMFsXkFXCReX73JCrFMTuLmuU5mEJsTaNDb2ZugdmVJ
        LLiyiHkCI88CRoZVjCKppcW56bnFhnrFibnFpXnpesn5uZsYgaG07djPzTsYL20MPsQowMGo
        xMOrYSUaLcSaWFZcmXuIUYKDWUmE97QFUIg3JbGyKrUoP76oNCe1+BCjNAeLkjjveYPKKCGB
        9MSS1OzU1ILUIpgsEwenVANjdkdxQF7pJakXKakub59Obp7yP9u/ol61W+PJkd2Xvm/aL92/
        jGdO1993U66LhH5kunOoxtNv2kmfIwuu/axN+fGFx95315rFdw1fPvn67J/jsnWJX/9Zat03
        uPJedZrO15u9kvGFp83nv1vHHNKs9yL90XrDbd/auaznis5kmXDq0EfGIyXRD5VYijMSDbWY
        i4oTAcaK6QYhAgAA
X-CMS-MailID: 20180604135954eucas1p2156fed3300b5514a4efa2baf9e7b9bc5
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180604135954eucas1p2156fed3300b5514a4efa2baf9e7b9bc5
References: <20180530144505.GB5705@atomide.com>
        <1528120764-14316-1-git-send-email-m.purski@samsung.com>
        <CGME20180604135954eucas1p2156fed3300b5514a4efa2baf9e7b9bc5@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implementing coupled regulators adds a new dependency between
regulators. Therefore, the current locking model should be changed.
Coupled regulators should be locked with regulator's supplies at the
same time.

Add new function regulator_lock_dependent(), which locks all regulators
related with the one, that is being changed.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 drivers/regulator/core.c | 75 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 52 insertions(+), 23 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 0b366c5..7c57268 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -201,38 +201,67 @@ static void regulator_unlock(struct regulator_dev *rdev)
 	}
 }
 
-/**
- * regulator_lock_supply - lock a regulator and its supplies
- * @rdev:         regulator source
- */
-static void regulator_lock_supply(struct regulator_dev *rdev)
+static int regulator_lock_recursive(struct regulator_dev *rdev,
+				    unsigned int subclass)
 {
+	struct regulator_dev *c_rdev;
 	int i;
 
-	for (i = 0; rdev; rdev = rdev_get_supply(rdev), i++)
-		regulator_lock_nested(rdev, i);
+	for (i = 0; i < rdev->coupling_desc.n_coupled; i++) {
+		c_rdev = rdev->coupling_desc.coupled_rdevs[i];
+
+		if (!c_rdev)
+			continue;
+
+		regulator_lock_nested(c_rdev, subclass++);
+
+		if (c_rdev->supply)
+			subclass =
+				regulator_lock_recursive(c_rdev->supply->rdev,
+							 subclass);
+	}
+
+	return subclass;
 }
 
 /**
- * regulator_unlock_supply - unlock a regulator and its supplies
- * @rdev:         regulator source
+ * regulator_unlock_dependent - unlock regulator's suppliers and coupled
+ *				regulators
+ * @rdev:			regulator source
+ *
+ * Unlock all regulators related with rdev by coupling or suppling.
  */
-static void regulator_unlock_supply(struct regulator_dev *rdev)
+static void regulator_unlock_dependent(struct regulator_dev *rdev)
 {
-	struct regulator *supply;
+	struct regulator_dev *c_rdev;
+	int i;
 
-	while (1) {
-		regulator_unlock(rdev);
-		supply = rdev->supply;
+	for (i = 0; i < rdev->coupling_desc.n_coupled; i++) {
+		c_rdev = rdev->coupling_desc.coupled_rdevs[i];
 
-		if (!rdev->supply)
-			return;
+		if (!c_rdev)
+			continue;
+
+		regulator_unlock(c_rdev);
 
-		rdev = supply->rdev;
+		if (c_rdev->supply)
+			regulator_unlock_dependent(c_rdev->supply->rdev);
 	}
 }
 
 /**
+ * regulator_lock_dependent - lock regulator's suppliers and coupled regulators
+ * @rdev:			regulator source
+ *
+ * This function as a wrapper on regulator_lock_recursive(), which locks
+ * all regulators related with rdev by coupling or suppling.
+ */
+static inline void regulator_lock_dependent(struct regulator_dev *rdev)
+{
+	regulator_lock_recursive(rdev, 0);
+}
+
+/**
  * of_get_regulator - get a regulator device node based on supply name
  * @dev: Device pointer for the consumer (of regulator) device
  * @supply: regulator supply name
@@ -3332,12 +3361,12 @@ int regulator_set_voltage(struct regulator *regulator, int min_uV, int max_uV)
 	int ret = 0;
 
 	pr_err("%s: %d\n", __func__, __LINE__);
-	regulator_lock_supply(regulator->rdev);
+	regulator_lock_dependent(regulator->rdev);
 
 	ret = regulator_set_voltage_unlocked(regulator, min_uV, max_uV,
 					     PM_SUSPEND_ON);
 
-	regulator_unlock_supply(regulator->rdev);
+	regulator_unlock_dependent(regulator->rdev);
 
 	return ret;
 }
@@ -3415,12 +3444,12 @@ int regulator_set_suspend_voltage(struct regulator *regulator, int min_uV,
 	if (regulator_check_states(state) || state == PM_SUSPEND_ON)
 		return -EINVAL;
 
-	regulator_lock_supply(regulator->rdev);
+	regulator_lock_dependent(regulator->rdev);
 
 	ret = _regulator_set_suspend_voltage(regulator, min_uV,
 					     max_uV, state);
 
-	regulator_unlock_supply(regulator->rdev);
+	regulator_unlock_dependent(regulator->rdev);
 
 	return ret;
 }
@@ -3612,11 +3641,11 @@ int regulator_get_voltage(struct regulator *regulator)
 {
 	int ret;
 
-	regulator_lock_supply(regulator->rdev);
+	regulator_lock_dependent(regulator->rdev);
 
 	ret = _regulator_get_voltage(regulator->rdev);
 
-	regulator_unlock_supply(regulator->rdev);
+	regulator_unlock_dependent(regulator->rdev);
 
 	return ret;
 }
-- 
2.7.4
