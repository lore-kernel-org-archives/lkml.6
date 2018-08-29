Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE89C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9378B2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="F6v4e5iE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9378B2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbeH2U6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 16:58:13 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37038 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728353AbeH2U6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 16:58:13 -0400
Received: by mail-lj1-f193.google.com with SMTP id v9-v6so4967732ljk.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 10:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GGdVZ2AXCArAPX7bCxHkMqmphl/h3koL3VeJOZWJOts=;
        b=F6v4e5iEsdDCz4m0P1jHMN0EZ//UboSJoR0HIxwfv6Rt6o31HqrMYEMrdVAlPe3D7a
         CvVIEBdXcIXWl70AL/jD/McEJ5ZNdvgvaN62RQpnwTAm+F2Nu25anqrkyXLIxNX7mjKF
         Lsj3vXpu+gPGzp61KypMQMp66uOQxLbj+w9VM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GGdVZ2AXCArAPX7bCxHkMqmphl/h3koL3VeJOZWJOts=;
        b=o4Px2yh1ZCU9Ijz017ap8fzF4kBqEG38BirFsQdw0FXvL2ClC9NVJ3Gv4OofvEPGPt
         8jOo1hAaIu/bEXZSwK4JWfMS7wZb3t/QLjl9musHjPwZF+bVoNo4SbRO7CnW0EFW6Vu/
         eBRq3lVbqKmt++2syu/SIju1cTcd1wEuOub7DYXIopUFv7Fc0UbprF2WwnTGWNQbF7nS
         gp+MD+CefSJ5CViPrvlrkav5a26641FudxNFcLMwvqqDrw1GVSEGcw6NyJI+CwjcZwkX
         23MbwrbhuqLTtZ2dkg24o28Kd3+Boqr91huzwzkL1RpYjROqch8kyr0EXdMp6xGwibyD
         /1pQ==
X-Gm-Message-State: APzg51DLuX9s4hGYd7lYfQSQ0qxQL4AeMRWphBfwf0HJGrbR1RgIABNv
        EmrxgqEsWute606pGd0iE20IbnuVL/Q=
X-Google-Smtp-Source: ANB0VdZdaLogLM1kPqqyTMs22L86mlGi387N6rjkpGAHO6Oy2UieqnYwt0aYxnnigHjvwuz1FN7Tpw==
X-Received: by 2002:a2e:658a:: with SMTP id e10-v6mr4387312ljf.99.1535562020522;
        Wed, 29 Aug 2018 10:00:20 -0700 (PDT)
Received: from localhost ([195.238.92.132])
        by smtp.gmail.com with ESMTPSA id 103-v6sm665554lfs.28.2018.08.29.10.00.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 10:00:19 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        codalist@coda.cs.cmu.edu, coda@cs.cmu.edu
Cc:     Jan Harkes <jaharkes@cs.cmu.edu>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Praneeth Bajjuri <praneeth@ti.com>,
        Paul Sokolovsky <paul.sokolovsky@linaro.org>,
        Miklos Szeredi <mszeredi@suse.cz>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v2 2/2] scsi: aic7xxx: Fix build using bare-metal toolchain
Date:   Wed, 29 Aug 2018 20:00:15 +0300
Message-Id: <20180829170015.7729-3-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180829170015.7729-1-semen.protsenko@linaro.org>
References: <20180829170015.7729-1-semen.protsenko@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bare-metal toolchains don't define __linux__, so aic7xxx build with
bare-metal toolchain is broken. This driver codebase used to be
partially shared with FreeBSD, but these days there is no point in
keeping the compatibility around. So let's just drop FreeBSD related
code and get rid of __linux__ checking in order to fix the build using
bare-metal toolchains.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/scsi/aic7xxx/aic7770.c                |  6 ---
 drivers/scsi/aic7xxx/aic79xx.h                |  6 ---
 drivers/scsi/aic7xxx/aic79xx_core.c           | 43 -------------------
 drivers/scsi/aic7xxx/aic79xx_pci.c            |  6 ---
 drivers/scsi/aic7xxx/aic7xxx.h                |  6 ---
 drivers/scsi/aic7xxx/aic7xxx_93cx6.c          |  6 ---
 drivers/scsi/aic7xxx/aic7xxx_core.c           | 40 +----------------
 drivers/scsi/aic7xxx/aic7xxx_pci.c            |  7 ---
 drivers/scsi/aic7xxx/aicasm/aicasm.h          |  4 --
 drivers/scsi/aic7xxx/aicasm/aicasm_gram.y     |  4 --
 .../scsi/aic7xxx/aicasm/aicasm_macro_gram.y   |  4 --
 .../scsi/aic7xxx/aicasm/aicasm_macro_scan.l   |  4 --
 drivers/scsi/aic7xxx/aicasm/aicasm_scan.l     |  4 --
 drivers/scsi/aic7xxx/aicasm/aicasm_symbol.c   |  4 --
 drivers/scsi/aic7xxx/aicasm/aicasm_symbol.h   |  4 --
 15 files changed, 1 insertion(+), 147 deletions(-)

diff --git a/drivers/scsi/aic7xxx/aic7770.c b/drivers/scsi/aic7xxx/aic7770.c
index 5000bd69c13f..176704b24e6a 100644
--- a/drivers/scsi/aic7xxx/aic7770.c
+++ b/drivers/scsi/aic7xxx/aic7770.c
@@ -42,15 +42,9 @@
  * $FreeBSD$
  */
 
-#ifdef __linux__
 #include "aic7xxx_osm.h"
 #include "aic7xxx_inline.h"
 #include "aic7xxx_93cx6.h"
-#else
-#include <dev/aic7xxx/aic7xxx_osm.h>
-#include <dev/aic7xxx/aic7xxx_inline.h>
-#include <dev/aic7xxx/aic7xxx_93cx6.h>
-#endif
 
 #define ID_AIC7770	0x04907770
 #define ID_AHA_274x	0x04907771
diff --git a/drivers/scsi/aic7xxx/aic79xx.h b/drivers/scsi/aic7xxx/aic79xx.h
index 31f2bb9d7146..9a515551641c 100644
--- a/drivers/scsi/aic7xxx/aic79xx.h
+++ b/drivers/scsi/aic7xxx/aic79xx.h
@@ -607,9 +607,6 @@ struct scb {
 	ahd_io_ctx_t		  io_ctx;
 	struct ahd_softc	 *ahd_softc;
 	scb_flag		  flags;
-#ifndef __linux__
-	bus_dmamap_t		  dmamap;
-#endif
 	struct scb_platform_data *platform_data;
 	struct map_node	 	 *hscb_map;
 	struct map_node	 	 *sg_map;
@@ -1056,9 +1053,6 @@ struct ahd_completion
 struct ahd_softc {
 	bus_space_tag_t           tags[2];
 	bus_space_handle_t        bshs[2];
-#ifndef __linux__
-	bus_dma_tag_t		  buffer_dmat;   /* dmat for buffer I/O */
-#endif
 	struct scb_data		  scb_data;
 
 	struct hardware_scb	 *next_queued_hscb;
diff --git a/drivers/scsi/aic7xxx/aic79xx_core.c b/drivers/scsi/aic7xxx/aic79xx_core.c
index 2d82ec85753e..8e57a1dacb6a 100644
--- a/drivers/scsi/aic7xxx/aic79xx_core.c
+++ b/drivers/scsi/aic7xxx/aic79xx_core.c
@@ -40,16 +40,9 @@
  * $Id: //depot/aic7xxx/aic7xxx/aic79xx.c#250 $
  */
 
-#ifdef __linux__
 #include "aic79xx_osm.h"
 #include "aic79xx_inline.h"
 #include "aicasm/aicasm_insformat.h"
-#else
-#include <dev/aic7xxx/aic79xx_osm.h>
-#include <dev/aic7xxx/aic79xx_inline.h>
-#include <dev/aic7xxx/aicasm/aicasm_insformat.h>
-#endif
-
 
 /***************************** Lookup Tables **********************************/
 static const char *const ahd_chip_names[] =
@@ -6172,17 +6165,11 @@ ahd_free(struct ahd_softc *ahd)
 	case 2:
 		ahd_dma_tag_destroy(ahd, ahd->shared_data_dmat);
 	case 1:
-#ifndef __linux__
-		ahd_dma_tag_destroy(ahd, ahd->buffer_dmat);
-#endif
 		break;
 	case 0:
 		break;
 	}
 
-#ifndef __linux__
-	ahd_dma_tag_destroy(ahd, ahd->parent_dmat);
-#endif
 	ahd_platform_free(ahd);
 	ahd_fini_scbdata(ahd);
 	for (i = 0; i < AHD_NUM_TARGETS; i++) {
@@ -6934,9 +6921,6 @@ ahd_alloc_scbs(struct ahd_softc *ahd)
 	for (i = 0; i < newcount; i++) {
 		struct scb_platform_data *pdata;
 		u_int col_tag;
-#ifndef __linux__
-		int error;
-#endif
 
 		next_scb = kmalloc(sizeof(*next_scb), GFP_ATOMIC);
 		if (next_scb == NULL)
@@ -6970,15 +6954,6 @@ ahd_alloc_scbs(struct ahd_softc *ahd)
 			next_scb->sg_list_busaddr += sizeof(struct ahd_dma_seg);
 		next_scb->ahd_softc = ahd;
 		next_scb->flags = SCB_FLAG_NONE;
-#ifndef __linux__
-		error = ahd_dmamap_create(ahd, ahd->buffer_dmat, /*flags*/0,
-					  &next_scb->dmamap);
-		if (error != 0) {
-			kfree(next_scb);
-			kfree(pdata);
-			break;
-		}
-#endif
 		next_scb->hscb->tag = ahd_htole16(scb_data->numscbs);
 		col_tag = scb_data->numscbs ^ 0x100;
 		next_scb->col_scb = ahd_find_scb_by_tag(ahd, col_tag);
@@ -7091,24 +7066,6 @@ ahd_init(struct ahd_softc *ahd)
 	if ((AHD_TMODE_ENABLE & (0x1 << ahd->unit)) == 0)
 		ahd->features &= ~AHD_TARGETMODE;
 
-#ifndef __linux__
-	/* DMA tag for mapping buffers into device visible space. */
-	if (ahd_dma_tag_create(ahd, ahd->parent_dmat, /*alignment*/1,
-			       /*boundary*/BUS_SPACE_MAXADDR_32BIT + 1,
-			       /*lowaddr*/ahd->flags & AHD_39BIT_ADDRESSING
-					? (dma_addr_t)0x7FFFFFFFFFULL
-					: BUS_SPACE_MAXADDR_32BIT,
-			       /*highaddr*/BUS_SPACE_MAXADDR,
-			       /*filter*/NULL, /*filterarg*/NULL,
-			       /*maxsize*/(AHD_NSEG - 1) * PAGE_SIZE,
-			       /*nsegments*/AHD_NSEG,
-			       /*maxsegsz*/AHD_MAXTRANSFER_SIZE,
-			       /*flags*/BUS_DMA_ALLOCNOW,
-			       &ahd->buffer_dmat) != 0) {
-		return (ENOMEM);
-	}
-#endif
-
 	ahd->init_level++;
 
 	/*
diff --git a/drivers/scsi/aic7xxx/aic79xx_pci.c b/drivers/scsi/aic7xxx/aic79xx_pci.c
index cc9bd26f5d1a..c68943b22e89 100644
--- a/drivers/scsi/aic7xxx/aic79xx_pci.c
+++ b/drivers/scsi/aic7xxx/aic79xx_pci.c
@@ -41,14 +41,8 @@
  * $Id: //depot/aic7xxx/aic7xxx/aic79xx_pci.c#92 $
  */
 
-#ifdef __linux__
 #include "aic79xx_osm.h"
 #include "aic79xx_inline.h"
-#else
-#include <dev/aic7xxx/aic79xx_osm.h>
-#include <dev/aic7xxx/aic79xx_inline.h>
-#endif
-
 #include "aic79xx_pci.h"
 
 static inline uint64_t
diff --git a/drivers/scsi/aic7xxx/aic7xxx.h b/drivers/scsi/aic7xxx/aic7xxx.h
index 4ce4e903a759..5614921b4041 100644
--- a/drivers/scsi/aic7xxx/aic7xxx.h
+++ b/drivers/scsi/aic7xxx/aic7xxx.h
@@ -568,9 +568,6 @@ struct scb {
 	ahc_io_ctx_t		  io_ctx;
 	struct ahc_softc	 *ahc_softc;
 	scb_flag		  flags;
-#ifndef __linux__
-	bus_dmamap_t		  dmamap;
-#endif
 	struct scb_platform_data *platform_data;
 	struct sg_map_node	 *sg_map;
 	struct ahc_dma_seg 	 *sg_list;
@@ -906,9 +903,6 @@ typedef void ahc_callback_t (void *);
 struct ahc_softc {
 	bus_space_tag_t           tag;
 	bus_space_handle_t        bsh;
-#ifndef __linux__
-	bus_dma_tag_t		  buffer_dmat;   /* dmat for buffer I/O */
-#endif
 	struct scb_data		 *scb_data;
 
 	struct scb		 *next_queued_scb;
diff --git a/drivers/scsi/aic7xxx/aic7xxx_93cx6.c b/drivers/scsi/aic7xxx/aic7xxx_93cx6.c
index 9e85a7ef9c8e..cc9e41967ce4 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_93cx6.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_93cx6.c
@@ -64,15 +64,9 @@
  *   bit to be sent from the chip.
  */
 
-#ifdef __linux__
 #include "aic7xxx_osm.h"
 #include "aic7xxx_inline.h"
 #include "aic7xxx_93cx6.h"
-#else
-#include <dev/aic7xxx/aic7xxx_osm.h>
-#include <dev/aic7xxx/aic7xxx_inline.h>
-#include <dev/aic7xxx/aic7xxx_93cx6.h>
-#endif
 
 /*
  * Right now, we only have to read the SEEPROM.  But we make it easier to
diff --git a/drivers/scsi/aic7xxx/aic7xxx_core.c b/drivers/scsi/aic7xxx/aic7xxx_core.c
index 915a34f141e4..aa4eaa4fa23a 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_core.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_core.c
@@ -40,15 +40,9 @@
  * $Id: //depot/aic7xxx/aic7xxx/aic7xxx.c#155 $
  */
 
-#ifdef __linux__
 #include "aic7xxx_osm.h"
 #include "aic7xxx_inline.h"
 #include "aicasm/aicasm_insformat.h"
-#else
-#include <dev/aic7xxx/aic7xxx_osm.h>
-#include <dev/aic7xxx/aic7xxx_inline.h>
-#include <dev/aic7xxx/aicasm/aicasm_insformat.h>
-#endif
 
 /***************************** Lookup Tables **********************************/
 static const char *const ahc_chip_names[] = {
@@ -4509,17 +4503,11 @@ ahc_free(struct ahc_softc *ahc)
 	case 2:
 		ahc_dma_tag_destroy(ahc, ahc->shared_data_dmat);
 	case 1:
-#ifndef __linux__
-		ahc_dma_tag_destroy(ahc, ahc->buffer_dmat);
-#endif
 		break;
 	case 0:
 		break;
 	}
 
-#ifndef __linux__
-	ahc_dma_tag_destroy(ahc, ahc->parent_dmat);
-#endif
 	ahc_platform_free(ahc);
 	ahc_fini_scbdata(ahc);
 	for (i = 0; i < AHC_NUM_TARGETS; i++) {
@@ -5005,9 +4993,7 @@ ahc_alloc_scbs(struct ahc_softc *ahc)
 	newcount = min(newcount, (AHC_SCB_MAX_ALLOC - scb_data->numscbs));
 	for (i = 0; i < newcount; i++) {
 		struct scb_platform_data *pdata;
-#ifndef __linux__
-		int error;
-#endif
+
 		pdata = kmalloc(sizeof(*pdata), GFP_ATOMIC);
 		if (pdata == NULL)
 			break;
@@ -5021,12 +5007,6 @@ ahc_alloc_scbs(struct ahc_softc *ahc)
 		next_scb->sg_list_phys = physaddr + sizeof(struct ahc_dma_seg);
 		next_scb->ahc_softc = ahc;
 		next_scb->flags = SCB_FREE;
-#ifndef __linux__
-		error = ahc_dmamap_create(ahc, ahc->buffer_dmat, /*flags*/0,
-					  &next_scb->dmamap);
-		if (error != 0)
-			break;
-#endif
 		next_scb->hscb = &scb_data->hscbs[scb_data->numscbs];
 		next_scb->hscb->tag = ahc->scb_data->numscbs;
 		SLIST_INSERT_HEAD(&ahc->scb_data->free_scbs,
@@ -5325,24 +5305,6 @@ ahc_init(struct ahc_softc *ahc)
 	if ((AHC_TMODE_ENABLE & (0x1 << ahc->unit)) == 0)
 		ahc->features &= ~AHC_TARGETMODE;
 
-#ifndef __linux__
-	/* DMA tag for mapping buffers into device visible space. */
-	if (ahc_dma_tag_create(ahc, ahc->parent_dmat, /*alignment*/1,
-			       /*boundary*/BUS_SPACE_MAXADDR_32BIT + 1,
-			       /*lowaddr*/ahc->flags & AHC_39BIT_ADDRESSING
-					? (dma_addr_t)0x7FFFFFFFFFULL
-					: BUS_SPACE_MAXADDR_32BIT,
-			       /*highaddr*/BUS_SPACE_MAXADDR,
-			       /*filter*/NULL, /*filterarg*/NULL,
-			       /*maxsize*/(AHC_NSEG - 1) * PAGE_SIZE,
-			       /*nsegments*/AHC_NSEG,
-			       /*maxsegsz*/AHC_MAXTRANSFER_SIZE,
-			       /*flags*/BUS_DMA_ALLOCNOW,
-			       &ahc->buffer_dmat) != 0) {
-		return (ENOMEM);
-	}
-#endif
-
 	ahc->init_level++;
 
 	/*
diff --git a/drivers/scsi/aic7xxx/aic7xxx_pci.c b/drivers/scsi/aic7xxx/aic7xxx_pci.c
index 673e826d7adb..656f680c7802 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_pci.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_pci.c
@@ -42,16 +42,9 @@
  * $Id: //depot/aic7xxx/aic7xxx/aic7xxx_pci.c#79 $
  */
 
-#ifdef __linux__
 #include "aic7xxx_osm.h"
 #include "aic7xxx_inline.h"
 #include "aic7xxx_93cx6.h"
-#else
-#include <dev/aic7xxx/aic7xxx_osm.h>
-#include <dev/aic7xxx/aic7xxx_inline.h>
-#include <dev/aic7xxx/aic7xxx_93cx6.h>
-#endif
-
 #include "aic7xxx_pci.h"
 
 static inline uint64_t
diff --git a/drivers/scsi/aic7xxx/aicasm/aicasm.h b/drivers/scsi/aic7xxx/aicasm/aicasm.h
index 51678dd46ff7..716a2aefc925 100644
--- a/drivers/scsi/aic7xxx/aicasm/aicasm.h
+++ b/drivers/scsi/aic7xxx/aicasm/aicasm.h
@@ -42,11 +42,7 @@
  * $FreeBSD$
  */
 
-#ifdef __linux__
 #include "../queue.h"
-#else
-#include <sys/queue.h>
-#endif
 
 #ifndef TRUE
 #define TRUE 1
diff --git a/drivers/scsi/aic7xxx/aicasm/aicasm_gram.y b/drivers/scsi/aic7xxx/aicasm/aicasm_gram.y
index f1586a437906..924d55a8acbf 100644
--- a/drivers/scsi/aic7xxx/aicasm/aicasm_gram.y
+++ b/drivers/scsi/aic7xxx/aicasm/aicasm_gram.y
@@ -52,11 +52,7 @@
 #include <string.h>
 #include <sysexits.h>
 
-#ifdef __linux__
 #include "../queue.h"
-#else
-#include <sys/queue.h>
-#endif
 
 #include "aicasm.h"
 #include "aicasm_symbol.h"
diff --git a/drivers/scsi/aic7xxx/aicasm/aicasm_macro_gram.y b/drivers/scsi/aic7xxx/aicasm/aicasm_macro_gram.y
index 708326df0766..8c0479865f04 100644
--- a/drivers/scsi/aic7xxx/aicasm/aicasm_macro_gram.y
+++ b/drivers/scsi/aic7xxx/aicasm/aicasm_macro_gram.y
@@ -52,11 +52,7 @@
 #include <string.h>
 #include <sysexits.h>
 
-#ifdef __linux__
 #include "../queue.h"
-#else
-#include <sys/queue.h>
-#endif
 
 #include "aicasm.h"
 #include "aicasm_symbol.h"
diff --git a/drivers/scsi/aic7xxx/aicasm/aicasm_macro_scan.l b/drivers/scsi/aic7xxx/aicasm/aicasm_macro_scan.l
index c0457b8c3b77..98e9959c6907 100644
--- a/drivers/scsi/aic7xxx/aicasm/aicasm_macro_scan.l
+++ b/drivers/scsi/aic7xxx/aicasm/aicasm_macro_scan.l
@@ -51,11 +51,7 @@
 #include <stdio.h>
 #include <string.h>
 #include <sysexits.h>
-#ifdef __linux__
 #include "../queue.h"
-#else
-#include <sys/queue.h>
-#endif
 
 #include "aicasm.h"
 #include "aicasm_symbol.h"
diff --git a/drivers/scsi/aic7xxx/aicasm/aicasm_scan.l b/drivers/scsi/aic7xxx/aicasm/aicasm_scan.l
index 93c8667cd704..c78d4f68eea5 100644
--- a/drivers/scsi/aic7xxx/aicasm/aicasm_scan.l
+++ b/drivers/scsi/aic7xxx/aicasm/aicasm_scan.l
@@ -51,11 +51,7 @@
 #include <stdio.h>
 #include <string.h>
 #include <sysexits.h>
-#ifdef __linux__
 #include "../queue.h"
-#else
-#include <sys/queue.h>
-#endif
 
 #include "aicasm.h"
 #include "aicasm_symbol.h"
diff --git a/drivers/scsi/aic7xxx/aicasm/aicasm_symbol.c b/drivers/scsi/aic7xxx/aicasm/aicasm_symbol.c
index 232aff1fe784..975fcfcc0d8f 100644
--- a/drivers/scsi/aic7xxx/aicasm/aicasm_symbol.c
+++ b/drivers/scsi/aic7xxx/aicasm/aicasm_symbol.c
@@ -44,11 +44,7 @@
 
 #include <sys/types.h>
 
-#ifdef __linux__
 #include "aicdb.h"
-#else
-#include <db.h>
-#endif
 #include <fcntl.h>
 #include <inttypes.h>
 #include <regex.h>
diff --git a/drivers/scsi/aic7xxx/aicasm/aicasm_symbol.h b/drivers/scsi/aic7xxx/aicasm/aicasm_symbol.h
index 34bbcad7f83f..7bf7fd5953ac 100644
--- a/drivers/scsi/aic7xxx/aicasm/aicasm_symbol.h
+++ b/drivers/scsi/aic7xxx/aicasm/aicasm_symbol.h
@@ -42,11 +42,7 @@
  * $FreeBSD$
  */
 
-#ifdef __linux__
 #include "../queue.h"
-#else
-#include <sys/queue.h>
-#endif
 
 typedef enum {
 	UNINITIALIZED,
-- 
2.18.0

