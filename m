Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937762AbeE1Niy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:38:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:35596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163069AbeE1Ko7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:44:59 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Andrew F. Davis" <afd@ti.com>,
        Dave Gerlach <d-gerlach@ti.com>, Keerthy <j-keerthy@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>, Tero Kristo <t-kristo@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 070/496] ARM: OMAP2+: Fix sar_base inititalization for HS omaps
Date: Mon, 28 May 2018 11:57:35 +0200
Message-Id: <20180528100322.736842640@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit fe27f16794f313f5fc16f6d2f42d8c2b2f4d70cc ]

HS omaps use irq_save_secure_context() instead of irq_save_context()
so sar_base will never get initialized and irq_sar_clear() gets called
with a wrong address for HS omaps from irq_restore_context().

Starting with commit f4b9f40ae95b ("ARM: OMAP4+: Initialize SAR RAM
base early for proper CPU1 reset for kexec") we have it available,
and this ideally would been fixed with that commit already.

Fixes: f4b9f40ae95b ("ARM: OMAP4+: Initialize SAR RAM base early for
proper CPU1 reset for kexec")
Cc: Andrew F. Davis <afd@ti.com>
Cc: Dave Gerlach <d-gerlach@ti.com>
Cc: Keerthy <j-keerthy@ti.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mach-omap2/omap-wakeupgen.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -299,8 +299,6 @@ static void irq_save_context(void)
 	if (soc_is_dra7xx())
 		return;
 
-	if (!sar_base)
-		sar_base = omap4_get_sar_ram_base();
 	if (wakeupgen_ops && wakeupgen_ops->save_context)
 		wakeupgen_ops->save_context();
 }
@@ -598,6 +596,8 @@ static int __init wakeupgen_init(struct
 	irq_hotplug_init();
 	irq_pm_init();
 
+	sar_base = omap4_get_sar_ram_base();
+
 	return 0;
 }
 IRQCHIP_DECLARE(ti_wakeupgen, "ti,omap4-wugen-mpu", wakeupgen_init);
