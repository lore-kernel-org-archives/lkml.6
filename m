Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AC4C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FA8D20879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oO2RurHa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FA8D20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbeLEJiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:38:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:42844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728305AbeLEJix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:38:53 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE45C20879;
        Wed,  5 Dec 2018 09:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002733;
        bh=PWv4wmsh0RruDM1hNgbka1GBnb5TKDTb8ttkQyLTxK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oO2RurHaQdBxs3ZzgpHjm928O/MIujGKlnbA93KfPhw7oyBbsBWGhylbb1Oo0+oBm
         y67F5TZg+EssttqL8RtXHuQfO+AUGg4Z2G7ZtDUwHXsrnmNJLsOYXBnGMMG6pY1Thb
         jdBroGwOITRibFXeEooR4QKSNX2uDHk0NEHZuBIc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Romain Izard <romain.izard.pro@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 051/123] ARM: dts: at91: sama5d2: use the divided clock for SMC
Date:   Wed,  5 Dec 2018 04:34:43 -0500
Message-Id: <20181205093555.5386-51-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Romain Izard <romain.izard.pro@gmail.com>

[ Upstream commit 4ab7ca092c3c7ac8b16aa28eba723a8868f82f14 ]

The SAMA5D2 is different from SAMA5D3 and SAMA5D4, as there are two
different clocks for the peripherals in the SoC. The Static Memory
controller is connected to the divided master clock.

Unfortunately, the device tree does not correctly show this and uses the
master clock directly. This clock is then used by the code for the NAND
controller to calculate the timings for the controller, and we end up with
slow NAND Flash access.

Fix the device tree, and the performance of Flash access is improved.

Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/sama5d2.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 61f68e5c48e9..b405992eb601 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -308,7 +308,7 @@
 				  0x1 0x0 0x60000000 0x10000000
 				  0x2 0x0 0x70000000 0x10000000
 				  0x3 0x0 0x80000000 0x10000000>;
-			clocks = <&mck>;
+			clocks = <&h32ck>;
 			status = "disabled";
 
 			nand_controller: nand-controller {
-- 
2.17.1

