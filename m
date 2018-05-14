Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752613AbeENWmk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 18:42:40 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36459 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752378AbeENWmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 18:42:38 -0400
X-Google-Smtp-Source: AB8JxZpEfWTWMVoEk4ZV/UjbxPaoFkixtrKi7VcaEgnwDtHU/EPwJ6WvCx/IimuRG6D5zlzsrpjZmQ==
From: Douglas Anderson <dianders@chromium.org>
To: kishon@ti.com
Cc: Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/2] phy: qcom-qusb2: Quiet -EPROBE_DEFER from qusb2_phy_probe()
Date: Mon, 14 May 2018 15:42:22 -0700
Message-Id: <20180514224222.54495-2-dianders@chromium.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180514224222.54495-1-dianders@chromium.org>
References: <20180514224222.54495-1-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The -EPROBE_DEFER virus demands special case code to avoid printing
error messages when the error is only -EPROBE_DEFER.  Spread the virus
to a new host: qusb2_phy_probe().  Specifically handle when our
regulators might not be ready yet.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/phy/qualcomm/phy-qcom-qusb2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qusb2.c b/drivers/phy/qualcomm/phy-qcom-qusb2.c
index 94afeac1a19e..26354618fd45 100644
--- a/drivers/phy/qualcomm/phy-qcom-qusb2.c
+++ b/drivers/phy/qualcomm/phy-qcom-qusb2.c
@@ -711,7 +711,9 @@ static int qusb2_phy_probe(struct platform_device *pdev)
 
 	ret = devm_regulator_bulk_get(dev, num, qphy->vregs);
 	if (ret) {
-		dev_err(dev, "failed to get regulator supplies\n");
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "failed to get regulator supplies: %d\n",
+				ret);
 		return ret;
 	}
 
-- 
2.17.0.441.gb46fe60e1d-goog
