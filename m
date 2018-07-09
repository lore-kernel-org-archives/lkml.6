Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DFAC5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 19:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0B0320881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 19:19:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0B0320881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754682AbeGITTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 15:19:34 -0400
Received: from www.osadl.org ([62.245.132.105]:39344 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754516AbeGITTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 15:19:32 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59] (may be forged))
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id w69JHK2a009403;
        Mon, 9 Jul 2018 21:17:20 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Wolfram Sang <w.sang@pengutronix.de>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] can: mpc5xxx_can: check of_iomap return before use
Date:   Mon,  9 Jul 2018 21:16:40 +0200
Message-Id: <1531163800-12111-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 of_iompa() can return NULL so that return needs to be checked and NULL
treated as failure. While at it also take care of the missing
of_node_put() in the error path.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: commit afa17a500a36 ("net/can: add driver for mscan family & mpc52xx_mscan")
---

Problem was found by an experimental coccinelle script

Patch was compiletested with: mpc5200_defconfig + CONFIG_CAN=y,
CONFIG_CAN_MSCAN=y, CONFIG_CAN_MPC5XXX=y
(with a number of sparse warnings not related to the proposed change)

Patch is against 4.18-rc3 (localversion-next is next-20180706)

 drivers/net/can/mscan/mpc5xxx_can.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/can/mscan/mpc5xxx_can.c b/drivers/net/can/mscan/mpc5xxx_can.c
index c7427bd..2949a38 100644
--- a/drivers/net/can/mscan/mpc5xxx_can.c
+++ b/drivers/net/can/mscan/mpc5xxx_can.c
@@ -86,6 +86,11 @@ static u32 mpc52xx_can_get_clock(struct platform_device *ofdev,
 		return 0;
 	}
 	cdm = of_iomap(np_cdm, 0);
+	if (!cdm) {
+		of_node_put(np_cdm);
+		dev_err(&ofdev->dev, "can't map clock node!\n");
+		return 0;
+	}
 
 	if (in_8(&cdm->ipb_clk_sel) & 0x1)
 		freq *= 2;
-- 
2.1.4

