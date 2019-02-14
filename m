Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB735C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 22:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8645A2177E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 22:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440512AbfBNWXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 17:23:55 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:46784 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440473AbfBNWXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 17:23:02 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 7516129BE0; Thu, 14 Feb 2019 17:22:55 -0500 (EST)
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Joshua Thompson <funaho@jurai.org>
Cc:     Laurent Vivier <lvivier@redhat.com>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Message-Id: <224218b529a5abb1d5dd5ce2103b685a10866577.1550182390.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH] m68k/mac: Revisit floppy disc controller base addresses
Date:   Fri, 15 Feb 2019 09:13:10 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename floppy_type macros to make them more consistent with the scsi_type
macros, which are named after classes of models with similar memory maps.

The documentation for LC-class machines has the IO devices at offsets
from $50F0 0000. Use these addresses (consistent with mac_scsi resources)
because they may not be aliased elsewhere in the memory map, e.g. at
offsets from $5000 0000.

Add comments with controller type information from 'Designing Cards and
Drivers for the Macintosh Family', relevant Developer Notes and
http://mess.redump.net/mess/driver_info/mac_technical_notes

Adopt phys_addr_t to avoid type casts.

Cc: Laurent Vivier <lvivier@redhat.com>
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Acked-by: Laurent Vivier <lvivier@redhat.com>
---
 arch/m68k/include/asm/macintosh.h |  10 +--
 arch/m68k/mac/config.c            | 128 +++++++++++++++---------------
 2 files changed, 69 insertions(+), 69 deletions(-)

diff --git a/arch/m68k/include/asm/macintosh.h b/arch/m68k/include/asm/macintosh.h
index 08cee11180e6..344fe91ad671 100644
--- a/arch/m68k/include/asm/macintosh.h
+++ b/arch/m68k/include/asm/macintosh.h
@@ -78,11 +78,11 @@ struct mac_model
 #define MAC_EXP_PDS_NUBUS	3 /* Accepts PDS card and/or NuBus card(s) */
 #define MAC_EXP_PDS_COMM	4 /* Accepts PDS card or Comm Slot card */
 
-#define MAC_FLOPPY_IWM		0
-#define MAC_FLOPPY_SWIM_ADDR1	1
-#define MAC_FLOPPY_SWIM_ADDR2	2
-#define MAC_FLOPPY_SWIM_IOP	3
-#define MAC_FLOPPY_AV		4
+#define MAC_FLOPPY_UNSUPPORTED	0
+#define MAC_FLOPPY_SWIM_IOP	1
+#define MAC_FLOPPY_OLD		2
+#define MAC_FLOPPY_QUADRA	3
+#define MAC_FLOPPY_LC		4
 
 extern struct mac_model *macintosh_config;
 
diff --git a/arch/m68k/mac/config.c b/arch/m68k/mac/config.c
index 11be08f4f750..39835ca5a474 100644
--- a/arch/m68k/mac/config.c
+++ b/arch/m68k/mac/config.c
@@ -209,7 +209,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_OLD,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_NUBUS,
-		.floppy_type	= MAC_FLOPPY_IWM,
+		.floppy_type	= MAC_FLOPPY_UNSUPPORTED, /* IWM */
 	},
 
 	/*
@@ -224,7 +224,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_OLD,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_NUBUS,
-		.floppy_type	= MAC_FLOPPY_IWM,
+		.floppy_type	= MAC_FLOPPY_UNSUPPORTED, /* IWM */
 	}, {
 		.ident		= MAC_MODEL_IIX,
 		.name		= "IIx",
@@ -233,7 +233,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_OLD,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_IICX,
 		.name		= "IIcx",
@@ -242,7 +242,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_OLD,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_SE30,
 		.name		= "SE/30",
@@ -251,7 +251,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_OLD,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_PDS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	},
 
 	/*
@@ -269,7 +269,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_OLD,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_IIFX,
 		.name		= "IIfx",
@@ -278,7 +278,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_IIFX,
 		.scc_type	= MAC_SCC_IOP,
 		.expansion_type	= MAC_EXP_PDS_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_IOP,
+		.floppy_type	= MAC_FLOPPY_SWIM_IOP, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_IISI,
 		.name		= "IIsi",
@@ -287,7 +287,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_OLD,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_PDS_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_IIVI,
 		.name		= "IIvi",
@@ -296,7 +296,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_LC,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_LC, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_IIVX,
 		.name		= "IIvx",
@@ -305,7 +305,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_LC,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_LC, /* SWIM */
 	},
 
 	/*
@@ -319,7 +319,7 @@ static struct mac_model mac_data_table[] = {
 		.via_type	= MAC_VIA_IICI,
 		.scsi_type	= MAC_SCSI_LC,
 		.scc_type	= MAC_SCC_II,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_LC, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_CCL,
 		.name		= "Color Classic",
@@ -328,7 +328,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_LC,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_PDS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_LC, /* SWIM 2 */
 	}, {
 		.ident		= MAC_MODEL_CCLII,
 		.name		= "Color Classic II",
@@ -337,7 +337,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_LC,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_PDS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_LC, /* SWIM 2 */
 	},
 
 	/*
@@ -352,7 +352,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_LC,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_PDS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_LC, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_LCII,
 		.name		= "LC II",
@@ -361,7 +361,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_LC,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_PDS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_LC, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_LCIII,
 		.name		= "LC III",
@@ -370,7 +370,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_LC,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_PDS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_LC, /* SWIM 2 */
 	},
 
 	/*
@@ -391,7 +391,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_QUADRA,
 		.scc_type	= MAC_SCC_QUADRA,
 		.expansion_type	= MAC_EXP_PDS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR1,
+		.floppy_type	= MAC_FLOPPY_QUADRA, /* SWIM 2 */
 	}, {
 		.ident		= MAC_MODEL_Q605_ACC,
 		.name		= "Quadra 605",
@@ -400,7 +400,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_QUADRA,
 		.scc_type	= MAC_SCC_QUADRA,
 		.expansion_type	= MAC_EXP_PDS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR1,
+		.floppy_type	= MAC_FLOPPY_QUADRA, /* SWIM 2 */
 	}, {
 		.ident		= MAC_MODEL_Q610,
 		.name		= "Quadra 610",
@@ -410,7 +410,7 @@ static struct mac_model mac_data_table[] = {
 		.scc_type	= MAC_SCC_QUADRA,
 		.ether_type	= MAC_ETHER_SONIC,
 		.expansion_type	= MAC_EXP_PDS_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR1,
+		.floppy_type	= MAC_FLOPPY_QUADRA, /* SWIM 2 */
 	}, {
 		.ident		= MAC_MODEL_Q630,
 		.name		= "Quadra 630",
@@ -420,7 +420,7 @@ static struct mac_model mac_data_table[] = {
 		.ide_type	= MAC_IDE_QUADRA,
 		.scc_type	= MAC_SCC_QUADRA,
 		.expansion_type	= MAC_EXP_PDS_COMM,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR1,
+		.floppy_type	= MAC_FLOPPY_QUADRA, /* SWIM 2 */
 	}, {
 		.ident		= MAC_MODEL_Q650,
 		.name		= "Quadra 650",
@@ -430,7 +430,7 @@ static struct mac_model mac_data_table[] = {
 		.scc_type	= MAC_SCC_QUADRA,
 		.ether_type	= MAC_ETHER_SONIC,
 		.expansion_type	= MAC_EXP_PDS_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR1,
+		.floppy_type	= MAC_FLOPPY_QUADRA, /* SWIM 2 */
 	},
 	/* The Q700 does have a NS Sonic */
 	{
@@ -442,7 +442,7 @@ static struct mac_model mac_data_table[] = {
 		.scc_type	= MAC_SCC_QUADRA,
 		.ether_type	= MAC_ETHER_SONIC,
 		.expansion_type	= MAC_EXP_PDS_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR1,
+		.floppy_type	= MAC_FLOPPY_QUADRA, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_Q800,
 		.name		= "Quadra 800",
@@ -452,7 +452,7 @@ static struct mac_model mac_data_table[] = {
 		.scc_type	= MAC_SCC_QUADRA,
 		.ether_type	= MAC_ETHER_SONIC,
 		.expansion_type	= MAC_EXP_PDS_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR1,
+		.floppy_type	= MAC_FLOPPY_QUADRA, /* SWIM 2 */
 	}, {
 		.ident		= MAC_MODEL_Q840,
 		.name		= "Quadra 840AV",
@@ -462,7 +462,7 @@ static struct mac_model mac_data_table[] = {
 		.scc_type	= MAC_SCC_PSC,
 		.ether_type	= MAC_ETHER_MACE,
 		.expansion_type	= MAC_EXP_NUBUS,
-		.floppy_type	= MAC_FLOPPY_AV,
+		.floppy_type	= MAC_FLOPPY_UNSUPPORTED, /* New Age */
 	}, {
 		.ident		= MAC_MODEL_Q900,
 		.name		= "Quadra 900",
@@ -472,7 +472,7 @@ static struct mac_model mac_data_table[] = {
 		.scc_type	= MAC_SCC_IOP,
 		.ether_type	= MAC_ETHER_SONIC,
 		.expansion_type	= MAC_EXP_PDS_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_IOP,
+		.floppy_type	= MAC_FLOPPY_SWIM_IOP, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_Q950,
 		.name		= "Quadra 950",
@@ -482,7 +482,7 @@ static struct mac_model mac_data_table[] = {
 		.scc_type	= MAC_SCC_IOP,
 		.ether_type	= MAC_ETHER_SONIC,
 		.expansion_type	= MAC_EXP_PDS_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_IOP,
+		.floppy_type	= MAC_FLOPPY_SWIM_IOP, /* SWIM */
 	},
 
 	/*
@@ -497,7 +497,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_LC,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_PDS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_LC, /* SWIM 2 */
 	}, {
 		.ident		= MAC_MODEL_P475,
 		.name		= "Performa 475",
@@ -506,7 +506,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_QUADRA,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_PDS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR1,
+		.floppy_type	= MAC_FLOPPY_QUADRA, /* SWIM 2 */
 	}, {
 		.ident		= MAC_MODEL_P475F,
 		.name		= "Performa 475",
@@ -515,7 +515,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_QUADRA,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_PDS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR1,
+		.floppy_type	= MAC_FLOPPY_QUADRA, /* SWIM 2 */
 	}, {
 		.ident		= MAC_MODEL_P520,
 		.name		= "Performa 520",
@@ -524,7 +524,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_LC,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_PDS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_LC, /* SWIM 2 */
 	}, {
 		.ident		= MAC_MODEL_P550,
 		.name		= "Performa 550",
@@ -533,7 +533,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_LC,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_PDS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_LC, /* SWIM 2 */
 	},
 	/* These have the comm slot, and therefore possibly SONIC ethernet */
 	{
@@ -544,7 +544,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_QUADRA,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_PDS_COMM,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR1,
+		.floppy_type	= MAC_FLOPPY_QUADRA, /* SWIM 2 */
 	}, {
 		.ident		= MAC_MODEL_P588,
 		.name		= "Performa 588",
@@ -554,7 +554,7 @@ static struct mac_model mac_data_table[] = {
 		.ide_type	= MAC_IDE_QUADRA,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_PDS_COMM,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR1,
+		.floppy_type	= MAC_FLOPPY_QUADRA, /* SWIM 2 */
 	}, {
 		.ident		= MAC_MODEL_TV,
 		.name		= "TV",
@@ -562,7 +562,7 @@ static struct mac_model mac_data_table[] = {
 		.via_type	= MAC_VIA_IICI,
 		.scsi_type	= MAC_SCSI_LC,
 		.scc_type	= MAC_SCC_II,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_LC, /* SWIM 2 */
 	}, {
 		.ident		= MAC_MODEL_P600,
 		.name		= "Performa 600",
@@ -571,7 +571,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_LC,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_LC, /* SWIM */
 	},
 
 	/*
@@ -588,7 +588,7 @@ static struct mac_model mac_data_table[] = {
 		.scc_type	= MAC_SCC_QUADRA,
 		.ether_type	= MAC_ETHER_SONIC,
 		.expansion_type	= MAC_EXP_PDS_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR1,
+		.floppy_type	= MAC_FLOPPY_QUADRA, /* SWIM 2 */
 	}, {
 		.ident		= MAC_MODEL_C650,
 		.name		= "Centris 650",
@@ -598,7 +598,7 @@ static struct mac_model mac_data_table[] = {
 		.scc_type	= MAC_SCC_QUADRA,
 		.ether_type	= MAC_ETHER_SONIC,
 		.expansion_type	= MAC_EXP_PDS_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR1,
+		.floppy_type	= MAC_FLOPPY_QUADRA, /* SWIM 2 */
 	}, {
 		.ident		= MAC_MODEL_C660,
 		.name		= "Centris 660AV",
@@ -608,7 +608,7 @@ static struct mac_model mac_data_table[] = {
 		.scc_type	= MAC_SCC_PSC,
 		.ether_type	= MAC_ETHER_MACE,
 		.expansion_type	= MAC_EXP_PDS_NUBUS,
-		.floppy_type	= MAC_FLOPPY_AV,
+		.floppy_type	= MAC_FLOPPY_UNSUPPORTED, /* New Age */
 	},
 
 	/*
@@ -624,7 +624,7 @@ static struct mac_model mac_data_table[] = {
 		.via_type	= MAC_VIA_QUADRA,
 		.scsi_type	= MAC_SCSI_OLD,
 		.scc_type	= MAC_SCC_QUADRA,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_PB145,
 		.name		= "PowerBook 145",
@@ -632,7 +632,7 @@ static struct mac_model mac_data_table[] = {
 		.via_type	= MAC_VIA_QUADRA,
 		.scsi_type	= MAC_SCSI_OLD,
 		.scc_type	= MAC_SCC_QUADRA,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_PB150,
 		.name		= "PowerBook 150",
@@ -641,7 +641,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_OLD,
 		.ide_type	= MAC_IDE_PB,
 		.scc_type	= MAC_SCC_QUADRA,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_PB160,
 		.name		= "PowerBook 160",
@@ -649,7 +649,7 @@ static struct mac_model mac_data_table[] = {
 		.via_type	= MAC_VIA_QUADRA,
 		.scsi_type	= MAC_SCSI_OLD,
 		.scc_type	= MAC_SCC_QUADRA,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_PB165,
 		.name		= "PowerBook 165",
@@ -657,7 +657,7 @@ static struct mac_model mac_data_table[] = {
 		.via_type	= MAC_VIA_QUADRA,
 		.scsi_type	= MAC_SCSI_OLD,
 		.scc_type	= MAC_SCC_QUADRA,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_PB165C,
 		.name		= "PowerBook 165c",
@@ -665,7 +665,7 @@ static struct mac_model mac_data_table[] = {
 		.via_type	= MAC_VIA_QUADRA,
 		.scsi_type	= MAC_SCSI_OLD,
 		.scc_type	= MAC_SCC_QUADRA,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_PB170,
 		.name		= "PowerBook 170",
@@ -673,7 +673,7 @@ static struct mac_model mac_data_table[] = {
 		.via_type	= MAC_VIA_QUADRA,
 		.scsi_type	= MAC_SCSI_OLD,
 		.scc_type	= MAC_SCC_QUADRA,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_PB180,
 		.name		= "PowerBook 180",
@@ -681,7 +681,7 @@ static struct mac_model mac_data_table[] = {
 		.via_type	= MAC_VIA_QUADRA,
 		.scsi_type	= MAC_SCSI_OLD,
 		.scc_type	= MAC_SCC_QUADRA,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_PB180C,
 		.name		= "PowerBook 180c",
@@ -689,7 +689,7 @@ static struct mac_model mac_data_table[] = {
 		.via_type	= MAC_VIA_QUADRA,
 		.scsi_type	= MAC_SCSI_OLD,
 		.scc_type	= MAC_SCC_QUADRA,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_PB190,
 		.name		= "PowerBook 190",
@@ -698,7 +698,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_OLD,
 		.ide_type	= MAC_IDE_BABOON,
 		.scc_type	= MAC_SCC_QUADRA,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM 2 */
 	}, {
 		.ident		= MAC_MODEL_PB520,
 		.name		= "PowerBook 520",
@@ -707,7 +707,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_OLD,
 		.scc_type	= MAC_SCC_QUADRA,
 		.ether_type	= MAC_ETHER_SONIC,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM 2 */
 	},
 
 	/*
@@ -724,7 +724,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_DUO,
 		.scc_type	= MAC_SCC_QUADRA,
 		.expansion_type	= MAC_EXP_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_PB230,
 		.name		= "PowerBook Duo 230",
@@ -733,7 +733,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_DUO,
 		.scc_type	= MAC_SCC_QUADRA,
 		.expansion_type	= MAC_EXP_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_PB250,
 		.name		= "PowerBook Duo 250",
@@ -742,7 +742,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_DUO,
 		.scc_type	= MAC_SCC_QUADRA,
 		.expansion_type	= MAC_EXP_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_PB270C,
 		.name		= "PowerBook Duo 270c",
@@ -751,7 +751,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_DUO,
 		.scc_type	= MAC_SCC_QUADRA,
 		.expansion_type	= MAC_EXP_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_PB280,
 		.name		= "PowerBook Duo 280",
@@ -760,7 +760,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_DUO,
 		.scc_type	= MAC_SCC_QUADRA,
 		.expansion_type	= MAC_EXP_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_PB280C,
 		.name		= "PowerBook Duo 280c",
@@ -769,7 +769,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_DUO,
 		.scc_type	= MAC_SCC_QUADRA,
 		.expansion_type	= MAC_EXP_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	},
 
 	/*
@@ -956,7 +956,7 @@ static const struct resource mac_scsi_ccl_rsrc[] __initconst = {
 
 int __init mac_platform_init(void)
 {
-	u8 *swim_base;
+	phys_addr_t swim_base = 0;
 
 	if (!MACH_IS_MAC)
 		return -ENODEV;
@@ -973,22 +973,22 @@ int __init mac_platform_init(void)
 	 */
 
 	switch (macintosh_config->floppy_type) {
-	case MAC_FLOPPY_SWIM_ADDR1:
-		swim_base = (u8 *)(VIA1_BASE + 0x1E000);
+	case MAC_FLOPPY_QUADRA:
+		swim_base = 0x5001E000;
 		break;
-	case MAC_FLOPPY_SWIM_ADDR2:
-		swim_base = (u8 *)(VIA1_BASE + 0x16000);
+	case MAC_FLOPPY_OLD:
+		swim_base = 0x50016000;
 		break;
-	default:
-		swim_base = NULL;
+	case MAC_FLOPPY_LC:
+		swim_base = 0x50F16000;
 		break;
 	}
 
 	if (swim_base) {
 		struct resource swim_rsrc = {
 			.flags = IORESOURCE_MEM,
-			.start = (resource_size_t)swim_base,
-			.end   = (resource_size_t)swim_base + 0x1FFF,
+			.start = swim_base,
+			.end   = swim_base + 0x1FFF,
 		};
 
 		platform_device_register_simple("swim", -1, &swim_rsrc, 1);
-- 
2.19.2

