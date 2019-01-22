Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36F2C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84AB920879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548170544;
	bh=nYZhELDHRUjRep/UElSMBbN2aNjVg8oiAJAZ+XgdfWM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=FYf5G8qfXFYGIH9t+Fz++Ah5Qp4RtrHvCqYm/gv6aZ13DkPJ3pRf9Y9naY6fNnBEE
	 /HrtMsgl4lY3a/cmj0grUA/reBQJ8zjmRtgCrn7rZHr8HV3/+14WIGCd4Ubc5yhEcm
	 k+unYWmIfMlcJgU4HMlBJ9KkVVz0+XCPMtVfyc6s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbfAVPWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:22:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:34430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729505AbfAVPWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:22:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FF1A20879;
        Tue, 22 Jan 2019 15:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548170540;
        bh=nYZhELDHRUjRep/UElSMBbN2aNjVg8oiAJAZ+XgdfWM=;
        h=From:To:Cc:Subject:Date:From;
        b=JGdeZ8hhY3WvHvQVF0TgDwbv2A6RrFvq1gX7kOIE8fNYb4BGoYKJEjKuzT0O8C0TI
         WUEIpmaxhW697+HHchYIyuSnsSQQ26ORyqlpVP79It+T13X4ZdYi9D4udp5ZC4KgfC
         KsXpUdqVEOJ8ZTptKz8Ia0hHYNhbLUQ/sN9NvRh4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH] fbdev: mbx: fix up debugfs file creation
Date:   Tue, 22 Jan 2019 16:21:15 +0100
Message-Id: <20190122152151.16139-16-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to keep the dentries around for the individual debugfs
files, just delete the whole directory all at once at shutdown instead.

This also fixes a tiny memory leak where the memory for the pointers to
the file dentries was never freed when the device shut down, as well as
making the logic of the code a lot simpler.

Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/mbx/mbxdebugfs.c | 40 +++++++++-------------------
 drivers/video/fbdev/mbx/mbxfb.c      |  2 +-
 2 files changed, 14 insertions(+), 28 deletions(-)

diff --git a/drivers/video/fbdev/mbx/mbxdebugfs.c b/drivers/video/fbdev/mbx/mbxdebugfs.c
index 2bd328883178..52cfe0132b25 100644
--- a/drivers/video/fbdev/mbx/mbxdebugfs.c
+++ b/drivers/video/fbdev/mbx/mbxdebugfs.c
@@ -211,36 +211,22 @@ static const struct file_operations misc_fops = {
 static void mbxfb_debugfs_init(struct fb_info *fbi)
 {
 	struct mbxfb_info *mfbi = fbi->par;
-	struct mbxfb_debugfs_data *dbg;
-
-	dbg = kzalloc(sizeof(struct mbxfb_debugfs_data), GFP_KERNEL);
-	mfbi->debugfs_data = dbg;
-
-	dbg->dir = debugfs_create_dir("mbxfb", NULL);
-	dbg->sysconf = debugfs_create_file("sysconf", 0444, dbg->dir,
-				      fbi, &sysconf_fops);
-	dbg->clock = debugfs_create_file("clock", 0444, dbg->dir,
-				    fbi, &clock_fops);
-	dbg->display = debugfs_create_file("display", 0444, dbg->dir,
-				      fbi, &display_fops);
-	dbg->gsctl = debugfs_create_file("gsctl", 0444, dbg->dir,
-				    fbi, &gsctl_fops);
-	dbg->sdram = debugfs_create_file("sdram", 0444, dbg->dir,
-					fbi, &sdram_fops);
-	dbg->misc = debugfs_create_file("misc", 0444, dbg->dir,
-					fbi, &misc_fops);
+	struct dentry *dir;
+
+	dir = debugfs_create_dir("mbxfb", NULL);
+	mbfi->debugfs_dir = dir;
+
+	debugfs_create_file("sysconf", 0444, dir, fbi, &sysconf_fops);
+	debugfs_create_file("clock", 0444, dir, fbi, &clock_fops);
+	debugfs_create_file("display", 0444, dir, fbi, &display_fops);
+	debugfs_create_file("gsctl", 0444, dir, fbi, &gsctl_fops);
+	debugfs_create_file("sdram", 0444, dir, fbi, &sdram_fops);
+	debugfs_create_file("misc", 0444, dir, fbi, &misc_fops);
 }
 
 static void mbxfb_debugfs_remove(struct fb_info *fbi)
 {
 	struct mbxfb_info *mfbi = fbi->par;
-	struct mbxfb_debugfs_data *dbg = mfbi->debugfs_data;
-
-	debugfs_remove(dbg->misc);
-	debugfs_remove(dbg->sdram);
-	debugfs_remove(dbg->gsctl);
-	debugfs_remove(dbg->display);
-	debugfs_remove(dbg->clock);
-	debugfs_remove(dbg->sysconf);
-	debugfs_remove(dbg->dir);
+
+	debugfs_remove_recursive(mfbi->debugfs_dir);
 }
diff --git a/drivers/video/fbdev/mbx/mbxfb.c b/drivers/video/fbdev/mbx/mbxfb.c
index 539b85da0897..6ded480a69b4 100644
--- a/drivers/video/fbdev/mbx/mbxfb.c
+++ b/drivers/video/fbdev/mbx/mbxfb.c
@@ -74,7 +74,7 @@ struct mbxfb_info {
 
 	u32 pseudo_palette[MAX_PALETTES];
 #ifdef CONFIG_FB_MBX_DEBUG
-	void *debugfs_data;
+	struct dentry *debugfs_dir;
 #endif
 
 };
-- 
2.20.1

