Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BBEC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E62B121019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548170887;
	bh=cUgfs522aE0MgKuvWNDHEznVAK83DlFXNepH+6WZeVQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=nn9L9jgQiFlBMOMZE+wQfJtlI5rtQdfnBi6QHcJic8Ddop5vLfx5aigxhGrFY1OoI
	 NsvYQAEGm1+F7K23MxiBi34Lx5HseRHG3i3lF2EosfFCmTj62bKwTC3fjYupoQQqAi
	 Fchsp0LIrOV11T184T1H7pikhCTh4P3K5APcAAnU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729544AbfAVPWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:22:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:34348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729408AbfAVPWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:22:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 888CC20879;
        Tue, 22 Jan 2019 15:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548170537;
        bh=cUgfs522aE0MgKuvWNDHEznVAK83DlFXNepH+6WZeVQ=;
        h=From:To:Cc:Subject:Date:From;
        b=v3SdoX5fEnfINnfXGJM8gSFpZoinZS5NO72OJU3VuVnJlp/JACxSiuIs042J+laXn
         Lmcq3JSPCwVQfy9Iq1B43IgogNOuCLMZyPbAvvDzfJAONWQ0FPW3IHsLFQ5YRGDbug
         RNHBAFVxao0OTvnWdmFaTOykpWXkGMMB6Y0moxAA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] fbdev: omap2: no need to check return value of debugfs_create functions
Date:   Tue, 22 Jan 2019 16:21:14 +0100
Message-Id: <20190122152151.16139-15-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: linux-omap@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/omap2/omapfb/dss/core.c | 31 ++++-----------------
 drivers/video/fbdev/omap2/omapfb/dss/dss.h  |  2 +-
 2 files changed, 7 insertions(+), 26 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/dss/core.c b/drivers/video/fbdev/omap2/omapfb/dss/core.c
index b4bcf3a4a647..7e6a3eb266d0 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/core.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/core.c
@@ -110,19 +110,12 @@ DEFINE_SHOW_ATTRIBUTE(dss);
 
 static struct dentry *dss_debugfs_dir;
 
-static int dss_initialize_debugfs(void)
+static void dss_initialize_debugfs(void)
 {
 	dss_debugfs_dir = debugfs_create_dir("omapdss", NULL);
-	if (IS_ERR(dss_debugfs_dir)) {
-		int err = PTR_ERR(dss_debugfs_dir);
-		dss_debugfs_dir = NULL;
-		return err;
-	}
 
 	debugfs_create_file("clk", S_IRUGO, dss_debugfs_dir,
 			&dss_debug_dump_clocks, &dss_fops);
-
-	return 0;
 }
 
 static void dss_uninitialize_debugfs(void)
@@ -130,24 +123,18 @@ static void dss_uninitialize_debugfs(void)
 	debugfs_remove_recursive(dss_debugfs_dir);
 }
 
-int dss_debugfs_create_file(const char *name, void (*write)(struct seq_file *))
+void dss_debugfs_create_file(const char *name, void (*write)(struct seq_file *))
 {
-	struct dentry *d;
-
-	d = debugfs_create_file(name, S_IRUGO, dss_debugfs_dir,
-			write, &dss_fops);
-
-	return PTR_ERR_OR_ZERO(d);
+	debugfs_create_file(name, S_IRUGO, dss_debugfs_dir, write, &dss_fops);
 }
 #else /* CONFIG_FB_OMAP2_DSS_DEBUGFS */
-static inline int dss_initialize_debugfs(void)
+static inline void dss_initialize_debugfs(void)
 {
-	return 0;
 }
 static inline void dss_uninitialize_debugfs(void)
 {
 }
-int dss_debugfs_create_file(const char *name, void (*write)(struct seq_file *))
+void dss_debugfs_create_file(const char *name, void (*write)(struct seq_file *))
 {
 	return 0;
 }
@@ -188,9 +175,7 @@ static int __init omap_dss_probe(struct platform_device *pdev)
 
 	dss_features_init(omapdss_get_version());
 
-	r = dss_initialize_debugfs();
-	if (r)
-		goto err_debugfs;
+	dss_initialize_debugfs();
 
 	if (def_disp_name)
 		core.default_display_name = def_disp_name;
@@ -198,10 +183,6 @@ static int __init omap_dss_probe(struct platform_device *pdev)
 	register_pm_notifier(&omap_dss_pm_notif_block);
 
 	return 0;
-
-err_debugfs:
-
-	return r;
 }
 
 static int omap_dss_remove(struct platform_device *pdev)
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dss.h b/drivers/video/fbdev/omap2/omapfb/dss/dss.h
index a3cc0ca8f9d2..b1a354494144 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dss.h
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dss.h
@@ -214,7 +214,7 @@ struct platform_device *dss_get_core_pdev(void);
 int dss_dsi_enable_pads(int dsi_id, unsigned lane_mask);
 void dss_dsi_disable_pads(int dsi_id, unsigned lane_mask);
 int dss_set_min_bus_tput(struct device *dev, unsigned long tput);
-int dss_debugfs_create_file(const char *name, void (*write)(struct seq_file *));
+void dss_debugfs_create_file(const char *name, void (*write)(struct seq_file *));
 
 /* display */
 int dss_suspend_all_devices(void);
-- 
2.20.1

