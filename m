Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E46C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEC0720658
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:55:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEC0720658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbeH1Foe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 01:44:34 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:42940 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbeH1Foe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 01:44:34 -0400
Received: by mail-oi0-f66.google.com with SMTP id q204-v6so1732066oig.9;
        Mon, 27 Aug 2018 18:55:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6GXlxyXUgbelAbEjAaxb7b0y+0sJFbxQbtsrd2YVPQo=;
        b=F+rCwfz5TSn9mtufs5U1dBkJFTRe6WpJMDJGxuQafNSxRtRTrIlRnctZrJL1GBWH3z
         yfUbXu1Lj9FoXV/9oxFiKVLjozgJ/Aj6/EF5g1CJo1tZPuC3e8SIofj+Rq6xU/MNEsIA
         IPinpfwJj3XeGXfjJmZCuZn6zjHOs/wgC4X1x3pkmhNPbMcbYaEQS9dlaHZ28IUiOO4A
         Rf/pLuS0GTGDIIRRUrnjU9unvkoRZz5onmjAyxMLDrLp/BYtcvLVhoJj4NoB1cBbjQGI
         MI04/YjOWG9Rd9rZ0p2z50ft7iDBJeiJSBf5drjIz89ezTlKxHgshb4KtNCc4DlRyCX9
         46QQ==
X-Gm-Message-State: APzg51DgJ4+NI23hAnK1TvkBZ5NTYQrOC1SZ9N8PXjnqNO+wEGK2NyXv
        zAhQ2R3HIAnll4IFHkP+z8aixeE=
X-Google-Smtp-Source: ANB0VdYCjsnn0IqrgiTFRl0JDsQ5KBci5/1/iNOHRsMUYYJx91K98t+Q0LJOLgz6zS9SaJivYFpG7g==
X-Received: by 2002:aca:3507:: with SMTP id c7-v6mr1204742oia.46.1535421317711;
        Mon, 27 Aug 2018 18:55:17 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id n71-v6sm1652696oig.48.2018.08.27.18.55.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 18:55:17 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH] fbdev: Convert to using %pOFn instead of device_node.name
Date:   Mon, 27 Aug 2018 20:52:50 -0500
Message-Id: <20180828015252.28511-49-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/video/fbdev/cg14.c        |  4 +---
 drivers/video/fbdev/cg3.c         |  2 +-
 drivers/video/fbdev/core/fbmon.c  |  4 ++--
 drivers/video/fbdev/imsttfb.c     |  2 +-
 drivers/video/fbdev/leo.c         |  2 +-
 drivers/video/fbdev/offb.c        | 12 ++++++++----
 drivers/video/fbdev/p9100.c       |  2 +-
 drivers/video/of_display_timing.c |  2 +-
 8 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/video/fbdev/cg14.c b/drivers/video/fbdev/cg14.c
index 8de88b129b62..9af54c2368fd 100644
--- a/drivers/video/fbdev/cg14.c
+++ b/drivers/video/fbdev/cg14.c
@@ -355,9 +355,7 @@ static int cg14_ioctl(struct fb_info *info, unsigned int cmd, unsigned long arg)
 static void cg14_init_fix(struct fb_info *info, int linebytes,
 			  struct device_node *dp)
 {
-	const char *name = dp->name;
-
-	strlcpy(info->fix.id, name, sizeof(info->fix.id));
+	snprintf(info->fix.id, sizeof(info->fix.id), "%pOFn", dp);
 
 	info->fix.type = FB_TYPE_PACKED_PIXELS;
 	info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
diff --git a/drivers/video/fbdev/cg3.c b/drivers/video/fbdev/cg3.c
index 6c334260cf53..1bd95b02f3aa 100644
--- a/drivers/video/fbdev/cg3.c
+++ b/drivers/video/fbdev/cg3.c
@@ -246,7 +246,7 @@ static int cg3_ioctl(struct fb_info *info, unsigned int cmd, unsigned long arg)
 static void cg3_init_fix(struct fb_info *info, int linebytes,
 			 struct device_node *dp)
 {
-	strlcpy(info->fix.id, dp->name, sizeof(info->fix.id));
+	snprintf(info->fix.id, sizeof(info->fix.id), "%pOFn", dp);
 
 	info->fix.type = FB_TYPE_PACKED_PIXELS;
 	info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/core/fbmon.c
index 852d86c1c527..dd3128990776 100644
--- a/drivers/video/fbdev/core/fbmon.c
+++ b/drivers/video/fbdev/core/fbmon.c
@@ -1480,8 +1480,8 @@ int of_get_fb_videomode(struct device_node *np, struct fb_videomode *fb,
 	if (ret)
 		return ret;
 
-	pr_debug("%pOF: got %dx%d display mode from %s\n",
-		np, vm.hactive, vm.vactive, np->name);
+	pr_debug("%pOF: got %dx%d display mode\n",
+		np, vm.hactive, vm.vactive);
 	dump_fb_videomode(fb);
 
 	return 0;
diff --git a/drivers/video/fbdev/imsttfb.c b/drivers/video/fbdev/imsttfb.c
index ecdcf358ad5e..901ca4ed10e9 100644
--- a/drivers/video/fbdev/imsttfb.c
+++ b/drivers/video/fbdev/imsttfb.c
@@ -1473,7 +1473,7 @@ static int imsttfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	
 	dp = pci_device_to_OF_node(pdev);
 	if(dp)
-		printk(KERN_INFO "%s: OF name %s\n",__func__, dp->name);
+		printk(KERN_INFO "%s: OF name %pOFn\n",__func__, dp);
 	else if (IS_ENABLED(CONFIG_OF))
 		printk(KERN_ERR "imsttfb: no OF node for pci device\n");
 
diff --git a/drivers/video/fbdev/leo.c b/drivers/video/fbdev/leo.c
index 71862188f528..446ac3364bad 100644
--- a/drivers/video/fbdev/leo.c
+++ b/drivers/video/fbdev/leo.c
@@ -434,7 +434,7 @@ static int leo_ioctl(struct fb_info *info, unsigned int cmd, unsigned long arg)
 static void
 leo_init_fix(struct fb_info *info, struct device_node *dp)
 {
-	strlcpy(info->fix.id, dp->name, sizeof(info->fix.id));
+	snprintf(info->fix.id, sizeof(info->fix.id), "%pOFn", dp);
 
 	info->fix.type = FB_TYPE_PACKED_PIXELS;
 	info->fix.visual = FB_VISUAL_TRUECOLOR;
diff --git a/drivers/video/fbdev/offb.c b/drivers/video/fbdev/offb.c
index 77c0a2f45b3b..31f769d67195 100644
--- a/drivers/video/fbdev/offb.c
+++ b/drivers/video/fbdev/offb.c
@@ -419,9 +419,13 @@ static void __init offb_init_fb(const char *name,
 	var = &info->var;
 	info->par = par;
 
-	strcpy(fix->id, "OFfb ");
-	strncat(fix->id, name, sizeof(fix->id) - sizeof("OFfb "));
-	fix->id[sizeof(fix->id) - 1] = '\0';
+	if (name) {
+		strcpy(fix->id, "OFfb ");
+		strncat(fix->id, name, sizeof(fix->id) - sizeof("OFfb "));
+		fix->id[sizeof(fix->id) - 1] = '\0';
+	} else
+		snprintf(fix->id, sizeof(fix->id), "OFfb %pOFn", dp);
+
 
 	var->xres = var->xres_virtual = width;
 	var->yres = var->yres_virtual = height;
@@ -644,7 +648,7 @@ static void __init offb_init_nodriver(struct device_node *dp, int no_real_node)
 		/* kludge for valkyrie */
 		if (strcmp(dp->name, "valkyrie") == 0)
 			address += 0x1000;
-		offb_init_fb(no_real_node ? "bootx" : dp->name,
+		offb_init_fb(no_real_node ? "bootx" : NULL,
 			     width, height, depth, pitch, address,
 			     foreign_endian, no_real_node ? NULL : dp);
 	}
diff --git a/drivers/video/fbdev/p9100.c b/drivers/video/fbdev/p9100.c
index 64de5cda541d..c4283e9e95af 100644
--- a/drivers/video/fbdev/p9100.c
+++ b/drivers/video/fbdev/p9100.c
@@ -239,7 +239,7 @@ static int p9100_ioctl(struct fb_info *info, unsigned int cmd,
 
 static void p9100_init_fix(struct fb_info *info, int linebytes, struct device_node *dp)
 {
-	strlcpy(info->fix.id, dp->name, sizeof(info->fix.id));
+	snprintf(info->fix.id, sizeof(info->fix.id), "%pOFn", dp);
 
 	info->fix.type = FB_TYPE_PACKED_PIXELS;
 	info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
diff --git a/drivers/video/of_display_timing.c b/drivers/video/of_display_timing.c
index 5244e93ceafc..c2e7aa103fa5 100644
--- a/drivers/video/of_display_timing.c
+++ b/drivers/video/of_display_timing.c
@@ -170,7 +170,7 @@ struct display_timings *of_get_display_timings(const struct device_node *np)
 		goto entryfail;
 	}
 
-	pr_debug("%pOF: using %s as default timing\n", np, entry->name);
+	pr_debug("%pOF: using %pOFn as default timing\n", np, entry);
 
 	native_mode = entry;
 
-- 
2.17.1

