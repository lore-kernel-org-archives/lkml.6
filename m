Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B2EC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99AE214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="pAF86/L2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbfA2I4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:56:11 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:2024 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbfA2I4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 03:56:10 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c50152a0001>; Tue, 29 Jan 2019 00:56:10 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 29 Jan 2019 00:56:09 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 29 Jan 2019 00:56:09 -0800
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 29 Jan
 2019 08:56:09 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 29 Jan 2019 08:56:08 +0000
Received: from localhost.localdomain (Not Verified[10.19.225.143]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c5015260002>; Tue, 29 Jan 2019 00:56:08 -0800
From:   Mark Zhang <markz@nvidia.com>
To:     <lee.jones@linaro.org>, <blaws05@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-tegra@vger.kernel.org>, Mark Zhang <markz@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Venkat Reddy Talla <vreddytalla@nvidia.com>
Subject: [PATCH v2 1/4] mfd: max77620: Add backup battery charger support
Date:   Tue, 29 Jan 2019 16:55:28 +0800
Message-ID: <20190129085531.32364-2-markz@nvidia.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190129085531.32364-1-markz@nvidia.com>
References: <20190129085531.32364-1-markz@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548752170; bh=OUDyElPhiPwMVEx8CTwkTQaz+hQEf3MSZtYJeqdam4Y=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=pAF86/L2m8P2dYwJRqXXYnVclp7zOdiFSlhpawszWnzcWfUY4TUeDURVBnCneNZkX
         vLTG0gO9kNGvlPVpO3tnk1tGhrL/VbNfcajeGB+qx3dDkRioAvKNJQE5/EwxvIdomF
         SruJpt2TeTfmeGSgA/C280nnWJ891gcRl7UIbe2lPfyw4zkiQc3NsAyVtxSdfkF2Re
         PawlLfgF8Z00CyRVEB8FG503TtmYGKQlSdpMbm3SWVc6SZfrg7UpXVXu/6q7duJ06l
         L2zQVfa3O8o0XFuGm9RBIWEm4M87iXOx9IBDPbclmhsfGKyLmYVvvz9t3SmZJFSkgj
         CQPFT0UySGMAQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PMIC configurations for backup battery charger, which
is a constant voltage and constant current style charger
with a series output resistance.

The max77620 register CNFGBBC(addr: 0x04) defines the
parameters of backup battery charger. This patch adds
support for it.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Signed-off-by: Venkat Reddy Talla <vreddytalla@nvidia.com>
Signed-off-by: Mark Zhang <markz@nvidia.com>
---
 drivers/mfd/max77620.c | 80 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/drivers/mfd/max77620.c b/drivers/mfd/max77620.c
index d8ddd1a6f304..f58143103185 100644
--- a/drivers/mfd/max77620.c
+++ b/drivers/mfd/max77620.c
@@ -398,6 +398,82 @@ static int max77620_initialise_fps(struct max77620_chi=
p *chip)
 	return 0;
 }
=20
+static int max77620_init_backup_battery_charging(struct max77620_chip *chi=
p)
+{
+	struct device *dev =3D chip->dev;
+	struct device_node *np;
+	u32 pval;
+	u8 config;
+	int charging_current;
+	int charging_voltage;
+	int resistor;
+	int ret;
+
+	np =3D of_get_child_by_name(dev->of_node, "backup-battery");
+	if (!np) {
+		dev_info(dev, "Backup battery charging support disabled\n");
+		ret =3D regmap_update_bits(chip->rmap, MAX77620_REG_CNFGBBC,
+					 MAX77620_CNFGBBC_ENABLE, 0);
+		if (ret < 0)
+			dev_err(dev, "Failed to update CNFGBBC: %d\n", ret);
+		return ret;
+	}
+
+	ret =3D of_property_read_u32(np,
+			"maxim,backup-battery-charging-current", &pval);
+	charging_current =3D (!ret) ? pval : 50;
+
+	ret =3D of_property_read_u32(np,
+			"maxim,backup-battery-charging-voltage", &pval);
+	charging_voltage =3D (!ret) ? pval : 2500000;
+	charging_voltage /=3D 1000;
+
+	ret =3D of_property_read_u32(np,
+			"maxim,backup-battery-output-resister", &pval);
+	resistor =3D (!ret) ? pval : 1000;
+
+	config =3D MAX77620_CNFGBBC_ENABLE;
+	if (charging_current <=3D 50)
+		config |=3D 0 << MAX77620_CNFGBBC_CURRENT_SHIFT;
+	else if (charging_current <=3D 100)
+		config |=3D 3 << MAX77620_CNFGBBC_CURRENT_SHIFT;
+	else if (charging_current <=3D 200)
+		config |=3D 0 << MAX77620_CNFGBBC_CURRENT_SHIFT;
+	else if (charging_current <=3D 400)
+		config |=3D 3 << MAX77620_CNFGBBC_CURRENT_SHIFT;
+	else if (charging_current <=3D 600)
+		config |=3D 1 << MAX77620_CNFGBBC_CURRENT_SHIFT;
+	else
+		config |=3D 2 << MAX77620_CNFGBBC_CURRENT_SHIFT;
+
+	if (charging_current > 100)
+		config |=3D MAX77620_CNFGBBC_LOW_CURRENT_DISABLE;
+
+	if (charging_voltage <=3D 2500)
+		config |=3D 0 << MAX77620_CNFGBBC_VOLTAGE_SHIFT;
+	else if (charging_voltage <=3D 3000)
+		config |=3D 1 << MAX77620_CNFGBBC_VOLTAGE_SHIFT;
+	else if (charging_voltage <=3D 3300)
+		config |=3D 2 << MAX77620_CNFGBBC_VOLTAGE_SHIFT;
+	else
+		config |=3D 3 << MAX77620_CNFGBBC_VOLTAGE_SHIFT;
+
+	if (resistor <=3D 100)
+		config |=3D 0 << MAX77620_CNFGBBC_RESISTOR_SHIFT;
+	else if (resistor <=3D 1000)
+		config |=3D 1 << MAX77620_CNFGBBC_RESISTOR_SHIFT;
+	else if (resistor <=3D 3000)
+		config |=3D 2 << MAX77620_CNFGBBC_RESISTOR_SHIFT;
+	else if (resistor <=3D 6000)
+		config |=3D 3 << MAX77620_CNFGBBC_RESISTOR_SHIFT;
+
+	ret =3D regmap_write(chip->rmap, MAX77620_REG_CNFGBBC, config);
+	if (ret < 0)
+		dev_err(dev, "Reg 0x%02x write failed, %d\n",
+				MAX77620_REG_CNFGBBC, ret);
+	return ret;
+}
+
 static int max77620_read_es_version(struct max77620_chip *chip)
 {
 	unsigned int val;
@@ -483,6 +559,10 @@ static int max77620_probe(struct i2c_client *client,
 	if (ret < 0)
 		return ret;
=20
+	ret =3D max77620_init_backup_battery_charging(chip);
+	if (ret < 0)
+		return ret;
+
 	ret =3D  devm_mfd_add_devices(chip->dev, PLATFORM_DEVID_NONE,
 				    mfd_cells, n_mfd_cells, NULL, 0,
 				    regmap_irq_get_domain(chip->top_irq_data));
--=20
2.19.2

