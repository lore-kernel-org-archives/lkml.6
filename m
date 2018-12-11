Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3509C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A942145D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543548;
	bh=Ngzewp+0f8vZbtGagOK/2y3gfsqZ6Q7LYRIf8Og8WuE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xhbj0cc5Vgil8oxjb26xlQrx5NGyJcxfUoEhU+S7teSBHd4SSQEyGj+ZBUwKDA1i8
	 4S7wihc0vRGQ9PvlZG/fFjv9FlVNd2M+JGwV0nTqwtAgJzm/CNO3Z9de0x4lKPOBuh
	 yBjT+6NW95Rt6ptZjXMs6jes48psrvxxxm9zJI8w=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99A942145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbeLKPw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:52:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:41078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729676AbeLKPwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:52:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CB2C2145D;
        Tue, 11 Dec 2018 15:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543544;
        bh=Ngzewp+0f8vZbtGagOK/2y3gfsqZ6Q7LYRIf8Og8WuE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CwJPHYPFRQahlE1wtF9pwqqan/9hky08lPlYYXNTOEqajtzIgT5g0gXHZ164xWBXf
         AeFPtdaUdrIUOxAFjf/6Yf9bEocaG9Jxy+tDXDYRJIHU3+JmNRTV2rWXq6D6N0c2cX
         qNXH3S514i8tatvcLCCXFDfd5Yp5wzpU6FsmOAHc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 05/67] can: rcar_can: Fix erroneous registration
Date:   Tue, 11 Dec 2018 16:41:05 +0100
Message-Id: <20181211151630.636901821@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151630.378216233@linuxfoundation.org>
References: <20181211151630.378216233@linuxfoundation.org>
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
 drivers/net/can/rcar/rcar_can.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index 11662f479e76..771a46083739 100644
--- a/drivers/net/can/rcar/rcar_can.c
+++ b/drivers/net/can/rcar/rcar_can.c
@@ -24,6 +24,9 @@
 
 #define RCAR_CAN_DRV_NAME	"rcar_can"
 
+#define RCAR_SUPPORTED_CLOCKS	(BIT(CLKR_CLKP1) | BIT(CLKR_CLKP2) | \
+				 BIT(CLKR_CLKEXT))
+
 /* Mailbox configuration:
  * mailbox 60 - 63 - Rx FIFO mailboxes
  * mailbox 56 - 59 - Tx FIFO mailboxes
@@ -789,7 +792,7 @@ static int rcar_can_probe(struct platform_device *pdev)
 		goto fail_clk;
 	}
 
-	if (clock_select >= ARRAY_SIZE(clock_names)) {
+	if (!(BIT(clock_select) & RCAR_SUPPORTED_CLOCKS)) {
 		err = -EINVAL;
 		dev_err(&pdev->dev, "invalid CAN clock selected\n");
 		goto fail_clk;
-- 
2.19.1



