Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5247DECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F01920840
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rNcF3Hrb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F01920840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbeJYWud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:50:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:60024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729680AbeJYWuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:50:32 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A51702086D;
        Thu, 25 Oct 2018 14:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477055;
        bh=Nalvp6KRus0y+YQ2P1HsAlISRL8ih0qczQFKkBwNCks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rNcF3HrbTKrDOxcTYHMuPYJyPFQP6iK6McwQdqSPl5TwA7EakqVoD4Z07xs4lZpGx
         1nh8eTfVDt/M0jDn7ti/8U8jgXzVaXaKKjKXqsSLyHWHCHPG3Dbcl4BklyZP5NVWrY
         MNpBeP3Baj+Rj5sE1zJ3kv0lXuC2y/GpJmCanZ/I=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Eduardo Valentin <edubezval@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 16/65] thermal: allow spear-thermal driver to be a module
Date:   Thu, 25 Oct 2018 10:16:16 -0400
Message-Id: <20181025141705.213937-16-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141705.213937-1-sashal@kernel.org>
References: <20181025141705.213937-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 4d2f1794c07aae55b8f25f4d8aebcafc0d3e501d ]

When the thermal subsystem is a loadable module, the spear driver
fails to build:

drivers/thermal/built-in.o: In function `spear_thermal_exit':
spear_thermal.c:(.text+0xf8): undefined reference to `thermal_zone_device_unregister'
drivers/thermal/built-in.o: In function `spear_thermal_probe':
spear_thermal.c:(.text+0x230): undefined reference to `thermal_zone_device_register'

This changes the symbol to a tristate, so Kconfig can track the
dependency correctly.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 4b660b5beb98..b556fa8250fc 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -195,7 +195,7 @@ config IMX_THERMAL
 	  passive trip is crossed.
 
 config SPEAR_THERMAL
-	bool "SPEAr thermal sensor driver"
+	tristate "SPEAr thermal sensor driver"
 	depends on PLAT_SPEAR || COMPILE_TEST
 	depends on OF
 	help
-- 
2.17.1

