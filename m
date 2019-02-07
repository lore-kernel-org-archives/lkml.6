Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8906FC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 523E921721
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549570511;
	bh=YmNGYrTHGPJ4Cusqf/ilxLeBLelJE/GXqm0uPK/J6ns=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=K3I2R14ivIUJk/yy50vCgFr8t+PHamP3fGKMSJ8FBzEexsoLX01FcLzOhigYLSes9
	 1F612h3+L5t9/xwohltIBdJBId18hrPzK9v+h2cFt6/T9DvrYcgCAN1XCcD9w7h2uh
	 vofkzE2QCoOE6TZoe5XWEPCQLuImdQjJA/qXvCtA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfBGUPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 15:15:09 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42581 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfBGUPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 15:15:09 -0500
Received: by mail-ot1-f66.google.com with SMTP id v23so2025509otk.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 12:15:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E0m8E4W3EbjxDKWEYI2e0ISoeX38gi4ZsTr/7fRHC3E=;
        b=RXFF76W7GZEQclcgfWutHhetaSK9t3rjakdeRY3Xb6tRdYuQTdm8QN1torKMpiqGd+
         6Ud0EhhjgcDPTUHL5qBfHNVA0lofzRT60tJqyfvMZ5fSI0ANqo9lmwZP7BAojIu/Ktnk
         7dATsd3Y/opJjnySf4X2TglwdJqPym51NZKXhjKcPHoYAxnXpvUaz8YL0GLavA1fhg4w
         A4dMe235G+K9jbhBFhRORnBx818PgbLMuCcsftDCHcnZqZuL4PZ9399ub6q8dqFR/Oq4
         1zRk5w3WrH3R2CrY+hcD3dLGgAIttZr1yV3ZYWNJsR761QqrNM+iwlrFhw9KLvy9mHMV
         sTKQ==
X-Gm-Message-State: AHQUAuacqjYvi3YPs87xEgW+hb14vUqNKp6Cxc0NX54aptm1uEeoInRR
        pkTucuINTVb28UeC559bR+8MGA==
X-Google-Smtp-Source: AHgI3IZB+5McvwO+deN0U07MwwGILByt+8je6f4tx+5eh7UjCP2Xt37PryRBaukfTkBwKCS+EOtgRQ==
X-Received: by 2002:a9d:2062:: with SMTP id n89mr1994734ota.244.1549570508481;
        Thu, 07 Feb 2019 12:15:08 -0800 (PST)
Received: from localhost ([130.164.62.200])
        by smtp.gmail.com with ESMTPSA id 187sm13064637oic.12.2019.02.07.12.15.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 12:15:07 -0800 (PST)
From:   Moritz Fischer <mdf@kernel.org>
To:     netdev@vger.kernel.org
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v2 net-next] net: fixed-phy: Add fixed_phy_register_with_gpiod() API
Date:   Thu,  7 Feb 2019 12:14:55 -0800
Message-Id: <20190207201455.25071-1-mdf@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add fixed_phy_register_with_gpiod() API. It lets users create a
fixed_phy instance that uses a GPIO descriptor which was obtained
externally e.g. through platform data.
This enables platform devices (non-DT based) to use GPIOs for link
status.

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---

Changes from v1:
- Added Florian's Reviewed-by: tag

Changes from RFC:
- Implemented Andrew's/Florians suggestion to add new API
  instead of changing old API

---
 drivers/net/phy/fixed_phy.c | 32 +++++++++++++++++++++++++-------
 include/linux/phy_fixed.h   | 15 +++++++++++++++
 2 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/fixed_phy.c b/drivers/net/phy/fixed_phy.c
index d810f914aaa4..b0d1368c3400 100644
--- a/drivers/net/phy/fixed_phy.c
+++ b/drivers/net/phy/fixed_phy.c
@@ -229,12 +229,12 @@ static struct gpio_desc *fixed_phy_get_gpiod(struct device_node *np)
 }
 #endif
 
-struct phy_device *fixed_phy_register(unsigned int irq,
-				      struct fixed_phy_status *status,
-				      struct device_node *np)
+static struct phy_device *__fixed_phy_register(unsigned int irq,
+					       struct fixed_phy_status *status,
+					       struct device_node *np,
+					       struct gpio_desc *gpiod)
 {
 	struct fixed_mdio_bus *fmb = &platform_fmb;
-	struct gpio_desc *gpiod = NULL;
 	struct phy_device *phy;
 	int phy_addr;
 	int ret;
@@ -243,9 +243,11 @@ struct phy_device *fixed_phy_register(unsigned int irq,
 		return ERR_PTR(-EPROBE_DEFER);
 
 	/* Check if we have a GPIO associated with this fixed phy */
-	gpiod = fixed_phy_get_gpiod(np);
-	if (IS_ERR(gpiod))
-		return ERR_CAST(gpiod);
+	if (!gpiod) {
+		gpiod = fixed_phy_get_gpiod(np);
+		if (IS_ERR(gpiod))
+			return ERR_CAST(gpiod);
+	}
 
 	/* Get the next available PHY address, up to PHY_MAX_ADDR */
 	phy_addr = ida_simple_get(&phy_fixed_ida, 0, PHY_MAX_ADDR, GFP_KERNEL);
@@ -308,8 +310,24 @@ struct phy_device *fixed_phy_register(unsigned int irq,
 
 	return phy;
 }
+
+struct phy_device *fixed_phy_register(unsigned int irq,
+				      struct fixed_phy_status *status,
+				      struct device_node *np)
+{
+	return __fixed_phy_register(irq, status, np, NULL);
+}
 EXPORT_SYMBOL_GPL(fixed_phy_register);
 
+struct phy_device *
+fixed_phy_register_with_gpiod(unsigned int irq,
+			      struct fixed_phy_status *status,
+			      struct gpio_desc *gpiod)
+{
+	return __fixed_phy_register(irq, status, NULL, gpiod);
+}
+EXPORT_SYMBOL_GPL(fixed_phy_register_with_gpiod);
+
 void fixed_phy_unregister(struct phy_device *phy)
 {
 	phy_device_remove(phy);
diff --git a/include/linux/phy_fixed.h b/include/linux/phy_fixed.h
index c78fc203db43..1e5d86ebdaeb 100644
--- a/include/linux/phy_fixed.h
+++ b/include/linux/phy_fixed.h
@@ -19,6 +19,12 @@ extern int fixed_phy_add(unsigned int irq, int phy_id,
 extern struct phy_device *fixed_phy_register(unsigned int irq,
 					     struct fixed_phy_status *status,
 					     struct device_node *np);
+
+extern struct phy_device *
+fixed_phy_register_with_gpiod(unsigned int irq,
+			      struct fixed_phy_status *status,
+			      struct gpio_desc *gpiod);
+
 extern void fixed_phy_unregister(struct phy_device *phydev);
 extern int fixed_phy_set_link_update(struct phy_device *phydev,
 			int (*link_update)(struct net_device *,
@@ -35,6 +41,15 @@ static inline struct phy_device *fixed_phy_register(unsigned int irq,
 {
 	return ERR_PTR(-ENODEV);
 }
+
+static inline struct phy_device *
+fixed_phy_register_with_gpiod(unsigned int irq,
+			      struct fixed_phy_status *status,
+			      struct gpio_desc *gpiod)
+{
+	return ERR_PTR(-ENODEV);
+}
+
 static inline void fixed_phy_unregister(struct phy_device *phydev)
 {
 }
-- 
2.20.1

