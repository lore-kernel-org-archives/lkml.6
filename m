Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751863AbeBWNpm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 08:45:42 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:48921 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751351AbeBWNig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 08:38:36 -0500
From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>
To: maxime.ripard@bootlin.com, linux@armlinux.org.uk, wens@csie.org,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, clabbe.montjoie@gmail.com,
        thomas.petazzoni@bootlin.com, mylene.josserand@bootlin.com,
        quentin.schulz@bootlin.com
Subject: [PATCH v4 04/10] ARM: sun8i: smp: Add hotplug support for sun8i-a83t
Date: Fri, 23 Feb 2018 14:37:36 +0100
Message-Id: <20180223133742.26044-5-mylene.josserand@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180223133742.26044-1-mylene.josserand@bootlin.com>
References: <20180223133742.26044-1-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add hotplug support for sun8i-a83t.

Hotplug CPU for CPU0 is currently not working.
Remove the possibility to disable CPU0 only for sun8i-a83t.

Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
---
 arch/arm/mach-sunxi/mc_smp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-sunxi/mc_smp.c b/arch/arm/mach-sunxi/mc_smp.c
index 3bd9066a1422..f2c2cfca28cd 100644
--- a/arch/arm/mach-sunxi/mc_smp.c
+++ b/arch/arm/mach-sunxi/mc_smp.c
@@ -579,6 +579,8 @@ static int sunxi_cluster_powerdown(unsigned int cluster)
 	reg = readl(prcm_base + PRCM_PWROFF_GATING_REG(cluster));
 	if (is_sun9i)
 		reg |= PRCM_PWROFF_GATING_REG_CLUSTER_SUN9I;
+	else
+		reg |= PRCM_PWROFF_GATING_REG_CLUSTER_SUN8I;
 	writel(reg, prcm_base + PRCM_PWROFF_GATING_REG(cluster));
 	udelay(20);
 
@@ -660,8 +662,12 @@ static int sunxi_mc_smp_cpu_kill(unsigned int l_cpu)
 	return !ret;
 }
 
-static bool sunxi_mc_smp_cpu_can_disable(unsigned int __unused)
+static bool sunxi_mc_smp_cpu_can_disable(unsigned int cpu)
 {
+	/* CPU0 hotplug handled only for sun9i */
+	if (!is_sun9i)
+		if (cpu == 0)
+			return false;
 	return true;
 }
 #endif
-- 
2.11.0
