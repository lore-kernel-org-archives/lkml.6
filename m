Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0500C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE072173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbfBZKxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 05:53:21 -0500
Received: from smtp.asem.it ([151.1.184.197]:61601 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727342AbfBZKxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 05:53:19 -0500
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Feb 2019 05:53:16 EST
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 5.5.0)
        with ESMTP id SG003717273.MSG 
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 11:48:11 +0100S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1261.35; Tue, 26
 Feb 2019 11:48:10 +0100
Received: from flavio-x.asem.intra (172.16.17.161) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server id 15.1.1261.35 via Frontend
 Transport; Tue, 26 Feb 2019 11:48:10 +0100
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Brown <broonie@kernel.org>,
        Frieder Schrempf <frieder.schrempf@exceet.de>,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH v1 1/1] mtd: devices: add ACPI support for non-jedec m25p80
Date:   Tue, 26 Feb 2019 11:48:08 +0100
Message-ID: <1551178088-6615-2-git-send-email-f.suligoi@asem.it>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551178088-6615-1-git-send-email-f.suligoi@asem.it>
References: <1551178088-6615-1-git-send-email-f.suligoi@asem.it>
MIME-Version: 1.0
Content-Type: text/plain
X-SGHeloLookup-Result: pass smtp.helo=webmail.asem.it (ip=172.16.16.44)
X-SGSPF-Result: none (smtp.asem.it)
X-SGOP-RefID: str=0001.0A0B0207.5C75196B.0066,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the x86 machines a m25p80-compatible device have to be declared using
an ACPI table (which can be directly a part of the BIOS ACPI tables).

In this case it is necessary to add the device in the "of_device_id" structure
list, to permit the device name matching by the ACPI kernel functions.

This is an example of a SSDT table for the Everspin mr25h40:

DefinitionBlock ("mr25h40.aml", "SSDT", 5, "ASEMsp", "MR25H40", 1)
{
	External (_SB.SPI1, DeviceObj)

	Scope (\_SB.SPI1)
	{
		Device (NVR0)
		{
			Name (_HID, "PRP0001")
			Name (_DDN, "Everspin MR25H40 MRAM")
			Name (_CRS, ResourceTemplate () {
				SpiSerialBus (
				1,                      // Chip select
				PolarityLow,            // Chip select is active low
				FourWireMode,           // Full duplex
				8,                      // Bits per word is 8 (byte)
				ControllerInitiated,    // Don't care
				10000000,               // 10 MHz
				ClockPolarityLow,       // SPI mode 0 ClockPolarityLow
				ClockPhaseFirst,        // SPI mode 0 ClockPhaseFirst
				"\\_SB.SPI1",      	// SPI host controller
				0,			// Must be 0
				ResourceConsumer,
				,
				)
			})

			Name (_DSD, Package () {
				ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
				Package () {
					Package () {"compatible", "mr25h40"},
				}
			})
		}
	}
}

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---

v1: - first patch version

 drivers/mtd/devices/m25p80.c | 57 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index c4a1d04..b5c7db8 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -312,9 +312,64 @@ MODULE_DEVICE_TABLE(spi, m25p_ids);
 static const struct of_device_id m25p_of_table[] = {
 	/*
 	 * Generic compatibility for SPI NOR that can be identified by the
-	 * JEDEC READ ID opcode (0x9F). Use this, if possible.
+	 * JEDEC READ ID opcode (0x9F). Use this (jedec,spi-nor), if possible.
+	 *
+	 * The list of all flash devices is instead necessary in x86 machines,
+	 * to use a "non-jedec device" inside the ACPI BIOS tables.
 	 */
 	{ .compatible = "jedec,spi-nor" },
+	{ .compatible = "s25sl064a" },
+	{ .compatible = "w25x16" },
+	{ .compatible = "m25p10" },
+	{ .compatible = "m25px64" },
+	{ .compatible = "at25df321a" },
+	{ .compatible = "at25df641" },
+	{ .compatible = "at26df081a" },
+	{ .compatible = "mx25l4005a" },
+	{ .compatible = "mx25l1606e" },
+	{ .compatible = "mx25l6405d" },
+	{ .compatible = "mx25l12805d" },
+	{ .compatible = "mx25l25635e" },
+	{ .compatible = "mx66l51235l" },
+	{ .compatible = "n25q064" },
+	{ .compatible = "n25q128a11" },
+	{ .compatible = "n25q128a13" },
+	{ .compatible = "n25q512a" },
+	{ .compatible = "s25fl256s1" },
+	{ .compatible = "s25fl512s" },
+	{ .compatible = "s25sl12801" },
+	{ .compatible = "s25fl008k" },
+	{ .compatible = "s25fl064k" },
+	{ .compatible = "sst25vf040b" },
+	{ .compatible = "sst25vf016b" },
+	{ .compatible = "sst25vf032b" },
+	{ .compatible = "sst25wf040" },
+	{ .compatible = "m25p40" },
+	{ .compatible = "m25p80" },
+	{ .compatible = "m25p16" },
+	{ .compatible = "m25p32" },
+	{ .compatible = "m25p64" },
+	{ .compatible = "m25p128" },
+	{ .compatible = "w25x80" },
+	{ .compatible = "w25x32" },
+	{ .compatible = "w25q32" },
+	{ .compatible = "w25q32dw" },
+	{ .compatible = "w25q80bl" },
+	{ .compatible = "w25q128" },
+	{ .compatible = "w25q256" },
+	{ .compatible = "m25p05-nonjedec" },
+	{ .compatible = "m25p10-nonjedec" },
+	{ .compatible = "m25p20-nonjedec" },
+	{ .compatible = "m25p40-nonjedec" },
+	{ .compatible = "m25p80-nonjedec" },
+	{ .compatible = "m25p16-nonjedec" },
+	{ .compatible = "m25p32-nonjedec" },
+	{ .compatible = "m25p64-nonjedec" },
+	{ .compatible = "m25p128-nonjedec" },
+	{ .compatible = "mr25h128" },
+	{ .compatible = "mr25h256" },
+	{ .compatible = "mr25h10" },
+	{ .compatible = "mr25h40" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, m25p_of_table);
-- 
2.7.4

