Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD2DC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 629C9208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544039481;
	bh=iWngFWtdnWJxlcIyZjSo4FvbuLVlCB/M4J7ubRJ7AWw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Eu8aEdUYH0+wY10hmVJmv82sO2MRgx09aMCq1qhJRSW/8W2a5kBH75bLpHEK9RbD0
	 ZmqfaaaCEQSp3J9A4LVkasgVsKZc68Nh7p0qBMQBtTHyTHHqaRWuNCd4GJ+qnYQYE/
	 lWyCkESwobT6GJ7QUxmsDFPh5qfaUw7XTiz3xbFE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 629C9208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbeLETvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:51:20 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40325 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728341AbeLETvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:51:17 -0500
Received: by mail-ot1-f65.google.com with SMTP id s5so19788289oth.7;
        Wed, 05 Dec 2018 11:51:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X9hiiVDsGIeZTKSEpJvxk+vVUqpbDP7GTYNGP9UlwcQ=;
        b=G5NE49d5P8Uk7p5yfyHdh01UhrIr7WUbFbjDSstRI1mgCwFTlmDTvGIn50yLjRnEAe
         XnButYyHED7Ic7Sre2knlBEgHaaaOd69TY9zqis/9oi7laC5prKzqAu20esbgvFvcFQD
         /gZY/quil+SDPtrg2MxsSyw7nxwJIzdzw1m6Lg1owXIxyDGG6ewHUx1BxoA1P4UUbrub
         j8NEhTBT0rSNxFF1YmWlyV2tL4jXSWpoE+xPb2N7bQjp7hPYORI1BHCfg/jilFNK4yT2
         9CT0BRKytT4AwUP6EF5a/IxhqMLMu7U2d1yuTMwdOpKc9KMZcDjxwVHnBUF0mvkJ/2kp
         RvsQ==
X-Gm-Message-State: AA+aEWZ6NgYu/Ahihg6UKWieXgrQMpUtaLNJTJwqZ8ddu/ozLSCI9q6F
        tEswBNeKfkSwzns9UDMT0IUC1/4=
X-Google-Smtp-Source: AFSGD/Vi6QHiKDzVbD8CKPuoJkWxXo1ig9x/rtwOcaS1N6eGeTsuZ9qqau6bn7vkPeInimWHA7dH3A==
X-Received: by 2002:a9d:bf7:: with SMTP id 110mr16864434oth.201.1544039476233;
        Wed, 05 Dec 2018 11:51:16 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id k13sm25759879otj.19.2018.12.05.11.51.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 11:51:15 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: [PATCH] sbus: Use of_node_name_eq for node name comparisons
Date:   Wed,  5 Dec 2018 13:50:38 -0600
Message-Id: <20181205195050.4759-22-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert string compares of DT node names to use of_node_name_eq helper
instead. This removes direct access to the node name pointer.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/sbus/char/bbc_envctrl.c | 4 ++--
 drivers/sbus/char/envctrl.c     | 6 +++---
 drivers/sbus/char/flash.c       | 6 +++---
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/sbus/char/bbc_envctrl.c b/drivers/sbus/char/bbc_envctrl.c
index fb5bcf6dddc1..4f2dd21e44a0 100644
--- a/drivers/sbus/char/bbc_envctrl.c
+++ b/drivers/sbus/char/bbc_envctrl.c
@@ -571,9 +571,9 @@ int bbc_envctrl_init(struct bbc_i2c_bus *bp)
 	int devidx = 0;
 
 	while ((op = bbc_i2c_getdev(bp, devidx++)) != NULL) {
-		if (!strcmp(op->dev.of_node->name, "temperature"))
+		if (of_node_name_eq(op->dev.of_node, "temperature"))
 			attach_one_temp(bp, op, temp_index++);
-		if (!strcmp(op->dev.of_node->name, "fan-control"))
+		if (of_node_name_eq(op->dev.of_node, "fan-control"))
 			attach_one_fan(bp, op, fan_index++);
 	}
 	if (temp_index != 0 && fan_index != 0) {
diff --git a/drivers/sbus/char/envctrl.c b/drivers/sbus/char/envctrl.c
index 56e962a01493..08b7d25c1136 100644
--- a/drivers/sbus/char/envctrl.c
+++ b/drivers/sbus/char/envctrl.c
@@ -906,7 +906,7 @@ static void envctrl_init_i2c_child(struct device_node *dp,
 		int len;
 
 		root_node = of_find_node_by_path("/");
-		if (!strcmp(root_node->name, "SUNW,UltraSPARC-IIi-cEngine")) {
+		if (of_node_name_eq(root_node, "SUNW,UltraSPARC-IIi-cEngine")) {
 			for (len = 0; len < PCF8584_MAX_CHANNELS; ++len) {
 				pchild->mon_type[len] = ENVCTRL_NOMON;
 			}
@@ -1037,10 +1037,10 @@ static int envctrl_probe(struct platform_device *op)
 	index = 0;
 	dp = op->dev.of_node->child;
 	while (dp) {
-		if (!strcmp(dp->name, "gpio")) {
+		if (of_node_name_eq(dp, "gpio")) {
 			i2c_childlist[index].i2ctype = I2C_GPIO;
 			envctrl_init_i2c_child(dp, &(i2c_childlist[index++]));
-		} else if (!strcmp(dp->name, "adc")) {
+		} else if (of_node_name_eq(dp, "adc")) {
 			i2c_childlist[index].i2ctype = I2C_ADC;
 			envctrl_init_i2c_child(dp, &(i2c_childlist[index++]));
 		}
diff --git a/drivers/sbus/char/flash.c b/drivers/sbus/char/flash.c
index a610b8d3d11f..515dc1ff1e33 100644
--- a/drivers/sbus/char/flash.c
+++ b/drivers/sbus/char/flash.c
@@ -165,9 +165,9 @@ static int flash_probe(struct platform_device *op)
 
 	parent = dp->parent;
 
-	if (strcmp(parent->name, "sbus") &&
-	    strcmp(parent->name, "sbi") &&
-	    strcmp(parent->name, "ebus"))
+	if (!of_node_name_eq(parent, "sbus") &&
+	    !of_node_name_eq(parent, "sbi") &&
+	    !of_node_name_eq(parent, "ebus"))
 		return -ENODEV;
 
 	flash.read_base = op->resource[0].start;
-- 
2.19.1

