Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF52C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99D132083B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549561945;
	bh=VXuIkLPO7UHZKLQ+DASIWxC1QL4CafOhPc0zebpltzQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=yWyK8jUwyOVAlaiDbWlFV18bxEMGEeOpkhVB4g4X4OIim2avw/gR63abeIZbh9Nus
	 ldlf8ztKf83ZuUacs7KOd1G4P9ScFFGnmW7Y1GdABPXb7SyTHhAwmYsVLoCo/0qZ9f
	 s1ptNYkJ8WBQXXnovFTAyIa+t7OfWwf4HO2ux9WM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfBGRwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 12:52:24 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42552 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfBGRwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 12:52:23 -0500
Received: by mail-ot1-f65.google.com with SMTP id v23so1233442otk.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 09:52:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=czzHZm0V8GUPBg6n38wNMyj3O57s5Ayi7nWM0gcUkzg=;
        b=iNu/92hKOuysEL7JUhpAQ2Xq5vrh7DebcUH+dthbCR4fTRhndnuY3zmmjecapQzPmc
         ug0fS0asKTZRUcWyM/+oHQlRUIcSklU7xD5s/5tFFdnG8Klhkow3EiiA3IbmBk7AOk7N
         YP5Fpdm/qGs2wNs7o9SZBX7ReJ/C/k4EM8luT5ricE/hXfKxAoEZKHj7nxTub7lGvAvR
         62vxnf7EPYJC7Hf7gfdrR0rUNbpkSQdJWqQgHCyq0Wylom9gN3DCixzW0YfiaKKPFgQk
         oM3CRfijpjPCOFoXHyTZlyG3O8rSP7irlaskjFzJ6GyzvF5caDeD+4ILEWkUlhmBVuUb
         jFPQ==
X-Gm-Message-State: AHQUAubQlmCBdGQDdY6sLWC0uDHfdOrDptGIjUK/8Uy3P/1sCOLVTQen
        N6LRrMRNhkzXfVRenW2+/ycC6+BBqfo=
X-Google-Smtp-Source: AHgI3IaxHkaFK5xSW8UrOXXzLHFu+0ceKP0mAAl1TjA7ogQnaWlqgVzznhTfRy6ly4h8nwfOk8YK+g==
X-Received: by 2002:a9d:7285:: with SMTP id t5mr9863479otj.228.1549561942483;
        Thu, 07 Feb 2019 09:52:22 -0800 (PST)
Received: from localhost ([130.164.62.200])
        by smtp.gmail.com with ESMTPSA id m207sm11960617oig.2.2019.02.07.09.52.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 09:52:21 -0800 (PST)
From:   Moritz Fischer <mdf@kernel.org>
To:     andrew@lunn.ch
Cc:     f.fainelli@gmail.com, hkallweit1@gmail.com, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH net-next] net: fixed-phy: Add fixed_phy_register_with_gpiod() API
Date:   Thu,  7 Feb 2019 09:52:10 -0800
Message-Id: <20190207175210.9309-1-mdf@kernel.org>
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

Signed-off-by: Moritz Fischer <mdf@kernel.org>
---

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

