Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB99C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADAD421B1A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549898895;
	bh=sZLeKUCcedlJ0/GEdaCochuP6vAU4P2Vc+7V2HW6H2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZexgYf69AtaDTxcuuLJnc7y+qFUE9JUnSmeqgL2UlAAb5++6c8iK6b80qiIbksGXW
	 Mw8/kbwbdcLMkX1PL8xSoHiel7OFWngfv5891X4nEy1E+RiHWhCVpbwMg23o6EO5aj
	 zIl41jeiG6nqEiwFe8UkN4ksTeU2LJQ1tQDCBfks=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389609AbfBKO6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:58:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:46264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389177AbfBKO6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:58:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3A0A222A6;
        Mon, 11 Feb 2019 14:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897114;
        bh=sZLeKUCcedlJ0/GEdaCochuP6vAU4P2Vc+7V2HW6H2w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tNr9v1147J7Ea1s+QWn8slNN9RXH3OftD3myw8iwqiIB6atWMQgE+Knm8H+JW44gL
         XD1B6372AQEjxxxRf0vzPVk/O9ShEGDVD98QLF4cDBDkJiQCyC9dcj/JLUV8f66Ex+
         p82iUg1PRrdD7Xi5zzppOuotoR+5SzF9tMDzYvGY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michal Suchanek <msuchanek@suse.de>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Eric Anholt <eric@anholt.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 096/205] mmc: bcm2835: reset host on timeout
Date:   Mon, 11 Feb 2019 15:18:14 +0100
Message-Id: <20190211141834.901138160@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index abf1f3c8b0c3..5301302fb531 100644
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



