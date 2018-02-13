Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934643AbeBMJiG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 04:38:06 -0500
Received: from laurent.telenet-ops.be ([195.130.137.89]:33920 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934272AbeBMJiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 04:38:04 -0500
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] regulator: Fix resume from suspend to idle
Date: Tue, 13 Feb 2018 10:37:59 +0100
Message-Id: <1518514679-27782-1-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When resuming from idle with the new suspend mode configuration support
we go through the resume callbacks with a state of PM_SUSPEND_TO_IDLE
which we don't have regulator constraints for, causing an error:

    dpm_run_callback(): regulator_resume_early+0x0/0x64 returns -22
    PM: Device regulator.0 failed to resume early: error -22

Avoid this and similar errors by treating missing constraints as a noop.

See also commit 57a0dd187956ea04 ("regulator: Fix suspend to idle"),
which fixed the suspend part.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
[hiding in brown paper bag]
No idea how I managed not to see this when testing 57a0dd187956ea04.

 drivers/regulator/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index dd4708c58480d277..1fc0c0811da4e9f2 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4310,7 +4310,7 @@ static int _regulator_resume_early(struct device *dev, void *data)
 
 	rstate = regulator_get_suspend_state(rdev, *state);
 	if (rstate == NULL)
-		return -EINVAL;
+		return 0;
 
 	mutex_lock(&rdev->mutex);
 
-- 
2.7.4
