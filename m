Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90899C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E9DF20844
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548695925;
	bh=+ESr3YzHU75iNoAECia5QDRpd+aO21K7llA4fSG/Tmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=suKg34x9Z9/d8qM+0HVo14SD7CxdZXvfYIaTK3E75ON/opLTdhM+QgPOI2pymE1hq
	 cHeYjAsB+GjQc7frCe9wX9kvJ8oC590sUagS0jGQUvFIIbGsiVbin8qGwdPvGJ/yiT
	 TsWyY9jkHmEGBmXVCFeGXJplErb0TI1ejGQdClzA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731764AbfA1QFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:05:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:51234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731083AbfA1QFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:05:03 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6128920989;
        Mon, 28 Jan 2019 16:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691502;
        bh=+ESr3YzHU75iNoAECia5QDRpd+aO21K7llA4fSG/Tmc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XVHts6dZL5y0WECENVZBzDbPdDUJPThnYjFP49gUsg4zSOvNBnINdTUd8SwCxeQSF
         YRFVj793K+HQMFyD5AUDDRp+4U2PU0syiMW/ObUA4GNMZsfFjC9I2fNKFRSFHEDGX6
         OMb8y+Q3Aw13dMm8oY24JiQPBRIKtT/F8MygqPBY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 119/258] ARM: dts: Fix OMAP4430 SDP Ethernet startup
Date:   Mon, 28 Jan 2019 10:57:05 -0500
Message-Id: <20190128155924.51521-119-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King - ARM Linux <linux@armlinux.org.uk>

[ Upstream commit 84fb6c7feb1494ebb7d1ec8b95cfb7ada0264465 ]

It was noticed that unbinding and rebinding the KSZ8851 ethernet
resulted in the driver reporting "failed to read device ID" at probe.
Probing the reset line with a 'scope while repeatedly attempting to
bind the driver in a shell loop revealed that the KSZ8851 RSTN pin is
constantly held at zero, meaning the device is held in reset, and
does not respond on the SPI bus.

Experimentation with the startup delay on the regulator set to 50ms
shows that the reset is positively released after 20ms.

Schematics for this board are not available, and the traces are buried
in the inner layers of the board which makes tracing where the RSTN pin
extremely difficult.  We can only guess that the RSTN pin is wired to a
reset generator chip driven off the ethernet supply, which fits the
observed behaviour.

Include this delay in the regulator startup delay - effectively
treating the reset as a "supply stable" indicator.

This can not be modelled as a delay in the KSZ8851 driver since the
reset generation is board specific - if the RSTN pin had been wired to
a GPIO, reset could be released earlier via the already provided support
in the KSZ8851 driver.

This also got confirmed by Peter Ujfalusi <peter.ujfalusi@ti.com> based
on Blaze schematics that should be very close to SDP4430:

TPS22902YFPR is used as the regulator switch (gpio48 controlled):
Convert arm boot_lock to raw The VOUT is routed to TPS3808G01DBV.
(SCH Note: Threshold set at 90%. Vsense: 0.405V).

According to the TPS3808 data sheet the RESET delay time when Ct is
open (this is the case in the schema): MIN/TYP/MAX: 12/20/28 ms.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
[tony@atomide.com: updated with notes from schematics from Peter]
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/omap4-sdp.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index 490726b52216..9dc7ec7655cb 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -33,6 +33,7 @@
 		gpio = <&gpio2 16 GPIO_ACTIVE_HIGH>;  /* gpio line 48 */
 		enable-active-high;
 		regulator-boot-on;
+		startup-delay-us = <25000>;
 	};
 
 	vbat: fixedregulator-vbat {
-- 
2.19.1

