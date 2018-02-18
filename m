Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751535AbeBRORW (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 09:17:22 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:52084 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751335AbeBRORU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 09:17:20 -0500
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: tj@kernel.org
Cc: hdegoede@redhat.com, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v2] libata: disable LPM for Crucial BX100 SSD 500GB drive
Date: Sun, 18 Feb 2018 22:17:09 +0800
Message-Id: <20180218141709.24913-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After Laptop Mode Tools starts to use min_power for LPM, a user found
out Crucial BX100 SSD can't get mounted.

Crucial BX100 SSD 500GB drive don't work well with min_power. This also
happens to med_power_with_dipm.

So let's disable LPM for Crucial BX100 SSD 500GB drive.

BugLink: https://bugs.launchpad.net/bugs/1726930
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2: Only apply the quirk to 500GB variant with firmware version MU02,
also reorder the quirk entry to make it next to other Crucial disks.

 drivers/ata/libata-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 28cad49fc846..cb789f8849ae 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4530,6 +4530,9 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "PIONEER DVD-RW  DVR-212D",	NULL,	ATA_HORKAGE_NOSETXFER },
 	{ "PIONEER DVD-RW  DVR-216D",	NULL,	ATA_HORKAGE_NOSETXFER },
 
+	/* Crucial BX100 SSD 500GB has broken LPM support */
+	{ "CT500BX100SSD1",		"MU02",	ATA_HORKAGE_NOLPM },
+
 	/* The 512GB version of the MX100 has both queued TRIM and LPM issues */
 	{ "Crucial_CT512MX100*",	NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM |
-- 
2.15.1
