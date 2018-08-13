Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5717C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97C7021475
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tVFM2uCr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97C7021475
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729919AbeHMR4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 13:56:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729063AbeHMR4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 13:56:16 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D52DF20839;
        Mon, 13 Aug 2018 15:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534173216;
        bh=snTRjQxdepD/wDnxYzED4y5hU8r6b/cnsKsNsEEZZP0=;
        h=From:To:Subject:Date:From;
        b=tVFM2uCrU4Jiw48yIcEJuq7lastSCCwI5ByKcakm5OL2w6Ia9KCbacha24q/JlDyS
         W9DqMjRT/1/GbR5OVh5akkMSpaIL0WjWea5upkKHVrFKW23MiYiERtywMHqV0NqMKb
         FWbMYUgEqwGo/uQvLkKK9wvIVbTUvWQ4pvMtXD7M=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: s3c24xx: Remove empty gta02_pmu children probe
Date:   Mon, 13 Aug 2018 17:13:10 +0200
Message-Id: <20180813151310.21960-1-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 67e67df8da72 ("gta02: Use pcf50633 backlight driver instead
of platform backlight driver.") the list of gta02 pmu children is empty
therefore looping through it and adding devices is a no-op.

This also fixes the GCC v8.1 W=1 warning:

    arch/arm/mach-s3c24xx/mach-gta02.c: In function 'gta02_pmu_attach_child_devices':
    arch/arm/mach-s3c24xx/mach-gta02.c:538:16: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
      for (n = 0; n < ARRAY_SIZE(gta02_devices_pmu_children); n++)
                    ^

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/mach-s3c24xx/mach-gta02.c | 42 --------------------------------------
 1 file changed, 42 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/mach-gta02.c b/arch/arm/mach-s3c24xx/mach-gta02.c
index 9d5595c4ad99..594901f3b8e5 100644
--- a/arch/arm/mach-s3c24xx/mach-gta02.c
+++ b/arch/arm/mach-s3c24xx/mach-gta02.c
@@ -219,17 +219,6 @@ static void gta02_udc_vbus_draw(unsigned int ma)
 #define gta02_udc_vbus_draw		NULL
 #endif
 
-/*
- * This is called when pc50633 is probed, unfortunately quite late in the
- * day since it is an I2C bus device. Here we can belatedly define some
- * platform devices with the advantage that we can mark the pcf50633 as the
- * parent. This makes them get suspended and resumed with their parent
- * the pcf50633 still around.
- */
-
-static void gta02_pmu_attach_child_devices(struct pcf50633 *pcf);
-
-
 static char *gta02_batteries[] = {
 	"battery",
 };
@@ -355,7 +344,6 @@ static struct pcf50633_platform_data gta02_pcf_pdata = {
 		},
 
 	},
-	.probe_done = gta02_pmu_attach_child_devices,
 	.mbc_event_callback = gta02_pmu_event_callback,
 };
 
@@ -512,36 +500,6 @@ static struct platform_device *gta02_devices[] __initdata = {
 	&s3c_device_ts,
 };
 
-/* These guys DO need to be children of PMU. */
-
-static struct platform_device *gta02_devices_pmu_children[] = {
-};
-
-
-/*
- * This is called when pc50633 is probed, quite late in the day since it is an
- * I2C bus device.  Here we can define platform devices with the advantage that
- * we can mark the pcf50633 as the parent.  This makes them get suspended and
- * resumed with their parent the pcf50633 still around.  All devices whose
- * operation depends on something from pcf50633 must have this relationship
- * made explicit like this, or suspend and resume will become an unreliable
- * hellworld.
- */
-
-static void gta02_pmu_attach_child_devices(struct pcf50633 *pcf)
-{
-	int n;
-
-	/* Grab a copy of the now probed PMU pointer. */
-	gta02_pcf = pcf;
-
-	for (n = 0; n < ARRAY_SIZE(gta02_devices_pmu_children); n++)
-		gta02_devices_pmu_children[n]->dev.parent = pcf->dev;
-
-	platform_add_devices(gta02_devices_pmu_children,
-			     ARRAY_SIZE(gta02_devices_pmu_children));
-}
-
 static void gta02_poweroff(void)
 {
 	pcf50633_reg_set_bit_mask(gta02_pcf, PCF50633_REG_OOCSHDWN, 1, 1);
-- 
2.14.1

