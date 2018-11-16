Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A52C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 00:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9EC82145D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 00:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="k5mES5R5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9EC82145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389057AbeKPKtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 05:49:47 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40530 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbeKPKtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 05:49:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=zjfgjbsjJBrYMtgCGEnJNHWXgT4B4XjMT4GxPdW9nCY=; b=k5mES5R5vSNP
        OMgqk3wqpabXvfOv+zkbP3jL+p4H2Jd37QOL3+rLu5sC/zs6L9QzLRcdOT/RPIWe/jviESQJC31mV
        NHC5q1pDL1EgHXDh9s2RgaCNPtZUtaYy+Y22PAq+Cf022lO/lV5mSQWXoxMreowX1RCf6jeBQgteI
        keG2U=;
Received: from [64.114.255.97] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gNSAV-0006hu-HA; Fri, 16 Nov 2018 00:39:31 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id A386A440079; Fri, 16 Nov 2018 00:39:29 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     zoro <long17.cool@163.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator/of_get_regulator: add child path to find the regulator supplier" to the regulator tree
In-Reply-To: 
Message-Id: <20181116003929.A386A440079@finisterre.ee.mobilebroadband>
Date:   Fri, 16 Nov 2018 00:39:29 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator/of_get_regulator: add child path to find the regulator supplier

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From fe06051dbf8abf5962d9258c4a863056bdfa6eae Mon Sep 17 00:00:00 2001
From: zoro <long17.cool@163.com>
Date: Wed, 14 Nov 2018 17:38:22 +0800
Subject: [PATCH] regulator/of_get_regulator: add child path to find the
 regulator supplier

when the VIR_LDO1 regulator supplier is it's brother,
we can't find the supplier.

example code :
&vir_regulator {
	ldo0_vir: ldo0-virtual {
		regulator-compatible = "VIR_LDO0";
		regulator-name= "VIR_LDO0";
		regulator-min-microvolt = <1000000>;
		regulator-max-microvolt = <2000000>;
	};
	ldo1_vir: ldo1-virtual {
		regulator-compatible = "VIR_LDO1";
		regulator-name= "VIR_LDO1";
		regulator-min-microvolt = <1000000>;
		regulator-max-microvolt = <3000000>;
		ldo1-supply = <&ldo0_vir>;
	};
	...
}

so we add the child ptah to find the suppier.

Signed-off-by: zoro <long17.cool@163.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 2c66b528aede..55207264c212 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -227,6 +227,37 @@ static void regulator_unlock_supply(struct regulator_dev *rdev)
 	}
 }
 
+/**
+ * of_get_child_regulator - get a child regulator device node
+ * based on supply name
+ * @parent: Parent device node
+ * @prop_name: Combination regulator supply name and "-supply"
+ *
+ * Traverse all child nodes.
+ * Extract the child regulator device node corresponding to the supply name.
+ * returns the device node corresponding to the regulator if found, else
+ * returns NULL.
+ */
+static struct device_node *of_get_child_regulator(struct device_node *parent,
+						  const char *prop_name)
+{
+	struct device_node *regnode = NULL;
+	struct device_node *child = NULL;
+
+	for_each_child_of_node(parent, child) {
+		regnode = of_parse_phandle(child, prop_name, 0);
+
+		if (!regnode) {
+			regnode = of_get_child_regulator(child, prop_name);
+			if (regnode)
+				return regnode;
+		} else {
+			return regnode;
+		}
+	}
+	return NULL;
+}
+
 /**
  * of_get_regulator - get a regulator device node based on supply name
  * @dev: Device pointer for the consumer (of regulator) device
@@ -247,6 +278,10 @@ static struct device_node *of_get_regulator(struct device *dev, const char *supp
 	regnode = of_parse_phandle(dev->of_node, prop_name, 0);
 
 	if (!regnode) {
+		regnode = of_get_child_regulator(dev->of_node, prop_name);
+		if (regnode)
+			return regnode;
+
 		dev_dbg(dev, "Looking up %s property in node %pOF failed\n",
 				prop_name, dev->of_node);
 		return NULL;
-- 
2.19.1

