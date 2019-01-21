Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1077FC2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D330520879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548078549;
	bh=P3nJqod41iTOT7JPj+2mZQA1FLO6CRh7oOcX4KKF7As=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pP5Kpk8m7qJDh6Sk+ymRY0w5z2qQLFXvYLXs7YgnpIg6UzIFNy/9rZ3SfkL1rJKix
	 sikgq5e9j0rphxkF7s5xDNxFn4ZSPGOPtQHcHK/UP2uMLw3lESVS9gfDmyVVGPMf7R
	 HEl5fjS20RpML8Gy7zsdwSKtJDUXDcrULbXIkXtI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbfAUNtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:49:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:59360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730070AbfAUNtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:49:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 131822063F;
        Mon, 21 Jan 2019 13:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078543;
        bh=P3nJqod41iTOT7JPj+2mZQA1FLO6CRh7oOcX4KKF7As=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H5a/1P3xaeL5slQzhdFH05D2Gv71TCzFtno9plqYj7r8AirbJmCsjkQJ2h1SWN1mV
         smZmWV85sxoo2jbfmqbLKBZUAcU8iH2yJCCVdJ6ZZYWCON93PJRUxGvOiR6/6wr2cd
         kNFwPyTQiub5LFKy90MQM/cnnlGx+/nj7P2qmlx8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mathieu Malaterre <malat@debian.org>,
        Elimar Riesebieter <riesebie@lxtec.de>,
        Rob Herring <robh@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 4.20 069/111] fbdev: offb: Fix OF node name handling
Date:   Mon, 21 Jan 2019 14:43:03 +0100
Message-Id: <20190121122504.097886408@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122455.819406896@linuxfoundation.org>
References: <20190121122455.819406896@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rob Herring <robh@kernel.org>

commit 00257e0cc550c4a8df5f99c0a4fc74fec0656144 upstream.

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
Tested-by: Mathieu Malaterre <malat@debian.org>
Cc: stable@vger.kernel.org # v4.19+
Cc: Elimar Riesebieter <riesebie@lxtec.de>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/video/fbdev/offb.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

--- a/drivers/video/fbdev/offb.c
+++ b/drivers/video/fbdev/offb.c
@@ -318,28 +318,28 @@ static void __iomem *offb_map_reg(struct
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
@@ -350,7 +350,7 @@ static void offb_init_palette_hacks(stru
 		par->cmap_adr = offb_map_reg(dp, 0, 0x6000, 0x1000);
 		if (par->cmap_adr)
 			par->cmap_type = cmap_gxt2000;
-	} else if (dp && !strncmp(name, "vga,Display-", 12)) {
+	} else if (of_node_name_prefix(dp, "vga,Display-")) {
 		/* Look for AVIVO initialized by SLOF */
 		struct device_node *pciparent = of_get_parent(dp);
 		const u32 *vid, *did;
@@ -438,7 +438,7 @@ static void __init offb_init_fb(const ch
 
 	par->cmap_type = cmap_unknown;
 	if (depth == 8)
-		offb_init_palette_hacks(info, dp, name, address);
+		offb_init_palette_hacks(info, dp, address);
 	else
 		fix->visual = FB_VISUAL_TRUECOLOR;
 


