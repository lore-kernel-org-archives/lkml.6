Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE43DC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83FD32086C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548692183;
	bh=Xh9oBqZwuPzJcsNL1oJvb/evRqXbv2pdvg0Yi85km6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qlyNyoT10ocMe8Q90wblzG5SfWRWQAjyO6bjvsu5NIPh3nhzmsUVFB6QmUcH7pNqf
	 e2cubpwuba2U4FQQ5hj8YfFFGZcRFGO4mC1n3r2JOVz0zTQbtYSpalTmCEfFWhJqA4
	 VxLtGfcw9/G2Frz2Qa7d7QMeF5JvCSWCzpEbSonQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387946AbfA1QQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:16:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:48282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733160AbfA1QQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:16:19 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9B662086C;
        Mon, 28 Jan 2019 16:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692178;
        bh=Xh9oBqZwuPzJcsNL1oJvb/evRqXbv2pdvg0Yi85km6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L5vOF370HP4WiFNHrb5IsuxrokJYCUXediqFm1sWh+BsYhImDLTBIkQrZAYTrE/uK
         N+T3GPC4ZqKTGmMLBwj/P51wIrrFh7MQEG3riHl0hXwdmKgUGjupTmmhHdL0YtMz4p
         PFfwxnf6IE3I/FK6A9Hi0I944oDu0e1KJ9q8cH/o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Phil Elwell <phil@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 099/170] mmc: bcm2835: Recover from MMC_SEND_EXT_CSD
Date:   Mon, 28 Jan 2019 11:10:49 -0500
Message-Id: <20190128161200.55107-99-sashal@kernel.org>
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

From: Phil Elwell <phil@raspberrypi.org>

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
index 768972af8b85..aef40e1739ee 100644
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

