Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D232AECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 06:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9175B214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 06:22:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9175B214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbeIQLsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 07:48:50 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:64957 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727130AbeIQLst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 07:48:49 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42DGJM3jbFz9ttC3;
        Mon, 17 Sep 2018 08:22:43 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id p7nuRR7PhQqb; Mon, 17 Sep 2018 08:22:43 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42DGJM3DCgz9ttBw;
        Mon, 17 Sep 2018 08:22:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6A5A48B788;
        Mon, 17 Sep 2018 08:22:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id UVG-svbMFVMJ; Mon, 17 Sep 2018 08:22:52 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3A5B38B786;
        Mon, 17 Sep 2018 08:22:52 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id E4DC9715B8; Mon, 17 Sep 2018 06:22:50 +0000 (UTC)
Message-Id: <207741bf9c994a869f574a93d4fb4152d4e169c9.1537163779.git.christophe.leroy@c-s.fr>
In-Reply-To: <c09f541d459c29aca40d54fff152d5645e24b50d.1537163776.git.christophe.leroy@c-s.fr>
References: <c09f541d459c29aca40d54fff152d5645e24b50d.1537163776.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 2/3] watchdog: mpc8xxx: provide boot status
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Radu Rendec <radu.rendec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
Date:   Mon, 17 Sep 2018 06:22:50 +0000 (UTC)
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

Hereunder is an example of devicetree for mpc8xx,
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
index 1dcf5f10cdd9..069072e6747d 100644
--- a/drivers/watchdog/mpc8xxx_wdt.c
+++ b/drivers/watchdog/mpc8xxx_wdt.c
@@ -47,6 +47,7 @@ struct mpc8xxx_wdt {
 struct mpc8xxx_wdt_type {
 	int prescaler;
 	bool hw_enabled;
+	u32 rsr_mask;
 };
 
 struct mpc8xxx_wdt_ddata {
@@ -159,6 +160,24 @@ static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
 		return -ENODEV;
 	}
 
+	res = platform_get_resource(ofdev, IORESOURCE_MEM, 1);
+	if (res) {
+		bool status;
+		u32 __iomem *rsr = ioremap(res->start, resource_size(res));
+
+		if (!rsr)
+			return -ENOMEM;
+
+		status = in_be32(rsr) & wdt_type->rsr_mask;
+		ddata->wdd.bootstatus = status ? WDIOF_CARDRESET : 0;
+		 /* clear reset status bits related to watchdog timer */
+		out_be32(rsr, wdt_type->rsr_mask);
+		iounmap(rsr);
+
+		dev_info(dev, "Last boot was %scaused by watchdog\n",
+			 status ? "" : "not ");
+	}
+
 	spin_lock_init(&ddata->lock);
 
 	ddata->wdd.info = &mpc8xxx_wdt_info,
@@ -216,6 +235,7 @@ static const struct of_device_id mpc8xxx_wdt_match[] = {
 		.compatible = "mpc83xx_wdt",
 		.data = &(struct mpc8xxx_wdt_type) {
 			.prescaler = 0x10000,
+			.rsr_mask = BIT(3), /* RSR Bit SWRS */
 		},
 	},
 	{
@@ -223,6 +243,7 @@ static const struct of_device_id mpc8xxx_wdt_match[] = {
 		.data = &(struct mpc8xxx_wdt_type) {
 			.prescaler = 0x10000,
 			.hw_enabled = true,
+			.rsr_mask = BIT(20), /* RSTRSCR Bit WDT_RR */
 		},
 	},
 	{
@@ -230,6 +251,7 @@ static const struct of_device_id mpc8xxx_wdt_match[] = {
 		.data = &(struct mpc8xxx_wdt_type) {
 			.prescaler = 0x800,
 			.hw_enabled = true,
+			.rsr_mask = BIT(28), /* RSR Bit SWRS */
 		},
 	},
 	{},
-- 
2.13.3

