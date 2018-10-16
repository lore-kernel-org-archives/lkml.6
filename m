Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCAA0C5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 816F92148E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ij1H6ZBo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 816F92148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbeJQHrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:47:41 -0400
Received: from mail-io1-f73.google.com ([209.85.166.73]:35002 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727966AbeJQHrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:47:40 -0400
Received: by mail-io1-f73.google.com with SMTP id z20-v6so23259651ioh.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 16:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rTMtFvbEL5wKlvpvyNmblvvMe/SeevVrMylypi+1pmA=;
        b=Ij1H6ZBoqLFXY4LSZ+F8jqafESI09IwnXUv/SayN/rV7iRL83lzp1R2mBkHzggwzs9
         MXXwlgtYixKHjLyfIl2WO/XgBTnPG+XHVwvWnQjXhJcaW279Lo/J8U5XesswVnNhCQbe
         uUJpe8pwYL0m8ca8bNnoUM3khas3fIhyY2cX8jCDIXnGSJse35/pjJo6loDFqzb2CAT3
         u35UN8SnnwuREmP8xbDVvX306UmsGOuteOTWn72WeNtfA+I/30JWNkxXsw7eell8JQij
         HCONAWQhFvaJYlOIKdiYhMve/YRRsvfwyZxAz6NnL5kDW3zNU/YQK7J07/3Kj3wnDybU
         STxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rTMtFvbEL5wKlvpvyNmblvvMe/SeevVrMylypi+1pmA=;
        b=p8fOwjvTlr0BUgyOLzHsukbNmx+pfj3c02SIbU9n2DNoKnajjQ/Wv8lzJ3fRnjFzBq
         WNdvY9X8/WA7HiDSxPDPEJXwW5ydaYsFFRGX5xIkKvSqVB6fygvX6cGrG6wY3ZDymIBb
         HsOSeR8ytNQMlvyBmmG4tBviroC2zX0TtsQSMITy2LaoyzTf6Zf4j6/04EwqEJiXJBcs
         lhgAq/RQUyfT8LTWlp9UkS/2baokXJ3Y85DyYhpjkFXS/roc1zZL9jSHnydnOCwgtde5
         KwQVtqE7pbjmQwZbEIa94t7h4ZCno55kQSFVZM/yKryOAGNNSdhj6rScmUQKoqthmfwI
         L2Fg==
X-Gm-Message-State: ABuFfog3UFsgtQHmsR05JJ5n1/KXeKsjNCtpfMu1VwlX+J8yX7jg9jgm
        c/zxYMISIXCRmxHN6nxHnVGohBpZTjRpMuRe/cy6+w==
X-Google-Smtp-Source: ACcGV60qsgyfUWmkMgB33t8fclVO9HCQg4LIMj60RsbXwcv+KsjUPuYEU7pePKSmHdn+QyrEW5B4LfgVo/7XN134Sm2RWw==
X-Received: by 2002:a05:660c:310:: with SMTP id u16mr218066itj.1.1539734089937;
 Tue, 16 Oct 2018 16:54:49 -0700 (PDT)
Date:   Tue, 16 Oct 2018 16:51:15 -0700
In-Reply-To: <20181016235120.138227-1-brendanhiggins@google.com>
Message-Id: <20181016235120.138227-27-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20181016235120.138227-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
Subject: [RFC v1 26/31] arch: um: added stubs for mock iomem for KUnit
From:   Brendan Higgins <brendanhiggins@google.com>
To:     gregkh@linuxfoundation.org, keescook@google.com, mcgrof@kernel.org,
        shuah@kernel.org
Cc:     joel@jms.id.au, mpe@ellerman.id.au, joe@perches.com, brakmo@fb.com,
        rostedt@goodmis.org, Tim.Bird@sony.com, khilman@baylibre.com,
        julia.lawall@lip6.fr, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This mocks out some iomem functions (functions like readl and writel),
for mocking hardware interfaces.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 arch/um/Kconfig.common               |  8 +++++-
 arch/um/Kconfig.um                   |  5 ++++
 arch/um/include/asm/Kbuild           |  1 -
 arch/um/include/asm/io-mock-shared.h | 33 +++++++++++++++++++++
 arch/um/include/asm/io-mock.h        | 43 ++++++++++++++++++++++++++++
 arch/um/include/asm/io.h             |  8 ++++++
 arch/um/kernel/Makefile              |  1 +
 arch/um/kernel/io-mock.c             | 40 ++++++++++++++++++++++++++
 kunit/Kconfig                        |  1 +
 9 files changed, 138 insertions(+), 2 deletions(-)
 create mode 100644 arch/um/include/asm/io-mock-shared.h
 create mode 100644 arch/um/include/asm/io-mock.h
 create mode 100644 arch/um/kernel/io-mock.c

diff --git a/arch/um/Kconfig.common b/arch/um/Kconfig.common
index 07f84c842cc31..72e7efb74f7fd 100644
--- a/arch/um/Kconfig.common
+++ b/arch/um/Kconfig.common
@@ -19,7 +19,13 @@ config MMU
 	default y
 
 config NO_IOMEM
-	def_bool y
+	bool
+	default y if !KUNIT
+
+config HAS_IOMEM
+	bool "Turns on fake IOMEM support for KUnit"
+	depends on KUNIT
+	select MOCK_IOMEM
 
 config ISA
 	bool
diff --git a/arch/um/Kconfig.um b/arch/um/Kconfig.um
index 20da5a8ca9490..8d35e0e2c23d1 100644
--- a/arch/um/Kconfig.um
+++ b/arch/um/Kconfig.um
@@ -122,3 +122,8 @@ config SECCOMP
 	  defined by each seccomp mode.
 
 	  If unsure, say Y.
+
+config PLATFORM_MOCK
+	bool "Enable a mock architecture used for unit testing."
+	depends on KUNIT && OF
+	default n
diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
index b10dde6cb793b..9fd2827ab76d1 100644
--- a/arch/um/include/asm/Kbuild
+++ b/arch/um/include/asm/Kbuild
@@ -12,7 +12,6 @@ generic-y += ftrace.h
 generic-y += futex.h
 generic-y += hardirq.h
 generic-y += hw_irq.h
-generic-y += io.h
 generic-y += irq_regs.h
 generic-y += irq_work.h
 generic-y += kdebug.h
diff --git a/arch/um/include/asm/io-mock-shared.h b/arch/um/include/asm/io-mock-shared.h
new file mode 100644
index 0000000000000..6baf59cb17a58
--- /dev/null
+++ b/arch/um/include/asm/io-mock-shared.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_UM_IO_MOCK_SHARED_H
+#define _ASM_UM_IO_MOCK_SHARED_H
+
+#define readb readb
+u8 readb(const volatile void __iomem *);
+
+#define readw readw
+u16 readw(const volatile void __iomem *);
+
+#define readl readl
+u32 readl(const volatile void __iomem *);
+
+#ifdef CONFIG_64BIT
+#define readq readq
+u64 readq(const volatile void __iomem *);
+#endif /* CONFIG_64BIT */
+
+#define writeb writeb
+void writeb(u8, const volatile void __iomem *);
+
+#define writew writew
+void writew(u16, const volatile void __iomem *);
+
+#define writel writel
+void writel(u32, const volatile void __iomem *);
+
+#ifdef CONFIG_64BIT
+#define writeq writeq
+void writeq(u64, const volatile void __iomem *);
+#endif /* CONFIG_64BIT */
+
+#endif /* _ASM_UM_IO_MOCK_SHARED_H */
diff --git a/arch/um/include/asm/io-mock.h b/arch/um/include/asm/io-mock.h
new file mode 100644
index 0000000000000..bdc5cd1d4e33c
--- /dev/null
+++ b/arch/um/include/asm/io-mock.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Mock IO functions.
+ *
+ * Copyright (C) 2018, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#ifndef _ASM_UM_IO_MOCK_H
+#define _ASM_UM_IO_MOCK_H
+
+#include <asm/io-mock-shared.h>
+#include <kunit/mock.h>
+
+DECLARE_FUNCTION_MOCK(readb,
+		      RETURNS(u8), PARAMS(const volatile void __iomem *));
+
+DECLARE_FUNCTION_MOCK(readw,
+		      RETURNS(u16), PARAMS(const volatile void __iomem *));
+
+DECLARE_FUNCTION_MOCK(readl,
+		      RETURNS(u32), PARAMS(const volatile void __iomem *));
+
+#ifdef CONFIG_64BIT
+DECLARE_FUNCTION_MOCK(readq,
+		      RETURNS(u64), PARAMS(const volatile void __iomem *));
+#endif /* CONFIG_64BIT */
+
+DECLARE_FUNCTION_MOCK_VOID_RETURN(writeb,
+				  PARAMS(u8, const volatile void __iomem *));
+
+DECLARE_FUNCTION_MOCK_VOID_RETURN(writew,
+				  PARAMS(u16, const volatile void __iomem *));
+
+DECLARE_FUNCTION_MOCK_VOID_RETURN(writel,
+				  PARAMS(u32, const volatile void __iomem *));
+
+#ifdef CONFIG_64BIT
+DECLARE_FUNCTION_MOCK_VOID_RETURN(writeq,
+				  PARAMS(u64, const volatile void __iomem *));
+#endif /* CONFIG_64BIT */
+
+#endif /* _ASM_UM_IO_MOCK_H */
diff --git a/arch/um/include/asm/io.h b/arch/um/include/asm/io.h
index 96f77b5232aaf..a7f61cf963756 100644
--- a/arch/um/include/asm/io.h
+++ b/arch/um/include/asm/io.h
@@ -2,11 +2,19 @@
 #ifndef _ASM_UM_IO_H
 #define _ASM_UM_IO_H
 
+#include <linux/types.h>
+#include <asm/byteorder.h>
+
+#if IS_ENABLED(CONFIG_PLATFORM_MOCK)
+#include <asm/io-mock-shared.h>
+#endif
+
 #define ioremap ioremap
 static inline void __iomem *ioremap(phys_addr_t offset, size_t size)
 {
 	return (void __iomem *)(unsigned long)offset;
 }
+#define ioremap_nocache ioremap
 
 #define iounmap iounmap
 static inline void iounmap(void __iomem *addr)
diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
index 2f36d515762ec..770c480d5a101 100644
--- a/arch/um/kernel/Makefile
+++ b/arch/um/kernel/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_GPROF)	+= gprof_syms.o
 obj-$(CONFIG_GCOV)	+= gmon_syms.o
 obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
 obj-$(CONFIG_STACKTRACE) += stacktrace.o
+obj-$(CONFIG_PLATFORM_MOCK)	+= io-mock.o
 
 USER_OBJS := config.o
 
diff --git a/arch/um/kernel/io-mock.c b/arch/um/kernel/io-mock.c
new file mode 100644
index 0000000000000..e0d4648e97a6c
--- /dev/null
+++ b/arch/um/kernel/io-mock.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Mock IO functions.
+ *
+ * Copyright (C) 2018, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#include <linux/mm.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <kunit/mock.h>
+
+DEFINE_FUNCTION_MOCK(readb,
+		     RETURNS(u8), PARAMS(const volatile void __iomem *));
+
+DEFINE_FUNCTION_MOCK(readw,
+		     RETURNS(u16), PARAMS(const volatile void __iomem *));
+
+DEFINE_FUNCTION_MOCK(readl,
+		     RETURNS(u32), PARAMS(const volatile void __iomem *));
+
+#ifdef CONFIG_64BIT
+DEFINE_FUNCTION_MOCK(readq,
+		     RETURNS(u64), PARAMS(const volatile void __iomem *));
+#endif /* CONFIG_64BIT */
+
+DEFINE_FUNCTION_MOCK_VOID_RETURN(writeb,
+				 PARAMS(u8, const volatile void __iomem *));
+
+DEFINE_FUNCTION_MOCK_VOID_RETURN(writew,
+				 PARAMS(u16, const volatile void __iomem *));
+
+DEFINE_FUNCTION_MOCK_VOID_RETURN(writel,
+				 PARAMS(u32, const volatile void __iomem *));
+
+#ifdef CONFIG_64BIT
+DEFINE_FUNCTION_MOCK_VOID_RETURN(writeq,
+				 PARAMS(u64, const volatile void __iomem *));
+#endif /* CONFIG_64BIT */
diff --git a/kunit/Kconfig b/kunit/Kconfig
index 5cb500355c873..9d4b7cfff9d92 100644
--- a/kunit/Kconfig
+++ b/kunit/Kconfig
@@ -6,6 +6,7 @@ menu "KUnit support"
 
 config KUNIT
 	bool "Enable support for unit tests (KUnit)"
+	select HAS_IOMEM
 	help
 	  Enables support for kernel unit tests (KUnit), a lightweight unit
 	  testing and mocking framework for the Linux kernel. These tests are
-- 
2.19.1.331.ge82ca0e54c-goog

