Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10606C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE94720825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="k0ap6N/L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE94720825
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbeKJDQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 22:16:09 -0500
Received: from rcdn-iport-6.cisco.com ([173.37.86.77]:45942 "EHLO
        rcdn-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbeKJDQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 22:16:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=6514; q=dns/txt; s=iport;
  t=1541784875; x=1542994475;
  h=from:to:cc:subject:date:message-id;
  bh=0y5wrl//GJ4z1dENQTUgLY7P1BEHD3pTofJksrLUyzk=;
  b=k0ap6N/Lvy7PGGWxptONLFo/lbhzHcDd1WgRnOOK0AbI8LIvAeAcr8tu
   Tw86NODv8UZJ1UwkrlpoF8tRjvl2riTLB/omsF9EZfjiWUdFAn6B8nYmO
   z0+SA0ZOLWIDtZa9kP7xRFC8odM9JhC9icQ7ECNsoY+XaEBMTYK4yjfap
   w=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AMAAA+xOVb/4cNJK1jGwEBAQEDAQE?=
 =?us-ascii?q?BBwMBAQGBUQYBAQELAYIDgWgnjBCLe5k/FIFmDYRsgyYiNA0NAQMBAQIBAQJ?=
 =?us-ascii?q?tKIY6KQR9CAwTgyGCAqkYiiUUhz6EKheBQT+BEYdVhhYCj3iPVAmCHI5yCxi?=
 =?us-ascii?q?QbpdxgUM4gVUzGggbFYMngicXjj0eAzCKRCqCIwEB?=
X-IronPort-AV: E=Sophos;i="5.54,483,1534809600"; 
   d="scan'208";a="479397800"
Received: from alln-core-2.cisco.com ([173.36.13.135])
  by rcdn-iport-6.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Nov 2018 17:34:35 +0000
Received: from zorba.cisco.com ([10.24.43.135])
        by alln-core-2.cisco.com (8.15.2/8.15.2) with ESMTP id wA9HYXVs010556;
        Fri, 9 Nov 2018 17:34:34 GMT
From:   Daniel Walker <danielwa@cisco.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Daniel Walker <dwalker@fifo99.com>, xe-linux-external@cisco.com,
        Maksym Kokhan <maksym.kokhan@globallogic.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] add generic builtin command line
Date:   Fri,  9 Nov 2018 09:34:31 -0800
Message-Id: <20181109173433.1271-1-danielwa@cisco.com>
X-Mailer: git-send-email 2.14.1
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.24.43.135, [10.24.43.135]
X-Outbound-Node: alln-core-2.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code allows architectures to use a generic builtin command line.
The state of the builtin command line options across architecture is
diverse. On x86 and mips they have pretty much the same code and the
code prepends the builtin command line onto the boot loader provided
one. On powerpc there is only a builtin override and nothing else.

The code in this commit unifies the mips and x86 code into a generic
header file under the CONFIG_GENERIC_CMDLINE option. When this
option is enabled the architecture can call the cmdline_add_builtin()
to add the builtin command line.

[maksym.kokhan@globallogic.com: fix cmdline_add_builtin() macro]
Cc: Daniel Walker <dwalker@fifo99.com>
Cc: Daniel Walker <danielwa@cisco.com>
Cc: xe-linux-external@cisco.com
Signed-off-by: Daniel Walker <danielwa@cisco.com>
Signed-off-by: Maksym Kokhan <maksym.kokhan@globallogic.com>
---
 include/linux/cmdline.h | 79 +++++++++++++++++++++++++++++++++++++++++++++++++
 init/Kconfig            | 72 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 151 insertions(+)
 create mode 100644 include/linux/cmdline.h

diff --git a/include/linux/cmdline.h b/include/linux/cmdline.h
new file mode 100644
index 000000000000..e7e5cdd66d3a
--- /dev/null
+++ b/include/linux/cmdline.h
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_CMDLINE_H
+#define _LINUX_CMDLINE_H
+
+/*
+ *
+ * Copyright (C) 2015. Cisco Systems, Inc.
+ *
+ * Generic Append/Prepend cmdline support.
+ */
+
+#if defined(CONFIG_GENERIC_CMDLINE) && defined(CONFIG_CMDLINE_BOOL)
+
+#ifndef CONFIG_CMDLINE_OVERRIDE
+/*
+ * This function will append or prepend a builtin command line to the command
+ * line provided by the bootloader. Kconfig options can be used to alter
+ * the behavior of this builtin command line.
+ * @dest: The destination of the final appended/prepended string
+ * @src: The starting string or NULL if there isn't one.
+ * @tmp: temporary space used for prepending
+ * @length: the maximum length of the strings above.
+ */
+static inline void
+_cmdline_add_builtin(char *dest, char *src, char *tmp, unsigned long length)
+{
+	if (src != dest && src != NULL) {
+		strlcpy(dest, " ", length);
+		strlcat(dest, src, length);
+	}
+
+	strlcat(dest, " ", length);
+
+	if (sizeof(CONFIG_CMDLINE_APPEND) > 1)
+		strlcat(dest, CONFIG_CMDLINE_APPEND, length);
+
+	/*
+	 * You need to convert you old style CONFIG_CMDLINE to use
+	 * the prepend, or append defines. Some architectures use one
+	 * some use the other. You need to figure out which ones is
+	 * right for your situation. I would recommend prepending
+	 * because it's the safest (i.e. CONFIG_CMDLINE_PREPEND).
+	 */
+	BUILD_BUG_ON(sizeof(CONFIG_CMDLINE) != 1);
+
+	if (sizeof(CONFIG_CMDLINE_PREPEND) > 1) {
+		strlcpy(tmp, CONFIG_CMDLINE_PREPEND, length);
+		strlcat(tmp, " ", length);
+		strlcat(tmp, dest, length);
+		strlcpy(dest, tmp, length);
+	}
+}
+
+#define cmdline_add_builtin(dest, src, length)				    \
+{									    \
+	if (sizeof(CONFIG_CMDLINE_PREPEND) > 1) {			    \
+		static char cmdline_tmp_space[length] __initdata;	    \
+		_cmdline_add_builtin(dest, src, cmdline_tmp_space, length); \
+	} else {							    \
+		_cmdline_add_builtin(dest, src, NULL, length);		    \
+	}								    \
+}
+#else
+#define cmdline_add_builtin(dest, src, length)				   \
+{									   \
+	strlcpy(dest, CONFIG_CMDLINE_PREPEND " " CONFIG_CMDLINE_APPEND,    \
+		length);						   \
+}
+#endif /* !CONFIG_CMDLINE_OVERRIDE */
+
+#else
+#define cmdline_add_builtin(dest, src, length) { \
+	if (src != NULL)						   \
+		strlcpy(dest, src, length);				   \
+}
+#endif /* CONFIG_GENERIC_CMDLINE */
+
+
+#endif /* _LINUX_CMDLINE_H */
diff --git a/init/Kconfig b/init/Kconfig
index a4112e95724a..bac58530e082 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1775,6 +1775,78 @@ config PROFILING
 config TRACEPOINTS
 	bool
 
+config GENERIC_CMDLINE
+	bool
+
+if GENERIC_CMDLINE
+
+config CMDLINE_BOOL
+	bool "Built-in kernel command line"
+	help
+	  Allow for specifying boot arguments to the kernel at
+	  build time.  On some systems (e.g. embedded ones), it is
+	  necessary or convenient to provide some or all of the
+	  kernel boot arguments with the kernel itself (that is,
+	  to not rely on the boot loader to provide them.)
+
+	  To compile command line arguments into the kernel,
+	  set this option to 'Y', then fill in the
+	  the boot arguments in CONFIG_CMDLINE.
+
+	  Systems with fully functional boot loaders (i.e. non-embedded)
+	  should leave this option set to 'N'.
+
+config CMDLINE_APPEND
+	string "Built-in kernel command string append"
+	depends on CMDLINE_BOOL
+	default ""
+	help
+	  Enter arguments here that should be compiled into the kernel
+	  image and used at boot time.  If the boot loader provides a
+	  command line at boot time, this string is appended to it to
+	  form the full kernel command line, when the system boots.
+
+	  However, you can use the CONFIG_CMDLINE_OVERRIDE option to
+	  change this behavior.
+
+	  In most cases, the command line (whether built-in or provided
+	  by the boot loader) should specify the device for the root
+	  file system.
+
+config CMDLINE_PREPEND
+	string "Built-in kernel command string prepend"
+	depends on CMDLINE_BOOL
+	default ""
+	help
+	  Enter arguments here that should be compiled into the kernel
+	  image and used at boot time.  If the boot loader provides a
+	  command line at boot time, this string is prepended to it to
+	  form the full kernel command line, when the system boots.
+
+	  However, you can use the CONFIG_CMDLINE_OVERRIDE option to
+	  change this behavior.
+
+	  In most cases, the command line (whether built-in or provided
+	  by the boot loader) should specify the device for the root
+	  file system.
+
+config CMDLINE_OVERRIDE
+	bool "Built-in command line overrides boot loader arguments"
+	depends on CMDLINE_BOOL
+	help
+	  Set this option to 'Y' to have the kernel ignore the boot loader
+	  command line, and use ONLY the built-in command line. In this case
+	  append and prepend strings are concatenated to form the full
+	  command line.
+
+	  This is used to work around broken boot loaders.  This should
+	  be set to 'N' under normal conditions.
+
+config CMDLINE
+	string ""
+
+endif
+
 endmenu		# General setup
 
 source "arch/Kconfig"
-- 
2.14.1

