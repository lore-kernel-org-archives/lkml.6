Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1571C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF2120823
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6I2K+ax"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbfBUPqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:46:44 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34066 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbfBUPqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 10:46:42 -0500
Received: by mail-wr1-f68.google.com with SMTP id f14so31238122wrg.1;
        Thu, 21 Feb 2019 07:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=20WKRsSfTrf5aBYjOI8r3Skz9h4IzNSQWOqvPDnaEuw=;
        b=M6I2K+axK+yFAnKhw1XaRMq3aVSplkIcb3gSaUgToyTFYBKrvgBK02hCz4RHeoWWgQ
         5UqX3VIx/G4ZvoBScb8tv6qdsN9+Gd2KaiwIROXEccnu4rPIVhEgse9Zdfnsv6tk8+JO
         jFAUKr5IHVYo/mWhGAX9koGFXLRcLqAUHbcCp5N7iDIuh2a6xhOcWx5KAdE2u4hhJHvy
         bzHFQ7M1+qNnDZ58k6VLTxQU4gXP2OGggs07Yube6bCP9/zIGRS4leDYCBpJYrbxgYKs
         4jvJoE4HtSj9QRNS6O7HvgU3RnLYnfRBWRT7P8SqgfONDyMPi4JP6YOVe8mR83QM23+p
         uYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=20WKRsSfTrf5aBYjOI8r3Skz9h4IzNSQWOqvPDnaEuw=;
        b=s+gjstF5NBmZB57tkzJp+67vW5Y68+2xB8+Yzq5On4qiMm/Bz2PtT/D+gYvOJaPXFW
         1XrYWoAj2Z7Sq1NmlXKuZXbqIEN/8eTEqgKOItzAccVUiVaLv9cpmJTfrUxwYRo0KRWw
         l+7OmZFb8bKhlvn8hFYKFqnVKq9EED9k0CwYu5VdpoSfSxrdGD89NIPN1ip+cP+PKD3T
         wy7IHcgZLqmrF+YZKvbAdVgABUnIWCMJQFLGBH2vh3j22Y2JwPjKJ7JaY4SncEuc7rW3
         Xp9M05NKif3YaWfQYFP0ik9KfokKEJShrvtIkEh3nCcck9nO1+yxm6bq/IKBufsbk/iI
         doMw==
X-Gm-Message-State: AHQUAuaOGgEzW3EZJ8mVpjLaJGj7tiuA59yfLfKcl6ad7nQQKdU0ynlF
        vcM3IncrjhNkC7gjguvhTJc=
X-Google-Smtp-Source: AHgI3IY0/4kYSPgbnUOI4HK58/r3/Hv913q+5wDnEZH1TvHclz7EWqlUBXt36NkhHDFCE4qltPD90w==
X-Received: by 2002:a05:6000:1c2:: with SMTP id t2mr18584708wrx.109.1550764000699;
        Thu, 21 Feb 2019 07:46:40 -0800 (PST)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id v4sm9771208wmg.1.2019.02.21.07.46.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 07:46:40 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>, JC Kuo <jckuo@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] phy: tegra: xusb: Parse dual-role mode property
Date:   Thu, 21 Feb 2019 16:46:32 +0100
Message-Id: <20190221154634.10684-4-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221154634.10684-1-thierry.reding@gmail.com>
References: <20190221154634.10684-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The device tree bindings document the "mode" property of "ports"
subnodes, but the driver was not parsing the property. In preparation
for adding role switching, parse the property at probe time.

Based on work by JC Kuo <jckuo@nvidia.com>.

Reviewed-by: JC Kuo <jckuo@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/phy/tegra/xusb.c | 21 +++++++++++++++++++++
 drivers/phy/tegra/xusb.h |  3 +++
 2 files changed, 24 insertions(+)

diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index e3bc60cfe6a1..57a2d08ef6da 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -546,13 +546,34 @@ static void tegra_xusb_port_unregister(struct tegra_xusb_port *port)
 	device_unregister(&port->dev);
 }
 
+static const char *const modes[] = {
+	[USB_DR_MODE_UNKNOWN] = "",
+	[USB_DR_MODE_HOST] = "host",
+	[USB_DR_MODE_PERIPHERAL] = "peripheral",
+	[USB_DR_MODE_OTG] = "otg",
+};
+
 static int tegra_xusb_usb2_port_parse_dt(struct tegra_xusb_usb2_port *usb2)
 {
 	struct tegra_xusb_port *port = &usb2->base;
 	struct device_node *np = port->dev.of_node;
+	const char *mode;
 
 	usb2->internal = of_property_read_bool(np, "nvidia,internal");
 
+	if (!of_property_read_string(np, "mode", &mode)) {
+		int err = match_string(modes, ARRAY_SIZE(modes), mode);
+		if (err < 0) {
+			dev_err(&port->dev, "invalid value %s for \"mode\"\n",
+				mode);
+			usb2->mode = USB_DR_MODE_UNKNOWN;
+		} else {
+			usb2->mode = err;
+		}
+	} else {
+		usb2->mode = USB_DR_MODE_HOST;
+	}
+
 	usb2->supply = devm_regulator_get(&port->dev, "vbus");
 	return PTR_ERR_OR_ZERO(usb2->supply);
 }
diff --git a/drivers/phy/tegra/xusb.h b/drivers/phy/tegra/xusb.h
index b49dbc36efa3..bb60fc09c752 100644
--- a/drivers/phy/tegra/xusb.h
+++ b/drivers/phy/tegra/xusb.h
@@ -19,6 +19,8 @@
 #include <linux/mutex.h>
 #include <linux/workqueue.h>
 
+#include <linux/usb/otg.h>
+
 /* legacy entry points for backwards-compatibility */
 int tegra_xusb_padctl_legacy_probe(struct platform_device *pdev);
 int tegra_xusb_padctl_legacy_remove(struct platform_device *pdev);
@@ -271,6 +273,7 @@ struct tegra_xusb_usb2_port {
 	struct tegra_xusb_port base;
 
 	struct regulator *supply;
+	enum usb_dr_mode mode;
 	bool internal;
 };
 
-- 
2.20.1

