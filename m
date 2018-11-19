Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187FCC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA03720851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:49:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA03720851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730303AbeKTGO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 01:14:56 -0500
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:32812 "EHLO
        emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729324AbeKTGO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 01:14:56 -0500
Received: from localhost.localdomain (85-76-71-135-nat.elisa-mobile.fi [85.76.71.135])
        by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 7002FB0061;
        Mon, 19 Nov 2018 21:49:46 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] ARM: OMAP1: devices: configure omap1_spi100k only on OMAP7xx
Date:   Mon, 19 Nov 2018 21:49:43 +0200
Message-Id: <20181119194943.351-1-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure omap1_spi100k only on OMAP7xx. This allows running multiboard
kernels on non-OMAP7xx HW with CONFIG_SPI_OMAP_100K enabled.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/arm/mach-omap1/devices.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index baaf902b7016..e1243b5d554f 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -244,6 +244,9 @@ struct platform_device omap_spi2 = {
 
 static void omap_init_spi100k(void)
 {
+	if (!cpu_is_omap7xx())
+		return;
+
 	omap_spi1.dev.platform_data = ioremap(OMAP7XX_SPI1_BASE, 0x7ff);
 	if (omap_spi1.dev.platform_data)
 		platform_device_register(&omap_spi1);
-- 
2.17.0

