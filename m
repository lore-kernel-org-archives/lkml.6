Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755257AbeDTNdY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 09:33:24 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:46954 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755242AbeDTNdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 09:33:20 -0400
X-Google-Smtp-Source: AIpwx4/QAW7hmW4/wHpNePEQSpudsjYLlGNnh+yO19pvpbKGbCACGX4rof4nzhgCRiwoO0MHDfow4w==
From: Greentime Hu <green.hu@gmail.com>
X-Google-Original-From: Greentime Hu <greentime@andestech.com>
To: linux-kernel@vger.kernel.org, arnd@arndb.de, greentime@andestech.com,
        green.hu@gmail.com, private@roeck-us.net, hch@infradead.org,
        vincentc@andestech.com, nickhu@andestech.com
Subject: [PATCH v2 9/9] nds32: Fix the allmodconfig build. To make sure CONFIG_CPU_LITTLE_ENDIAN is default y
Date: Fri, 20 Apr 2018 21:31:15 +0800
Message-Id: <186daa632c13751fc68bc31c52d3230846966a6a.1524229040.git.greentime@andestech.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <cover.1524229035.git.greentime@andestech.com>
References: <cover.1524229035.git.greentime@andestech.com>
In-Reply-To: <cover.1524229035.git.greentime@andestech.com>
References: <cover.1524229035.git.greentime@andestech.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This way we can build kernel with CONFIG_CPU_LITTLE_ENDIAN=y. Build allmodconfig
and allnoconfig are available too. It also fix the endian mismatch issue because
AFLAGS and LDFLAGS is not passed correctly.

Signed-off-by: Vincent Ren-Wei Chen <vincentc@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 arch/nds32/Kconfig.cpu | 5 +++--
 arch/nds32/Makefile    | 4 ++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/nds32/Kconfig.cpu b/arch/nds32/Kconfig.cpu
index ba44cc539da9..b8c8984d1456 100644
--- a/arch/nds32/Kconfig.cpu
+++ b/arch/nds32/Kconfig.cpu
@@ -1,10 +1,11 @@
 comment "Processor Features"
 
 config CPU_BIG_ENDIAN
-	bool "Big endian"
+	def_bool !CPU_LITTLE_ENDIAN
 
 config CPU_LITTLE_ENDIAN
-        def_bool !CPU_BIG_ENDIAN
+	bool "Little endian"
+	default y
 
 config HWZOL
 	bool "hardware zero overhead loop support"
diff --git a/arch/nds32/Makefile b/arch/nds32/Makefile
index 20edf34e70ce..513bb2e9baf9 100644
--- a/arch/nds32/Makefile
+++ b/arch/nds32/Makefile
@@ -32,8 +32,12 @@ endif
 
 ifdef CONFIG_CPU_LITTLE_ENDIAN
 KBUILD_CFLAGS   += $(call cc-option, -EL)
+KBUILD_AFLAGS   += $(call cc-option, -EL)
+LDFLAGS         += $(call cc-option, -EL)
 else
 KBUILD_CFLAGS   += $(call cc-option, -EB)
+KBUILD_AFLAGS   += $(call cc-option, -EB)
+LDFLAGS         += $(call cc-option, -EB)
 endif
 
 boot := arch/nds32/boot
-- 
1.9.5
