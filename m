Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751695AbeEQKrT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 06:47:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:50203 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751481AbeEQKrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 06:47:17 -0400
From: Petr Vorel <pvorel@suse.cz>
To: linux-integrity@vger.kernel.org
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH] ima: Fix pr_fmt() redefinition
Date: Thu, 17 May 2018 12:47:02 +0200
Message-Id: <20180517104702.24689-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.16.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previous definition was too late and caused problems in powerpc allyesconfig:
security/integrity/ima/ima_kexec.c:18:0: warning: "pr_fmt" redefined
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

In file included from include/linux/kernel.h:14:0,
                 from include/asm-generic/bug.h:18,
                 from arch/powerpc/include/asm/bug.h:128,
                 from include/linux/bug.h:5,
                 from include/linux/seq_file.h:7,
                 from security/integrity/ima/ima_kexec.c:13:
include/linux/printk.h:288:0: note: this is the location of the previous definition
 #define pr_fmt(fmt) fmt

Fixes: 3dea0d93d257 ("ima: Unify logging")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 security/integrity/ima/ima_kexec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index db0de585f6c0..16bd18747cfa 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -10,13 +10,13 @@
  * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
  */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/seq_file.h>
 #include <linux/vmalloc.h>
 #include <linux/kexec.h>
 #include "ima.h"
 
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
 #ifdef CONFIG_IMA_KEXEC
 static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
 				     unsigned long segment_size)
-- 
2.16.3
