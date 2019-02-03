Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF629C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA4F32084A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbfBCN5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:57:12 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53910 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728389AbfBCNuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:50:03 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9p-0003th-5N; Sun, 03 Feb 2019 13:50:01 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9j-0007Fd-GZ; Sun, 03 Feb 2019 14:49:55 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Marc" <suaefar@googlemail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Lukas Kahnert" <openproggerfreak@gmail.com>,
        "Hans de Goede" <hdegoede@redhat.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.572144002@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 217/305] ACPI / platform: Add SMB0001 HID to
 forbidden_id_list
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit 2bbb5fa37475d7aa5fa62f34db1623f3da2dfdfa upstream.

Many HP AMD based laptops contain an SMB0001 device like this:

Device (SMBD)
{
    Name (_HID, "SMB0001")  // _HID: Hardware ID
    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
    {
        IO (Decode16,
            0x0B20,             // Range Minimum
            0x0B20,             // Range Maximum
            0x20,               // Alignment
            0x20,               // Length
            )
        IRQ (Level, ActiveLow, Shared, )
            {7}
    })
}

The legacy style IRQ resource here causes acpi_dev_get_irqresource() to
be called with legacy=true and this message to show in dmesg:
ACPI: IRQ 7 override to edge, high

This causes issues when later on the AMD0030 GPIO device gets enumerated:

Device (GPIO)
{
    Name (_HID, "AMDI0030")  // _HID: Hardware ID
    Name (_CID, "AMDI0030")  // _CID: Compatible ID
    Name (_UID, Zero)  // _UID: Unique ID
    Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
    {
	Name (RBUF, ResourceTemplate ()
	{
	    Interrupt (ResourceConsumer, Level, ActiveLow, Shared, ,, )
	    {
		0x00000007,
	    }
	    Memory32Fixed (ReadWrite,
		0xFED81500,         // Address Base
		0x00000400,         // Address Length
		)
	})
	Return (RBUF) /* \_SB_.GPIO._CRS.RBUF */
    }
}

Now acpi_dev_get_irqresource() gets called with legacy=false, but because
of the earlier override of the trigger-type acpi_register_gsi() returns
-EBUSY (because we try to register the same interrupt with a different
trigger-type) and we end up setting IORESOURCE_DISABLED in the flags.

The setting of IORESOURCE_DISABLED causes platform_get_irq() to call
acpi_irq_get() which is not implemented on x86 and returns -EINVAL.
resulting in the following in dmesg:

amd_gpio AMDI0030:00: Failed to get gpio IRQ: -22
amd_gpio: probe of AMDI0030:00 failed with error -22

The SMB0001 is a "virtual" device in the sense that the only way the OS
interacts with it is through calling a couple of methods to do SMBus
transfers. As such it is weird that it has IO and IRQ resources at all,
because the driver for it is not expected to ever access the hardware
directly.

The Linux driver for the SMB0001 device directly binds to the acpi_device
through the acpi_bus, so we do not need to instantiate a platform_device
for this ACPI device. This commit adds the SMB0001 HID to the
forbidden_id_list, avoiding the instantiating of a platform_device for it.
Not instantiating a platform_device means we will no longer call
acpi_dev_get_irqresource() for the legacy IRQ resource fixing the probe of
the AMDI0030 device failing.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1644013
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=198715
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=199523
Reported-by: Lukas Kahnert <openproggerfreak@gmail.com>
Tested-by: Marc <suaefar@googlemail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/acpi/acpi_platform.c | 1 +
 1 file changed, 1 insertion(+)

--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -28,6 +28,7 @@ static const struct acpi_device_id forbi
 	{"PNP0200",  0},	/* AT DMA Controller */
 	{"ACPI0009", 0},	/* IOxAPIC */
 	{"ACPI000A", 0},	/* IOAPIC */
+	{"SMB0001",  0},	/* ACPI SMBUS virtual device */
 	{"", 0},
 };
 

