Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58080ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20493208E3
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQyPONkT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20493208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbeKIHgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:36:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:54586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729930AbeKIHgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:36:53 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54328208E3;
        Thu,  8 Nov 2018 21:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714364;
        bh=irjNwdiyZ+IXOga1f9nL2Ua6JL+oa7CFL3Jh+EeUbN0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OQyPONkTZ64UuWnxE5DQYn730TUUy2BhTx0V+ymB/JkW2FRNjXZ8HlraPT3P6QVVk
         d/uOYAHImHoFmG6HEOpxEUJAPP0OMNn4TTmLUdQg03y09QaHPiNOVHMsHoeKRkRWLk
         EmBkwswG9SIakDjmIS6IpS65+8oiXKPbMm5CMx94=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Eduardo Valentin <edubezval@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 035/114] thermal: allow u8500-thermal driver to be a module
Date:   Thu,  8 Nov 2018 13:50:50 -0800
Message-Id: <20181108215103.077903100@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215059.051093652@linuxfoundation.org>
References: <20181108215059.051093652@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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



