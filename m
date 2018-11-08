Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3717BC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 05:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E86422086A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 05:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Y5lCkKTW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E86422086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbeKHPaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 10:30:24 -0500
Received: from m50-138.163.com ([123.125.50.138]:49830 "EHLO m50-138.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725724AbeKHPaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 10:30:23 -0500
X-Greylist: delayed 917 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Nov 2018 10:30:05 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=QO8vpMXgrlQhm2NLH+
        bmW/pzQSYs+GaIA30/yEidogI=; b=Y5lCkKTWUx7n2ljXWEd6o9vMXr3d42yTiF
        4TOLgXGYSdwsNvUD1OjSEfqNo/2Q2uCdE/Wy8sbommpepZWIVQkAhAv45Bcg2WHb
        P9WWi6MYriVj2KxpMGFQbcdEc/SJD1u+QFQqO9zHpq4EI1apoMig1kx4sjIhFHaH
        H0alr7Nu0=
Received: from localhost.localdomain (unknown [221.0.93.75])
        by smtp1 (Coremail) with SMTP id C9GowADX3GBVzONbLerEAw--.85S2;
        Thu, 08 Nov 2018 13:40:56 +0800 (CST)
From:   zoro <long17.cool@163.com>
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        zoro <long17.cool@163.com>
Subject: [PATCH] regulator/of_get_regulator: add child path to find the regulator supplier
Date:   Thu,  8 Nov 2018 13:40:35 +0800
Message-Id: <1541655635-11574-1-git-send-email-long17.cool@163.com>
X-Mailer: git-send-email 1.7.9.5
X-CM-TRANSID: C9GowADX3GBVzONbLerEAw--.85S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw45Jw1UJFy8XF4ftr15XFb_yoW8Ww48pa
        n8WF9xCFsY9FyxWw4Sk34Ika4Ygrn8C397Ar9Ykw4fCwn5Jas7Jr1DAF1Yy3Z5Jr4kGw4a
        yrW8Ar1xAF4UJrJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UlJPiUUUUU=
X-Originating-IP: [221.0.93.75]
X-CM-SenderInfo: 5orqwi2xof00ro6rljoofrz/1tbivgn4F1ZcTMQgzQAAs3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
        };

when the VIR_LDO1 regulator supplier is it's brother,
we can't find the supplier.
so we add the child ptah to find the suppier.

Signed-off-by: zoro <long17.cool@163.com>
---
 drivers/regulator/core.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 2c66b52..5dbfdba 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -239,6 +239,7 @@ static void regulator_unlock_supply(struct regulator_dev *rdev)
 static struct device_node *of_get_regulator(struct device *dev, const char *supply)
 {
 	struct device_node *regnode = NULL;
+	struct device_node *child = NULL;
 	char prop_name[32]; /* 32 is max size of property name */
 
 	dev_dbg(dev, "Looking up %s-supply from device tree\n", supply);
@@ -247,6 +248,11 @@ static struct device_node *of_get_regulator(struct device *dev, const char *supp
 	regnode = of_parse_phandle(dev->of_node, prop_name, 0);
 
 	if (!regnode) {
+		for_each_child_of_node(dev->of_node, child) {
+			regnode = of_parse_phandle(child, prop_name, 0);
+			if (regnode)
+				return regnode;
+		}
 		dev_dbg(dev, "Looking up %s property in node %pOF failed\n",
 				prop_name, dev->of_node);
 		return NULL;
-- 
1.7.9.5

