Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424011AbeE1Lzp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:55:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:55894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423600AbeE1LI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:08:27 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        RVC test team via Yoshihiro Shimoda
        <yoshihiro.shimoda.uh@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vinod Koul <vinod.koul@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 082/272] dmaengine: rcar-dmac: Fix too early/late system suspend/resume callbacks
Date: Mon, 28 May 2018 12:01:55 +0200
Message-Id: <20180528100248.038168313@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 73dcc666d6bd0db56cd556010f93d8f04c1cc70c ]

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
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/sh/rcar-dmac.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -1677,8 +1677,8 @@ static const struct dev_pm_ops rcar_dmac
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
