Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751664AbeEKV32 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 17:29:28 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:33424 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751313AbeEKV30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 17:29:26 -0400
From: Paul Cercueil <paul@crapouillou.net>
To: David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bolin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] mtd: nand: Add support for reading ooblayout from device tree
Date: Fri, 11 May 2018 23:29:12 +0200
Message-Id: <20180511212912.1426-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By specifying the properties "mtd-oob-ecc" and "mtd-oob-free", it is
now possible to specify from devicetree where the ECC data is located
inside the OOB region.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 Documentation/devicetree/bindings/mtd/nand.txt |  7 +++++
 drivers/mtd/nand/raw/nand_base.c               | 42 ++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/nand.txt b/Documentation/devicetree/bindings/mtd/nand.txt
index 8bb11d809429..118ea92787cb 100644
--- a/Documentation/devicetree/bindings/mtd/nand.txt
+++ b/Documentation/devicetree/bindings/mtd/nand.txt
@@ -45,6 +45,13 @@ Optional NAND chip properties:
 		     as reliable as possible.
 - nand-rb: shall contain the native Ready/Busy ids.
 
+- nand-oob-ecc: <offset, length> couples of integers, specifying the offset
+		     and length of the ECC data in the OOB region. There can be more
+		     than one couple.
+- nand-oob-free: <offset, length> couples of integers, specifying the offset
+		     and length of a free-to-use area in the OOB region. There can be
+		     more than one couple.
+
 The ECC strength and ECC step size properties define the correction capability
 of a controller. Together, they say a controller can correct "{strength} bit
 errors per {size} bytes".
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 72f3a89da513..c905531effb0 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -213,6 +213,43 @@ static const struct mtd_ooblayout_ops nand_ooblayout_lp_hamming_ops = {
 	.free = nand_ooblayout_free_lp_hamming,
 };
 
+static int nand_oob_of(struct device_node *np, int section,
+		       struct mtd_oob_region *oobregion, const char *prop)
+{
+	int ret = of_property_read_u32_index(np, prop,
+			section * 2, &oobregion->offset);
+	if (ret == -EOVERFLOW)
+		return -ERANGE; /* We're done */
+	if (ret)
+		return ret;
+
+	ret = of_property_read_u32_index(np, prop,
+			section * 2 + 1, &oobregion->length);
+	if (ret == -EOVERFLOW)
+		return -EINVAL; /* We must have an even number of integers */
+
+	return ret;
+}
+
+static int nand_ooblayout_ecc_of(struct mtd_info *mtd, int section,
+				 struct mtd_oob_region *oobregion)
+{
+	return nand_oob_of(mtd->dev.of_node, section,
+			oobregion, "nand-oob-ecc");
+}
+
+static int nand_ooblayout_free_of(struct mtd_info *mtd, int section,
+				 struct mtd_oob_region *oobregion)
+{
+	return nand_oob_of(mtd->dev.of_node, section,
+			oobregion, "nand-oob-free");
+}
+
+static const struct mtd_ooblayout_ops nand_ooblayout_of_ops = {
+	.ecc = nand_ooblayout_ecc_of,
+	.free = nand_ooblayout_free_of,
+};
+
 static int check_offs_len(struct mtd_info *mtd,
 					loff_t ofs, uint64_t len)
 {
@@ -5843,6 +5880,11 @@ static int nand_dt_init(struct nand_chip *chip)
 	if (of_property_read_bool(dn, "nand-ecc-maximize"))
 		chip->ecc.options |= NAND_ECC_MAXIMIZE;
 
+	if (!chip->mtd.ooblayout &&
+				of_property_read_bool(dn, "nand-oob-ecc") &&
+				of_property_read_bool(dn, "nand-oob-free"))
+		chip->mtd.ooblayout = &nand_ooblayout_of_ops;
+
 	return 0;
 }
 
-- 
2.11.0
