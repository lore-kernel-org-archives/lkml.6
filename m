Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752328AbeCNQg4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 12:36:56 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:42070 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752150AbeCNQgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 12:36:54 -0400
X-Google-Smtp-Source: AG47ELsWUPwMuEezHFB0fWV3tAEk3ZcnsgqUu0UUc+ud6K4q3iDEhOqSvzhhCHDo71kPKBYjITAqmQ==
Subject: [PATCH] of: Respect CONFIG_CMDLINE{,_EXTENED,_FORCE) with no chosen node
Date: Wed, 14 Mar 2018 09:31:05 -0700
Message-Id: <20180314163105.8638-1-palmer@sifive.com>
X-Mailer: git-send-email 2.16.1
Cc: Palmer Dabbelt <palmer@sifive.com>, Michael J Clark <mjc@sifive.com>,
        Trung Tran <trung.tran@ettus.com>, Moritz Fischer <mdf@kernel.org>
From: Palmer Dabbelt <palmer@sifive.com>
To: robh+dt@kernel.org, frowand.list@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Systems that boot without a chosen node in the device tree should still
respect the command lines that are built into the kernel.  This patch
avoids bailing out of the command line argument parsing code when there
is no chosen node in the device tree.  This is necessary to boot
straight to a root file system (ie, without an initramfs)

The intent here is that the only functional change is to copy
CONFIG_CMDLINE into data if both of them are valid (ie, CONFIG_CMDLINE
is defined and data is non-null) on systems where there is no chosen
device tree node.  I don't actually know what the return values do so I
just preserved them.

Thanks to Trung and Moritz for finding the bug during our ELC hackathon
(and providing the first fix), and Michal for suggesting this fix (which
is cleaner than what I was doing).  I've given this very minimal
testing: it fixes the RISC-V bug (in conjunction with a patch to move
from COMMANDLINE_OVERRIDE to COMMANDLINE_FORCE), still works on systems
with and without the chosen node, and builds on ARM64.

CC: Michael J Clark <mjc@sifive.com>
CC: Trung Tran <trung.tran@ettus.com>
CC: Moritz Fischer <mdf@kernel.org>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 drivers/of/fdt.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 84aa9d676375..60241b1cb024 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1084,9 +1084,12 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
 
 	pr_debug("search \"chosen\", depth: %d, uname: %s\n", depth, uname);
 
-	if (depth != 1 || !data ||
+	if (!data)
+		goto no_data;
+
+	if (depth != 1 ||
 	    (strcmp(uname, "chosen") != 0 && strcmp(uname, "chosen@0") != 0))
-		return 0;
+		goto no_chosen;
 
 	early_init_dt_check_for_initrd(node);
 
@@ -1117,6 +1120,13 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
 
 	/* break now */
 	return 1;
+
+no_chosen:
+#ifdef CONFIG_CMDLINE
+	strlcpy(data, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
+#endif
+no_data:
+	return 0;
 }
 
 #ifdef CONFIG_HAVE_MEMBLOCK
-- 
2.16.1
