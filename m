Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629C8C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2495B2083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:30:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2495B2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407696AbeHATQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:16:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52540 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389856AbeHATQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:16:56 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3A861D57;
        Wed,  1 Aug 2018 17:30:12 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiao Yao <xiaoyao@rock-chips.com>,
        Ziyuan <xzy.xu@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 111/144] mmc: dw_mmc: update actual clock for mmc debugfs
Date:   Wed,  1 Aug 2018 18:52:18 +0200
Message-Id: <20180801164957.294239168@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801164949.023217860@linuxfoundation.org>
References: <20180801164949.023217860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shawn Lin <shawn.lin@rock-chips.com>

[ Upstream commit ff178981bd5fd1667f373098740cb1c6d6efa1ba ]

Respect the actual clock for mmc debugfs to help better debug
the hardware.

mmc_host mmc0: Bus speed (slot 0) = 135475200Hz (slot req 150000000Hz,
actual 135475200HZ div = 0)

cat /sys/kernel/debug/mmc0/ios
clock:          150000000 Hz
actual clock:   135475200 Hz
vdd:            21 (3.3 ~ 3.4 V)
bus mode:       2 (push-pull)
chip select:    0 (don't care)
power mode:     2 (on)
bus width:      3 (8 bits)
timing spec:    9 (mmc HS200)
signal voltage: 0 (1.80 V)
driver type:    0 (driver type B)

Cc: Xiao Yao <xiaoyao@rock-chips.com>
Cc: Ziyuan <xzy.xu@rock-chips.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/dw_mmc.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1164,6 +1164,8 @@ static void dw_mci_setup_bus(struct dw_m
 	if (host->state == STATE_WAITING_CMD11_DONE)
 		sdmmc_cmd_bits |= SDMMC_CMD_VOLT_SWITCH;
 
+	slot->mmc->actual_clock = 0;
+
 	if (!clock) {
 		mci_writel(host, CLKENA, 0);
 		mci_send_cmd(slot, sdmmc_cmd_bits, 0);
@@ -1209,6 +1211,8 @@ static void dw_mci_setup_bus(struct dw_m
 
 		/* keep the last clock value that was requested from core */
 		slot->__clk_old = clock;
+		slot->mmc->actual_clock = div ? ((host->bus_hz / div) >> 1) :
+					  host->bus_hz;
 	}
 
 	host->current_speed = clock;


