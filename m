Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932074AbeCIKo6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 05:44:58 -0500
Received: from laurent.telenet-ops.be ([195.130.137.89]:43610 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751092AbeCIKoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 05:44:54 -0500
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/3] of: overlay: Remove unused of_overlay_remove_all()
Date: Fri,  9 Mar 2018 11:44:48 +0100
Message-Id: <1520592288-7680-4-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520592288-7680-1-git-send-email-geert+renesas@glider.be>
References: <1520592288-7680-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_overlay_remove_all(), and its predecessor of_overlay_destroy_all(),
were never used.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/overlay-notes.txt |  4 ----
 drivers/of/overlay.c                       | 23 -----------------------
 include/linux/of.h                         |  6 ------
 3 files changed, 33 deletions(-)

diff --git a/Documentation/devicetree/overlay-notes.txt b/Documentation/devicetree/overlay-notes.txt
index a4feb6dde8cd08e8..b84452bfa6dafc62 100644
--- a/Documentation/devicetree/overlay-notes.txt
+++ b/Documentation/devicetree/overlay-notes.txt
@@ -94,10 +94,6 @@ return value is an error or a cookie identifying this overlay.
 previously created via the call to of_overlay_fdt_apply(). Removal of an
 overlay changeset that is stacked by another will not be permitted.
 
-Finally, if you need to remove all overlays in one-go, just call
-of_overlay_remove_all() which will remove every single one in the correct
-order.
-
 Overlay DTS Format
 ------------------
 
diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index dbdeef5a12863ac3..187d5fb4b111b6b0 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -1056,26 +1056,3 @@ int of_overlay_remove(int *ovcs_id)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(of_overlay_remove);
-
-/**
- * of_overlay_remove_all() - Reverts and frees all overlay changesets
- *
- * Removes all overlays from the system in the correct order.
- *
- * Returns 0 on success, or a negative error number
- */
-int of_overlay_remove_all(void)
-{
-	struct overlay_changeset *ovcs, *ovcs_n;
-	int ret;
-
-	/* the tail of list is guaranteed to be safe to remove */
-	list_for_each_entry_safe_reverse(ovcs, ovcs_n, &ovcs_list, ovcs_list) {
-		ret = of_overlay_remove(&ovcs->id);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(of_overlay_remove_all);
diff --git a/include/linux/of.h b/include/linux/of.h
index 4d25e4f952d9bd4c..c6e3300950423ece 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1374,7 +1374,6 @@ struct of_overlay_notify_data {
 int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
 			 int *ovcs_id);
 int of_overlay_remove(int *ovcs_id);
-int of_overlay_remove_all(void);
 
 int of_overlay_notifier_register(struct notifier_block *nb);
 int of_overlay_notifier_unregister(struct notifier_block *nb);
@@ -1391,11 +1390,6 @@ static inline int of_overlay_remove(int *ovcs_id)
 	return -ENOTSUPP;
 }
 
-static inline int of_overlay_remove_all(void)
-{
-	return -ENOTSUPP;
-}
-
 static inline int of_overlay_notifier_register(struct notifier_block *nb)
 {
 	return 0;
-- 
2.7.4
