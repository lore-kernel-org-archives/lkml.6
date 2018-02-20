Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751867AbeBTMjO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 07:39:14 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54490 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751545AbeBTMjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 07:39:12 -0500
From: Mark Brown <broonie@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Applied "regulator: Fix resume from suspend to idle" to the regulator tree
In-Reply-To: <1518514679-27782-1-git-send-email-geert+renesas@glider.be>
Message-Id: <E1eo7CP-0005FM-5m@debutante>
Date: Tue, 20 Feb 2018 12:39:09 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: Fix resume from suspend to idle

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 35b5f14ec6dab281346a2d0ceb34abe2dba94190 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 13 Feb 2018 10:37:59 +0100
Subject: [PATCH] regulator: Fix resume from suspend to idle

When resuming from idle with the new suspend mode configuration support
we go through the resume callbacks with a state of PM_SUSPEND_TO_IDLE
which we don't have regulator constraints for, causing an error:

    dpm_run_callback(): regulator_resume_early+0x0/0x64 returns -22
    PM: Device regulator.0 failed to resume early: error -22

Avoid this and similar errors by treating missing constraints as a noop.

See also commit 57a0dd187956ea04 ("regulator: Fix suspend to idle"),
which fixed the suspend part.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index dd4708c58480..1fc0c0811da4 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4310,7 +4310,7 @@ static int _regulator_resume_early(struct device *dev, void *data)
 
 	rstate = regulator_get_suspend_state(rdev, *state);
 	if (rstate == NULL)
-		return -EINVAL;
+		return 0;
 
 	mutex_lock(&rdev->mutex);
 
-- 
2.16.1
