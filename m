Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752118AbeDXQUD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 12:20:03 -0400
Received: from thoth.sbs.de ([192.35.17.2]:57624 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750814AbeDXQUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 12:20:01 -0400
X-Mozilla-News-Host: news://news.gmane.org:119
To: Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree <devicetree@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Tull <atull@kernel.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] of: overlay: Stop leaking resources on overlay removal
Openpgp: preference=signencrypt
Message-ID: <097f1b01-6cb4-8dcb-0498-7b4c59a7ea53@siemens.com>
Date: Tue, 24 Apr 2018 18:19:55 +0200
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
hold of references to those two resources, but they do not store them.
So it is safe to stop the intentional leaking.

See also https://lkml.org/lkml/2018/4/23/1063 and following.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Ideally, we sort out any remaining worries during the 4.17-rc cycle.

 drivers/of/overlay.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index b35fe88f1851..3553f1f57a62 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -671,17 +671,8 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
 		of_node_put(ovcs->fragments[i].overlay);
 	}
 	kfree(ovcs->fragments);
-
-	/*
-	 * TODO
-	 *
-	 * would like to: kfree(ovcs->overlay_tree);
-	 * but can not since drivers may have pointers into this data
-	 *
-	 * would like to: kfree(ovcs->fdt);
-	 * but can not since drivers may have pointers into this data
-	 */
-
+	kfree(ovcs->overlay_tree);
+	kfree(ovcs->fdt);
 	kfree(ovcs);
 }
 
-- 
2.13.6
