Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756042AbeDZMgu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 08:36:50 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:45975 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756009AbeDZMgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 08:36:41 -0400
X-Google-Smtp-Source: AB8JxZonaoRBUah7N1C2zvkEXsRGK1eRzppXlB8UsdoL26bAuItWEMa+E8K3KzRqc1udwQo2+j5okQ==
From: Niklas Cassel <niklas.cassel@linaro.org>
To: Kalle Valo <kvalo@qca.qualcomm.com>
Cc: Niklas Cassel <niklas.cassel@linaro.org>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ath10k: sdio: jump to correct label in error handling path
Date: Thu, 26 Apr 2018 14:35:02 +0200
Message-Id: <20180426123502.23962-1-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jump to the correct label in error handling path.
At this point of execution create_singlethread_workqueue() has succeeded,
so it should be properly destroyed.

Jump label was renamed in commit ec2c64e20257 ("ath10k: sdio: fix memory
leak for probe allocations").
However, the bug was originally introduced in commit d96db25d2025
("ath10k: add initial SDIO support").

Fixes: d96db25d2025 ("ath10k: add initial SDIO support")
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 drivers/net/wireless/ath/ath10k/sdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index 2d04c54a4153..d612ce8c9cff 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -2011,7 +2011,7 @@ static int ath10k_sdio_probe(struct sdio_func *func,
 		ret = -ENODEV;
 		ath10k_err(ar, "unsupported device id %u (0x%x)\n",
 			   dev_id_base, id->device);
-		goto err_core_destroy;
+		goto err_free_wq;
 	}
 
 	ar->id.vendor = id->vendor;
-- 
2.14.3
