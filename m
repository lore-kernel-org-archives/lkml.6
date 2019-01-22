Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD56C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2020217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548170604;
	bh=UEB610lHpX8IzbMk+K0D+wlmM2n52roj5Owc+Pu0IR0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=2DAQJG0rzsVPeClNweMd8YIG5VvTJCcaDKFcwRzd9W0hVJA6C7P0hbroLMsYdI679
	 G2i6XktHshmJVa7cq619TfZ0kcaTT1LApTrYMI82wp53eJdoU4fh7E9cOZbz0899AS
	 ACYiWkhLDqnVw7ZdxbE+vxfQvkfyV94aJ+Lz449E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729822AbfAVPXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:23:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:36178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729034AbfAVPXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:23:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C7E120879;
        Tue, 22 Jan 2019 15:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548170598;
        bh=UEB610lHpX8IzbMk+K0D+wlmM2n52roj5Owc+Pu0IR0=;
        h=From:To:Cc:Subject:Date:From;
        b=Ap82X8rVHQUInznQSBGMl+rOv/9D3RTuzrf0mNOnoe/+/x9XOZ+9V7sQ+wy+7vLbJ
         vOFDLMoG26dDpE21b+jVZHAsdx9JDrvKd91Qlfu/wfWlwf/Px+4Yy17ZzheHCH1HyY
         cEawlMcTn2hKC8gRE/au4pCrE8CR66AyBTsy8ZAs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org
Subject: [PATCH] backing-dev: no need to check return value of debugfs_create functions
Date:   Tue, 22 Jan 2019 16:21:07 +0100
Message-Id: <20190122152151.16139-8-gregkh@linuxfoundation.org>
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

And as the return value does not matter at all, no need to save the
dentry in struct backing_dev_info, so delete it.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Anders Roxell <anders.roxell@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Michal Hocko <mhocko@suse.com>
Cc: linux-mm@kvack.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/backing-dev-defs.h |  1 -
 mm/backing-dev.c                 | 24 +++++-------------------
 2 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index c31157135598..7f64d813580b 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -202,7 +202,6 @@ struct backing_dev_info {
 
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debug_dir;
-	struct dentry *debug_stats;
 #endif
 };
 
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 8a8bb8796c6c..85ef344a9c67 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -102,39 +102,25 @@ static int bdi_debug_stats_show(struct seq_file *m, void *v)
 }
 DEFINE_SHOW_ATTRIBUTE(bdi_debug_stats);
 
-static int bdi_debug_register(struct backing_dev_info *bdi, const char *name)
+static void bdi_debug_register(struct backing_dev_info *bdi, const char *name)
 {
-	if (!bdi_debug_root)
-		return -ENOMEM;
-
 	bdi->debug_dir = debugfs_create_dir(name, bdi_debug_root);
-	if (!bdi->debug_dir)
-		return -ENOMEM;
-
-	bdi->debug_stats = debugfs_create_file("stats", 0444, bdi->debug_dir,
-					       bdi, &bdi_debug_stats_fops);
-	if (!bdi->debug_stats) {
-		debugfs_remove(bdi->debug_dir);
-		bdi->debug_dir = NULL;
-		return -ENOMEM;
-	}
 
-	return 0;
+	debugfs_create_file("stats", 0444, bdi->debug_dir, bdi,
+			    &bdi_debug_stats_fops);
 }
 
 static void bdi_debug_unregister(struct backing_dev_info *bdi)
 {
-	debugfs_remove(bdi->debug_stats);
-	debugfs_remove(bdi->debug_dir);
+	debugfs_remove_recursive(bdi->debug_dir);
 }
 #else
 static inline void bdi_debug_init(void)
 {
 }
-static inline int bdi_debug_register(struct backing_dev_info *bdi,
+static inline void bdi_debug_register(struct backing_dev_info *bdi,
 				      const char *name)
 {
-	return 0;
 }
 static inline void bdi_debug_unregister(struct backing_dev_info *bdi)
 {
-- 
2.20.1

