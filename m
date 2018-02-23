Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751480AbeBWMoZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 07:44:25 -0500
Received: from albert.telenet-ops.be ([195.130.137.90]:37106 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750827AbeBWMoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 07:44:24 -0500
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, devicetree-compiler@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] mmc: dw_mmc-k3: Fix out-of-bounds access through DT alias
Date: Fri, 23 Feb 2018 13:44:19 +0100
Message-Id: <1519389859-14947-1-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hs_timing_cfg[] array is indexed using a value derived from the
"mshcN" alias in DT, which may lead to an out-of-bounds access.

Fix this by adding a range check.

Fixes: 361c7fe9b02eee7e ("mmc: dw_mmc-k3: add sd support for hi3660")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Fix Fixes reference.

There is another possible out-of-bounds access in
drivers/mmc/host/dw_mmc.c:dw_mci_init_slot():

    if (drv_data && drv_data->caps)
	    mmc->caps |= drv_data->caps[ctrl_id];

With ctrl_id derived from "mshcN".

Unfortunately the upper bound is not known at run-time, without adding
such a field to struct dw_mci_drv_data first.
---
 drivers/mmc/host/dw_mmc-k3.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
index 73fd75c3c824904d..75ae5803b0db24dd 100644
--- a/drivers/mmc/host/dw_mmc-k3.c
+++ b/drivers/mmc/host/dw_mmc-k3.c
@@ -135,6 +135,9 @@ static int dw_mci_hi6220_parse_dt(struct dw_mci *host)
 	if (priv->ctrl_id < 0)
 		priv->ctrl_id = 0;
 
+	if (priv->ctrl_id >= TIMING_MODE)
+		return -EINVAL;
+
 	host->priv = priv;
 	return 0;
 }
-- 
2.7.4
