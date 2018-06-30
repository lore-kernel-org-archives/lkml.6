Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98B6C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 22:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92B3C253D1
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 22:53:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92B3C253D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tribudubois.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751956AbeF3Wx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 18:53:28 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:60958 "EHLO
        slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751869AbeF3WxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 18:53:25 -0400
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
        by slow1-d.mail.gandi.net (Postfix) with ESMTP id 0EDEE3A8BEA;
        Sun,  1 Jul 2018 00:11:16 +0200 (CEST)
X-Originating-IP: 78.235.240.156
Received: from localhost.localdomain (smm49-1-78-235-240-156.fbx.proxad.net [78.235.240.156])
        (Authenticated sender: jcd@tribudubois.net)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 20BE5C0003;
        Sat, 30 Jun 2018 22:11:16 +0000 (UTC)
From:   Jean-Christophe Dubois <jcd@tribudubois.net>
To:     shawnguo@kernel.org, kernel@pengutronix.de, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, rui.zhang@intel.com,
        edubezval@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jean-Christophe Dubois <jcd@tribudubois.net>
Subject: [PATCH v2] thermal: i.MX: Allow thermal probe to fail gracefully in case of bad calibration.
Date:   Sun,  1 Jul 2018 00:10:50 +0200
Message-Id: <20180630221050.1474-1-jcd@tribudubois.net>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this fix, the thermal probe on i.MX6 might trigger a division
by zero exception later in the probe if the calibration does fail.

Note: This linux behavior (Division by zero in kernel) has been triggered
on a Qemu i.MX6 emulation where parameters in nvmem were not set. With this
fix the division by zero is not triggeed anymore as the thermal probe does
fail early.

Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
---
v2 changes:
 - improved subject line
 - added thermal maintainers in the destination list.

 drivers/thermal/imx_thermal.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 334d98be03b9..b1f82d64253e 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -604,7 +604,10 @@ static int imx_init_from_nvmem_cells(struct platform_device *pdev)
 	ret = nvmem_cell_read_u32(&pdev->dev, "calib", &val);
 	if (ret)
 		return ret;
-	imx_init_calib(pdev, val);
+
+	ret = imx_init_calib(pdev, val);
+	if (ret)
+		return ret;
 
 	ret = nvmem_cell_read_u32(&pdev->dev, "temp_grade", &val);
 	if (ret)
-- 
2.17.1

