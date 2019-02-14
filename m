Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33BEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D0E521904
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="fWzf4TNN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391664AbfBNBu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 20:50:26 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:50509 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbfBNBu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 20:50:26 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x1E1mU1f030693;
        Thu, 14 Feb 2019 10:48:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x1E1mU1f030693
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550108911;
        bh=0BvUdvCRw6PHAEM4VEzTZq100sYqySqWIxigW0cVcLM=;
        h=From:To:Cc:Subject:Date:From;
        b=fWzf4TNNn/shTYGZ7qsdt21aRq1IBwEDxBlCliK/k2ABtep601ErBHSs/zLtXTMtx
         S6Bki/FtMoE/2pIaIrubwC5vnPnM2eeV35zhOFKKdyKcwwRF8Ut7Fb4YDxkhv8elRr
         DrRl/qnv/Cam6XkTZdpFlUQi0WzGXtE1w1cqd+4EXXCPcez85R5CL0erM3Rx/3hr2u
         z8/CU4qhpHtz11IXUSjvyG/QmeJW8smxo+v0Qj7Qct0Pok+/SOgswbvn+PUX1iLeEf
         kjMxacVuaV8A0f2sdTQwl1OyR2EKaebgkM8dfmZQDVGRJHdF9M9rlTwaH2xrLFCO7H
         6Ed1ElISGJ36Q==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Popov <alex.popov@linux.com>,
        Kees Cook <keescook@chromium.org>, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH v2] kernel/configs: use .incbin directive to embed config_data.gz
Date:   Thu, 14 Feb 2019 10:48:13 +0900
Message-Id: <1550108893-21226-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This slightly optimizes the kernel/configs.c build.

bin2c is not very efficient because it converts a data file into a
huge array to embed it into a *.c file.

Instead, we can use the .incbin directive.

Also, this simplifies the code; Makefile is cleaner, and the way to
get the offset/size of the config_data.gz is more straightforward.

I used the "asm" statement in *.c instead of splitting it into *.S
because MODULE_* tags are not supported in *.S files.

I also cleaned up kernel/.gitignore; "config_data.gz" is unneeded
because the top-level .gitignore takes care of the "*.gz" pattern.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - The .section directive in v1 accidentally moved executable code
    from .text into .rodata (reported by kbuild test robot).
    .pushsection and .popsection should be used here.

 Documentation/dontdiff |  1 -
 kernel/.gitignore      |  2 --
 kernel/Makefile        | 11 +----------
 kernel/configs.c       | 42 ++++++++++++++++++++----------------------
 4 files changed, 21 insertions(+), 35 deletions(-)

diff --git a/Documentation/dontdiff b/Documentation/dontdiff
index 2228fcc..ef25a06 100644
--- a/Documentation/dontdiff
+++ b/Documentation/dontdiff
@@ -106,7 +106,6 @@ compile.h*
 conf
 config
 config-*
-config_data.h*
 config.mak
 config.mak.autogen
 conmakehash
diff --git a/kernel/.gitignore b/kernel/.gitignore
index b3097bd..6e69910 100644
--- a/kernel/.gitignore
+++ b/kernel/.gitignore
@@ -1,7 +1,5 @@
 #
 # Generated files
 #
-config_data.h
-config_data.gz
 timeconst.h
 hz.bc
diff --git a/kernel/Makefile b/kernel/Makefile
index 6aa7543..6c57e78 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -116,17 +116,8 @@ obj-$(CONFIG_GCC_PLUGIN_STACKLEAK) += stackleak.o
 KASAN_SANITIZE_stackleak.o := n
 KCOV_INSTRUMENT_stackleak.o := n
 
-$(obj)/configs.o: $(obj)/config_data.h
+$(obj)/configs.o: $(obj)/config_data.gz
 
 targets += config_data.gz
 $(obj)/config_data.gz: $(KCONFIG_CONFIG) FORCE
 	$(call if_changed,gzip)
-
-filechk_ikconfiggz = \
-	echo "static const char kernel_config_data[] __used = MAGIC_START"; \
-	cat $< | scripts/bin2c; \
-	echo "MAGIC_END;"
-
-targets += config_data.h
-$(obj)/config_data.h: $(obj)/config_data.gz FORCE
-	$(call filechk,ikconfiggz)
diff --git a/kernel/configs.c b/kernel/configs.c
index 2df132b..b062425 100644
--- a/kernel/configs.c
+++ b/kernel/configs.c
@@ -30,37 +30,35 @@
 #include <linux/init.h>
 #include <linux/uaccess.h>
 
-/**************************************************/
-/* the actual current config file                 */
-
 /*
- * Define kernel_config_data and kernel_config_data_size, which contains the
- * wrapped and compressed configuration file.  The file is first compressed
- * with gzip and then bounded by two eight byte magic numbers to allow
- * extraction from a binary kernel image:
- *
- *   IKCFG_ST
- *   <image>
- *   IKCFG_ED
+ * "IKCFG_ST" and "IKCFG_ED" are used to extract the config data from
+ * a binary kernel image or a module. See scripts/extract-ikconfig.
  */
-#define MAGIC_START	"IKCFG_ST"
-#define MAGIC_END	"IKCFG_ED"
-#include "config_data.h"
-
-
-#define MAGIC_SIZE (sizeof(MAGIC_START) - 1)
-#define kernel_config_data_size \
-	(sizeof(kernel_config_data) - 1 - MAGIC_SIZE * 2)
+asm (
+"	.pushsection .rodata, \"a\"		\n"
+"	.ascii \"IKCFG_ST\"			\n"
+"	.global kernel_config_data		\n"
+"kernel_config_data:				\n"
+"	.incbin \"kernel/config_data.gz\"	\n"
+"	.global kernel_config_data_end		\n"
+"kernel_config_data_end:			\n"
+"	.ascii \"IKCFG_ED\"			\n"
+"	.popsection				\n"
+);
 
 #ifdef CONFIG_IKCONFIG_PROC
 
+extern char kernel_config_data;
+extern char kernel_config_data_end;
+
 static ssize_t
 ikconfig_read_current(struct file *file, char __user *buf,
 		      size_t len, loff_t * offset)
 {
 	return simple_read_from_buffer(buf, len, offset,
-				       kernel_config_data + MAGIC_SIZE,
-				       kernel_config_data_size);
+				       &kernel_config_data,
+				       &kernel_config_data_end -
+				       &kernel_config_data);
 }
 
 static const struct file_operations ikconfig_file_ops = {
@@ -79,7 +77,7 @@ static int __init ikconfig_init(void)
 	if (!entry)
 		return -ENOMEM;
 
-	proc_set_size(entry, kernel_config_data_size);
+	proc_set_size(entry, &kernel_config_data_end - &kernel_config_data);
 
 	return 0;
 }
-- 
2.7.4

