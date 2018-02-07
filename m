Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754223AbeBGNqN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 08:46:13 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33014 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754165AbeBGNqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 08:46:10 -0500
X-Google-Smtp-Source: AH8x2241pIxH80jNg/P5MPBfubt/XlnrSRaYAacy0sJSW7i+EkN/0ILwRBbVJ0E/6/GeJAmVHVvj3g==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 3/7] ARM: davinci: don't setup pm_clk if we're using genpd
Date: Wed,  7 Feb 2018 14:45:49 +0100
Message-Id: <20180207134553.13510-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180207134553.13510-1-brgl@bgdev.pl>
References: <20180207134553.13510-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

As the first step in switching to using the genpd driver in DT mode,
check if a relevant genpd node exists and don't setup the clock pm in
this case.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/pm_domain.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-davinci/pm_domain.c b/arch/arm/mach-davinci/pm_domain.c
index 78eac2c0c146..98a4f3fcba50 100644
--- a/arch/arm/mach-davinci/pm_domain.c
+++ b/arch/arm/mach-davinci/pm_domain.c
@@ -13,6 +13,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/pm_clock.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
 
 static struct dev_pm_domain davinci_pm_domain = {
 	.ops = {
@@ -28,7 +29,13 @@ static struct pm_clk_notifier_block platform_bus_notifier = {
 
 static int __init davinci_pm_runtime_init(void)
 {
-	pm_clk_add_notifier(&platform_bus_type, &platform_bus_notifier);
+	struct device_node *np;
+
+	/* Use pm_clk as fallback if we're not using genpd. */
+	np = of_find_compatible_node(NULL, NULL, "ti,davinci-pm-domains");
+	if (!np)
+		pm_clk_add_notifier(&platform_bus_type,
+				    &platform_bus_notifier);
 
 	return 0;
 }
-- 
2.16.1
