Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752518AbeBWVCK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 16:02:10 -0500
Received: from muru.com ([72.249.23.125]:58034 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752194AbeBWVBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 16:01:14 -0500
From: Tony Lindgren <tony@atomide.com>
To: linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Nishanth Menon <nm@ti.com>,
        Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 10/12] ARM: OMAP2+: Try to parse earlycon from parent too
Date: Fri, 23 Feb 2018 13:00:58 -0800
Message-Id: <20180223210100.86732-11-tony@atomide.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223210100.86732-1-tony@atomide.com>
References: <20180223210100.86732-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With ti-sysc driver the "ti,hwmods" property will be moved to the
interconnect target module instead of the child device. To keep
earlycon working, we need to match against the interconnect target
module in the ti-sysc case.

Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -3492,6 +3492,12 @@ static void __init omap_hwmod_setup_earlycon_flags(void)
 			if (np) {
 				uart = of_get_property(np, "ti,hwmods", NULL);
 				oh = omap_hwmod_lookup(uart);
+				if (!oh) {
+					uart = of_get_property(np->parent,
+							       "ti,hwmods",
+							       NULL);
+					oh = omap_hwmod_lookup(uart);
+				}
 				if (oh)
 					oh->flags |= DEBUG_OMAPUART_FLAGS;
 			}
-- 
2.16.2
