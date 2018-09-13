Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C377C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 08:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F0EB2133F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 08:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F0EB2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbeIMNPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 09:15:45 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:56361 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726792AbeIMNPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 09:15:44 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 429rpw17qGz9ttlr;
        Thu, 13 Sep 2018 10:07:20 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id l3MDntBmrWA8; Thu, 13 Sep 2018 10:07:20 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 429rpw0NR1z9ttlp;
        Thu, 13 Sep 2018 10:07:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9C2BC8B879;
        Thu, 13 Sep 2018 10:07:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id VWz9OaWmQTfV; Thu, 13 Sep 2018 10:07:22 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 541FF8B74C;
        Thu, 13 Sep 2018 10:07:22 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 7E62A71916; Thu, 13 Sep 2018 08:07:21 +0000 (UTC)
Message-Id: <055ff141d12942ed5750cc9e803e730de0e38c93.1536778520.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] watchdog: mpc8xxx: provide boot status
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Radu Rendec <radu.rendec@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-watchdog@vger.kernel.org
Date:   Thu, 13 Sep 2018 08:07:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mpc8xxx watchdog driver supports the following platforms:
- mpc8xx
- mpc83xx
- mpc86xx

Those three platforms have a 32 bits register which provides the
reason of the last boot, including whether it was caused by the
watchdog.

mpc8xx: Register RSR, bit SWRS (bit 3)
mpc83xx: Register RSR, bit SWRS (bit 28)
mpc86xx: Register RSTRSCR, bit WDT_RR (bit 11)

This patch maps the register as defined in the device tree and updates
wdt.bootstatus based on the value of the watchdog related bit. Then
the information can be retrieved via the WDIOC_GETBOOTSTATUS ioctl.

Hereunder is an exemple of devicetree for mpc8xx,
the Reset Status Register being at offset 0x288:

		WDT: watchdog@0 {
			compatible = "fsl,mpc823-wdt";
			reg = <0x0 0x10 0x288 0x4>;
		};

On the mpc83xx, RSR is at offset 0x910
On the mpc86xx, RSTRSCR is at offset 0xe0094

Suggested-by: Radu Rendec <radu.rendec@gmail.com>
Tested-by: Christophe Leroy <christophe.leroy@c-s.fr> # On mpc885
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 drivers/watchdog/mpc8xxx_wdt.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
index aca2d6323f8a..2951a485a6b4 100644
--- a/drivers/watchdog/mpc8xxx_wdt.c
+++ b/drivers/watchdog/mpc8xxx_wdt.c
@@ -49,10 +49,12 @@ struct mpc8xxx_wdt {
 struct mpc8xxx_wdt_type {
 	int prescaler;
 	bool hw_enabled;
+	u32 rsr_mask;
 };
 
 struct mpc8xxx_wdt_ddata {
 	struct mpc8xxx_wdt __iomem *base;
+	u32 __iomem *rsr;
 	struct watchdog_device wdd;
 	spinlock_t lock;
 	u16 swtc;
@@ -137,6 +139,7 @@ static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
 	struct mpc8xxx_wdt_ddata *ddata;
 	u32 freq = fsl_get_sys_freq();
 	bool enabled;
+	struct device *dev = &ofdev->dev;
 
 	wdt_type = of_device_get_match_data(&ofdev->dev);
 	if (!wdt_type)
@@ -160,6 +163,22 @@ static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
 		return -ENODEV;
 	}
 
+	res = platform_get_resource(ofdev, IORESOURCE_MEM, 1);
+	ddata->rsr = devm_ioremap_resource(dev, res);
+	if (IS_ERR(ddata->rsr)) {
+		dev_info(dev, "Could not map reset status register");
+	} else {
+		u32 rsr_v = in_be32(ddata->rsr);
+		bool status = rsr_v & wdt_type->rsr_mask;
+
+		ddata->wdd.bootstatus = status ? WDIOF_CARDRESET : 0;
+		 /* clear reset status bits related to watchdog time */
+		out_be32(ddata->rsr, wdt_type->rsr_mask);
+
+		dev_info(dev, "Last boot was %s by watchdog (RSR = 0x%8.8x)\n",
+			 status ? "caused" : "not caused", rsr_v);
+	}
+
 	spin_lock_init(&ddata->lock);
 
 	ddata->wdd.info = &mpc8xxx_wdt_info,
@@ -216,6 +235,7 @@ static const struct of_device_id mpc8xxx_wdt_match[] = {
 		.compatible = "mpc83xx_wdt",
 		.data = &(struct mpc8xxx_wdt_type) {
 			.prescaler = 0x10000,
+			.rsr_mask = BIT(3), /* RSR Bit 28 */
 		},
 	},
 	{
@@ -223,6 +243,7 @@ static const struct of_device_id mpc8xxx_wdt_match[] = {
 		.data = &(struct mpc8xxx_wdt_type) {
 			.prescaler = 0x10000,
 			.hw_enabled = true,
+			.rsr_mask = BIT(20), /* RSTRSCR Bit 11 */
 		},
 	},
 	{
@@ -230,6 +251,7 @@ static const struct of_device_id mpc8xxx_wdt_match[] = {
 		.data = &(struct mpc8xxx_wdt_type) {
 			.prescaler = 0x800,
 			.hw_enabled = true,
+			.rsr_mask = BIT(28), /* RSR Bit 3 */
 		},
 	},
 	{},
-- 
2.13.3

