Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753725AbeDPVvu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 17:51:50 -0400
Received: from mail.bootlin.com ([62.4.15.54]:40780 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753697AbeDPVvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 17:51:47 -0400
From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>
To: linux@armlinux.org.uk, maxime.ripard@bootlin.com, wens@csie.org,
        marc.zyngier@arm.com, mark.rutland@arm.com, robh+dt@kernel.org,
        horms@verge.net.au, geert@linux-m68k.org, magnus.damm@gmail.com
Cc: linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, mylene.josserand@bootlin.com
Subject: [PATCH v6 08/11] ARM: sun9i: smp: Add is_sun8i field
Date: Mon, 16 Apr 2018 23:50:29 +0200
Message-Id: <20180416215032.5023-9-mylene.josserand@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180416215032.5023-1-mylene.josserand@bootlin.com>
References: <20180416215032.5023-1-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prepare the support of sun8i-a83t, add a field in the smp_data
structure to know if we are on sun9i-a80 or sun8i-a83t.

Add also a global variable to retrieve which architecture we are
having.

Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
---
 arch/arm/mach-sunxi/mc_smp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-sunxi/mc_smp.c b/arch/arm/mach-sunxi/mc_smp.c
index 03f021d0c73e..9d57ea27dacc 100644
--- a/arch/arm/mach-sunxi/mc_smp.c
+++ b/arch/arm/mach-sunxi/mc_smp.c
@@ -74,6 +74,7 @@ static void __iomem *sram_b_smp_base;
 
 extern void sunxi_mc_smp_secondary_startup(void);
 extern void sunxi_mc_smp_resume(void);
+static int is_sun8i;
 
 static bool sunxi_core_is_cortex_a15(unsigned int core, unsigned int cluster)
 {
@@ -624,6 +625,7 @@ struct sunxi_mc_smp_nodes {
 struct sunxi_mc_smp_data {
 	const char *enable_method;
 	int (*get_smp_nodes)(struct sunxi_mc_smp_nodes *nodes);
+	int is_sun8i;
 };
 
 static void __init sunxi_mc_smp_put_nodes(struct sunxi_mc_smp_nodes *nodes)
@@ -664,6 +666,7 @@ static const struct sunxi_mc_smp_data sunxi_mc_smp_data[] __initconst = {
 	{
 		.enable_method	= "allwinner,sun9i-a80-smp",
 		.get_smp_nodes	= sun9i_a80_get_smp_nodes,
+		.is_sun8i	= false,
 	},
 };
 
@@ -697,6 +700,8 @@ static int __init sunxi_mc_smp_init(void)
 			break;
 	}
 
+	is_sun8i = sunxi_mc_smp_data[i].is_sun8i;
+
 	of_node_put(node);
 	if (ret)
 		return -ENODEV;
-- 
2.11.0
