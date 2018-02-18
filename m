Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751598AbeBRRE1 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 12:04:27 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41158 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751422AbeBRRE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 12:04:26 -0500
From: Hans de Goede <hdegoede@redhat.com>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: core: Handle PM_SUSPEND_TO_IDLE suspend_state_t
Date: Sun, 18 Feb 2018 18:04:24 +0100
Message-Id: <20180218170424.11976-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regulator framework is used on x86 in some cases now and x86 has
a PM_SUSPEND_TO_IDLE suspend_state_t, treat this as PM_SUSPEND_STANDBY,
this fixes these errors on resume:

dpm_run_callback(): regulator_resume_early+0x0/0x60 returns -22
PM: Device regulator.0 failed to resume early: error -22

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/regulator/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index dd4708c58480..c980703ba705 100644
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
2.14.3
