Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752406AbeENWkr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 18:40:47 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42464 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752049AbeENWkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 18:40:41 -0400
X-Google-Smtp-Source: AB8JxZpz6G/ZxIPkPpLf9kFn/sTHjyv+LxweWVQq+TyQao+sWtDKS86upkckxl95gAr9MlBwHP1+dw==
From: Douglas Anderson <dianders@chromium.org>
To: broonie@kernel.org
Cc: Douglas Anderson <dianders@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: core: Quiet -EPROBE_DEFER from regulator_bulk_get()
Date: Mon, 14 May 2018 15:40:27 -0700
Message-Id: <20180514224027.53748-1-dianders@chromium.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The -EPROBE_DEFER virus demands special case code to avoid printing
error messages when the error is only -EPROBE_DEFER.  Spread the virus
to a new host: regulator_bulk_get()

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/regulator/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index d4803460a557..42e97fb85e95 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3696,8 +3696,9 @@ int regulator_bulk_get(struct device *dev, int num_consumers,
 						      consumers[i].supply);
 		if (IS_ERR(consumers[i].consumer)) {
 			ret = PTR_ERR(consumers[i].consumer);
-			dev_err(dev, "Failed to get supply '%s': %d\n",
-				consumers[i].supply, ret);
+			if (ret != -EPROBE_DEFER)
+				dev_err(dev, "Failed to get supply '%s': %d\n",
+					consumers[i].supply, ret);
 			consumers[i].consumer = NULL;
 			goto err;
 		}
-- 
2.17.0.441.gb46fe60e1d-goog
