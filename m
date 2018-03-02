Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425661AbeCBTMy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 14:12:54 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:39016 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424128AbeCBTMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 14:12:52 -0500
X-Google-Smtp-Source: AG47ELubX2jUUyJJYN3yXc19+ii/1h/cE4HQCKMPB/xhdsBBLm4dlfk7o7v+7w6ttw7IfCjXNym+7g==
From: Fabio Estevam <festevam@gmail.com>
To: broonie@kernel.org
Cc: david@lechnology.com, linux-kernel@vger.kernel.org,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH] regmap: debugfs: Do not print warning when no device is associated
Date: Fri,  2 Mar 2018 16:12:40 -0300
Message-Id: <1520017960-5120-1-git-send-email-festevam@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Commit 9b947a13e7f6 ("regmap: use debugfs even when no device")
allows the usage of regmap debugfs even when there is no device
associated, which causes several warnings like this:

(NULL device *): Failed to create debugfs directory

Do not print the warning in the case there is no associated device. 

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/base/regmap/regmap-debugfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index 7eb512b..db6141f 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -575,7 +575,9 @@ void regmap_debugfs_init(struct regmap *map, const char *name)
 
 	map->debugfs = debugfs_create_dir(name, regmap_debugfs_root);
 	if (!map->debugfs) {
-		dev_warn(map->dev, "Failed to create debugfs directory\n");
+		if (map->dev)
+			dev_warn(map->dev,
+				 "Failed to create debugfs directory\n");
 		return;
 	}
 
-- 
2.7.4
