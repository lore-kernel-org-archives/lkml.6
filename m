Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932223AbeDXJTh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 05:19:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52324 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932077AbeDXJTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 05:19:10 -0400
From: Hans de Goede <hdegoede@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kevin Shanahan <kevin@shanahan.id.au>
Subject: [PATCH] libata: Apply NOLPM quirk for SAMSUNG MZMPC128HBFU-000MV SSD
Date: Tue, 24 Apr 2018 11:19:07 +0200
Message-Id: <20180424091907.19903-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Shanahan reports the following repeating errors when using LPM,
causing long delays accessing the disk:

  Apr 23 10:21:43 link kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x50000 action 0x6 frozen
  Apr 23 10:21:43 link kernel: ata1: SError: { PHYRdyChg CommWake }
  Apr 23 10:21:43 link kernel: ata1.00: failed command: WRITE DMA
  Apr 23 10:21:43 link kernel: ata1.00: cmd ca/00:08:60:5d:cd/00:00:00:00:00/e1 tag 9 dma 4096 out
                                        res 50/01:01:01:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
  Apr 23 10:21:43 link kernel: ata1.00: status: { DRDY }
  Apr 23 10:21:43 link kernel: ata1.00: error: { AMNF }
  Apr 23 10:21:43 link kernel: ata1: hard resetting link
  Apr 23 10:21:43 link kernel: ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
  Apr 23 10:21:43 link kernel: ata1.00: configured for UDMA/133
  Apr 23 10:21:43 link kernel: ata1: EH complete

These go away when switching from med_power_with_dipm to medium_power.

This is somewhat weird as the PM830 datasheet explicitly mentions DIPM
being supported and the idle power-consumption is specified with DIPM
enabled.

There are many OEM customized firmware versions for the PM830, so for now
lets assume this is firmware version specific and blacklist LPM based on
the firmware version.

Cc: Kevin Shanahan <kevin@shanahan.id.au>
Reported-by: Kevin Shanahan <kevin@shanahan.id.au>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/ata/libata-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 8bc71ca61e7f..6e400ff2b5db 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4549,6 +4549,9 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 						ATA_HORKAGE_ZERO_AFTER_TRIM |
 						ATA_HORKAGE_NOLPM, },
 
+	/* This specific Samsung model/firmware-rev does not handle LPM well */
+	{ "SAMSUNG MZMPC128HBFU-000MV", "CXM14M1Q", ATA_HORKAGE_NOLPM, },
+
 	/* devices that don't properly handle queued TRIM commands */
 	{ "Micron_M500_*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
-- 
2.17.0
