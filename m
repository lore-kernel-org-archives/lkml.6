Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D3BC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A4D120700
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896319;
	bh=4hbQyc1XhOLeSSRAFffK/immrnHqw+y3lhQFoO9+GxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fWwyiuNib8G8gcx2edSWcUQBbYNgvlnb3/hXRZTh90wngHjmR9Xk14vTjGeZVOyqQ
	 +U0pG96Pb7BQkkWazttDNuXlxdzV2+AyLyidcaOR1tHmm3ZA7bcX/O5bLq89x/R5t1
	 qr6fNuvPnpzGomQ5I4yeCNfUXY/x2i1cvvg59Ohk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733007AbfBKOpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:45:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:58268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732994AbfBKOpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:45:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECB2E20700;
        Mon, 11 Feb 2019 14:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896315;
        bh=4hbQyc1XhOLeSSRAFffK/immrnHqw+y3lhQFoO9+GxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dQFBbBKKTfwzrGVj6aDtRxEC7IdT+dKmlou0ww90vt5deTFqguxY9xWOIbRbr6y3P
         oGARuSwSq7r9YE2Rvm2CES03pom4EklrBR+5++QZ8O62D8UqLk7pCI1fKESPkd/rRx
         +MXjvimN2ZBbs8xwF6GGJ0PXFfugVLSZ/xzisiQ0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Phil Elwell <phil@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Eric Anholt <eric@anholt.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 143/313] mmc: bcm2835: Recover from MMC_SEND_EXT_CSD
Date:   Mon, 11 Feb 2019 15:17:03 +0100
Message-Id: <20190211141903.183464372@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

[ Upstream commit 07d405769afea5718529fc9e341f0b13b3189b6f ]

If the user issues an "mmc extcsd read", the SD controller receives
what it thinks is a SEND_IF_COND command with an unexpected data block.
The resulting operations leave the FSM stuck in READWAIT, a state which
persists until the MMC framework resets the controller, by which point
the root filesystem is likely to have been unmounted.

A less heavyweight solution is to detect the condition and nudge the
FSM by asserting the (self-clearing) FORCE_DATA_MODE bit.

Link: https://github.com/raspberrypi/linux/issues/2728
Signed-off-by: Phil Elwell <phil@raspberrypi.org>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Acked-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/bcm2835.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index 0d3b7473bc21..abf1f3c8b0c3 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -772,6 +772,8 @@ static void bcm2835_finish_command(struct bcm2835_host *host)
 
 		if (!(sdhsts & SDHSTS_CRC7_ERROR) ||
 		    (host->cmd->opcode != MMC_SEND_OP_COND)) {
+			u32 edm, fsm;
+
 			if (sdhsts & SDHSTS_CMD_TIME_OUT) {
 				host->cmd->error = -ETIMEDOUT;
 			} else {
@@ -780,6 +782,13 @@ static void bcm2835_finish_command(struct bcm2835_host *host)
 				bcm2835_dumpregs(host);
 				host->cmd->error = -EILSEQ;
 			}
+			edm = readl(host->ioaddr + SDEDM);
+			fsm = edm & SDEDM_FSM_MASK;
+			if (fsm == SDEDM_FSM_READWAIT ||
+			    fsm == SDEDM_FSM_WRITESTART1)
+				/* Kick the FSM out of its wait */
+				writel(edm | SDEDM_FORCE_DATA_MODE,
+				       host->ioaddr + SDEDM);
 			bcm2835_finish_request(host);
 			return;
 		}
-- 
2.19.1



