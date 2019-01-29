Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259D8C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7944214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="IS8C+n3s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbfA2I4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:56:18 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:4764 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbfA2I4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 03:56:16 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5015070002>; Tue, 29 Jan 2019 00:55:35 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 29 Jan 2019 00:56:15 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 29 Jan 2019 00:56:15 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 29 Jan
 2019 08:56:14 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 29 Jan
 2019 08:56:14 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 29 Jan 2019 08:56:14 +0000
Received: from localhost.localdomain (Not Verified[10.19.225.143]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c50152b0006>; Tue, 29 Jan 2019 00:56:14 -0800
From:   Mark Zhang <markz@nvidia.com>
To:     <lee.jones@linaro.org>, <blaws05@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-tegra@vger.kernel.org>, Mark Zhang <markz@nvidia.com>,
        "Laxman Dewangan" <ldewangan@nvidia.com>,
        Venkat Reddy Talla <vreddytalla@nvidia.com>
Subject: [PATCH v2 3/4] mfd: max77620: Add low battery monitor support
Date:   Tue, 29 Jan 2019 16:55:30 +0800
Message-ID: <20190129085531.32364-4-markz@nvidia.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190129085531.32364-1-markz@nvidia.com>
References: <20190129085531.32364-1-markz@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548752136; bh=BgG6FUugC1CevREJ1krBzbps1BGj7dMGa+3M+zudQjU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=IS8C+n3sj6zoBQx9m0diEhLB9G43DtLLPVrvriYTNg0MaJXC+osEaZPBlQfhwytr8
         dT8ssw94ROFIZJ3oV8oD6rcAogg/B0jSVbnxt1w4X2eFsxGujrR7p/53AiCIdvRwC0
         3ShL+okLBCIObiDnZIQCDrHxFIpY74NmcZdp5T5tWZKRQPzF8jxE2q6MRHyjKWKMaZ
         qldGwWtjxMEsVU0jp4iE4Ix0Ra81xAwIbZSphNqljGf4JP4fUjfhR8/WCGBDy4jJKT
         dp7KKObDwSA8LKOmXnOrlwfofHX3gGXwzb0jTXdVlUTFtFv++vrxgp/uHN9oKqThjJ
         QWM+dQTtsY9IA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds PMIC configurations for low-battery
monitoring by handling max77620 register CNFGGLBL1.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Signed-off-by: Venkat Reddy Talla <vreddytalla@nvidia.com>
Signed-off-by: Mark Zhang <markz@nvidia.com>
---
 drivers/mfd/max77620.c | 57 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/max77620.c b/drivers/mfd/max77620.c
index f58143103185..9e50d145afd8 100644
--- a/drivers/mfd/max77620.c
+++ b/drivers/mfd/max77620.c
@@ -474,6 +474,57 @@ static int max77620_init_backup_battery_charging(struc=
t max77620_chip *chip)
 	return ret;
 }
=20
+static int max77620_init_low_battery_monitor(struct max77620_chip *chip)
+{
+	struct device *dev =3D chip->dev;
+	struct device_node *np;
+	bool pval;
+	u8 mask =3D 0;
+	u8 val =3D 0;
+	int ret;
+
+	np =3D of_get_child_by_name(dev->of_node, "low-battery-monitor");
+	if (!np) {
+		dev_info(dev, "Low battery monitoring support disabled\n");
+		return 0;
+	}
+
+	pval =3D of_property_read_bool(np, "maxim,low-battery-dac-enable");
+	if (pval) {
+		mask |=3D MAX77620_CNFGGLBL1_LBDAC_EN;
+		val |=3D MAX77620_CNFGGLBL1_LBDAC_EN;
+	}
+
+	pval =3D of_property_read_bool(np, "maxim,low-battery-dac-disable");
+	if (pval)
+		mask |=3D MAX77620_CNFGGLBL1_LBDAC_EN;
+
+	pval =3D of_property_read_bool(np, "maxim,low-battery-shutdown-enable");
+	if (pval) {
+		mask |=3D MAX77620_CNFGGLBL1_MPPLD;
+		val |=3D MAX77620_CNFGGLBL1_MPPLD;
+	}
+
+	pval =3D of_property_read_bool(np, "maxim,low-battery-shutdown-disable");
+	if (pval)
+		mask |=3D MAX77620_CNFGGLBL1_MPPLD;
+
+	pval =3D of_property_read_bool(np, "maxim,low-battery-reset-enable");
+	if (pval) {
+		mask |=3D MAX77620_CNFGGLBL1_LBRSTEN;
+		val |=3D MAX77620_CNFGGLBL1_LBRSTEN;
+	}
+
+	pval =3D of_property_read_bool(np, "maxim,low-battery-reset-disable");
+	if (pval)
+		mask |=3D MAX77620_CNFGGLBL1_LBRSTEN;
+
+	ret =3D regmap_update_bits(chip->rmap, MAX77620_REG_CNFGGLBL1, mask, val)=
;
+	if (ret < 0)
+		dev_err(dev, "Reg CNFGGLBL1 update failed: %d\n", ret);
+	return ret;
+}
+
 static int max77620_read_es_version(struct max77620_chip *chip)
 {
 	unsigned int val;
@@ -563,7 +614,11 @@ static int max77620_probe(struct i2c_client *client,
 	if (ret < 0)
 		return ret;
=20
-	ret =3D  devm_mfd_add_devices(chip->dev, PLATFORM_DEVID_NONE,
+	ret =3D max77620_init_low_battery_monitor(chip);
+	if (ret < 0)
+		return ret;
+
+	ret =3D devm_mfd_add_devices(chip->dev, PLATFORM_DEVID_NONE,
 				    mfd_cells, n_mfd_cells, NULL, 0,
 				    regmap_irq_get_domain(chip->top_irq_data));
 	if (ret < 0) {
--=20
2.19.2

