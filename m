Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59793C65BAA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16F73208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBIAd69f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16F73208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729665AbeJEXWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:22:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:54108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729974AbeJEXQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:16:13 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57A1B214DA;
        Fri,  5 Oct 2018 16:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538756209;
        bh=sVmTB1JdlSndcv5v8WWmn0N3IvuDTfaxErybjA5HYw4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PBIAd69f3WmJC4gYvXoIWBPgWvqB3jTxTkdmNSezmk0NMYbNTaZq5rmydGJWOC4Zi
         DgUuKYnoMPE6H+zpLEMlUFe1jTFHmNWWCkA5mnSm9RsMwQIYZQNCMbpSu3XTm5rt3N
         nOkEuZqcKnzhc2DslkHVquQTpBIg7YFzD3nqwgjY=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 16/23] net: macb: disable scatter-gather for macb on sama5d3
Date:   Fri,  5 Oct 2018 12:16:27 -0400
Message-Id: <20181005161634.20631-16-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005161634.20631-1-sashal@kernel.org>
References: <20181005161634.20631-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

[ Upstream commit eb4ed8e2d7fecb5f40db38e4498b9ee23cddf196 ]

Create a new configuration for the sama5d3-macb new compatibility string.
This configuration disables scatter-gather because we experienced lock down
of the macb interface of this particular SoC under very high load.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index dfef4ec167c1..d90539c8065c 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3301,6 +3301,13 @@ static const struct macb_config at91sam9260_config = {
 	.init = macb_init,
 };
 
+static const struct macb_config sama5d3macb_config = {
+	.caps = MACB_CAPS_SG_DISABLED
+	      | MACB_CAPS_USRIO_HAS_CLKEN | MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII,
+	.clk_init = macb_clk_init,
+	.init = macb_init,
+};
+
 static const struct macb_config pc302gem_config = {
 	.caps = MACB_CAPS_SG_DISABLED | MACB_CAPS_GIGABIT_MODE_AVAILABLE,
 	.dma_burst_length = 16,
@@ -3368,6 +3375,7 @@ static const struct of_device_id macb_dt_ids[] = {
 	{ .compatible = "cdns,gem", .data = &pc302gem_config },
 	{ .compatible = "atmel,sama5d2-gem", .data = &sama5d2_config },
 	{ .compatible = "atmel,sama5d3-gem", .data = &sama5d3_config },
+	{ .compatible = "atmel,sama5d3-macb", .data = &sama5d3macb_config },
 	{ .compatible = "atmel,sama5d4-gem", .data = &sama5d4_config },
 	{ .compatible = "cdns,at91rm9200-emac", .data = &emac_config },
 	{ .compatible = "cdns,emac", .data = &emac_config },
-- 
2.17.1

