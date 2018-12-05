Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC955C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 889D3208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544039489;
	bh=sAeSORTSoRGoNpdQjufiNZAPvySOJb8kRdoEq9I9fBA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=iYkOJo3TLXZpdHS2QB/KkbYRUQPPSLNTCd/HC7rX8MpNT/Pp+bBT7OLldp80IoY5L
	 a1dSFvcfRq1TtsHi9kXqYb77k7HUTuZae1FZdM4yRudjuHs312Bf82xX17xH0EdHaX
	 EdMLUi7CBZs8WlTZmT/MCEhf5dyj4hnbMdsagJ1M=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 889D3208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbeLETv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:51:27 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41590 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728846AbeLETvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:51:25 -0500
Received: by mail-oi1-f193.google.com with SMTP id j21so18613329oii.8;
        Wed, 05 Dec 2018 11:51:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RAj3RG1UBPGI7GeqlRPUG5pKvqZ7bJfcoUGOt4urFsw=;
        b=NH0xwoZK7WxzyBBIGIy0kzl38WrbpjU11+S+SZAUdnDYeR099Ga/475L9burHAPYuM
         aPOs6aDMPkAYRXErvE2hbxuXlM8QsH/XgurSP3YkvBLZ+n1WRGVVn+uVAyvZR13ct3M3
         9WcAxF1R+TSbcpD3DaQZIfqqcUj4AGxfLqwlTm4NRZ1vRG0MqHJnvUkNgyGJRxeht/Rc
         NvPQJeSBgTULcJ39cBFo/Hl6GPoBbyyj1unVwgabo0mwPCKHchEvxvnhWmxH/LYOCdMo
         V2IiWtJvD5T0xQ4np8f+PSJOm+yl7s+JFSQ2lclAHn92TCNahEcvRXgikCZd5tdMxixq
         UB7A==
X-Gm-Message-State: AA+aEWYc1qXVJyMxbSCTwur80Z/TVmje3tlVqKfOkSMnCJwMjdkRVrvz
        DBOyub5Iu0LKaFE/s5tnrF/HDDH2pQ==
X-Google-Smtp-Source: AFSGD/WuvJA6t2QskcuSMQrwyzBEZOnSRmuqzXRQQWT/lauwBGvaa6CkHp5D81u9nac8ZlMqQjDu0Q==
X-Received: by 2002:aca:f244:: with SMTP id q65mr14732666oih.50.1544039484056;
        Wed, 05 Dec 2018 11:51:24 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id k13sm25759879otj.19.2018.12.05.11.51.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 11:51:23 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-omap@vger.kernel.org
Subject: [PATCH] fbdev: Use of_node_name_eq for node name comparisons
Date:   Wed,  5 Dec 2018 13:50:45 -0600
Message-Id: <20181205195050.4759-29-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert string compares of DT node names to use of_node_name_eq helper
instead. This removes direct access to the node name pointer.

For instances using of_node_cmp, this has the side effect of now using
case sensitive comparisons. This should not matter for any FDT based
system which omap is.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-omap@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/video/fbdev/aty/radeon_pm.c           | 6 +++---
 drivers/video/fbdev/cg14.c                    | 4 ++--
 drivers/video/fbdev/cg3.c                     | 2 +-
 drivers/video/fbdev/ffb.c                     | 2 +-
 drivers/video/fbdev/imsttfb.c                 | 4 ++--
 drivers/video/fbdev/offb.c                    | 2 +-
 drivers/video/fbdev/omap2/omapfb/dss/dss-of.c | 4 ++--
 7 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/video/fbdev/aty/radeon_pm.c b/drivers/video/fbdev/aty/radeon_pm.c
index e695adb0e573..2dc5703eac51 100644
--- a/drivers/video/fbdev/aty/radeon_pm.c
+++ b/drivers/video/fbdev/aty/radeon_pm.c
@@ -2844,8 +2844,8 @@ void radeonfb_pm_init(struct radeonfb_info *rinfo, int dynclk, int ignore_devlis
 		 * in some desktop G4s), Via (M9+ chip on iBook G4) and
 		 * Snowy (M11 chip on iBook G4 manufactured after July 2005)
 		 */
-		if (!strcmp(rinfo->of_node->name, "ATY,JasperParent") ||
-		    !strcmp(rinfo->of_node->name, "ATY,SnowyParent")) {
+		if (of_node_name_eq(rinfo->of_node, "ATY,JasperParent") ||
+		    of_node_name_eq(rinfo->of_node, "ATY,SnowyParent")) {
 			rinfo->reinit_func = radeon_reinitialize_M10;
 			rinfo->pm_mode |= radeon_pm_off;
 		}
@@ -2855,7 +2855,7 @@ void radeonfb_pm_init(struct radeonfb_info *rinfo, int dynclk, int ignore_devlis
 			rinfo->pm_mode |= radeon_pm_off;
 		}
 #endif
-		if (!strcmp(rinfo->of_node->name, "ATY,ViaParent")) {
+		if (of_node_name_eq(rinfo->of_node, "ATY,ViaParent")) {
 			rinfo->reinit_func = radeon_reinitialize_M9P;
 			rinfo->pm_mode |= radeon_pm_off;
 		}
diff --git a/drivers/video/fbdev/cg14.c b/drivers/video/fbdev/cg14.c
index 9af54c2368fd..a6dce1a78490 100644
--- a/drivers/video/fbdev/cg14.c
+++ b/drivers/video/fbdev/cg14.c
@@ -486,8 +486,8 @@ static int cg14_probe(struct platform_device *op)
 					  info->var.xres);
 	info->fix.smem_len = PAGE_ALIGN(linebytes * info->var.yres);
 
-	if (!strcmp(dp->parent->name, "sbus") ||
-	    !strcmp(dp->parent->name, "sbi")) {
+	if (of_node_name_eq(dp->parent, "sbus") ||
+	    of_node_name_eq(dp->parent, "sbi")) {
 		info->fix.smem_start = op->resource[0].start;
 		par->iospace = op->resource[0].flags & IORESOURCE_BITS;
 	} else {
diff --git a/drivers/video/fbdev/cg3.c b/drivers/video/fbdev/cg3.c
index 1bd95b02f3aa..6d42def8436b 100644
--- a/drivers/video/fbdev/cg3.c
+++ b/drivers/video/fbdev/cg3.c
@@ -369,7 +369,7 @@ static int cg3_probe(struct platform_device *op)
 	info->var.red.length = 8;
 	info->var.green.length = 8;
 	info->var.blue.length = 8;
-	if (!strcmp(dp->name, "cgRDI"))
+	if (of_node_name_eq(dp, "cgRDI"))
 		par->flags |= CG3_FLAG_RDI;
 	if (par->flags & CG3_FLAG_RDI)
 		cg3_rdi_maybe_fixup_var(&info->var, dp);
diff --git a/drivers/video/fbdev/ffb.c b/drivers/video/fbdev/ffb.c
index 6b1915872af1..b7aee0c427a8 100644
--- a/drivers/video/fbdev/ffb.c
+++ b/drivers/video/fbdev/ffb.c
@@ -944,7 +944,7 @@ static int ffb_probe(struct platform_device *op)
 
 	info->var.accel_flags = FB_ACCELF_TEXT;
 
-	if (!strcmp(dp->name, "SUNW,afb"))
+	if (of_node_name_eq(dp, "SUNW,afb"))
 		par->flags |= FFB_FLAG_AFB;
 
 	par->board_type = of_getintprop_default(dp, "board_type", 0);
diff --git a/drivers/video/fbdev/imsttfb.c b/drivers/video/fbdev/imsttfb.c
index 901ca4ed10e9..b268570b019d 100644
--- a/drivers/video/fbdev/imsttfb.c
+++ b/drivers/video/fbdev/imsttfb.c
@@ -1498,8 +1498,8 @@ static int imsttfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	switch (pdev->device) {
 		case PCI_DEVICE_ID_IMS_TT128: /* IMS,tt128mbA */
 			par->ramdac = IBM;
-			if (dp && ((strcmp(dp->name, "IMS,tt128mb8") == 0) ||
-				   (strcmp(dp->name, "IMS,tt128mb8A") == 0)))
+			if (of_node_name_eq(dp, "IMS,tt128mb8") ||
+			    of_node_name_eq(dp, "IMS,tt128mb8A"))
 				par->ramdac = TVP;
 			break;
 		case PCI_DEVICE_ID_IMS_TT3D:  /* IMS,tt3d */
diff --git a/drivers/video/fbdev/offb.c b/drivers/video/fbdev/offb.c
index 31f769d67195..7b452a520e85 100644
--- a/drivers/video/fbdev/offb.c
+++ b/drivers/video/fbdev/offb.c
@@ -646,7 +646,7 @@ static void __init offb_init_nodriver(struct device_node *dp, int no_real_node)
 		}
 #endif
 		/* kludge for valkyrie */
-		if (strcmp(dp->name, "valkyrie") == 0)
+		if (of_node_name_eq(dp, "valkyrie"))
 			address += 0x1000;
 		offb_init_fb(no_real_node ? "bootx" : NULL,
 			     width, height, depth, pitch, address,
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dss-of.c b/drivers/video/fbdev/omap2/omapfb/dss/dss-of.c
index f1eb8b0f8a2a..5ce893c1923d 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dss-of.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dss-of.c
@@ -60,7 +60,7 @@ omapdss_of_get_next_port(const struct device_node *parent,
 				return NULL;
 			}
 			prev = port;
-		} while (of_node_cmp(port->name, "port") != 0);
+		} while (!of_node_name_eq(port, "port"));
 
 		of_node_put(ports);
 	}
@@ -83,7 +83,7 @@ omapdss_of_get_next_endpoint(const struct device_node *parent,
 		if (!ep)
 			return NULL;
 		prev = ep;
-	} while (of_node_cmp(ep->name, "endpoint") != 0);
+	} while (!of_node_name_eq(ep, "endpoint"));
 
 	return ep;
 }
-- 
2.19.1

