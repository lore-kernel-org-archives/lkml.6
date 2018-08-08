Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0958C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 07:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75991216FB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 07:47:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75991216FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbeHHKGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 06:06:15 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:55155 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbeHHKGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 06:06:15 -0400
X-IronPort-AV: E=Sophos;i="5.51,456,1526367600"; 
   d="scan'208";a="17244718"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 Aug 2018 00:47:47 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.76.4) by
 chn-sv-exch06.mchp-main.com (10.10.76.107) with Microsoft SMTP Server id
 14.3.352.0; Wed, 8 Aug 2018 00:47:46 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH] ARM: at91: pm: remove pm_bu initialization in at91_pm_backup_init()
Date:   Wed, 8 Aug 2018 10:47:40 +0300
Message-ID: <1533714460-6883-1-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to initialize pm_bu since it is used only if backup
mode is selected. In case backup mode initialization fails (which means
pm_bu is invalid) the ULP0 mode will be selected.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index c8ef696b83b6..901d6445964d 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -577,8 +577,6 @@ static int __init at91_pm_backup_init(void)
 	if (!at91_is_pm_mode_active(AT91_PM_BACKUP))
 		return 0;
 
-	pm_bu = NULL;
-
 	np = of_find_compatible_node(NULL, NULL, "atmel,sama5d2-sfrbu");
 	if (!np) {
 		pr_warn("%s: failed to find sfrbu!\n", __func__);
@@ -587,7 +585,6 @@ static int __init at91_pm_backup_init(void)
 
 	pm_data.sfrbu = of_iomap(np, 0);
 	of_node_put(np);
-	pm_bu = NULL;
 
 	np = of_find_compatible_node(NULL, NULL, "atmel,sama5d2-securam");
 	if (!np)
-- 
2.7.4

