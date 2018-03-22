Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932494AbeCVOWj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 10:22:39 -0400
Received: from forward106p.mail.yandex.net ([77.88.28.109]:56167 "EHLO
        forward106p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932482AbeCVOWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 10:22:35 -0400
Authentication-Results: smtp2j.mail.yandex.net; dkim=pass header.i=@flygoat.com
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
To: jhogan@kernel.org
Cc: chenhc@lemote.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 1/2] MIPS: Introduce has_cpu_mips*_user in cpu-features.h
Date: Thu, 22 Mar 2018 22:22:14 +0800
Message-Id: <20180322142215.7705-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180321145304.4639-1-jiaxun.yang@flygoat.com>
References: <20180321145304.4639-1-jiaxun.yang@flygoat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some processors support user mode instructions ISA level which is
different with the ISA level it should be treated in kernel, such
as Loongson 3A1000 3B1000 3A1500 3B1500 support all mips64r2 user
mode instructions however, they should be treated as mips64r1 in
kernel.

So we introduce has_cpu_mips*_user to decide which level should be
displayed in cpuinfo to prevent misleading userspace programs.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/include/asm/cpu-features.h | 39 ++++++++++++++++++++++++++++++++++++
 arch/mips/kernel/proc.c              | 22 ++++++++++----------
 2 files changed, 50 insertions(+), 11 deletions(-)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index 721b698bfe3c..0eff1956e229 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -251,6 +251,45 @@
 # define cpu_has_mips64r6	(cpu_data[0].isa_level & MIPS_CPU_ISA_M64R6)
 #endif
 
+/*
+ * For the CPU that has a user mode instructions ISA level which is different
+ * from the ISA level it should be treated in kernel, this ISA level will
+ * be displayed in cpuinfo as a reference for userspace programs.
+ */
+#ifndef cpu_has_mips_1_user
+# define cpu_has_mips_1_user		(cpu_has_mips_1)
+#endif
+#ifndef cpu_has_mips_2_user
+# define cpu_has_mips_2_user		(cpu_has_mips_2)
+#endif
+#ifndef cpu_has_mips_3_user
+# define cpu_has_mips_3_user		(cpu_has_mips_3)
+#endif
+#ifndef cpu_has_mips_4_user
+# define cpu_has_mips_4_user		(cpu_has_mips_4)
+#endif
+#ifndef cpu_has_mips_5_user
+# define cpu_has_mips_5_user		(cpu_has_mips_5)
+#endif
+#ifndef cpu_has_mips32r1_user
+# define cpu_has_mips32r1_user	(cpu_has_mips32r1)
+#endif
+#ifndef cpu_has_mips32r2_user
+# define cpu_has_mips32r2_user	(cpu_has_mips32r2)
+#endif
+#ifndef cpu_has_mips32r6_user
+# define cpu_has_mips32r6_user	(cpu_has_mips32r6)
+#endif
+#ifndef cpu_has_mips64r1_user
+# define cpu_has_mips64r1_user	(cpu_has_mips64r1)
+#endif
+#ifndef cpu_has_mips64r2_user
+# define cpu_has_mips64r2_user	(cpu_has_mips64r2)
+#endif
+#ifndef cpu_has_mips64r6_user
+# define cpu_has_mips64r6_user	(cpu_has_mips64r6)
+#endif
+
 /*
  * Shortcuts ...
  */
diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
index b2de408a259e..65a9a695af3c 100644
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -84,27 +84,27 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	}
 
 	seq_printf(m, "isa\t\t\t:"); 
-	if (cpu_has_mips_1)
+	if (cpu_has_mips_1_user)
 		seq_printf(m, " mips1");
-	if (cpu_has_mips_2)
+	if (cpu_has_mips_2_user)
 		seq_printf(m, "%s", " mips2");
-	if (cpu_has_mips_3)
+	if (cpu_has_mips_3_user)
 		seq_printf(m, "%s", " mips3");
-	if (cpu_has_mips_4)
+	if (cpu_has_mips_4_user)
 		seq_printf(m, "%s", " mips4");
-	if (cpu_has_mips_5)
+	if (cpu_has_mips_5_user)
 		seq_printf(m, "%s", " mips5");
-	if (cpu_has_mips32r1)
+	if (cpu_has_mips32r1_user)
 		seq_printf(m, "%s", " mips32r1");
-	if (cpu_has_mips32r2)
+	if (cpu_has_mips32r2_user)
 		seq_printf(m, "%s", " mips32r2");
-	if (cpu_has_mips32r6)
+	if (cpu_has_mips32r6_user)
 		seq_printf(m, "%s", " mips32r6");
-	if (cpu_has_mips64r1)
+	if (cpu_has_mips64r1_user)
 		seq_printf(m, "%s", " mips64r1");
-	if (cpu_has_mips64r2)
+	if (cpu_has_mips64r2_user)
 		seq_printf(m, "%s", " mips64r2");
-	if (cpu_has_mips64r6)
+	if (cpu_has_mips64r6_user)
 		seq_printf(m, "%s", " mips64r6");
 	seq_printf(m, "\n");
 
-- 
2.16.2
