Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932656AbeCOTRc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 15:17:32 -0400
Received: from vern.gendns.com ([206.190.152.46]:38754 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752198AbeCOTR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 15:17:29 -0400
From: David Lechner <david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
Cc: David Lechner <david@lechnology.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] ARM: davinci: DA8XX: fix oops in USB PHY driver due to stack allocated platform platform_data
Date: Thu, 15 Mar 2018 14:17:20 -0500
Message-Id: <1521141440-16418-1-git-send-email-david@lechnology.com>
X-Mailer: git-send-email 2.7.4
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a possible kernel oops due to using stack allocated platform
data for the USB PHY driver on DA8XX devices. If the platform device
probe is deferred, then we get a corrupt pointer for the platform data.

We now use a global static struct for the platform data so that the
platform data pointer does not get written over.

Fixes: 9b504750923cb ("ARM: davinci: da8xx: Add USB PHY platform device")
Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/usb-da8xx.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-davinci/usb-da8xx.c b/arch/arm/mach-davinci/usb-da8xx.c
index 4d89d86..67d634b 100644
--- a/arch/arm/mach-davinci/usb-da8xx.c
+++ b/arch/arm/mach-davinci/usb-da8xx.c
@@ -26,6 +26,8 @@
 
 static struct clk *usb20_clk;
 
+static struct da8xx_usb_phy_platform_data da8xx_usb_phy_pdata;
+
 static struct platform_device da8xx_usb_phy = {
 	.name		= "da8xx-usb-phy",
 	.id		= -1,
@@ -37,14 +39,14 @@ static struct platform_device da8xx_usb_phy = {
 		 */
 		.init_name	= "da8xx-usb-phy",
 	},
+	.dev		= {
+		.platform_data	= &da8xx_usb_phy_pdata,
+	},
 };
 
 int __init da8xx_register_usb_phy(void)
 {
-	struct da8xx_usb_phy_platform_data pdata;
-
-	pdata.cfgchip = da8xx_get_cfgchip();
-	da8xx_usb_phy.dev.platform_data = &pdata;
+	da8xx_usb_phy_pdata.cfgchip = da8xx_get_cfgchip();
 
 	return platform_device_register(&da8xx_usb_phy);
 }
-- 
2.7.4
