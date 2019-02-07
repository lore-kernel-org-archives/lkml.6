Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA12C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 21:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17A3921907
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 21:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="iMa7YZiJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfBGVLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 16:11:24 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44341 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727524AbfBGVLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 16:11:24 -0500
Received: by mail-qt1-f193.google.com with SMTP id n32so1553296qte.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 13:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=506iggCwjUov+wxboSi2JHOUIlui0OJeyiN/05dB3Ec=;
        b=iMa7YZiJJ6TAAaN1tJ14LKd8rQFv7Tio4r+PglScG32adMrCalbiKl+XlKhhtmgVzO
         c9/9RuL0TtmriQTowIhkFq6X03WHrUV+/peKr7rpS2GhQwyCdN9qRvU31hPpJeNH042l
         GEGb5eKbfjvmO0sgCOyLHQj3dCPz1/6hn/Myk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=506iggCwjUov+wxboSi2JHOUIlui0OJeyiN/05dB3Ec=;
        b=P3CzNxesbyVtZD8RNrxl+I2LD4+0dzivNnABN5qdzGQooOA939Jz6XBsXEPYQvvIyq
         v9IeJvBxuYtYeWliifcbt6Mz385i6PbK5HLh2aGysKaJvGXyW7KybbdbszUfN0Lxnmi9
         9Vm5b+rRIRlYSslFAlDbFPdLUzaThm5+Yz7J00ALuMz7V+jgiopk9R4yfK0rMrETdSlO
         whUzZYKH+EYtrJVP2QqI4I0uwbGFDsuQkxOfOcoHZtBXG64TqUo9KmXEH/CxIJNha7ym
         /+ku90PMA6zCHnnnOt70Mqv2h4pZus5f9+/TK2hHRfjETvqxlzAJ65bNlNQrI3545b7T
         mBWw==
X-Gm-Message-State: AHQUAuYSE9ZyrFfPpVfJzHPPcPRAArG35KXWtTnHpltg9TYPiWDwEdsA
        56BRLtdnJek4a40pDKQbOFHo5FKCprs=
X-Google-Smtp-Source: AHgI3IaVMOu7cHNhxYiio5PlVkRwfcbqsbZRb2Q4fHXtpse0yetyec6fjsLMC4fgMBZsKWBap6iq3g==
X-Received: by 2002:aed:3c7d:: with SMTP id u58mr13918563qte.198.1549573871270;
        Thu, 07 Feb 2019 13:11:11 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id b77sm162681qka.5.2019.02.07.13.11.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 13:11:10 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Andrew Morton <akpm@linux-foundation.org>, ast@kernel.org,
        atishp04@gmail.com, dancol@google.com,
        Dan Williams <dan.j.williams@intel.com>,
        gregkh@linuxfoundation.org, Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, karim.yaghmour@opersys.com,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Manoj Rao <linux@manojrajarao.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        paulmck@linux.vnet.ibm.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        rdunlap@infradead.org, rostedt@goodmis.org,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        yhs@fb.com
Subject: [PATCH 1/2] Provide in-kernel headers for making it easy to extend the kernel
Date:   Thu,  7 Feb 2019 16:11:01 -0500
Message-Id: <20190207211102.154634-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.20.1.611.gfbb209baf1-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce in-kernel headers and other artifacts which are made available
as an archive through proc (/proc/kheaders.txz file). This archive makes
it possible to build kernel modules, run eBPF programs, and other
tracing programs that need to extend the kernel for tracing purposes
without any dependency on the file system having headers and build
artifacts.

On Android and embedded systems, it is common to switch kernels but not
have kernel headers available on the file system. Raw kernel headers
also cannot be copied into the filesystem like they can be on other
distros, due to licensing and other issues. There's no linux-headers
package on Android. Further once a different kernel is booted, any
headers stored on the file system will no longer be useful. By storing
the headers as a compressed archive within the kernel, we can avoid these
issues that have been a hindrance for a long time.

The feature is also buildable as a module just in case the user desires
it not being part of the kernel image. This makes it possible to load
and unload the headers on demand. A tracing program, or a kernel module
builder can load the module, do its operations, and then unload the
module to save kernel memory. The total memory needed is 3.8MB.

The code to read the headers is based on /proc/config.gz code and uses
the same technique to embed the headers.

To build a module, the below steps have been tested on an x86 machine:
modprobe kheaders
rm -rf $HOME/headers
mkdir -p $HOME/headers
tar -xvf /proc/kheaders.txz -C $HOME/headers >/dev/null
cd my-kernel-module
make -C $HOME/headers M=$(pwd) modules
rmmod kheaders

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
Changes since RFC:
Both changes bring size down to 3.8MB:
- use xz for compression
- strip comments except SPDX lines
- Call out the module name in Kconfig
- Also added selftests in second patch to ensure headers are always
working.

 Documentation/dontdiff    |  1 +
 arch/x86/Makefile         |  2 ++
 init/Kconfig              | 11 ++++++
 kernel/.gitignore         |  2 ++
 kernel/Makefile           | 29 +++++++++++++++
 kernel/kheaders.c         | 74 +++++++++++++++++++++++++++++++++++++++
 scripts/gen_ikh_data.sh   | 19 ++++++++++
 scripts/strip-comments.pl |  8 +++++
 8 files changed, 146 insertions(+)
 create mode 100644 kernel/kheaders.c
 create mode 100755 scripts/gen_ikh_data.sh
 create mode 100755 scripts/strip-comments.pl

diff --git a/Documentation/dontdiff b/Documentation/dontdiff
index 2228fcc8e29f..05a2319ee2a2 100644
--- a/Documentation/dontdiff
+++ b/Documentation/dontdiff
@@ -151,6 +151,7 @@ int8.c
 kallsyms
 kconfig
 keywords.c
+kheaders_data.h*
 ksym.c*
 ksym.h*
 kxgettext
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 88398fdf8129..ad176d669da4 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -240,6 +240,8 @@ archmacros:
 ASM_MACRO_FLAGS = -Wa,arch/x86/kernel/macros.s
 export ASM_MACRO_FLAGS
 KBUILD_CFLAGS += $(ASM_MACRO_FLAGS)
+IKH_EXTRA += arch/x86/kernel/macros.s
+export IKH_EXTRA
 
 ###
 # Kernel objects
diff --git a/init/Kconfig b/init/Kconfig
index a4112e95724a..b95d769b6098 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -549,6 +549,17 @@ config IKCONFIG_PROC
 	  This option enables access to the kernel configuration file
 	  through /proc/config.gz.
 
+config IKHEADERS_PROC
+	tristate "Enable kernel header artifacts through /proc/kheaders.txz"
+	select BUILD_BIN2C
+	depends on PROC_FS
+	help
+	  This option enables access to the kernel header and other artifacts that
+          are generated during the build process. These can be used to build kernel
+          modules, and other in-kernel programs such as those generated by eBPF
+          and systemtap tools. If you build the headers as a module, a module
+          called kheaders.ko is built which can be loaded to get access to them.
+
 config LOG_BUF_SHIFT
 	int "Kernel log buffer size (16 => 64KB, 17 => 128KB)"
 	range 12 25
diff --git a/kernel/.gitignore b/kernel/.gitignore
index b3097bde4e9c..6acf71acbdcb 100644
--- a/kernel/.gitignore
+++ b/kernel/.gitignore
@@ -3,5 +3,7 @@
 #
 config_data.h
 config_data.gz
+kheaders_data.h
+kheaders_data.txz
 timeconst.h
 hz.bc
diff --git a/kernel/Makefile b/kernel/Makefile
index 7343b3a9bff0..aa2d3f9b9f49 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -73,6 +73,7 @@ obj-$(CONFIG_UTS_NS) += utsname.o
 obj-$(CONFIG_USER_NS) += user_namespace.o
 obj-$(CONFIG_PID_NS) += pid_namespace.o
 obj-$(CONFIG_IKCONFIG) += configs.o
+obj-$(CONFIG_IKHEADERS_PROC) += kheaders.o
 obj-$(CONFIG_SMP) += stop_machine.o
 obj-$(CONFIG_KPROBES_SANITY_TEST) += test_kprobes.o
 obj-$(CONFIG_AUDIT) += audit.o auditfilter.o
@@ -131,3 +132,31 @@ $(obj)/config_data.gz: $(KCONFIG_CONFIG) FORCE
 targets += config_data.h
 $(obj)/config_data.h: $(obj)/config_data.gz FORCE
 	$(call filechk,ikconfiggz)
+
+# Build a list of in-kernel headers for building kernel modules
+# Any other files will be stored in IKH_EXTRA variable.
+ikh_file_list := include/
+ikh_file_list += arch/$(ARCH)/Makefile
+ikh_file_list += arch/$(ARCH)/include/
+ikh_file_list += $(IKH_EXTRA)
+ikh_file_list += scripts/
+ikh_file_list += Makefile
+ikh_file_list += Module.symvers
+ifeq ($(CONFIG_STACK_VALIDATION), y)
+ikh_file_list += $(objtree)/tools/objtool/objtool
+endif
+
+$(obj)/kheaders.o: $(obj)/kheaders_data.h
+
+targets += kheaders_data.txz
+
+quiet_cmd_genikh = GEN     $(obj)/kheaders_data.txz
+cmd_genikh = $(srctree)/scripts/gen_ikh_data.sh $@ $^ >/dev/null 2>&1
+$(obj)/kheaders_data.txz: $(ikh_file_list) FORCE
+	$(call cmd,genikh)
+
+filechk_ikheadersxz = (echo "static const char kernel_headers_data[] __used = KH_MAGIC_START"; cat $< | scripts/bin2c; echo "KH_MAGIC_END;")
+
+targets += kheaders_data.h
+$(obj)/kheaders_data.h: $(obj)/kheaders_data.txz FORCE
+	$(call filechk,ikheadersxz)
diff --git a/kernel/kheaders.c b/kernel/kheaders.c
new file mode 100644
index 000000000000..c39930f51202
--- /dev/null
+++ b/kernel/kheaders.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * kernel/kheaders.c
+ * Provide headers and artifacts needed to build kernel modules.
+ * (Borrowed code from kernel/configs.c)
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include <linux/init.h>
+#include <linux/uaccess.h>
+
+/*
+ * Define kernel_headers_data and kernel_headers_data_size, which contains the
+ * compressed kernel headers.  The file is first compressed with xz and then
+ * bounded by two eight byte magic numbers to allow extraction from a binary
+ * kernel image:
+ *
+ *   IKHD_ST
+ *   <image>
+ *   IKHD_ED
+ */
+#define KH_MAGIC_START	"IKHD_ST"
+#define KH_MAGIC_END	"IKHD_ED"
+#include "kheaders_data.h"
+
+
+#define KH_MAGIC_SIZE (sizeof(KH_MAGIC_START) - 1)
+#define kernel_headers_data_size \
+	(sizeof(kernel_headers_data) - 1 - KH_MAGIC_SIZE * 2)
+
+static ssize_t
+ikheaders_read_current(struct file *file, char __user *buf,
+		      size_t len, loff_t *offset)
+{
+	return simple_read_from_buffer(buf, len, offset,
+				       kernel_headers_data + KH_MAGIC_SIZE,
+				       kernel_headers_data_size);
+}
+
+static const struct file_operations ikheaders_file_ops = {
+	.owner = THIS_MODULE,
+	.read = ikheaders_read_current,
+	.llseek = default_llseek,
+};
+
+static int __init ikheaders_init(void)
+{
+	struct proc_dir_entry *entry;
+
+	/* create the current headers file */
+	entry = proc_create("kheaders.txz", S_IFREG | S_IRUGO, NULL,
+			    &ikheaders_file_ops);
+	if (!entry)
+		return -ENOMEM;
+
+	proc_set_size(entry, kernel_headers_data_size);
+
+	return 0;
+}
+
+static void __exit ikheaders_cleanup(void)
+{
+	remove_proc_entry("kheaders.txz", NULL);
+}
+
+module_init(ikheaders_init);
+module_exit(ikheaders_cleanup);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Joel Fernandes");
+MODULE_DESCRIPTION("Echo the kernel header artifacts used to build the kernel");
diff --git a/scripts/gen_ikh_data.sh b/scripts/gen_ikh_data.sh
new file mode 100755
index 000000000000..609196b5cea2
--- /dev/null
+++ b/scripts/gen_ikh_data.sh
@@ -0,0 +1,19 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+spath="$(dirname "$(readlink -f "$0")")"
+
+rm -rf $1.tmp
+mkdir $1.tmp
+
+for f in "${@:2}";
+	do find "$f" ! -name "*.c" ! -name "*.o" ! -name "*.cmd" ! -name ".*";
+done | cpio -pd $1.tmp
+
+for f in $(find $1.tmp); do
+	$spath/strip-comments.pl $f
+done
+
+tar -Jcf $1 -C $1.tmp/ . > /dev/null
+
+rm -rf $1.tmp
diff --git a/scripts/strip-comments.pl b/scripts/strip-comments.pl
new file mode 100755
index 000000000000..f8ada87c5802
--- /dev/null
+++ b/scripts/strip-comments.pl
@@ -0,0 +1,8 @@
+#!/usr/bin/perl -pi
+# SPDX-License-Identifier: GPL-2.0
+
+# This script removes /**/ comments from a file, unless such comments
+# contain "SPDX". It is used when building compressed in-kernel headers.
+
+BEGIN {undef $/;}
+s/\/\*((?!SPDX).)*?\*\///smg;
-- 
2.20.1.611.gfbb209baf1-goog
