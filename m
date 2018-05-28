Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S940223AbeE1Qf2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 12:35:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:56718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934778AbeE1KIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:08:38 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>,
        Keerthy <j-keerthy@ti.com>, Ladislav Michl <ladis@linux-mips.org>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 067/185] ARM: OMAP: Fix dmtimer init for omap1
Date: Mon, 28 May 2018 12:01:48 +0200
Message-Id: <20180528100056.524499510@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100050.700971285@linuxfoundation.org>
References: <20180528100050.700971285@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit ba6887836178d43b3665b9da075c2c5dfe1d207c ]

We need to enable PM runtime on omap1 also as otherwise we
will get errors:

omap_timer omap_timer.1: omap_dm_timer_probe: pm_runtime_get_sync failed!
omap_timer: probe of omap_timer.1 failed with error -13
...

We are checking for OMAP_TIMER_NEEDS_RESET flag elsewhere so this is
safe to do.

Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Keerthy <j-keerthy@ti.com>
Cc: Ladislav Michl <ladis@linux-mips.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/plat-omap/dmtimer.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -853,11 +853,8 @@ static int omap_dm_timer_probe(struct pl
 	timer->irq = irq->start;
 	timer->pdev = pdev;
 
-	/* Skip pm_runtime_enable for OMAP1 */
-	if (!(timer->capability & OMAP_TIMER_NEEDS_RESET)) {
-		pm_runtime_enable(dev);
-		pm_runtime_irq_safe(dev);
-	}
+	pm_runtime_enable(dev);
+	pm_runtime_irq_safe(dev);
 
 	if (!timer->reserved) {
 		pm_runtime_get_sync(dev);
