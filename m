Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752594AbeENWmj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 18:42:39 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:38078 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752149AbeENWmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 18:42:37 -0400
X-Google-Smtp-Source: AB8JxZqFWjf2+M9hh9v/olLckGX7KrUiBS1v/D28YtIwLntRGILg12GVy9tiIqXwLIWanxc6PIg3sA==
From: Douglas Anderson <dianders@chromium.org>
To: kishon@ti.com
Cc: Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Manu Gautam <mgautam@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Varadarajan Narayanan <varada@codeaurora.org>
Subject: [PATCH 1/2] phy: qcom-qmp: Quiet -EPROBE_DEFER from qcom_qmp_phy_probe()
Date: Mon, 14 May 2018 15:42:21 -0700
Message-Id: <20180514224222.54495-1-dianders@chromium.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The -EPROBE_DEFER virus demands special case code to avoid printing
error messages when the error is only -EPROBE_DEFER.  Spread the virus
to a new host: qcom_qmp_phy_probe().  Specifically handle when our
regulators might not be ready yet.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/phy/qualcomm/phy-qcom-qmp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index 6470c5d61d1c..a740daa58b31 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -1447,7 +1447,9 @@ static int qcom_qmp_phy_probe(struct platform_device *pdev)
 
 	ret = qcom_qmp_phy_vreg_init(dev);
 	if (ret) {
-		dev_err(dev, "failed to get regulator supplies\n");
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "failed to get regulator supplies: %d\n",
+				ret);
 		return ret;
 	}
 
-- 
2.17.0.441.gb46fe60e1d-goog
