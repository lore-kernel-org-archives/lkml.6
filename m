Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF37CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 05:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75D0221722
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 05:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="axBrE55N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75D0221722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731521AbeKLPpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 10:45:07 -0500
Received: from m50-135.163.com ([123.125.50.135]:56750 "EHLO m50-135.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731004AbeKLPpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 10:45:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=FgcRd2b4juOl77/Wq+
        fjJ8rXj5ZhF0dhwhk50Q27hZ4=; b=axBrE55NvPPZaahsECJ/TlLGrjx8YnkUX2
        EHdHoTtn+4Aj6j1u6gyN4IL0GXJ8WAYENjFveEDT/i3039OGUVl1G2bRh5AiWOGH
        q2yDGVP3QjHovByM5il8IlzAX1vBpZ/OOjcZYo2X+dTP7hCoVAg9WCx6VTSh8+Kc
        WqHroRly8=
Received: from localhost.localdomain (unknown [221.0.93.75])
        by smtp5 (Coremail) with SMTP id D9GowADnSFRGFelbfYSgAQ--.50S2;
        Mon, 12 Nov 2018 13:53:20 +0800 (CST)
From:   zoro <long17.cool@163.com>
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        zoro <long17.cool@163.com>
Subject: [PATCH 4/4] regulator/of_get_regulator: add child path to find the regulator supplier
Date:   Mon, 12 Nov 2018 13:53:07 +0800
Message-Id: <1542001987-8352-1-git-send-email-long17.cool@163.com>
X-Mailer: git-send-email 1.7.9.5
X-CM-TRANSID: D9GowADnSFRGFelbfYSgAQ--.50S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw45Jw1UJFy8XF4ftr15XFb_yoW8Kw17pr
        4DWF9IkrsY9a4xuw4Syr12ya4Ygrn5Ca97Ar95Gw4fC3s5Jas3Jr1UAF1Yv3Z5Jr4kGw4j
        yrW8AF1xCF15XFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UBBTrUUUUU=
X-Originating-IP: [221.0.93.75]
X-CM-SenderInfo: 5orqwi2xof00ro6rljoofrz/1tbiDRD8F1QHKm73IwAAs1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
	}
	...
}

so we add the child ptah to find the suppier.

Signed-off-by: zoro <long17.cool@163.com>
---
 drivers/regulator/core.c |   33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 2c66b52..d328a84 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -228,6 +228,35 @@ static void regulator_unlock_supply(struct regulator_dev *rdev)
 }
 
 /**
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
+	const char *prop_name)
+{
+	struct device_node *regnode = NULL;
+	struct device_node *child = NULL;
+
+	for_each_child_of_node(parent, child) {
+		regnode = of_parse_phandle(child, prop_name, 0);
+		if (!regnode) {
+			regnode = of_get_child_regulator(child, prop_name);
+			if (regnode)
+				return regnode;
+		} else
+			return regnode;
+	}
+	return NULL;
+}
+
+/**
  * of_get_regulator - get a regulator device node based on supply name
  * @dev: Device pointer for the consumer (of regulator) device
  * @supply: regulator supply name
@@ -247,6 +276,10 @@ static struct device_node *of_get_regulator(struct device *dev, const char *supp
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
1.7.9.5


