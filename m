Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEB1C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDC452080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhSg8Lw7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDC452080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbeJ3WY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:24:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:54326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729069AbeJ3WYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:24:25 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 202692080A;
        Tue, 30 Oct 2018 13:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540906256;
        bh=vPC8Q+G12kMQsR7Ac85ECE8e4M7XxBOGmoGhpCAO6OY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZhSg8Lw7K7j6l08p+MdBsEsCQJuJ1JvuSxtOHv26N6LG4pdvmKgSTjs6aXG47RLF2
         UswYeeZ+TuCDQC6DKzB8f0Yl0GYT1BU9hZnYKJ/xPMBBJUwbp5HZ20YI6U8+mj6/bD
         TmQFL+xscf4D3+X+edJg3AY5r59P53aBaUoOQ9V4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 13/13] i2c: rcar: cleanup DMA for all kinds of failure
Date:   Tue, 30 Oct 2018 09:29:23 -0400
Message-Id: <20181030132923.218124-13-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181030132923.218124-1-sashal@kernel.org>
References: <20181030132923.218124-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

[ Upstream commit 31d86033a0749a0463ea654130b2de5c163154f1 ]

DMA needs to be cleaned up not only on timeout, but on all errors where
it has been setup before.

Fixes: 73e8b0528346 ("i2c: rcar: add DMA support")
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-rcar.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index c7592fe30e6e..93b8069041bb 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -723,8 +723,12 @@ static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
 
 	time_left = wait_event_timeout(priv->wait, priv->flags & ID_DONE,
 				     num * adap->timeout);
-	if (!time_left) {
+
+	/* cleanup DMA if it couldn't complete properly due to an error */
+	if (priv->dma_direction != DMA_NONE)
 		rcar_i2c_cleanup_dma(priv);
+
+	if (!time_left) {
 		rcar_i2c_init(priv);
 		ret = -ETIMEDOUT;
 	} else if (priv->flags & ID_NACK) {
-- 
2.17.1

