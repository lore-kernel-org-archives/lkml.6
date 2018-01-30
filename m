Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751574AbeA3Kcf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 05:32:35 -0500
Received: from albert.telenet-ops.be ([195.130.137.90]:41106 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751360AbeA3Kcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 05:32:33 -0500
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Chunyan Zhang <zhang.chunyan@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] regulator: core: Fix s2idle
Date: Tue, 30 Jan 2018 11:32:26 +0100
Message-Id: <1517308346-25299-1-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Systems using regulators can no longer be frozen:

$ echo 0 > /sys/module/printk/parameters/console_suspend
$ echo freeze > /sys/power/state

    PM: suspend entry (s2idle)
    PM: Syncing filesystems ... done.
    Freezing user space processes ... (elapsed 0.011 seconds) done.
    OOM killer disabled.
    Freezing remaining freezable tasks ... (elapsed 0.009 seconds) done.
    dpm_run_callback(): regulator_suspend_late+0x0/0x44 returns -22
    PM: Device regulator.7 failed to suspend late: error -22
    PM: late suspend of devices failed

Fix this by adding the missing case for s2idle.  Treat s2idle the same
as standby, as there are no separate constraints defined for s2idle.

Fixes: f7efad10b5c49289 ("regulator: add PM suspend and resume hooks")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
regulator_check_states() also considers PM_SUSPEND_TO_IDLE an invalid
state:

    /* return 0 if the state is valid */
    static int regulator_check_states(suspend_state_t state)
    {
	    return (state > PM_SUSPEND_MAX || state == PM_SUSPEND_TO_IDLE);
    }

But I have no idea what impact it has.  So far it doesn't seem to hurt,
though.

 drivers/regulator/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 42681c10cbe4fa9f..5f411b0cca9aa838 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -333,6 +333,7 @@ regulator_get_suspend_state(struct regulator_dev *rdev, suspend_state_t state)
 		return NULL;
 
 	switch (state) {
+	case PM_SUSPEND_TO_IDLE:
 	case PM_SUSPEND_STANDBY:
 		return &rdev->constraints->state_standby;
 	case PM_SUSPEND_MEM:
-- 
2.7.4
