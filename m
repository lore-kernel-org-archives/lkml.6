Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299A5C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF99A222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025649;
	bh=58us8l9OjRspD4vT/C0erJ5237JcPIjgJ5uWMU/Cnzw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Z82qE5XI8Lu0PfPuK72cKlftJl+8OoCkNbi4Av9JhTPdX/ifyfXcixsC2zl6f4Y6q
	 EX7JlBoDxB1KjLo2W3eUEhGz39luPGgkjQAvl/k7+eiyA9RvT2VDtXrdsKcORGf4qE
	 a7Wj31E+NtmlCNm8JIhgAM+LNoBKjuZOtPvPuj7k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389089AbfBMCkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:40:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:44458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389068AbfBMCkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:40:42 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9ECF7222C2;
        Wed, 13 Feb 2019 02:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025642;
        bh=58us8l9OjRspD4vT/C0erJ5237JcPIjgJ5uWMU/Cnzw=;
        h=From:To:Cc:Subject:Date:From;
        b=m5eOuWLj3rKXGWT4gqkZbSnUBVSUPKi7noYY0XwT6ctlE2jl+N1LRG1T+cNsTTgE8
         /I7x6mc8PXgrESbScGXKfF/BLc6jcZGMS/38UdIGI9fEHz865ytU4pw2aFySizAek+
         rMxW0QIbp51p+ajTWY7rEAn/p2cYbwTYhC9svfco=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vignesh R <vigneshr@ti.com>, Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 01/21] mfd: ti_am335x_tscadc: Use PLATFORM_DEVID_AUTO while registering mfd cells
Date:   Tue, 12 Feb 2019 21:40:20 -0500
Message-Id: <20190213024040.21740-1-sashal@kernel.org>
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
index 798f0a829637..60286adbd6a1 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -264,8 +264,9 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
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

