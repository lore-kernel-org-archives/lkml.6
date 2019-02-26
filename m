Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AE4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A900217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfBZKxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 05:53:18 -0500
Received: from smtp.asem.it ([151.1.184.197]:61601 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726602AbfBZKxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 05:53:17 -0500
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Feb 2019 05:53:16 EST
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 5.5.0)
        with ESMTP id SG003717272.MSG 
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
Subject: [PATCH v1 0/1] mtd: devices: add ACPI support for non-jedec m25p80
Date:   Tue, 26 Feb 2019 11:48:07 +0100
Message-ID: <1551178088-6615-1-git-send-email-f.suligoi@asem.it>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-SGHeloLookup-Result: pass smtp.helo=webmail.asem.it (ip=172.16.16.44)
X-SGSPF-Result: none (smtp.asem.it)
X-SGOP-RefID: str=0001.0A0B0207.5C75196B.0049,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch concerns the use of a "non-jedec" m25p80 device in a x86 machine.

For an x86 machine a m25p80 device has to be declared inside a BIOS ACPI table
(for example inside the SSDT or the DSDT table).

No matching problems for the jedec compatible devices, since we have the list:

static const struct of_device_id m25p_of_table[] = {
	{ .compatible = "jedec,spi-nor" },
	{}
};

But for the "non-jedec" devices there are no possible matches, even if we try to
use, the SPI modalias, as:

spi:mr25h40

So it is necessary filling the m25p_of_table with all the m25p80 device names
used in the driver. This solution works both for the ACPI-style (x86) and 
the DT-style declarations (ARM).
I checked this patch with:

1) x68 board using both an SSDT and DSDT tables
2) i.MX6DL custom board using a Device Tree 

This is an example of working SSDT table for x86:

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

Flavio Suligoi (1):
  mtd: devices: add ACPI support for non-jedec m25p80

 drivers/mtd/devices/m25p80.c | 57 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

-- 
2.7.4

