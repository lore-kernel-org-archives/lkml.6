Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933810AbeCDATF (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 19:19:05 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:40856 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933524AbeCDASp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 19:18:45 -0500
X-Google-Smtp-Source: AG47ELsTrURhGMZsvzc72pGBbUMHh5YqBqCSAQ3tjPub7VVxpYcrAbkUvQ4VHRtIUx1MjcuMwuz2Hg==
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>, pantelis.antoniou@konsulko.com,
        Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org, laurent.pinchart+renesas@ideasonboard.com
Subject: [PATCH v7 5/5] of: improve reporting invalid overlay target path
Date: Sat,  3 Mar 2018 16:17:53 -0800
Message-Id: <1520122673-11003-6-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520122673-11003-1-git-send-email-frowand.list@gmail.com>
References: <1520122673-11003-1-git-send-email-frowand.list@gmail.com>
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

changes from v2:
  - add fragment node name as suggested by Geert
  - existing error message printed short node name, thus not
    discriminating between fragments; change to full node name
  - existing error message printed node address, which is devicetree
    internal debugging, not useful in an overlay apply error message;
    remove node address from message

 drivers/of/overlay.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index e3d7f69a8333..b930e05d1215 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -488,20 +488,30 @@ static int build_changeset(struct overlay_changeset *ovcs)
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
+			pr_err("find target, node: %pOF, phandle 0x%x not found\n",
+			       info_node, val);
+		return node;
+	}
 
 	ret = of_property_read_string(info_node, "target-path", &path);
-	if (!ret)
-		return of_find_node_by_path(path);
+	if (!ret) {
+		node =  of_find_node_by_path(path);
+		if (!node)
+			pr_err("find target, node: %pOF, path '%s' not found\n",
+			       info_node, path);
+		return node;
+	}
 
-	pr_err("Failed to find target for node %p (%s)\n",
-		info_node, info_node->name);
+	pr_err("find target, node: %pOF, no target property\n", info_node);
 
 	return NULL;
 }
-- 
Frank Rowand <frank.rowand@sony.com>
