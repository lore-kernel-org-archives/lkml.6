Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755339AbeDZLAr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 07:00:47 -0400
Received: from david.siemens.de ([192.35.17.14]:46816 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754663AbeDZLAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 07:00:43 -0400
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2] of: overlay: Stop leaking resources on overlay removal
To: Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree <devicetree@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Tull <atull@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
X-Mozilla-News-Host: news://news://news.gmane.org:119
Message-ID: <e8704374-857c-d80e-e91c-89d59e1cffbe@siemens.com>
Date: Thu, 26 Apr 2018 13:00:30 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only the overlay notifier callbacks have a chance to potentially get
hold of references to those two resources, but they are not supposed to
store them beyond OF_OVERLAY_POST_REMOVE.

Document the overlay notifier API, its constraint regarding pointer
lifetime, and then remove intentional leaks of ovcs->overlay_tree and
ovcs->fdt from free_overlay_changeset.

See also https://lkml.org/lkml/2018/4/23/1063 and following.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Documentation/devicetree/overlay-notes.txt |  8 ++++++++
 drivers/of/overlay.c                       | 30 +++++++++++++++++++++---------
 2 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/overlay-notes.txt b/Documentation/devicetree/overlay-notes.txt
index a4feb6dde8cd..725fb8d255c1 100644
--- a/Documentation/devicetree/overlay-notes.txt
+++ b/Documentation/devicetree/overlay-notes.txt
@@ -98,6 +98,14 @@ Finally, if you need to remove all overlays in one-go, just call
 of_overlay_remove_all() which will remove every single one in the correct
 order.
 
+In addition, there is the option to register notifiers that get called on
+overlay operations. See of_overlay_notifier_register/unregister and
+enum of_overlay_notify_action for details.
+
+Note that a notifier callback is not supposed to store pointers to a device
+tree node or its content beyond OF_OVERLAY_POST_REMOVE corresponding to the
+respective node it received.
+
 Overlay DTS Format
 ------------------
 
diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index b35fe88f1851..7baa53e5b1d7 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -102,12 +102,28 @@ static DEFINE_IDR(ovcs_idr);
 
 static BLOCKING_NOTIFIER_HEAD(overlay_notify_chain);
 
+/**
+ * of_overlay_notifier_register() - Register notifier for overlay operations
+ * @nb:		Notifier block to register
+ *
+ * Register for notification on overlay operations on device tree nodes. The
+ * reported actions definied by @of_reconfig_change. The notifier callback
+ * furthermore receives a pointer to the affected device tree node.
+ *
+ * Note that a notifier callback is not supposed to store pointers to a device
+ * tree node or its content beyond @OF_OVERLAY_POST_REMOVE corresponding to the
+ * respective node it received.
+ */
 int of_overlay_notifier_register(struct notifier_block *nb)
 {
 	return blocking_notifier_chain_register(&overlay_notify_chain, nb);
 }
 EXPORT_SYMBOL_GPL(of_overlay_notifier_register);
 
+/**
+ * of_overlay_notifier_register() - Unregister notifier for overlay operations
+ * @nb:		Notifier block to unregister
+ */
 int of_overlay_notifier_unregister(struct notifier_block *nb)
 {
 	return blocking_notifier_chain_unregister(&overlay_notify_chain, nb);
@@ -671,17 +687,13 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
 		of_node_put(ovcs->fragments[i].overlay);
 	}
 	kfree(ovcs->fragments);
-
 	/*
-	 * TODO
-	 *
-	 * would like to: kfree(ovcs->overlay_tree);
-	 * but can not since drivers may have pointers into this data
-	 *
-	 * would like to: kfree(ovcs->fdt);
-	 * but can not since drivers may have pointers into this data
+	 * There should be no live pointers into ovcs->overlay_tree and
+	 * ovcs->fdt due to the policy that overlay notifiers are not allowed
+	 * to retain pointers into the overlay devicetree.
 	 */
-
+	kfree(ovcs->overlay_tree);
+	kfree(ovcs->fdt);
 	kfree(ovcs);
 }
 
-- 
2.13.6
