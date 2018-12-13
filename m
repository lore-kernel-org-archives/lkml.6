Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC07C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB15B208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544675328;
	bh=D9T187AVX6fK+0+jD4eUd5hS6yPUb2fa7uZv7PdDAUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VL/o3a11Bf4JIc5HlB54efXP5Psvq5OZY7S+W/ipysOUc2FF2/n4jY+cAlyZOV+DJ
	 byvnonurSey2E+xCohve3Risn34+U3240733HVqvJkBCZTiJo7cMlqgxP5jRCL+9b+
	 MZyn48Kt9oALBf19O1S/UFbsp7cYcfPJ0cn7oy0s=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB15B208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbeLME2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:28:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:41490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbeLME2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:28:44 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEAA12087F;
        Thu, 13 Dec 2018 04:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675323;
        bh=D9T187AVX6fK+0+jD4eUd5hS6yPUb2fa7uZv7PdDAUM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=of43hvQZKj/HkO3nv/c2FAc0YezDx8XSzfxpNKgCNN/hWzfLdSJ8zCa3lpBKCS+vj
         QYKSNXgo91tIzFaDvlaA33hp1liimZ9m4x86cvnwu4G65DGQMg+7QzJyK+1/JFVA+K
         /dkPhMEaR6GROhenWS/W8orkCZEHA8nxPd2NayZ0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>, linux-i2c@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 03/73] i2c: rcar: check bus state before reinitializing
Date:   Wed, 12 Dec 2018 23:27:28 -0500
Message-Id: <20181213042838.75160-3-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213042838.75160-1-sashal@kernel.org>
References: <20181213042838.75160-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

[ Upstream commit 0b57436f15bf40e432487086c4f2d01fd3529393 ]

We should check the bus state before reinitializing the IP core.
Otherwise, the internal bus busy state which also tracks multi-master
activity is lost.

Credits go to the Renesas BSP team for suggesting this change.

Reported-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Fixes: ae481cc13965 ("i2c: rcar: fix resume by always initializing registers before transfer")
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-rcar.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 4aa7dde876f3..254e6219e538 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -779,6 +779,11 @@ static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
 
 	pm_runtime_get_sync(dev);
 
+	/* Check bus state before init otherwise bus busy info will be lost */
+	ret = rcar_i2c_bus_barrier(priv);
+	if (ret < 0)
+		goto out;
+
 	/* Gen3 needs a reset before allowing RXDMA once */
 	if (priv->devtype == I2C_RCAR_GEN3) {
 		priv->flags |= ID_P_NO_RXDMA;
@@ -791,10 +796,6 @@ static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
 
 	rcar_i2c_init(priv);
 
-	ret = rcar_i2c_bus_barrier(priv);
-	if (ret < 0)
-		goto out;
-
 	for (i = 0; i < num; i++)
 		rcar_i2c_request_dma(priv, msgs + i);
 
-- 
2.19.1

