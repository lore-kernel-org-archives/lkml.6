Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A048C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE3092183E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546882296;
	bh=wdtw/iRpKJ9uRM+NpV8K92Hs7cItbt6GywS4BJ72YzA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=DZ39nqvaEhP/ZVfAYQFu7mZ8IfGggnu8dZYnhJaWLC7JObNr5LtpETyCaTDSUZbAN
	 0elSXFQp97jdlovq0D9bf0/FkHTRluMxqB1pfJZ3IfSzLsIEfNETILwPaQSfWLQW+r
	 5DF/4wQLvI8lmOq7zrKTlUbLxfLK/mgcAd4dPiO4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbfAGRbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 12:31:35 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37942 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbfAGRbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 12:31:35 -0500
Received: by mail-oi1-f193.google.com with SMTP id a77so980605oii.5;
        Mon, 07 Jan 2019 09:31:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fhWiQKGTwUaIx9qINTDmt01mL59lQ7SL6VXvKUCW3gg=;
        b=cVh68+gnAO/Xvx0j/okYIrOloGZlfFzv7qdjvQr+j402iIpvi9aqfMwp2wpX/6JhbI
         Nt+ClgKXRNxNoq8Pfp1QkgBrJh0c54NXlLQY8V/giVYQr+5hwPh13sRm6qioTEJQVoz4
         KiXPQNeOvfShx5ZfJQoHrkTjUCHbX8hmfrb3ImjA7p5fjiB+zoM1W+iT35VpU1xSZqnL
         GHluUDVRMXRuFsUK+KOs0lRclZD2q7K4geNJTA27x3argmTh1IWSqavY1qsi8ID/ebJ3
         yZ7IDKelSrDxGaALhUGHWERQc3jd9+PXz+fro7Cis0aHdhSwKWC8tkt/zTKt/fiiGJPV
         wf6A==
X-Gm-Message-State: AJcUukfaLPTHjmxxPSGfpo0JRFfzTQMFiXk12I/rQNJUnRbq7U0jyOFR
        Qw3yV9d+NywahS67VBZWGQ==
X-Google-Smtp-Source: AFSGD/WpHP2kRq0D+/ew9jQ8ulcT2VvDqOa4mycBRiNi3WojFBQGxblVGnSGh1FKLfn9QUMDG5buhA==
X-Received: by 2002:a54:4088:: with SMTP id i8mr40390953oii.324.1546882293833;
        Mon, 07 Jan 2019 09:31:33 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id o189sm32725579oif.23.2019.01.07.09.31.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 09:31:33 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Elimar Riesebieter <riesebie@lxtec.de>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Mathieu Malaterre <malat@debian.org>
Subject: [PATCH] fbdev: offb: Fix OF node name handling
Date:   Mon,  7 Jan 2019 11:31:32 -0600
Message-Id: <20190107173132.27316-1-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 5c63e407aaab ("fbdev: Convert to using %pOFn instead of
device_node.name") changed how the OF FB driver handles the OF node
name. This missed the case where the node name is passed to
offb_init_palette_hacks(). This results in a NULL ptr dereference
in strncmp and breaks any system except ones using bootx with no display
node.

Fix this by making offb_init_palette_hacks() use the OF node pointer and
use of_node_name_prefix() helper function instead for node name
comparisons. This helps in moving all OF node name accesses to helper
functions in preparation to remove struct device_node.name pointer.

Fixes: 5c63e407aaab ("fbdev: Convert to using %pOFn instead of device_node.name")

Reported-by: Mathieu Malaterre <malat@debian.org>
Cc: stable@vger.kernel.org # v4.19+
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/video/fbdev/offb.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/video/fbdev/offb.c b/drivers/video/fbdev/offb.c
index 31f769d67195..057d3cdef92e 100644
--- a/drivers/video/fbdev/offb.c
+++ b/drivers/video/fbdev/offb.c
@@ -318,28 +318,28 @@ static void __iomem *offb_map_reg(struct device_node *np, int index,
 }
 
 static void offb_init_palette_hacks(struct fb_info *info, struct device_node *dp,
-				    const char *name, unsigned long address)
+				    unsigned long address)
 {
 	struct offb_par *par = (struct offb_par *) info->par;
 
-	if (dp && !strncmp(name, "ATY,Rage128", 11)) {
+	if (of_node_name_prefix(dp, "ATY,Rage128")) {
 		par->cmap_adr = offb_map_reg(dp, 2, 0, 0x1fff);
 		if (par->cmap_adr)
 			par->cmap_type = cmap_r128;
-	} else if (dp && (!strncmp(name, "ATY,RageM3pA", 12)
-			  || !strncmp(name, "ATY,RageM3p12A", 14))) {
+	} else if (of_node_name_prefix(dp, "ATY,RageM3pA") ||
+		   of_node_name_prefix(dp, "ATY,RageM3p12A")) {
 		par->cmap_adr = offb_map_reg(dp, 2, 0, 0x1fff);
 		if (par->cmap_adr)
 			par->cmap_type = cmap_M3A;
-	} else if (dp && !strncmp(name, "ATY,RageM3pB", 12)) {
+	} else if (of_node_name_prefix(dp, "ATY,RageM3pB")) {
 		par->cmap_adr = offb_map_reg(dp, 2, 0, 0x1fff);
 		if (par->cmap_adr)
 			par->cmap_type = cmap_M3B;
-	} else if (dp && !strncmp(name, "ATY,Rage6", 9)) {
+	} else if (of_node_name_prefix(dp, "ATY,Rage6")) {
 		par->cmap_adr = offb_map_reg(dp, 1, 0, 0x1fff);
 		if (par->cmap_adr)
 			par->cmap_type = cmap_radeon;
-	} else if (!strncmp(name, "ATY,", 4)) {
+	} else if (of_node_name_prefix(dp, "ATY,")) {
 		unsigned long base = address & 0xff000000UL;
 		par->cmap_adr =
 			ioremap(base + 0x7ff000, 0x1000) + 0xcc0;
@@ -350,7 +350,7 @@ static void offb_init_palette_hacks(struct fb_info *info, struct device_node *dp
 		par->cmap_adr = offb_map_reg(dp, 0, 0x6000, 0x1000);
 		if (par->cmap_adr)
 			par->cmap_type = cmap_gxt2000;
-	} else if (dp && !strncmp(name, "vga,Display-", 12)) {
+	} else if (of_node_name_prefix(dp, "vga,Display-")) {
 		/* Look for AVIVO initialized by SLOF */
 		struct device_node *pciparent = of_get_parent(dp);
 		const u32 *vid, *did;
@@ -438,7 +438,7 @@ static void __init offb_init_fb(const char *name,
 
 	par->cmap_type = cmap_unknown;
 	if (depth == 8)
-		offb_init_palette_hacks(info, dp, name, address);
+		offb_init_palette_hacks(info, dp, address);
 	else
 		fix->visual = FB_VISUAL_TRUECOLOR;
 
-- 
2.19.1

