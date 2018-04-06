Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752499AbeDFNAu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 09:00:50 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:42121 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752128AbeDFNAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 09:00:48 -0400
X-Google-Smtp-Source: AIpwx49ilFivYCK5XXY3VGA8OqrVWvo2Ie97Prgzpt5fBOQr7dSXKAuEZ8AD4GPBNKEH8k9s2Xw6oQ==
From: Anders Roxell <anders.roxell@linaro.org>
To: tony@atomide.com, d-gerlach@ti.com
Cc: santosh.shilimkar@oracle.com, rmk+kernel@armlinux.org.uk,
        linux-kernel@vger.kernel.org, Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] drivers/memory: can't open emif-asm-offsets.s for writing
Date: Fri,  6 Apr 2018 15:00:30 +0200
Message-Id: <20180406130030.745-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.16.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Build failes due to that the directory isn't created before we execute
the build rule.
cc1: fatal error: can’t open ‘drivers/memory/emif-asm-offsets.s’ for
  writing: No such file or directory compilation terminated.
drivers/memory/Makefile.asm-offsets:2: recipe for target 'drivers/memory/emif-asm-offsets.s' failed
make[2]: *** [drivers/memory/emif-asm-offsets.s] Error 1
Makefile:1060: recipe for target
'arch/arm/mach-omap2' failed
make[1]: *** [arch/arm/mach-omap2] Error 2
make[1]: *** Waiting for unfinished jobs....

Current code adds a file check before checking the dependency, in
filechk it does mkdir -p $(dir $@).

Fixes: 41d9d44d7258 ("ARM: OMAP2+: pm33xx-core: Add platform code needed for PM")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/memory/Makefile.asm-offsets | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/memory/Makefile.asm-offsets b/drivers/memory/Makefile.asm-offsets
index 843ff60ccb5a..70d44a9ed32a 100644
--- a/drivers/memory/Makefile.asm-offsets
+++ b/drivers/memory/Makefile.asm-offsets
@@ -1,4 +1,5 @@
 drivers/memory/emif-asm-offsets.s: drivers/memory/emif-asm-offsets.c
+	$(call filechk,$@)
 	$(call if_changed_dep,cc_s_c)
 
 include/generated/ti-emif-asm-offsets.h: drivers/memory/emif-asm-offsets.s FORCE
-- 
2.16.3
