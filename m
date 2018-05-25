Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935886AbeEYHej (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 03:34:39 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:37316 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935429AbeEYHei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 03:34:38 -0400
Date: Fri, 25 May 2018 17:34:36 +1000
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <53ce6de3ce0c030aaf5293fe40c4b3a7ae2b1664.1527232847.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH] m68k/mac: Enable PDMA for PowerBook 500 series
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I can confirm that mac_scsi PDMA now works on these machines.
This increases sequential read throughput by a factor of 4.5.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 arch/m68k/include/asm/macintosh.h |  1 -
 arch/m68k/mac/config.c            | 19 +------------------
 2 files changed, 1 insertion(+), 19 deletions(-)

diff --git a/arch/m68k/include/asm/macintosh.h b/arch/m68k/include/asm/macintosh.h
index 9b840c03ebb7..08cee11180e6 100644
--- a/arch/m68k/include/asm/macintosh.h
+++ b/arch/m68k/include/asm/macintosh.h
@@ -57,7 +57,6 @@ struct mac_model
 #define MAC_SCSI_IIFX		5
 #define MAC_SCSI_DUO		6
 #define MAC_SCSI_LC		7
-#define MAC_SCSI_LATE		8
 
 #define MAC_IDE_NONE		0
 #define MAC_IDE_QUADRA		1
diff --git a/arch/m68k/mac/config.c b/arch/m68k/mac/config.c
index 0c3275aa0197..834e79bc6043 100644
--- a/arch/m68k/mac/config.c
+++ b/arch/m68k/mac/config.c
@@ -709,7 +709,7 @@ static struct mac_model mac_data_table[] = {
 		.name		= "PowerBook 520",
 		.adb_type	= MAC_ADB_PB2,
 		.via_type	= MAC_VIA_QUADRA,
-		.scsi_type	= MAC_SCSI_LATE,
+		.scsi_type	= MAC_SCSI_OLD,
 		.scc_type	= MAC_SCC_QUADRA,
 		.ether_type	= MAC_ETHER_SONIC,
 		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
@@ -943,18 +943,6 @@ static const struct resource mac_scsi_old_rsrc[] __initconst = {
 	},
 };
 
-static const struct resource mac_scsi_late_rsrc[] __initconst = {
-	{
-		.flags = IORESOURCE_IRQ,
-		.start = IRQ_MAC_SCSI,
-		.end   = IRQ_MAC_SCSI,
-	}, {
-		.flags = IORESOURCE_MEM,
-		.start = 0x50010000,
-		.end   = 0x50011FFF,
-	},
-};
-
 static const struct resource mac_scsi_ccl_rsrc[] __initconst = {
 	{
 		.flags = IORESOURCE_IRQ,
@@ -1064,11 +1052,6 @@ int __init mac_platform_init(void)
 		platform_device_register_simple("mac_scsi", 0,
 			mac_scsi_old_rsrc, ARRAY_SIZE(mac_scsi_old_rsrc));
 		break;
-	case MAC_SCSI_LATE:
-		/* XXX PDMA support for PowerBook 500 series needs testing */
-		platform_device_register_simple("mac_scsi", 0,
-			mac_scsi_late_rsrc, ARRAY_SIZE(mac_scsi_late_rsrc));
-		break;
 	case MAC_SCSI_LC:
 		/* Addresses from Mac LC data in Designing Cards & Drivers 3ed.
 		 * Also from the Developer Notes for Classic II, LC III,
-- 
2.16.1
