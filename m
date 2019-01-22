Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C855AC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99CDE217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548170766;
	bh=QkY9JuknuFfEDJqhGiKLfGCJcAdlvvTJd/PzrUlrPeg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=1xmRRcZzhMFCOKrH7HajfAD3xe2R0eVxBt5xCpGV/8cFByIkDEYULe93q/NkJM6GJ
	 KLMpvingm9XKvjVSNDW3FuOGioFU7RbF8UdTFf58d6RcKm1fhWPzAaDG0CU0aH7be3
	 xB4Fh2O9X/OWXawgIYZJWQXTtt/7rwQcqjQrfl0E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729806AbfAVPXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:23:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:36076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729278AbfAVPXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:23:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4370420879;
        Tue, 22 Jan 2019 15:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548170595;
        bh=QkY9JuknuFfEDJqhGiKLfGCJcAdlvvTJd/PzrUlrPeg=;
        h=From:To:Cc:Subject:Date:From;
        b=bMTKEpsz28eEKTj1OhAwDAMJ9w0MU/M+cZZigVBSCpmFZNQInbbvEbnoUYGQ0DYh0
         5qd+vprAFB6+soWZbaRN8axVHwLK99e79MBo1TpZIfZtLIs6iyhcl3kh10x5OfjgAP
         rj9edp5lGeVar5MHYBpOqsWGuPRBwtf2XGK7UojU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH] regmap: no need to check return value of debugfs_create functions
Date:   Tue, 22 Jan 2019 16:21:06 +0100
Message-Id: <20190122152151.16139-7-gregkh@linuxfoundation.org>
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

Cc: Mark Brown <broonie@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/regmap/regmap-debugfs.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index 19eb454f26c3..ce05ae1de630 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -572,14 +572,6 @@ void regmap_debugfs_init(struct regmap *map, const char *name)
 	}
 
 	map->debugfs = debugfs_create_dir(name, regmap_debugfs_root);
-	if (!map->debugfs) {
-		dev_warn(map->dev,
-			 "Failed to create %s debugfs directory\n", name);
-
-		kfree(map->debugfs_name);
-		map->debugfs_name = NULL;
-		return;
-	}
 
 	debugfs_create_file("name", 0400, map->debugfs,
 			    map, &regmap_name_fops);
@@ -656,10 +648,6 @@ void regmap_debugfs_initcall(void)
 	struct regmap_debugfs_node *node, *tmp;
 
 	regmap_debugfs_root = debugfs_create_dir("regmap", NULL);
-	if (!regmap_debugfs_root) {
-		pr_warn("regmap: Failed to create debugfs root\n");
-		return;
-	}
 
 	mutex_lock(&regmap_debugfs_early_lock);
 	list_for_each_entry_safe(node, tmp, &regmap_debugfs_early_list, link) {
-- 
2.20.1

