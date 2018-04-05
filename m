Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751874AbeDEPRI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 11:17:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34480 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751624AbeDEPRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 11:17:05 -0400
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc: lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        linux-kbuild@vger.kernel.org,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Eugene Syromiatnikov <esyr@redhat.com>, Jiri Benc <jbenc@redhat.com>,
        Stanislav Kozina <skozina@redhat.com>,
        Jerome Marchand <jmarchan@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>, Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 5/9] bpf: Add CONFIG_BUILDID_H option
Date: Thu,  5 Apr 2018 17:16:41 +0200
Message-Id: <20180405151645.19130-6-jolsa@kernel.org>
In-Reply-To: <20180405151645.19130-1-jolsa@kernel.org>
References: <20180405151645.19130-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding CONFIG_BUILDID_H option that forces build to generate
file with GNU build id value:

  include/linux/buildid.h

It contains following macros:

  #define LINUX_BUILDID_DATA "\x6c\x41\x0f\xea\xa9\x5d ...
  #define LINUX_BUILDID_SIZE 20

Those macros will be used in following patches to identify
kernel in more precise way when loading eBPF program that
can touch kernel internal structures.

There's new build output for the check and update
of the buildid.h:

    $ make
    ...
    LD      vmlinux.o
    MODPOST vmlinux.o
    KSYM    .tmp_kallsyms1.o
    KSYM    .tmp_kallsyms2.o
    LD      vmlinux
    SORTEX  vmlinux
    SYSMAP  System.map
    CHK     include/generated/uapi/linux/buildid.h
    UPD     include/generated/uapi/linux/buildid.h
    ...

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 Makefile                  | 12 ++++++++++++
 init/Kconfig              |  3 +++
 scripts/Makefile          |  1 +
 scripts/extract-buildid.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 58 insertions(+)
 create mode 100644 scripts/extract-buildid.c

diff --git a/Makefile b/Makefile
index a65a3919c6ad..92b04d8f08bc 100644
--- a/Makefile
+++ b/Makefile
@@ -1023,6 +1023,15 @@ endif
 include/generated/autoksyms.h: FORCE
 	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/adjust_autoksyms.sh true
 
+ifdef CONFIG_BUILDID_H
+buildid_h := include/linux/buildid.h
+
+define filechk_buildid.h
+	buildid=`readelf -n $@ | grep 'Build ID' | sed -e 's/^.*Build ID: \(.*\)$$/\1/'`; \
+	scripts/extract-buildid $$buildid
+endef
+endif
+
 ARCH_POSTLINK := $(wildcard $(srctree)/arch/$(SRCARCH)/Makefile.postlink)
 
 # Final link of vmlinux with optional arch pass after final link
@@ -1032,6 +1041,9 @@ cmd_link-vmlinux =                                                 \
 
 vmlinux: scripts/link-vmlinux.sh vmlinux_prereq $(vmlinux-deps) FORCE
 	+$(call if_changed,link-vmlinux)
+ifdef CONFIG_BUILDID_H
+	+$(call filechk2,buildid.h,$(buildid_h))
+endif
 
 # Build samples along the rest of the kernel
 ifdef CONFIG_SAMPLES
diff --git a/init/Kconfig b/init/Kconfig
index 2852692d7c9c..572df24dda9b 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1386,6 +1386,9 @@ config KALLSYMS_BASE_RELATIVE
 
 # end of the "standard kernel features (expert users)" menu
 
+config BUILDID_H
+	bool
+
 # syscall, maps, verifier
 config BPF_SYSCALL
 	bool "Enable bpf() system call"
diff --git a/scripts/Makefile b/scripts/Makefile
index 25ab143cbe14..fa34eaed6c29 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -19,6 +19,7 @@ hostprogs-$(CONFIG_ASN1)	 += asn1_compiler
 hostprogs-$(CONFIG_MODULE_SIG)	 += sign-file
 hostprogs-$(CONFIG_SYSTEM_TRUSTED_KEYRING) += extract-cert
 hostprogs-$(CONFIG_SYSTEM_EXTRA_CERTIFICATE) += insert-sys-cert
+hostprogs-$(CONFIG_BUILDID_H)	 += extract-buildid
 
 HOSTCFLAGS_sortextable.o = -I$(srctree)/tools/include
 HOSTCFLAGS_asn1_compiler.o = -I$(srctree)/include
diff --git a/scripts/extract-buildid.c b/scripts/extract-buildid.c
new file mode 100644
index 000000000000..a116723da3ad
--- /dev/null
+++ b/scripts/extract-buildid.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Formats buildid into following macros:
+ *
+ * #define LINUX_BUILDID_DATA "\x6c\x41\x0f\xea\xa9\x5d\x46 ...
+ * #define LINUX_BUILDID_SIZE 20
+ *
+ */
+#include <string.h>
+#include <stdio.h>
+
+int main(int argc, char **argv)
+{
+	char *id;
+	int len, i;
+
+	if (argc != 2) {
+		fprintf(stderr, "usage: %s buildid\n", argv[0]);
+		return -1;
+	}
+
+	id  = argv[1];
+	len = strlen(id);
+
+	printf("#ifndef _LINUX_BUILDID_H\n");
+	printf("#define _LINUX_BUILDID_H\n");
+	printf("\n");
+
+	printf("#define LINUX_BUILDID_DATA \"");
+
+	for (i = 0; i < len; i += 2)
+		printf("\\x%c%c", id[i], id[i + 1]);
+
+	printf("\"\n");
+
+	printf("#define LINUX_BUILDID_SIZE %u\n", len / 2);
+
+	printf("\n");
+	printf("#endif /* _LINUX_BUILDID_H */\n");
+	return 0;
+}
-- 
2.13.6
