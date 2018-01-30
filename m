Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751956AbeA3M3H (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 07:29:07 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37194 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751649AbeA3M3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 07:29:06 -0500
From: Mark Brown <broonie@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Chunyan Zhang <zhang.chunyan@linaro.org>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH] regulator: Fix suspend to idle
Date: Tue, 30 Jan 2018 12:29:00 +0000
Message-Id: <20180130122900.16917-1-broonie@kernel.org>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When suspending to idle with the new suspend mode configuration support
we go through the suspend callbacks with a state of PM_SUSPEND_TO_IDLE
which we don't have regulator constraints for, causing an error.  Avoid
this and similar errors by treating missing constraints as a noop.

Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 42681c10cbe4..dd4708c58480 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -758,7 +758,7 @@ static int suspend_set_state(struct regulator_dev *rdev,
 
 	rstate = regulator_get_suspend_state(rdev, state);
 	if (rstate == NULL)
-		return -EINVAL;
+		return 0;
 
 	/* If we have no suspend mode configration don't set anything;
 	 * only warn if the driver implements set_suspend_voltage or
-- 
2.15.1
