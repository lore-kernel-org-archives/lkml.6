Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751526AbeFBKMU (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 06:12:20 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39107 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750869AbeFBKMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 06:12:16 -0400
X-Google-Smtp-Source: ADUXVKLMamfY8PBXSMQIjzhZ/82csaI4DN95fVs4bJqbX3xkA6y+MxmCgVx/25oJVEjbAeYqxcStIg==
From: Marek Vasut <marek.vasut@gmail.com>
X-Google-Original-From: Marek Vasut <marek.vasut+renesas@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v3 01/10] mfd: da9063: Fix failpath in core
Date: Sat,  2 Jun 2018 12:11:46 +0200
Message-Id: <20180602101155.26375-1-marek.vasut+renesas@gmail.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case mfd_add_devices() fails, da9063_irq_exit() is not called to
undo the IRQchip setup done by da9063_irq_init(). Fix this by adding
the missing fail path.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org
---
V3: New patch
---
 drivers/mfd/da9063-core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/da9063-core.c b/drivers/mfd/da9063-core.c
index 6c2870d4e754..8226ebd8b96d 100644
--- a/drivers/mfd/da9063-core.c
+++ b/drivers/mfd/da9063-core.c
@@ -229,10 +229,16 @@ int da9063_device_init(struct da9063 *da9063, unsigned int irq)
 	ret = mfd_add_devices(da9063->dev, -1, da9063_devs,
 			      ARRAY_SIZE(da9063_devs), NULL, da9063->irq_base,
 			      NULL);
-	if (ret)
+	if (ret) {
 		dev_err(da9063->dev, "Cannot add MFD cells\n");
+		goto err_irq_exit;
+	}
 
 	return ret;
+
+err_irq_exit:
+	da9063_irq_exit(da9063);
+	return ret;
 }
 
 void da9063_device_exit(struct da9063 *da9063)
-- 
2.16.2
