Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752772AbeCESw1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 13:52:27 -0500
Received: from mail-ua0-f196.google.com ([209.85.217.196]:43961 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751965AbeCESwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 13:52:23 -0500
X-Google-Smtp-Source: AG47ELtjOgMRugeJU4JxKUxQruMfI+iVEBBWQA2ttuzZhizWr/n2d1wQOgKLVYMhfjbMHPlUpXxPWA==
From: Fabio Estevam <festevam@gmail.com>
To: broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, david@lechnology.com,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH v2] regmap: debugfs: Disambiguate dummy debugfs file name
Date: Mon,  5 Mar 2018 15:52:09 -0300
Message-Id: <1520275929-2708-1-git-send-email-festevam@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Since commit 9b947a13e7f6 ("regmap: use debugfs even when no device")
allows the usage of regmap debugfs even when there is no device
associated, which causes several warnings like this:

(NULL device *): Failed to create debugfs directory

This happens when the debugfs file name is 'dummy'.

The first dummy debugfs creation works fine, but subsequent creations
fail as they have all the same name.

Disambiguate the 'dummy' debugfs file name by adding a suffix entry,
so that the names become dummy0, dummy1, dummy2, etc.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes since v1:
- Add a suffix entry to the dummy name

 drivers/base/regmap/regmap-debugfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index 7eb512b..d2f0681 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -25,6 +25,7 @@ struct regmap_debugfs_node {
 	struct list_head link;
 };
 
+static unsigned int dummy_index;
 static struct dentry *regmap_debugfs_root;
 static LIST_HEAD(regmap_debugfs_early_list);
 static DEFINE_MUTEX(regmap_debugfs_early_lock);
@@ -573,6 +574,11 @@ void regmap_debugfs_init(struct regmap *map, const char *name)
 		name = devname;
 	}
 
+	if (!strcmp(name, "dummy")) {
+		name = kasprintf(GFP_KERNEL, "dummy%d", dummy_index);
+		dummy_index++;
+	}
+
 	map->debugfs = debugfs_create_dir(name, regmap_debugfs_root);
 	if (!map->debugfs) {
 		dev_warn(map->dev, "Failed to create debugfs directory\n");
-- 
2.7.4
