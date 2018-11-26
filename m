Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A12DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BEBA2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkSXMNS+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BEBA2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbeKZVuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:50:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:59086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726532AbeKZVuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:50:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D2A720817;
        Mon, 26 Nov 2018 10:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229776;
        bh=LZSYPzeNML9vuBugSGWnapQwR2hJkQ+PldBYtd2MDx0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CkSXMNS+wrYHqV9TPrBNnvgZLrXwhSj2dK0b89VOnKH3ezY3CtCy8vWzppTLLD845
         722iEvUr2QPDGEW96jqGEXfKyEPD9h8RkOb0GX2/cLmHj3AMDqofJbRKx6ndqICUOL
         NBB8XNsHJHk8bA82OnUXz+9xVUyBX1OfSV62P0M4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lukas Kahnert <openproggerfreak@gmail.com>,
        Marc <suaefar@googlemail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.4 68/70] ACPI / platform: Add SMB0001 HID to forbidden_id_list
Date:   Mon, 26 Nov 2018 11:51:23 +0100
Message-Id: <20181126105053.089505074@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105046.722096341@linuxfoundation.org>
References: <20181126105046.722096341@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

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
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/acpi_platform.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -29,6 +29,7 @@ static const struct acpi_device_id forbi
 	{"PNP0200",  0},	/* AT DMA Controller */
 	{"ACPI0009", 0},	/* IOxAPIC */
 	{"ACPI000A", 0},	/* IOAPIC */
+	{"SMB0001",  0},	/* ACPI SMBUS virtual device */
 	{"", 0},
 };
 


