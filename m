Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD96BC004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DB18206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:37:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DB18206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387704AbeJBUUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:20:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36638 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387680AbeJBUUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:20:38 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 600905AA;
        Tue,  2 Oct 2018 13:37:13 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yussuf Khalil <dev@pp3345.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean Delvare <jdelvare@suse.de>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 94/94] i2c: i801: Allow ACPI AML access I/O ports not reserved for SMBus
Date:   Tue,  2 Oct 2018 06:25:48 -0700
Message-Id: <20181002132507.053358151@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132500.494838053@linuxfoundation.org>
References: <20181002132500.494838053@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mika Westerberg <mika.westerberg@linux.intel.com>

[ Upstream commit 7fd6d98b89f382d414e1db528e29a67bbd749457 ]

Commit 7ae81952cda ("i2c: i801: Allow ACPI SystemIO OpRegion to conflict
with PCI BAR") made it possible for AML code to access SMBus I/O ports
by installing custom SystemIO OpRegion handler and blocking i80i driver
access upon first AML read/write to this OpRegion.

However, while ThinkPad T560 does have SystemIO OpRegion declared under
the SMBus device, it does not access any of the SMBus registers:

    Device (SMBU)
    {
        ...

        OperationRegion (SMBP, PCI_Config, 0x50, 0x04)
        Field (SMBP, DWordAcc, NoLock, Preserve)
        {
            ,   5,
            TCOB,   11,
            Offset (0x04)
        }

        Name (TCBV, 0x00)
        Method (TCBS, 0, NotSerialized)
        {
            If ((TCBV == 0x00))
            {
            TCBV = (\_SB.PCI0.SMBU.TCOB << 0x05)
            }

            Return (TCBV) /* \_SB_.PCI0.SMBU.TCBV */
        }

        OperationRegion (TCBA, SystemIO, TCBS (), 0x10)
        Field (TCBA, ByteAcc, NoLock, Preserve)
        {
            Offset (0x04),
            ,   9,
            CPSC,   1
        }
    }

Problem with the current approach is that it blocks all I/O port access
and because this system has touchpad connected to the SMBus controller
after first AML access (happens during suspend/resume cycle) the
touchpad fails to work anymore.

Fix this so that we allow ACPI AML I/O port access if it does not touch
the region reserved for the SMBus.

Fixes: 7ae81952cda ("i2c: i801: Allow ACPI SystemIO OpRegion to conflict with PCI BAR")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=200737
Reported-by: Yussuf Khalil <dev@pp3345.net>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i2c/busses/i2c-i801.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -1408,6 +1408,13 @@ static void i801_add_tco(struct i801_pri
 }
 
 #ifdef CONFIG_ACPI
+static bool i801_acpi_is_smbus_ioport(const struct i801_priv *priv,
+				      acpi_physical_address address)
+{
+	return address >= priv->smba &&
+	       address <= pci_resource_end(priv->pci_dev, SMBBAR);
+}
+
 static acpi_status
 i801_acpi_io_handler(u32 function, acpi_physical_address address, u32 bits,
 		     u64 *value, void *handler_context, void *region_context)
@@ -1423,7 +1430,7 @@ i801_acpi_io_handler(u32 function, acpi_
 	 */
 	mutex_lock(&priv->acpi_lock);
 
-	if (!priv->acpi_reserved) {
+	if (!priv->acpi_reserved && i801_acpi_is_smbus_ioport(priv, address)) {
 		priv->acpi_reserved = true;
 
 		dev_warn(&pdev->dev, "BIOS is accessing SMBus registers\n");


