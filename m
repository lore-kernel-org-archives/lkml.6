Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA48C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF7A20850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544039601;
	bh=Gu92oQuTV35bJytEwIrFTFG3gBebF6n4WV6/5MgCXWs=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=1UOHI8lv2YIM6mv+aqzGha2jGNRgAUAKTJANgKJXDuWsSlXdGMSirU2sZWomkX1IW
	 FaKkh7Soiuqsgx4TTvjNPlJvrqdceJd9d0sVai2nJVJbInExkghnm2iuCVzIcz+gRm
	 5UvtwFzFlsfBOXuKDn6jxd5o6FfXJhsG+oYj9OZE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEF7A20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbeLETxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:53:20 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44968 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728667AbeLETvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:51:08 -0500
Received: by mail-oi1-f196.google.com with SMTP id m6so18611492oig.11;
        Wed, 05 Dec 2018 11:51:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nQc83SVC/fPoNgqivTxVXJ/5HoDZLYAlNXFAVWXqJR0=;
        b=DFM4ruFVs5O/c6K0jlgzew3lSis9bBhC/GSEcy3YdIEXxQGK7RfVmgYvEinQrcs1Ft
         qLenr2srZRBj7b2adnq0CKqpbBjl9zEVhlpgE1GVEAcJkgkDw98RRBOeH+4l67zKkZFr
         0Z3i28Z6phXE3rJzdYvplsPX7mAtokQyCAgJBUH7eTx3LOgKmxhDaU7RuIcwvO87D6jI
         unvC6avB95afBL//OjlwT8WMBSLd6iwkdGUi11OCCRYR9OnGWoTyVIiLk0FMS3lDLwIU
         DCoUVb1V+/06jqcooNCMlyEae8iCduMVWwFoFu/iCklp7ZpQFjc8E87Q6VAEZLBBQHQw
         E/vA==
X-Gm-Message-State: AA+aEWYmCRKTPaB3EcmL8x2UwvM5hCk2Su4cAx5xYp+ExwcHRV6j4oPW
        5Zzz4MY4Xl4XEh/qGWJEfnNcwUs=
X-Google-Smtp-Source: AFSGD/VP7W2lyt/2jSL/ogpRen+lJ47BD5YYmDLnQGt2EdLMx9xFUZpDKrzoJ1l5/6DAN9wI1UazKg==
X-Received: by 2002:aca:f103:: with SMTP id p3mr15094422oih.94.1544039467448;
        Wed, 05 Dec 2018 11:51:07 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id k13sm25759879otj.19.2018.12.05.11.51.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 11:51:06 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>
Subject: [PATCH] mfd: Use of_node_name_eq for node name comparisons
Date:   Wed,  5 Dec 2018 13:50:31 -0600
Message-Id: <20181205195050.4759-15-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert string compares of DT node names to use of_node_name_eq helper
instead. This removes direct access to the node name pointer.

Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/mfd/max77620.c |  2 +-
 drivers/mfd/stmpe.c    | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/max77620.c b/drivers/mfd/max77620.c
index d8217366ed36..d8ddd1a6f304 100644
--- a/drivers/mfd/max77620.c
+++ b/drivers/mfd/max77620.c
@@ -280,7 +280,7 @@ static int max77620_config_fps(struct max77620_chip *chip,
 
 	for (fps_id = 0; fps_id < MAX77620_FPS_COUNT; fps_id++) {
 		sprintf(fps_name, "fps%d", fps_id);
-		if (!strcmp(fps_np->name, fps_name))
+		if (of_node_name_eq(fps_np, fps_name))
 			break;
 	}
 
diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
index 566caca4efd8..7569a4be0608 100644
--- a/drivers/mfd/stmpe.c
+++ b/drivers/mfd/stmpe.c
@@ -1302,17 +1302,17 @@ static void stmpe_of_probe(struct stmpe_platform_data *pdata,
 	pdata->autosleep = (pdata->autosleep_timeout) ? true : false;
 
 	for_each_child_of_node(np, child) {
-		if (!strcmp(child->name, "stmpe_gpio")) {
+		if (of_node_name_eq(child, "stmpe_gpio")) {
 			pdata->blocks |= STMPE_BLOCK_GPIO;
-		} else if (!strcmp(child->name, "stmpe_keypad")) {
+		} else if (of_node_name_eq(child, "stmpe_keypad")) {
 			pdata->blocks |= STMPE_BLOCK_KEYPAD;
-		} else if (!strcmp(child->name, "stmpe_touchscreen")) {
+		} else if (of_node_name_eq(child, "stmpe_touchscreen")) {
 			pdata->blocks |= STMPE_BLOCK_TOUCHSCREEN;
-		} else if (!strcmp(child->name, "stmpe_adc")) {
+		} else if (of_node_name_eq(child, "stmpe_adc")) {
 			pdata->blocks |= STMPE_BLOCK_ADC;
-		} else if (!strcmp(child->name, "stmpe_pwm")) {
+		} else if (of_node_name_eq(child, "stmpe_pwm")) {
 			pdata->blocks |= STMPE_BLOCK_PWM;
-		} else if (!strcmp(child->name, "stmpe_rotator")) {
+		} else if (of_node_name_eq(child, "stmpe_rotator")) {
 			pdata->blocks |= STMPE_BLOCK_ROTATOR;
 		}
 	}
-- 
2.19.1

