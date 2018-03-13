Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932560AbeCMDbw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 23:31:52 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:45843 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932294AbeCMDbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 23:31:51 -0400
X-Google-Smtp-Source: AG47ELsDxiNdHXsDS0F7JdHaHMYQY3RWAq4Bje6xagzry9FDgpq2//g5q6V36dXFkKtQW8NinVUoQA==
From: Moritz Fischer <mdf@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-riscv@lists.infradead.org, palmer@sifive.com, albert@sifive.com,
        olof@lixom.net, Moritz Fischer <mdf@kernel.org>,
        Trung Tran <trung.tran@ettus.com>
Subject: [RFC/PATCH] risc-v: Fix issue ignoring CONFIG_CMDLINE_OVERRIDE
Date: Mon, 12 Mar 2018 20:26:09 -0700
Message-Id: <20180313032609.405-1-mdf@kernel.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix issue where CONFIG_CMDLINE_OVERRIDE is being
ignored.

Signed-off-by: Trung Tran <trung.tran@ettus.com>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---

Hi all,

not sure this is the right fix, hopefully someone
can chime in and come up with the correct solution.

Thanks,

Moritz
---
 arch/riscv/kernel/setup.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 09f7064e898c..e24191a0c244 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -38,6 +38,8 @@
 #include <asm/tlbflush.h>
 #include <asm/thread_info.h>
 
+static char default_command_line[COMMAND_LINE_SIZE] __initdata = CONFIG_CMDLINE;
+
 #ifdef CONFIG_DUMMY_CONSOLE
 struct screen_info screen_info = {
 	.orig_video_lines	= 30,
@@ -194,7 +196,11 @@ static void __init setup_bootmem(void)
 
 void __init setup_arch(char **cmdline_p)
 {
+#if defined(CONFIG_CMDLINE_OVERRIDE)
+	*cmdline_p = default_command_line;
+#else
 	*cmdline_p = boot_command_line;
+#endif
 
 	parse_early_param();
 
-- 
2.16.2
