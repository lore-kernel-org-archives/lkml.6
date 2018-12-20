Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2141CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D9F20449
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298465;
	bh=VOciozYKQc6rTK9QkrTE9v7i2nhR0L+Bw8O7MAp9DkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X1KuxgO/olZAqolHapXIrNHfoF9wgMbYbUuTIYN918GAcx6Auvo0Gz2s45PUb59mB
	 MtBJblIkES6lOCMo7AbIA0eGS0gG5WKB0OIxzgHpP93yFwIQ+wtYwxREBbqrp8XjxN
	 FFDgqMY1G5o8IcavmFzaob7GLqr1zgK51kRbcH98=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733236AbeLTJeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:34:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:56492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732708AbeLTJ32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:29:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 821FF218D8;
        Thu, 20 Dec 2018 09:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545298168;
        bh=VOciozYKQc6rTK9QkrTE9v7i2nhR0L+Bw8O7MAp9DkQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tpHY3W0oy6y4a15DhEbhqa/YlmmUsV+okiwLuSRKBUkuwOjUVlA1HhvSYD+eIOAP2
         nbvbCaarK+NZQlwtavjIKFNGoNa9g9e9ynL8hH+Z/HNJJRiPE7J3mNQyC4uWbmBri1
         +NokoZJeB+2Q9hYGJS2zDnD27BvzvvVXrr/0GbE8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 06/67] i2c: rcar: check bus state before reinitializing
Date:   Thu, 20 Dec 2018 10:18:18 +0100
Message-Id: <20181220085903.822192733@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085903.562090333@linuxfoundation.org>
References: <20181220085903.562090333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



