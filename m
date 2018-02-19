Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752296AbeBSITZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 03:19:25 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:54581 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752137AbeBSITH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 03:19:07 -0500
From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>
To: maxime.ripard@bootlin.com, wens@csie.org, linux@armlinux.org.uk,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, clabbe.montjoie@gmail.com,
        thomas.petazzoni@bootlin.com, mylene.josserand@bootlin.com,
        quentin.schulz@bootlin.com
Subject: [PATCH v3 7/7] ARM: sun8i: smp: Remove the disabling of CPU0
Date: Mon, 19 Feb 2018 09:18:37 +0100
Message-Id: <20180219081837.15482-8-mylene.josserand@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180219081837.15482-1-mylene.josserand@bootlin.com>
References: <20180219081837.15482-1-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On sun8i-a63t, hotplug CPU for CPU0 is currently not working.
Remove the possibility to disable CPU0 only for sun8i-a83t.

Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
---
 arch/arm/mach-sunxi/mc_smp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-sunxi/mc_smp.c b/arch/arm/mach-sunxi/mc_smp.c
index fec592bf68b4..69d5ae5b3d72 100644
--- a/arch/arm/mach-sunxi/mc_smp.c
+++ b/arch/arm/mach-sunxi/mc_smp.c
@@ -661,8 +661,12 @@ static int sunxi_mc_smp_cpu_kill(unsigned int l_cpu)
 	return !ret;
 }
 
-static bool sunxi_mc_smp_cpu_can_disable(unsigned int __unused)
+static bool sunxi_mc_smp_cpu_can_disable(unsigned int cpu)
 {
+	/* CPU0 hotplug handled only for sun9i */
+	if (of_machine_is_compatible("allwinner,sun8i-a83t"))
+		if (cpu == 0)
+			return false;
 	return true;
 }
 #endif
-- 
2.11.0
