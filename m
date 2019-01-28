Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEA2C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C883B2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548697210;
	bh=P0oOs61tq//lvwzcpa3l3hK24HNWIhwRluwau96AKpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KeFIdb81JtC9m8PqLtPyccGpbMFGRdiP0OEAyLCpsRieTuO0v2EbI/ReYpzZedr4+
	 ikh9DOrTYydusqdOBuvH8pQnvIEi6iEFejxVSV+KrF2MCdS/o68aHJpcKFRvdiot43
	 xA1cmcgnubNwzV3YSRq0PhVf6KxbGyFqvhQ+rPcM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbfA1Pwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:52:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:39092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728357AbfA1Pwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:52:36 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 825672175B;
        Mon, 28 Jan 2019 15:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690756;
        bh=P0oOs61tq//lvwzcpa3l3hK24HNWIhwRluwau96AKpc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x1xSjtCG2TB/GYQ+8vmPiZgYipxwqola6SPLKjL2S/hYkKy6uBHMcHJwA31/Le8oa
         Qa4tWD7avEfvPir7AakFKMNtqhIfwW7NjBEPnQ4lesof+sLFVCZdaq+3lQ5h6kkxna
         FMP2E2iycaein/8YrLJa4vEUI2u2zT66KmBlo3nY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 183/304] mmc: bcm2835: reset host on timeout
Date:   Mon, 28 Jan 2019 10:41:40 -0500
Message-Id: <20190128154341.47195-183-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Suchanek <msuchanek@suse.de>

[ Upstream commit f6000a4eb34e6462bc0dd39809c1bb99f9633269 ]

The bcm2835 mmc host tends to lock up for unknown reason so reset it on
timeout. The upper mmc block layer tries retransimitting with single
blocks which tends to work out after a long wait.

This is better than giving up and leaving the machine broken for no
obvious reason.

Fixes: 660fc733bd74 ("mmc: bcm2835: Add new driver for the sdhost controller.")
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Acked-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/bcm2835.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index aef40e1739ee..a251be266ad7 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -286,6 +286,7 @@ static void bcm2835_reset(struct mmc_host *mmc)
 
 	if (host->dma_chan)
 		dmaengine_terminate_sync(host->dma_chan);
+	host->dma_chan = NULL;
 	bcm2835_reset_internal(host);
 }
 
@@ -846,6 +847,8 @@ static void bcm2835_timeout(struct work_struct *work)
 		dev_err(dev, "timeout waiting for hardware interrupt.\n");
 		bcm2835_dumpregs(host);
 
+		bcm2835_reset(host->mmc);
+
 		if (host->data) {
 			host->data->error = -ETIMEDOUT;
 			bcm2835_finish_data(host);
-- 
2.19.1

