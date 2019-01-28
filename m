Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E8FC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37F0220879
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548694073;
	bh=8BclaQ0Hw3mUxWlG0dnLyfczsKJrGQjtX1r1yJttt9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uUWz8JCMwAVq/SySe+Tdu+LXWfnD0zP0DERwe6gOA7BPsbUCdabokPt55PcHSVvRh
	 Q+lUd0cLdAAJ+CSkCcYYrTpCfWEmHnOMEACbkQ4+E8M5nZ0maFwfCz6hh77HDlzPEV
	 fGycgMY5yVuydqTvFC9wyxewwn54jiPStnuOHHjw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389124AbfA1QWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:22:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:57740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389087AbfA1QVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:21:51 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB9A92084A;
        Mon, 28 Jan 2019 16:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692510;
        bh=8BclaQ0Hw3mUxWlG0dnLyfczsKJrGQjtX1r1yJttt9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZY5n1Y0ycz8wWLgWQ/Mrz5fbknyGPv8u7ORZzhv1jFLrh8XkvU8OskzdH1M7mc712
         dqVDC+nLAX01Rfve0eftzjT5bwqkysGg8s3vX9qzUdlm2xVnkcHDIEixvLUxlEtUkZ
         i9HOxT1Qic+L7fVyEHnu5ZPeGpb6nL9w6zS/R/q8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 044/107] ARM: dts: Fix OMAP4430 SDP Ethernet startup
Date:   Mon, 28 Jan 2019 11:18:44 -0500
Message-Id: <20190128161947.57405-44-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161947.57405-1-sashal@kernel.org>
References: <20190128161947.57405-1-sashal@kernel.org>
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
index d728ec963111..891ba75fd459 100644
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

