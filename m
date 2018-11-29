Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766E1C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D8342086B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7sDIrNY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D8342086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730452AbeK2RJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:09:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:50200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727695AbeK2RJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:09:56 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18C9220868;
        Thu, 29 Nov 2018 06:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543471544;
        bh=jAD7j+8cjizOB/ele494X0FCYMBOXEotxTN9mlV/y6w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z7sDIrNY0DfqNr8PyyWACDscx/v5zPSj21leU/IQHcWtNoklgMkUYjBpumSNyVhs1
         EOf+U6jtk2ZlYbI8zKwRwH3Mfo0FQzZZqDxVjHC5NVqZSTeA+Pnd+ovsxhipRwrY0B
         y+hU+YrZyeR/fffViF4LHhPykYpaP5I94kePG0tQ=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 3.18 2/6] can: rcar_can: Fix erroneous registration
Date:   Thu, 29 Nov 2018 01:05:31 -0500
Message-Id: <20181129060535.160592-2-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129060535.160592-1-sashal@kernel.org>
References: <20181129060535.160592-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

[ Upstream commit 68c8d209cd4337da4fa04c672f0b62bb735969bc ]

Assigning 2 to "renesas,can-clock-select" tricks the driver into
registering the CAN interface, even though we don't want that.
This patch improves one of the checks to prevent that from happening.

Fixes: 862e2b6af9413b43 ("can: rcar_can: support all input clocks")
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Chris Paterson <Chris.Paterson2@renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/rcar_can.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/rcar_can.c b/drivers/net/can/rcar_can.c
index 9718248e55f1..16144e7d0c8f 100644
--- a/drivers/net/can/rcar_can.c
+++ b/drivers/net/can/rcar_can.c
@@ -24,6 +24,9 @@
 
 #define RCAR_CAN_DRV_NAME	"rcar_can"
 
+#define RCAR_SUPPORTED_CLOCKS	(BIT(CLKR_CLKP1) | BIT(CLKR_CLKP2) | \
+				 BIT(CLKR_CLKEXT))
+
 /* Mailbox configuration:
  * mailbox 60 - 63 - Rx FIFO mailboxes
  * mailbox 56 - 59 - Tx FIFO mailboxes
@@ -785,7 +788,7 @@ static int rcar_can_probe(struct platform_device *pdev)
 		goto fail_clk;
 	}
 
-	if (clock_select >= ARRAY_SIZE(clock_names)) {
+	if (!(BIT(clock_select) & RCAR_SUPPORTED_CLOCKS)) {
 		err = -EINVAL;
 		dev_err(&pdev->dev, "invalid CAN clock selected\n");
 		goto fail_clk;
-- 
2.17.1

