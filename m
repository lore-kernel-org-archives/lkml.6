Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933327AbeCBVDj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 16:03:39 -0500
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:39700 "EHLO
        emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933204AbeCBVDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 16:03:38 -0500
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] init/ramdisk: use pr_cont() at the end of ramdisk loading
Date: Fri,  2 Mar 2018 22:55:52 +0200
Message-Id: <20180302205552.16031-1-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.9.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use pr_cont() at the end of ramdisk loading. This will avoid the rotator
and an extra newline appearing in the dmesg.

Before:
[    0.868650] RAMDISK: Loading 2436KiB [1 disk] into ram disk... |
[    1.490464] done.

After:
[    0.868587] RAMDISK: Loading 2436KiB [1 disk] into ram disk... done.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 init/do_mounts_rd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
index 99e0b64..e3cba12 100644
--- a/init/do_mounts_rd.c
+++ b/init/do_mounts_rd.c
@@ -255,7 +255,7 @@ int __init rd_load_image(char *from)
 		nblocks, ((nblocks-1)/devblocks)+1, nblocks>devblocks ? "s" : "");
 	for (i = 0, disk = 1; i < nblocks; i++) {
 		if (i && (i % devblocks == 0)) {
-			printk("done disk #%d.\n", disk++);
+			pr_cont("done disk #%d.\n", disk++);
 			rotate = 0;
 			if (sys_close(in_fd)) {
 				printk("Error closing the disk.\n");
@@ -278,7 +278,7 @@ int __init rd_load_image(char *from)
 		}
 #endif
 	}
-	printk("done.\n");
+	pr_cont("done.\n");
 
 successful_load:
 	res = 1;
-- 
2.9.2
