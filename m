Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F288C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8A602175B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025806;
	bh=xB98+MPNv1UqDz2v60YK3UbvdBWzlfVGlvZHGo4BEy4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Vjb5X4ey1vhE/oje3uODsNSHEpEmDUr8bHeZQJUa9jzLDogl6pXlq6Z6xW1wSWnLw
	 2Cn2ae26WAj4MPMqc5BhkzN8KgqaoaG2BZsa7N2trgSbyPXJfT0SW4KRFYSEvckn4C
	 txXqxIfB3Uvmfr7VtsYf3OIc5qPsJqpr0z1zs8ws=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389547AbfBMCnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:43:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:45334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389341AbfBMCll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:41:41 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 289332175B;
        Wed, 13 Feb 2019 02:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025700;
        bh=xB98+MPNv1UqDz2v60YK3UbvdBWzlfVGlvZHGo4BEy4=;
        h=From:To:Cc:Subject:Date:From;
        b=CduRUYCyEW34Wevtt+Qho5gPeZbFoH/3lMcXzDbmSmA70pF2fKgzN/P6OHupwCx3x
         qxm6Og4MMav9v3BPytByrOl34tZoi1BMue22Y/Br8tGvSRTn/9caz/fSssmat+2ZHt
         A6NxN5Hb6s752u+vx45k5O+yBRasF74CFiqAl+Jg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vignesh R <vigneshr@ti.com>, Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 01/14] mfd: ti_am335x_tscadc: Use PLATFORM_DEVID_AUTO while registering mfd cells
Date:   Tue, 12 Feb 2019 21:41:25 -0500
Message-Id: <20190213024139.22268-1-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vignesh R <vigneshr@ti.com>

[ Upstream commit b40ee006fe6a8a25093434e5d394128c356a48f3 ]

Use PLATFORM_DEVID_AUTO to number mfd cells while registering, so that
different instances are uniquely identified. This is required in order
to support registering of multiple instances of same ti_am335x_tscadc IP.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/ti_am335x_tscadc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index 5726bf4e6c61..e8d5d171ab04 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -282,8 +282,9 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 		cell->pdata_size = sizeof(tscadc);
 	}
 
-	err = mfd_add_devices(&pdev->dev, pdev->id, tscadc->cells,
-			tscadc->used_cells, NULL, 0, NULL);
+	err = mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO,
+			      tscadc->cells, tscadc->used_cells, NULL,
+			      0, NULL);
 	if (err < 0)
 		goto err_disable_clk;
 
-- 
2.19.1

