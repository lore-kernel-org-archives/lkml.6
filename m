Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61B0C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA5720844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJ/PQ2Lu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AA5720844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729957AbeKIHgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:36:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:54336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729310AbeKIHgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:36:47 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B7FE21019;
        Thu,  8 Nov 2018 21:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714358;
        bh=tyuiD95XB5WGPqf0U3FsKQKDBQ6Z+XcQ7p/kwRho4mU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MJ/PQ2LuSU2Ts+fUntdh9DUKDUQKet10KH1Uqfw4lzrSjsMAE/tA5MNpHWPexoy6j
         oMYZuIsk+z68KZL+z1GcSI2WnaRtyo7lvp41/o6uHNFVZ7lbahcoEd6fNFzZopk8jb
         mOssJLOS2jTyH2CjFyJFN6J0fvvsfFxxKAtfOXJ4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Eduardo Valentin <edubezval@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 034/114] thermal: allow spear-thermal driver to be a module
Date:   Thu,  8 Nov 2018 13:50:49 -0800
Message-Id: <20181108215102.515329622@linuxfoundation.org>
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



