Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933093AbeBLIw6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 03:52:58 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:40733 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933045AbeBLIwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 03:52:21 -0500
X-Google-Smtp-Source: AH8x226wh13YSV1VD/vLQxg2QDhty3ytZAk9YBEA7Kv/q0IPcm2T0/BesqG8oBXPTvVXtywJeyTULQ==
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>, pantelis.antoniou@konsulko.com,
        Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org
Subject: [PATCH v2 4/4] of: improve reporting invalid overlay target path
Date: Mon, 12 Feb 2018 00:51:36 -0800
Message-Id: <1518425496-12159-5-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1518425496-12159-1-git-send-email-frowand.list@gmail.com>
References: <1518425496-12159-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Errors while developing the patch to create of_overlay_fdt_apply()
exposed inadequate error messages to debug problems when overlay
devicetree fragment nodes contain an invalid target path.  Improve
the messages in find_target_node() to remedy this.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---

Changes from v1:
  - split out from patch 1/2

 drivers/of/overlay.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 5f6c5569e97d..01362e7e98e3 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -488,17 +488,26 @@ static int build_changeset(struct overlay_changeset *ovcs)
  */
 static struct device_node *find_target_node(struct device_node *info_node)
 {
+	struct device_node *node;
 	const char *path;
 	u32 val;
 	int ret;
 
 	ret = of_property_read_u32(info_node, "target", &val);
-	if (!ret)
-		return of_find_node_by_phandle(val);
+	if (!ret) {
+		node = of_find_node_by_phandle(val);
+		if (!node)
+			pr_err("target node find by phandle failed\n");
+		return node;
+	}
 
 	ret = of_property_read_string(info_node, "target-path", &path);
-	if (!ret)
-		return of_find_node_by_path(path);
+	if (!ret) {
+		node =  of_find_node_by_path(path);
+		if (!node)
+			pr_err("target node find by path failed\n");
+		return node;
+	}
 
 	pr_err("Failed to find target for node %p (%s)\n",
 		info_node, info_node->name);
-- 
Frank Rowand <frank.rowand@sony.com>
