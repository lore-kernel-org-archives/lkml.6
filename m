Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A143FC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F60E2175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548694868;
	bh=FIg04Mk7uEd1VNosDJk4UdlGWW/anWXLP2dq8rvbWM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=waagrORSmtL9uC4XqmKsfX7Kzg+bi/32OrUpwR83zt89OAX6AHjPi5biv97WrjVhZ
	 xXZr6buEoS+1IdQnUorTkv4qNrovxBbeaaoakRbhtuHvJ8r9ii5m3js8N3sXWyOt37
	 b1jKu3c2ncTn4GfS6I7mKesbNJyz3vzizwJZob8k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388235AbfA1RBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:01:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:45138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387752AbfA1QPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:15:20 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9E1720879;
        Mon, 28 Jan 2019 16:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692119;
        bh=FIg04Mk7uEd1VNosDJk4UdlGWW/anWXLP2dq8rvbWM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RYNFu9xgDw7BmdJKTSUUY0u8glXFRxPUnSnUVvvVrLe25xcJMb0Yqqdz2quvTtq03
         kWBS0ptZAEKLgiqEnA+uZiPq0uPor/ISA1Ka6Ga6Nrhus4SpW5z0rw5hx2JVewlGgd
         D2aYFAmpYQAak/YbcuOgEFoR0X8/d5a8wPG71Ui0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 076/170] ARM: dts: Fix OMAP4430 SDP Ethernet startup
Date:   Mon, 28 Jan 2019 11:10:26 -0500
Message-Id: <20190128161200.55107-76-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161200.55107-1-sashal@kernel.org>
References: <20190128161200.55107-1-sashal@kernel.org>
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
index 280d92d42bf1..bfad6aadfe88 100644
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

