Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753294AbeDABnk (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 21:43:40 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:47306 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752366AbeDABlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 21:41:07 -0400
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Laurent Vivier <lvivier@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <b9b2888a903c5c8eae07852da124a70e2ee40b14.1522546571.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1522546571.git.fthain@telegraphics.com.au>
References: <cover.1522546571.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 01/12] m68k/mac: Revisit floppy disc controller base addresses
Date: Sat, 31 Mar 2018 21:41:04 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
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

Cc: Laurent Vivier <lvivier@redhat.com>
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 arch/m68k/include/asm/macintosh.h |  10 +--
 arch/m68k/mac/config.c            | 124 ++++++++++++++++++++------------------
 2 files changed, 70 insertions(+), 64 deletions(-)

diff --git a/arch/m68k/include/asm/macintosh.h b/arch/m68k/include/asm/macintosh.h
index 9b840c03ebb7..a61ce06c0a54 100644
--- a/arch/m68k/include/asm/macintosh.h
+++ b/arch/m68k/include/asm/macintosh.h
@@ -79,11 +79,11 @@ struct mac_model
 #define MAC_EXP_PDS_NUBUS	3 /* Accepts PDS card and/or NuBus card(s) */
 #define MAC_EXP_PDS_COMM	4 /* Accepts PDS card or Comm Slot card */
 
-#define MAC_FLOPPY_IWM		0
-#define MAC_FLOPPY_SWIM_ADDR1	1
-#define MAC_FLOPPY_SWIM_ADDR2	2
-#define MAC_FLOPPY_SWIM_IOP	3
-#define MAC_FLOPPY_AV		4
+#define MAC_FLOPPY_UNSUPPORTED	0
+#define MAC_FLOPPY_QUADRA	1
+#define MAC_FLOPPY_OLD		2
+#define MAC_FLOPPY_IIFX		3
+#define MAC_FLOPPY_LC		4
 
 extern struct mac_model *macintosh_config;
 
diff --git a/arch/m68k/mac/config.c b/arch/m68k/mac/config.c
index d3d435248a24..54f3a8421afc 100644
--- a/arch/m68k/mac/config.c
+++ b/arch/m68k/mac/config.c
@@ -213,7 +213,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_OLD,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_NUBUS,
-		.floppy_type	= MAC_FLOPPY_IWM,
+		.floppy_type	= MAC_FLOPPY_UNSUPPORTED, /* IWM */
 	},
 
 	/*
@@ -228,7 +228,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_OLD,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_NUBUS,
-		.floppy_type	= MAC_FLOPPY_IWM,
+		.floppy_type	= MAC_FLOPPY_UNSUPPORTED, /* IWM */
 	}, {
 		.ident		= MAC_MODEL_IIX,
 		.name		= "IIx",
@@ -237,7 +237,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_OLD,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_IICX,
 		.name		= "IIcx",
@@ -246,7 +246,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_OLD,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_SE30,
 		.name		= "SE/30",
@@ -255,7 +255,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_OLD,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_PDS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	},
 
 	/*
@@ -273,7 +273,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_OLD,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_IIFX,
 		.name		= "IIfx",
@@ -282,7 +282,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_IIFX,
 		.scc_type	= MAC_SCC_IOP,
 		.expansion_type	= MAC_EXP_PDS_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_IOP,
+		.floppy_type	= MAC_FLOPPY_IIFX, /* SWIM with IOP */
 	}, {
 		.ident		= MAC_MODEL_IISI,
 		.name		= "IIsi",
@@ -291,7 +291,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_OLD,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_PDS_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_IIVI,
 		.name		= "IIvi",
@@ -300,7 +300,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_LC,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_LC, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_IIVX,
 		.name		= "IIvx",
@@ -309,7 +309,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_LC,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_LC, /* SWIM */
 	},
 
 	/*
@@ -323,7 +323,7 @@ static struct mac_model mac_data_table[] = {
 		.via_type	= MAC_VIA_IICI,
 		.scsi_type	= MAC_SCSI_LC,
 		.scc_type	= MAC_SCC_II,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_LC, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_CCL,
 		.name		= "Color Classic",
@@ -332,7 +332,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_LC,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_PDS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_LC, /* SWIM II */
 	}, {
 		.ident		= MAC_MODEL_CCLII,
 		.name		= "Color Classic II",
@@ -341,7 +341,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_LC,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_PDS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_LC, /* SWIM II */
 	},
 
 	/*
@@ -356,7 +356,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_LC,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_PDS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_LC, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_LCII,
 		.name		= "LC II",
@@ -365,7 +365,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_LC,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_PDS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_LC, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_LCIII,
 		.name		= "LC III",
@@ -374,7 +374,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_LC,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_PDS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_LC, /* SWIM II */
 	},
 
 	/*
@@ -395,7 +395,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_QUADRA,
 		.scc_type	= MAC_SCC_QUADRA,
 		.expansion_type	= MAC_EXP_PDS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR1,
+		.floppy_type	= MAC_FLOPPY_QUADRA, /* SWIM II */
 	}, {
 		.ident		= MAC_MODEL_Q605_ACC,
 		.name		= "Quadra 605",
@@ -404,7 +404,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_QUADRA,
 		.scc_type	= MAC_SCC_QUADRA,
 		.expansion_type	= MAC_EXP_PDS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR1,
+		.floppy_type	= MAC_FLOPPY_QUADRA, /* SWIM II */
 	}, {
 		.ident		= MAC_MODEL_Q610,
 		.name		= "Quadra 610",
@@ -414,7 +414,7 @@ static struct mac_model mac_data_table[] = {
 		.scc_type	= MAC_SCC_QUADRA,
 		.ether_type	= MAC_ETHER_SONIC,
 		.expansion_type	= MAC_EXP_PDS_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR1,
+		.floppy_type	= MAC_FLOPPY_QUADRA, /* SWIM II */
 	}, {
 		.ident		= MAC_MODEL_Q630,
 		.name		= "Quadra 630",
@@ -424,7 +424,7 @@ static struct mac_model mac_data_table[] = {
 		.ide_type	= MAC_IDE_QUADRA,
 		.scc_type	= MAC_SCC_QUADRA,
 		.expansion_type	= MAC_EXP_PDS_COMM,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR1,
+		.floppy_type	= MAC_FLOPPY_QUADRA, /* SWIM II */
 	}, {
 		.ident		= MAC_MODEL_Q650,
 		.name		= "Quadra 650",
@@ -434,7 +434,7 @@ static struct mac_model mac_data_table[] = {
 		.scc_type	= MAC_SCC_QUADRA,
 		.ether_type	= MAC_ETHER_SONIC,
 		.expansion_type	= MAC_EXP_PDS_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR1,
+		.floppy_type	= MAC_FLOPPY_QUADRA, /* SWIM II */
 	},
 	/* The Q700 does have a NS Sonic */
 	{
@@ -446,7 +446,7 @@ static struct mac_model mac_data_table[] = {
 		.scc_type	= MAC_SCC_QUADRA,
 		.ether_type	= MAC_ETHER_SONIC,
 		.expansion_type	= MAC_EXP_PDS_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR1,
+		.floppy_type	= MAC_FLOPPY_QUADRA, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_Q800,
 		.name		= "Quadra 800",
@@ -456,7 +456,7 @@ static struct mac_model mac_data_table[] = {
 		.scc_type	= MAC_SCC_QUADRA,
 		.ether_type	= MAC_ETHER_SONIC,
 		.expansion_type	= MAC_EXP_PDS_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR1,
+		.floppy_type	= MAC_FLOPPY_QUADRA, /* SWIM II */
 	}, {
 		.ident		= MAC_MODEL_Q840,
 		.name		= "Quadra 840AV",
@@ -466,7 +466,7 @@ static struct mac_model mac_data_table[] = {
 		.scc_type	= MAC_SCC_PSC,
 		.ether_type	= MAC_ETHER_MACE,
 		.expansion_type	= MAC_EXP_NUBUS,
-		.floppy_type	= MAC_FLOPPY_AV,
+		.floppy_type	= MAC_FLOPPY_UNSUPPORTED, /* New Age */
 	}, {
 		.ident		= MAC_MODEL_Q900,
 		.name		= "Quadra 900",
@@ -476,7 +476,7 @@ static struct mac_model mac_data_table[] = {
 		.scc_type	= MAC_SCC_IOP,
 		.ether_type	= MAC_ETHER_SONIC,
 		.expansion_type	= MAC_EXP_PDS_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_IOP,
+		.floppy_type	= MAC_FLOPPY_QUADRA, /* SWIM with IOP */
 	}, {
 		.ident		= MAC_MODEL_Q950,
 		.name		= "Quadra 950",
@@ -486,7 +486,7 @@ static struct mac_model mac_data_table[] = {
 		.scc_type	= MAC_SCC_IOP,
 		.ether_type	= MAC_ETHER_SONIC,
 		.expansion_type	= MAC_EXP_PDS_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_IOP,
+		.floppy_type	= MAC_FLOPPY_QUADRA, /* SWIM with IOP */
 	},
 
 	/*
@@ -501,7 +501,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_LC,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_PDS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_LC, /* SWIM II */
 	}, {
 		.ident		= MAC_MODEL_P475,
 		.name		= "Performa 475",
@@ -510,7 +510,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_QUADRA,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_PDS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR1,
+		.floppy_type	= MAC_FLOPPY_QUADRA, /* SWIM II */
 	}, {
 		.ident		= MAC_MODEL_P475F,
 		.name		= "Performa 475",
@@ -519,7 +519,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_QUADRA,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_PDS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR1,
+		.floppy_type	= MAC_FLOPPY_QUADRA, /* SWIM II */
 	}, {
 		.ident		= MAC_MODEL_P520,
 		.name		= "Performa 520",
@@ -528,7 +528,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_LC,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_PDS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_LC, /* SWIM II */
 	}, {
 		.ident		= MAC_MODEL_P550,
 		.name		= "Performa 550",
@@ -537,7 +537,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_LC,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_PDS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_LC, /* SWIM II */
 	},
 	/* These have the comm slot, and therefore possibly SONIC ethernet */
 	{
@@ -548,7 +548,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_QUADRA,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_PDS_COMM,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR1,
+		.floppy_type	= MAC_FLOPPY_QUADRA, /* SWIM II */
 	}, {
 		.ident		= MAC_MODEL_P588,
 		.name		= "Performa 588",
@@ -558,7 +558,7 @@ static struct mac_model mac_data_table[] = {
 		.ide_type	= MAC_IDE_QUADRA,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_PDS_COMM,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR1,
+		.floppy_type	= MAC_FLOPPY_QUADRA, /* SWIM II */
 	}, {
 		.ident		= MAC_MODEL_TV,
 		.name		= "TV",
@@ -566,7 +566,7 @@ static struct mac_model mac_data_table[] = {
 		.via_type	= MAC_VIA_IICI,
 		.scsi_type	= MAC_SCSI_LC,
 		.scc_type	= MAC_SCC_II,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_LC, /* SWIM II */
 	}, {
 		.ident		= MAC_MODEL_P600,
 		.name		= "Performa 600",
@@ -575,7 +575,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_LC,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_LC, /* SWIM */
 	},
 
 	/*
@@ -592,7 +592,7 @@ static struct mac_model mac_data_table[] = {
 		.scc_type	= MAC_SCC_QUADRA,
 		.ether_type	= MAC_ETHER_SONIC,
 		.expansion_type	= MAC_EXP_PDS_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR1,
+		.floppy_type	= MAC_FLOPPY_QUADRA, /* SWIM II */
 	}, {
 		.ident		= MAC_MODEL_C650,
 		.name		= "Centris 650",
@@ -602,7 +602,7 @@ static struct mac_model mac_data_table[] = {
 		.scc_type	= MAC_SCC_QUADRA,
 		.ether_type	= MAC_ETHER_SONIC,
 		.expansion_type	= MAC_EXP_PDS_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR1,
+		.floppy_type	= MAC_FLOPPY_QUADRA, /* SWIM II */
 	}, {
 		.ident		= MAC_MODEL_C660,
 		.name		= "Centris 660AV",
@@ -612,7 +612,7 @@ static struct mac_model mac_data_table[] = {
 		.scc_type	= MAC_SCC_PSC,
 		.ether_type	= MAC_ETHER_MACE,
 		.expansion_type	= MAC_EXP_PDS_NUBUS,
-		.floppy_type	= MAC_FLOPPY_AV,
+		.floppy_type	= MAC_FLOPPY_UNSUPPORTED, /* New Age */
 	},
 
 	/*
@@ -628,7 +628,7 @@ static struct mac_model mac_data_table[] = {
 		.via_type	= MAC_VIA_QUADRA,
 		.scsi_type	= MAC_SCSI_OLD,
 		.scc_type	= MAC_SCC_QUADRA,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_PB145,
 		.name		= "PowerBook 145",
@@ -636,7 +636,7 @@ static struct mac_model mac_data_table[] = {
 		.via_type	= MAC_VIA_QUADRA,
 		.scsi_type	= MAC_SCSI_OLD,
 		.scc_type	= MAC_SCC_QUADRA,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_PB150,
 		.name		= "PowerBook 150",
@@ -645,7 +645,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_OLD,
 		.ide_type	= MAC_IDE_PB,
 		.scc_type	= MAC_SCC_QUADRA,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_PB160,
 		.name		= "PowerBook 160",
@@ -653,7 +653,7 @@ static struct mac_model mac_data_table[] = {
 		.via_type	= MAC_VIA_QUADRA,
 		.scsi_type	= MAC_SCSI_OLD,
 		.scc_type	= MAC_SCC_QUADRA,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_PB165,
 		.name		= "PowerBook 165",
@@ -661,7 +661,7 @@ static struct mac_model mac_data_table[] = {
 		.via_type	= MAC_VIA_QUADRA,
 		.scsi_type	= MAC_SCSI_OLD,
 		.scc_type	= MAC_SCC_QUADRA,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_PB165C,
 		.name		= "PowerBook 165c",
@@ -669,7 +669,7 @@ static struct mac_model mac_data_table[] = {
 		.via_type	= MAC_VIA_QUADRA,
 		.scsi_type	= MAC_SCSI_OLD,
 		.scc_type	= MAC_SCC_QUADRA,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_PB170,
 		.name		= "PowerBook 170",
@@ -677,7 +677,7 @@ static struct mac_model mac_data_table[] = {
 		.via_type	= MAC_VIA_QUADRA,
 		.scsi_type	= MAC_SCSI_OLD,
 		.scc_type	= MAC_SCC_QUADRA,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_PB180,
 		.name		= "PowerBook 180",
@@ -685,7 +685,7 @@ static struct mac_model mac_data_table[] = {
 		.via_type	= MAC_VIA_QUADRA,
 		.scsi_type	= MAC_SCSI_OLD,
 		.scc_type	= MAC_SCC_QUADRA,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_PB180C,
 		.name		= "PowerBook 180c",
@@ -693,7 +693,7 @@ static struct mac_model mac_data_table[] = {
 		.via_type	= MAC_VIA_QUADRA,
 		.scsi_type	= MAC_SCSI_OLD,
 		.scc_type	= MAC_SCC_QUADRA,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_PB190,
 		.name		= "PowerBook 190",
@@ -702,7 +702,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_LATE,
 		.ide_type	= MAC_IDE_BABOON,
 		.scc_type	= MAC_SCC_QUADRA,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM II */
 	}, {
 		.ident		= MAC_MODEL_PB520,
 		.name		= "PowerBook 520",
@@ -711,7 +711,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_LATE,
 		.scc_type	= MAC_SCC_QUADRA,
 		.ether_type	= MAC_ETHER_SONIC,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM II */
 	},
 
 	/*
@@ -728,7 +728,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_DUO,
 		.scc_type	= MAC_SCC_QUADRA,
 		.expansion_type	= MAC_EXP_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_PB230,
 		.name		= "PowerBook Duo 230",
@@ -737,7 +737,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_DUO,
 		.scc_type	= MAC_SCC_QUADRA,
 		.expansion_type	= MAC_EXP_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_PB250,
 		.name		= "PowerBook Duo 250",
@@ -746,7 +746,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_DUO,
 		.scc_type	= MAC_SCC_QUADRA,
 		.expansion_type	= MAC_EXP_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_PB270C,
 		.name		= "PowerBook Duo 270c",
@@ -755,7 +755,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_DUO,
 		.scc_type	= MAC_SCC_QUADRA,
 		.expansion_type	= MAC_EXP_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_PB280,
 		.name		= "PowerBook Duo 280",
@@ -764,7 +764,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_DUO,
 		.scc_type	= MAC_SCC_QUADRA,
 		.expansion_type	= MAC_EXP_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_PB280C,
 		.name		= "PowerBook Duo 280c",
@@ -773,7 +773,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_DUO,
 		.scc_type	= MAC_SCC_QUADRA,
 		.expansion_type	= MAC_EXP_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	},
 
 	/*
@@ -986,11 +986,17 @@ int __init mac_platform_init(void)
 	 */
 
 	switch (macintosh_config->floppy_type) {
-	case MAC_FLOPPY_SWIM_ADDR1:
-		swim_base = (u8 *)(VIA1_BASE + 0x1E000);
+	case MAC_FLOPPY_QUADRA:
+		swim_base = (u8 *)0x5001E000;
 		break;
-	case MAC_FLOPPY_SWIM_ADDR2:
-		swim_base = (u8 *)(VIA1_BASE + 0x16000);
+	case MAC_FLOPPY_OLD:
+		swim_base = (u8 *)0x50016000;
+		break;
+	case MAC_FLOPPY_LC:
+		swim_base = (u8 *)0x50F16000;
+		break;
+	case MAC_FLOPPY_IIFX:
+		swim_base = (u8 *)0x50012000;
 		break;
 	default:
 		swim_base = NULL;
-- 
2.16.1
