Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84063ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E73520848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sceThem4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E73520848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbeJYWuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:50:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:60060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729694AbeJYWud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:50:33 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02BEC20848;
        Thu, 25 Oct 2018 14:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477057;
        bh=YOaOrhJP1gTYEC+sWTuYO7WSENJVCfHUT4Zye/75TP8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sceThem4QS1G/aGcyPrJ5kAeacCJ1wQjiu6FPZy/LCs0qSztnqWx6imo0NlTXKPSq
         J2hsnDXo/3afLrYZCPpoAfuLzcVYBz+d/V74B/f+USFWa3vnRBwnbXzFI7TMe/OBK0
         aw64bMgnMDXAwPWajpKIEytdiWntSzJkJxVlRua0=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Eduardo Valentin <edubezval@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 17/65] thermal: allow u8500-thermal driver to be a module
Date:   Thu, 25 Oct 2018 10:16:17 -0400
Message-Id: <20181025141705.213937-17-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141705.213937-1-sashal@kernel.org>
References: <20181025141705.213937-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 26716ce124fce88f288f07738ef685d5dfe5c13f ]

When the thermal subsystem is a loadable module, the u8500 driver
fails to build:

drivers/thermal/built-in.o: In function `db8500_thermal_probe':
db8500_thermal.c:(.text+0x96c): undefined reference to `thermal_zone_device_register'
drivers/thermal/built-in.o: In function `db8500_thermal_work':
db8500_thermal.c:(.text+0xab4): undefined reference to `thermal_zone_device_update'

This changes the symbol to a tristate, so Kconfig can track the
dependency correctly.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/db8500-prcmu.c | 3 +++
 drivers/thermal/Kconfig    | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index e6e4bacb09ee..12099b09a9a7 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -2048,6 +2048,7 @@ int db8500_prcmu_config_hotmon(u8 low, u8 high)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(db8500_prcmu_config_hotmon);
 
 static int config_hot_period(u16 val)
 {
@@ -2074,11 +2075,13 @@ int db8500_prcmu_start_temp_sense(u16 cycles32k)
 
 	return config_hot_period(cycles32k);
 }
+EXPORT_SYMBOL_GPL(db8500_prcmu_start_temp_sense);
 
 int db8500_prcmu_stop_temp_sense(void)
 {
 	return config_hot_period(0xFFFF);
 }
+EXPORT_SYMBOL_GPL(db8500_prcmu_stop_temp_sense);
 
 static int prcmu_a9wdog(u8 cmd, u8 d0, u8 d1, u8 d2, u8 d3)
 {
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index b556fa8250fc..1def65d2f0b5 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -237,8 +237,8 @@ config DOVE_THERMAL
 	  framework.
 
 config DB8500_THERMAL
-	bool "DB8500 thermal management"
-	depends on ARCH_U8500
+	tristate "DB8500 thermal management"
+	depends on MFD_DB8500_PRCMU
 	default y
 	help
 	  Adds DB8500 thermal management implementation according to the thermal
-- 
2.17.1

