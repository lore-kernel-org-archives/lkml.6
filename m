Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754039AbeBMFmT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 00:42:19 -0500
Received: from exmail.andestech.com ([59.124.169.137]:19335 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751794AbeBMFmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 00:42:16 -0500
From: Alan Kao <alankao@andestech.com>
To: Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>,
        "Steven Rostedt" <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        <patches@groups.riscv.org>, <linux-kernel@vger.kernel.org>,
        <greentime@andestech.com>
CC: Alan Kao <alankao@andestech.com>
Subject: [PATCH v4 1/6] riscv/ftrace: Add RECORD_MCOUNT support
Date: Tue, 13 Feb 2018 13:13:16 +0800
Message-ID: <1518498801-677-2-git-send-email-alankao@andestech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518498801-677-1-git-send-email-alankao@andestech.com>
References: <1518498801-677-1-git-send-email-alankao@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w1D5G1FT046210
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now recordmcount.pl recognizes RISC-V object files. For the mechanism to
work, we have to disable the linker relaxation.

Cc: Greentime Hu <greentime@andestech.com>
Signed-off-by: Alan Kao <alankao@andestech.com>
---
 arch/riscv/Kconfig      | 1 +
 arch/riscv/Makefile     | 3 +++
 scripts/recordmcount.pl | 5 +++++
 3 files changed, 9 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 9e1074fd5cca..570af19a54ea 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -120,6 +120,7 @@ config ARCH_RV64I
 	select 64BIT
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_GRAPH_TRACER
+	select HAVE_FTRACE_MCOUNT_RECORD
 
 endchoice
 
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 6719dd30ec5b..899226e0da7d 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -11,6 +11,9 @@
 LDFLAGS         :=
 OBJCOPYFLAGS    := -O binary
 LDFLAGS_vmlinux :=
+ifeq ($(CONFIG_DYNAMIC_FTRACE),y)
+	LDFLAGS_vmlinux := --no-relax
+endif
 KBUILD_AFLAGS_MODULE += -fPIC
 KBUILD_CFLAGS_MODULE += -fPIC
 
diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
index 2033af758173..d44d55db7c06 100755
--- a/scripts/recordmcount.pl
+++ b/scripts/recordmcount.pl
@@ -376,6 +376,11 @@ if ($arch eq "x86_64") {
     $mcount_regex = "^\\s*([0-9a-fA-F]+):.*\\s__mcount\$";
     $type = ".quad";
     $alignment = 8;
+} elsif ($arch eq "riscv") {
+    $function_regex = "^([0-9a-fA-F]+)\\s+<([^.0-9][0-9a-zA-Z_\\.]+)>:";
+    $mcount_regex = "^\\s*([0-9a-fA-F]+):\\sR_RISCV_CALL\\s_mcount\$";
+    $type = ".quad";
+    $alignment = 2;
 } else {
     die "Arch $arch is not supported with CONFIG_FTRACE_MCOUNT_RECORD";
 }
-- 
2.15.1
