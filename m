Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B51FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F410D20671
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:32:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F410D20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbeINSqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 14:46:37 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:51291 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728293AbeINSqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 14:46:35 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42Bbz20pmJz9ttgV;
        Fri, 14 Sep 2018 15:31:58 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id n_9n5AaHBPB7; Fri, 14 Sep 2018 15:31:58 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42Bbz20CCrz9ttgK;
        Fri, 14 Sep 2018 15:31:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3ACFD8B8BF;
        Fri, 14 Sep 2018 15:32:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id PcrZRfdGl979; Fri, 14 Sep 2018 15:32:02 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F2DD78B8BC;
        Fri, 14 Sep 2018 15:32:01 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id E2205718F8; Fri, 14 Sep 2018 13:32:01 +0000 (UTC)
Message-Id: <4381d1515addcbc5329fbc955ef4a5074ab9afef.1536931725.git.christophe.leroy@c-s.fr>
In-Reply-To: <5edda1a360cf7867b98a72a1dfa22db3bd5ed7b4.1536931725.git.christophe.leroy@c-s.fr>
References: <5edda1a360cf7867b98a72a1dfa22db3bd5ed7b4.1536931725.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 2/3] watchdog: mpc8xxx: provide boot status
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Radu Rendec <radu.rendec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
Date:   Fri, 14 Sep 2018 13:32:01 +0000 (UTC)
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
 drivers/watchdog/mpc8xxx_wdt.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
index 1dcf5f10cdd9..4a4700458b17 100644
--- a/drivers/watchdog/mpc8xxx_wdt.c
+++ b/drivers/watchdog/mpc8xxx_wdt.c
@@ -47,6 +47,7 @@ struct mpc8xxx_wdt {
 struct mpc8xxx_wdt_type {
 	int prescaler;
 	bool hw_enabled;
+	u32 rsr_mask;
 };
 
 struct mpc8xxx_wdt_ddata {
@@ -136,6 +137,7 @@ static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
 	u32 freq = fsl_get_sys_freq();
 	bool enabled;
 	struct device *dev = &ofdev->dev;
+	u32 __iomem *rsr = NULL;
 
 	wdt_type = of_device_get_match_data(dev);
 	if (!wdt_type)
@@ -159,6 +161,21 @@ static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
 		return -ENODEV;
 	}
 
+	res = platform_get_resource(ofdev, IORESOURCE_MEM, 1);
+	if (res)
+		rsr = ioremap(res->start, resource_size(res));
+	if (rsr) {
+		bool status = in_be32(rsr) & wdt_type->rsr_mask;
+
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
@@ -216,6 +233,7 @@ static const struct of_device_id mpc8xxx_wdt_match[] = {
 		.compatible = "mpc83xx_wdt",
 		.data = &(struct mpc8xxx_wdt_type) {
 			.prescaler = 0x10000,
+			.rsr_mask = BIT(3), /* RSR Bit SWRS */
 		},
 	},
 	{
@@ -223,6 +241,7 @@ static const struct of_device_id mpc8xxx_wdt_match[] = {
 		.data = &(struct mpc8xxx_wdt_type) {
 			.prescaler = 0x10000,
 			.hw_enabled = true,
+			.rsr_mask = BIT(20), /* RSTRSCR Bit WDT_RR */
 		},
 	},
 	{
@@ -230,6 +249,7 @@ static const struct of_device_id mpc8xxx_wdt_match[] = {
 		.data = &(struct mpc8xxx_wdt_type) {
 			.prescaler = 0x800,
 			.hw_enabled = true,
+			.rsr_mask = BIT(28), /* RSR Bit SWRS */
 		},
 	},
 	{},
-- 
2.13.3

