Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A53C5AE5E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB74D2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="NvWYsYjM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730028AbfARW4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 17:56:21 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43969 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729988AbfARW4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 17:56:19 -0500
Received: by mail-qt1-f195.google.com with SMTP id i7so17021887qtj.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 14:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wWIoIjynhFpqCzaKzBujc7FkCNVHBpTIttxCTbYayWE=;
        b=NvWYsYjM2pcZtm/PAixRraf8hCa1Unf7V7r1K+r0z41DojV37fKiyJczwRfSnDNCCa
         3AcxhuZxm9OR1rQ46qRfCLwFE/Vg0T8XT6kXlJA2ULgGiAt5+5tSsoXHQPIKdMtEjQYZ
         d4yCbDvI4VZU9XcLxQELSFO0hMVVS1a7gD7A0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wWIoIjynhFpqCzaKzBujc7FkCNVHBpTIttxCTbYayWE=;
        b=SkttODVS23LUlTfRvT4opT7m81MV0TQSOsHWLeJpS48ziI7pAFuUAdj12mGqvi+J/z
         Y2DJhonPvPwUeO3ZRHTT9fnPOfHwz0gRpi7u4lrIU3WBnNSDz14jb6/Fkr96yxK736lp
         p2DqtMKe48ygkgNrqYRheNR6lkJGRu7EfmIywgZLF0TX0cWhnuAD0HWiNNiMPcn0BLRq
         u9JSvK0CJOZ2tM6HQq/TtepKm+/WXEK3KkXQzjwRGZYTnSuuAd1QPvYNN0UwFyy10RV6
         SAdqq2MGfTkSHoKhyoRiPeMpkGWlxeXnEKBGdfIRlTmJXsPXIBXiznR3jZ4e+3Y+Mkjt
         CrkQ==
X-Gm-Message-State: AJcUukfuJ37dBrOPoQeVD7PQWFluYzkSZW8AR0Q8wxC2qRbUMcgfh+m8
        gL5LlpDsHNgRFtrBku7lWknxO7P37pM=
X-Google-Smtp-Source: ALg8bN4lqnF75Fx+LTvoEaRwWtuAcsawjwyvlwj29j72VtFqGlBewmBEmFI4zYLfD0U6WVnNCUYAPg==
X-Received: by 2002:ac8:27c8:: with SMTP id x8mr17497793qtx.352.1547852177433;
        Fri, 18 Jan 2019 14:56:17 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id r18sm69429803qta.83.2019.01.18.14.56.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 14:56:16 -0800 (PST)
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>, ast@kernel.org,
        atishp04@gmail.com, Borislav Petkov <bp@alien8.de>,
        dancol@google.com, gregkh@linuxfoundation.org,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>,
        karim.yaghmour@opersys.com, Kees Cook <keescook@chromium.org>,
        kernel-team@android.com, linux-doc@vger.kernel.org,
        Manoj Rao <linux@manojrajarao.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        paulmck@linux.vnet.ibm.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        rdunlap@infradead.org, rostedt@goodmis.org,
        Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        yhs@fb.com
Subject: [RFC] Provide in-kernel headers for making it easy to extend the kernel
Date:   Fri, 18 Jan 2019 17:55:43 -0500
Message-Id: <20190118225543.86996-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

Introduce in-kernel headers and other artifacts which are made available
as an archive through proc (/proc/kheaders.tgz file). This archive makes
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

The feature is buildable as a module thus making it possible to load and
unload it on demand. A tracing program, or a kernel module builder can
then load the module, do its thing, and then unload the module to save
the kernel memory. At the moment the total memory needed is 7MB.
However, this can be brought down by stripping comments from the header
files, which brings it down to 4MB. Since many of the headers have
copyright information, I have avoided stripping the comments in this
first pass, and can provide future patches to bring the size down if
needed. A further reduction is possible using bzip compression instead
of gzip, however I have stuck to gzip to avoid any dependency on less
popular compression tools.

The code to read the headers is based on /proc/config.gz code and uses
the same technique to embed the headers.

To build a module, the below steps have been tested on an x86 machine:
modprobe kheaders    # If building as IKHEADERS as a module
rm -rf $HOME/headers
mkdir -p $HOME/headers
tar -xvf /proc/kheaders.tgz -C $HOME/headers >/dev/null
cd my-kernel-module
make -C $HOME/headers M=$(PWD) modules
rmmod kheaders

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 Documentation/dontdiff  |  1 +
 arch/x86/Makefile       |  2 ++
 init/Kconfig            | 10 ++++++
 kernel/.gitignore       |  2 ++
 kernel/Makefile         | 29 ++++++++++++++++
 kernel/kheaders.c       | 74 +++++++++++++++++++++++++++++++++++++++++
 scripts/gen_ikh_data.sh | 13 ++++++++
 7 files changed, 131 insertions(+)
 create mode 100644 kernel/kheaders.c
 create mode 100755 scripts/gen_ikh_data.sh

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
index a4112e95724a..0594df0b33ac 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -549,6 +549,16 @@ config IKCONFIG_PROC
 	  This option enables access to the kernel configuration file
 	  through /proc/config.gz.
 
+config IKHEADERS_PROC
+	tristate "Enable kernel header artifacts through /proc/kheaders.tgz"
+	select BUILD_BIN2C
+	depends on PROC_FS
+	help
+	  This option enables access to the kernel header and other artifacts that
+          are generated during the build process. These can be used to build kernel
+          modules, and other in-kernel programs such as those generated by eBPF
+          and systemtap tools.
+
 config LOG_BUF_SHIFT
 	int "Kernel log buffer size (16 => 64KB, 17 => 128KB)"
 	range 12 25
diff --git a/kernel/.gitignore b/kernel/.gitignore
index b3097bde4e9c..cacf6b7f6d32 100644
--- a/kernel/.gitignore
+++ b/kernel/.gitignore
@@ -3,5 +3,7 @@
 #
 config_data.h
 config_data.gz
+kheaders_data.h
+kheaders_data.tgz
 timeconst.h
 hz.bc
diff --git a/kernel/Makefile b/kernel/Makefile
index 7343b3a9bff0..d5968305d716 100644
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
+targets += kheaders_data.tgz
+
+quiet_cmd_genikh = GEN     $(obj)/kheaders_data.tgz
+cmd_genikh = $(srctree)/scripts/gen_ikh_data.sh $@ $^ >/dev/null 2>&1
+$(obj)/kheaders_data.tgz: $(ikh_file_list) FORCE
+	$(call cmd,genikh)
+
+filechk_ikheadersgz = (echo "static const char kernel_headers_data[] __used = KH_MAGIC_START"; cat $< | scripts/bin2c; echo "KH_MAGIC_END;")
+
+targets += kheaders_data.h
+$(obj)/kheaders_data.h: $(obj)/kheaders_data.tgz FORCE
+	$(call filechk,ikheadersgz)
diff --git a/kernel/kheaders.c b/kernel/kheaders.c
new file mode 100644
index 000000000000..ac4ca0248b8b
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
+ * compressed kernel headers.  The file is first compressed with gzip and then
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
+	entry = proc_create("kheaders.tgz", S_IFREG | S_IRUGO, NULL,
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
+	remove_proc_entry("kheaders.tgz", NULL);
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
index 000000000000..e87a0f0c13e5
--- /dev/null
+++ b/scripts/gen_ikh_data.sh
@@ -0,0 +1,13 @@
+#!/bin/bash
+
+echo "${@:2}" > $1.list
+
+rm -rf $1.tmp
+mkdir $1.tmp
+
+for f in "${@:2}";
+	do find "$f" ! -name "*.c" ! -name "*.o" ! -name "*.cmd" ! -name ".*";
+done | cpio -pd $1.tmp
+
+tar -jcf $1 -C $1.tmp/ . > /dev/null
+rm -rf $1.tmp
-- 
2.20.1.321.g9e740568ce-goog

