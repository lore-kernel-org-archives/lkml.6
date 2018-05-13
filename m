Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751984AbeEMSLt (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 14:11:49 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:15470 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751295AbeEMSLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 14:11:48 -0400
From: fcami@fedoraproject.org
To: tj@kernel.org, hdegoede@redhat.com, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org
Cc: =?UTF-8?q?Fran=C3=A7ois=20Cami?= <fcami@fedoraproject.org>
Subject: [PATCH] libata: Apply NOLPM quirk for SAMSUNG PM830 CXM13D1Q.
Date: Sun, 13 May 2018 20:11:15 +0200
Message-Id: <20180513181115.20541-1-fcami@fedoraproject.org>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: François Cami <fcami@fedoraproject.org>

Without this patch the drive errors out regularly:

[    1.090154] ata1.00: ATA-8: SAMSUNG SSD PM830 mSATA 256GB,
CXM13D1Q, max UDMA/133
(...)
[  345.154996] ata1.00: exception Emask 0x40 SAct 0x0 SErr 0xc0800 action 0x6
[  345.155006] ata1.00: irq_stat 0x40000001
[  345.155013] ata1: SError: { HostInt CommWake 10B8B }
[  345.155018] ata1.00: failed command: SET FEATURES
[  345.155032] ata1.00: cmd ef/05:e1:00:00:00/00:00:00:00:00/40 tag 7
                        res 51/04:e1:00:00:00/00:00:00:00:00/40 Emask 0x41 (internal error)
[  345.155038] ata1.00: status: { DRDY ERR }
[  345.155042] ata1.00: error: { ABRT }
[  345.155051] ata1: hard resetting link
[  345.465661] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[  345.466955] ata1.00: configured for UDMA/133
[  345.467085] ata1: EH complete

Signed-off-by: François Cami <fcami@fedoraproject.org>
Acked-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/ata/libata-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 68596bd4cf06..1ca365f13040 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4549,8 +4549,9 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 						ATA_HORKAGE_ZERO_AFTER_TRIM |
 						ATA_HORKAGE_NOLPM, },
 
-	/* This specific Samsung model/firmware-rev does not handle LPM well */
+	/* These specific Samsung models/firmware-revs do not handle LPM well */
 	{ "SAMSUNG MZMPC128HBFU-000MV", "CXM14M1Q", ATA_HORKAGE_NOLPM, },
+	{ "SAMSUNG SSD PM830 mSATA *",  "CXM13D1Q", ATA_HORKAGE_NOLPM, },
 
 	/* Sandisk devices which are known to not handle LPM well */
 	{ "SanDisk SD7UB3Q*G1001",	NULL,	ATA_HORKAGE_NOLPM, },
-- 
2.17.0
