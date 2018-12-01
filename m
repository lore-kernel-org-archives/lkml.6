Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C88DC04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 13:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F2BE20834
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 13:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPHZHuD5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F2BE20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbeLBANr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 19:13:47 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37711 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbeLBANr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 19:13:47 -0500
Received: by mail-pg1-f195.google.com with SMTP id 80so3713062pge.4;
        Sat, 01 Dec 2018 05:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mPnoibJi1FAr5xOnl8k/AfyaYdX8vMvoNRHUSV641fQ=;
        b=MPHZHuD5Vdkxtj8a4r4WlNqjBDVTZtpr/qyghwqiL4/lcss6AOOJE9g1Sg3/7/yQHC
         32mPibbq+o4aLv3UDggD9sQrmHWLbmEpRcicFLztbA2Q/Rs2x25i8tzrnWrYmNC/JBHD
         pdtlQDN33p+4nELzWchHFaSxVK+wJt2lN4wTi9u2x/9SKypRSoVt3bqXRTp0AbsRO6uS
         XnSExw60PcF7vl6zDIHL8mRSX+mSfOf4+Y00v2eesDsN04S52JPeFtDOpaqRnmpXYcnI
         RQ2cUcvSSGIJwHkoeJ7yYhJKbdvfzSZxo5hVlO38pUb6f7Lshb7/p0FIxTOJvCOmFsF2
         x5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mPnoibJi1FAr5xOnl8k/AfyaYdX8vMvoNRHUSV641fQ=;
        b=ZVnL8vj6brWQtj4kUkP72DqQwnQihpqXO+k+RHKheSWqtkaHYgU8/ae2Y7BLJLPgum
         bTGOapRKje0tdv0IyTrr1k6GLTSvOnTrEJZV3qpAvtJVLXY6x/f35Xz/1DYiytprO8HB
         ZDGyoM4m4n1zLyBswPw0sfM/PcNMB+M0mUMjiz4+8HkeE7XkNud3IKSQ0/JQhT7oEXbg
         J1ebH0g45/ZCiF8Er/xJYPh6SH8SfgEYiWLAiVPUrB6BBBW54z2/Wqd5ZRRn7C4CiRQV
         t0FRZHlCTCGnPe1Gz5kt9BwC+ahur4gnuoX/7GETevmg2mCHnnGF3rQ77+lYVeEtpVbX
         XOPg==
X-Gm-Message-State: AA+aEWYzP0ViFPlJgZ2qA9iA7SRP9qb9TUTJfYN+Z9hv+zTUJ8KWFmGd
        FC1mjH2Je70va/FDZsTuLVk=
X-Google-Smtp-Source: AFSGD/WbyYAsbYCJbqY/Sr/QVNY3kM6xDVJuYAWZj0mK+eac+LGAQifAJjEierubX+AA47hVtD7OKQ==
X-Received: by 2002:a63:170c:: with SMTP id x12mr7592320pgl.364.1543669278508;
        Sat, 01 Dec 2018 05:01:18 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id f62sm9505679pgc.67.2018.12.01.05.01.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Dec 2018 05:01:17 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     b.zolnierkie@samsung.com, fengguang.wu@intel.com,
        mchehab+samsung@kernel.org
Cc:     linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] media: omap2: omapfb: convert to DEFINE_SHOW_ATTRIBUTE
Date:   Sat,  1 Dec 2018 08:01:14 -0500
Message-Id: <20181201130114.7092-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/video/fbdev/omap2/omapfb/dss/core.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/dss/core.c b/drivers/video/fbdev/omap2/omapfb/dss/core.c
index a5e58a829ea0..7d3d9f6fad10 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/core.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/core.c
@@ -99,24 +99,14 @@ int dss_set_min_bus_tput(struct device *dev, unsigned long tput)
 }
 
 #if defined(CONFIG_FB_OMAP2_DSS_DEBUGFS)
-static int dss_debug_show(struct seq_file *s, void *unused)
+static int dss_show(struct seq_file *s, void *unused)
 {
 	void (*func)(struct seq_file *) = s->private;
 	func(s);
 	return 0;
 }
 
-static int dss_debug_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, dss_debug_show, inode->i_private);
-}
-
-static const struct file_operations dss_debug_fops = {
-	.open           = dss_debug_open,
-	.read           = seq_read,
-	.llseek         = seq_lseek,
-	.release        = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(dss);
 
 static struct dentry *dss_debugfs_dir;
 
@@ -130,7 +120,7 @@ static int dss_initialize_debugfs(void)
 	}
 
 	debugfs_create_file("clk", S_IRUGO, dss_debugfs_dir,
-			&dss_debug_dump_clocks, &dss_debug_fops);
+			&dss_debug_dump_clocks, &dss_fops);
 
 	return 0;
 }
-- 
2.17.0

