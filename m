Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5086AC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 214432148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548692187;
	bh=P0oOs61tq//lvwzcpa3l3hK24HNWIhwRluwau96AKpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PSciN1Gy4WVrkrSQPpBpYOWmZpw0b6LqtfUOdI4PSVQnCD85ZYYoILSkRc6eybFTG
	 xB15wgXs+lVI2dLg0jeufm4eH/uT3hFU7e6oDlsddLOffPhufjqtN/3WLpZlaDeH6S
	 RuD5WeX7xBeDzLCGxgCECssEy8IAFv4DnElxyoZk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733218AbfA1QQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:16:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:48490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733160AbfA1QQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:16:22 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38DB020879;
        Mon, 28 Jan 2019 16:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692182;
        bh=P0oOs61tq//lvwzcpa3l3hK24HNWIhwRluwau96AKpc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QH+bxLA4yP+dacAuNIS7+UlipD0s18efM7w6xF1RlF7+ooNp8jTnRJ3d3DSigVpmT
         oHng6nrZ5UgVYdCW98SDQ4F8Z2VXQxC79hcowiWb3lfQWoVcHgBXz422WQ7xZNEDoz
         qMKGg29s/aK9NjBKCA/mPvPMxDj6sg8Vr0BNPTy4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 100/170] mmc: bcm2835: reset host on timeout
Date:   Mon, 28 Jan 2019 11:10:50 -0500
Message-Id: <20190128161200.55107-100-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161200.55107-1-sashal@kernel.org>
References: <20190128161200.55107-1-sashal@kernel.org>
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

