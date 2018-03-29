Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752168AbeC2Qxo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 12:53:44 -0400
Received: from albert.telenet-ops.be ([195.130.137.90]:38556 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751862AbeC2Qxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 12:53:42 -0400
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Vinod Koul <vinod.koul@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?=
        <niklas.soderlund+renesas@ragnatech.se>,
        dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dmaengine: rcar-dmac: Fix too early/late system suspend/resume callbacks
Date: Thu, 29 Mar 2018 18:53:32 +0200
Message-Id: <1522342412-10126-1-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If serial console wake-up is enabled ("echo enabled >
/sys/.../ttySC0/power/wakeup"), and any serial input is received while
the system is suspended, serial port input no longer works after system
resume.

Note that:
  1) The system can still be woken up using the serial console,
  2) Serial port input keeps working if the system is woken up in some
     other way (e.g. Wake-on-LAN or gpio-keys), and no serial input was
     received while suspended.

To fix this, replace SET_LATE_SYSTEM_SLEEP_PM_OPS() by
SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(), as the callbacks installed by the
former happen too early resp. late in the suspend resp. resume process.

Reported-by: RVC test team via Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Fixes: 1131b0a4af911de5 ("dmaengine: rcar-dmac: Make DMAC reinit during system resume explicit")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This is a fix for a regression introduced in v4.16-rc1.
---
 drivers/dma/sh/rcar-dmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index b10bf71ef5ae2b34..386894fa9ecaa2f1 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -1686,8 +1686,8 @@ static const struct dev_pm_ops rcar_dmac_pm = {
 	 *   - Wait for the current transfer to complete and stop the device,
 	 *   - Resume transfers, if any.
 	 */
-	SET_LATE_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				     pm_runtime_force_resume)
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				      pm_runtime_force_resume)
 	SET_RUNTIME_PM_OPS(rcar_dmac_runtime_suspend, rcar_dmac_runtime_resume,
 			   NULL)
 };
-- 
2.7.4
