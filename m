Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752030AbeEOWHp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 18:07:45 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:42045 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751104AbeEOWHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 18:07:44 -0400
X-Google-Smtp-Source: AB8JxZpnzT5cbD2PJFyTgHqF4vGo2DJVBAzfNegK7FIdXnx6rosG+flxM99I6PGxdEsUgvSlJdw2gQ==
From: Douglas Anderson <dianders@chromium.org>
To: broonie@kernel.org
Cc: mka@chromium.org, collinsd@codeaurora.org,
        Douglas Anderson <dianders@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: core: Allow for regulators that can't be read at bootup
Date: Tue, 15 May 2018 15:07:17 -0700
Message-Id: <20180515220717.254950-1-dianders@chromium.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regulators attached via RPMh on Qualcomm sdm845 apparently are
write-only.  Specifically you can send a request for a certain voltage
but you can't read back to see what voltage you've requested.  What
this means is that at bootup we have absolutely no idea what voltage
we could be at.

As discussed in the patches to try to support the RPMh regulators [1],
the fact that regulators are write-only means that its driver's
get_voltage_sel() should return an error code if it's called before
any calls to set_voltage_sel().  This causes problems in
machine_constraints_voltage() when trying to apply the constraints.

A proposed fix was to come up with an error code that could be
returned by get_voltage_sel() which would cause the regulator
framework to simply try setting the voltage with the current
constraints.

In this patch I propose the error code -ENOTRECOVERABLE.  In errno.h
this error is described as "State not recoverable".  Though the error
code was originally intended "for robust mutexes", the description of
the error code seems to apply here because we can't read the state of
the regulator.  Also note that the only existing user of this error
code in the regulator framework is tps65090-regulator.c which returns
this error code from the enable() call (not get_voltage() or
get_voltage_sel()), so there should be no existing regulators that
might accidentally get the new behavior.  (Side note is that tps65090
seems to interpret this error code to mean an error that you can't
recover from rather than some data that can't be recovered).

[1] https://patchwork.kernel.org/patch/10340897/

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
If this patch is accepted then we'll need to update the latest RPMh
regulator patch to return it.  The current patch returns -EINVAL which
means that the regulator always fails.

 drivers/regulator/core.c         | 12 ++++++++++++
 include/linux/regulator/driver.h |  7 +++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index d4803460a557..fe314ff56772 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -886,6 +886,18 @@ static int machine_constraints_voltage(struct regulator_dev *rdev,
 	    rdev->constraints->min_uV && rdev->constraints->max_uV) {
 		int target_min, target_max;
 		int current_uV = _regulator_get_voltage(rdev);
+
+		if (current_uV == -ENOTRECOVERABLE) {
+			/* This regulator can't be read and must be initted */
+			rdev_info(rdev, "Setting %d-%duV\n",
+				  rdev->constraints->min_uV,
+				  rdev->constraints->max_uV);
+			_regulator_do_set_voltage(rdev,
+						  rdev->constraints->min_uV,
+						  rdev->constraints->max_uV);
+			current_uV = _regulator_get_voltage(rdev);
+		}
+
 		if (current_uV < 0) {
 			rdev_err(rdev,
 				 "failed to get the current voltage(%d)\n",
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 4fc96cb8e5d7..14e512ad6d4f 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -81,9 +81,12 @@ struct regulator_linear_range {
  * @set_voltage_sel: Set the voltage for the regulator using the specified
  *                   selector.
  * @map_voltage: Convert a voltage into a selector
- * @get_voltage: Return the currently configured voltage for the regulator.
+ * @get_voltage: Return the currently configured voltage for the regulator;
+ *                   return -ENOTRECOVERABLE if regulator can't be read at
+ *                   bootup and hasn't been set yet.
  * @get_voltage_sel: Return the currently configured voltage selector for the
- *                   regulator.
+ *                   regulator; return -ENOTRECOVERABLE if regulator can't
+ *                   be read at bootup and hasn't been set yet.
  * @list_voltage: Return one of the supported voltages, in microvolts; zero
  *	if the selector indicates a voltage that is unusable on this system;
  *	or negative errno.  Selectors range from zero to one less than
-- 
2.17.0.441.gb46fe60e1d-goog
