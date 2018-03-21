Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751796AbeCUBqz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 21:46:55 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:46867 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751557AbeCUBqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 21:46:44 -0400
X-Google-Smtp-Source: AG47ELs/XvaStBT6BO+QQAKJtXk6EQvsS/HBGETbQNvoRQIb7k0UCWpEi11pI3HDXZ9Re0SGDTc0qQ==
From: Laura Abbott <labbott@redhat.com>
To: Andy Lutomirski <luto@kernel.org>, mjw@fedoraproject.org,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Laura Abbott <labbott@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, linux-kernel@vger.kernel.org,
        Nick Clifton <nickc@redhat.com>, Cary Coutant <ccoutant@gmail.com>
Subject: [RFC PATCH 2/3] kbuild: Link with generated build-salt header
Date: Tue, 20 Mar 2018 18:46:34 -0700
Message-Id: <20180321014635.29113-3-labbott@redhat.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180321014635.29113-1-labbott@redhat.com>
References: <20180321014635.29113-1-labbott@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Now that we have a header with appropriate data, link it into the kernel
and modules. If BUILD_TAG isn't set, the script should be empty.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 Makefile                | 4 +++-
 scripts/.gitignore      | 1 +
 scripts/Makefile        | 2 +-
 scripts/build-id.lds.S  | 5 +++++
 scripts/link-vmlinux.sh | 3 ++-
 5 files changed, 12 insertions(+), 3 deletions(-)
 create mode 100644 scripts/build-id.lds.S

diff --git a/Makefile b/Makefile
index de360625aec5..8bef8bfe7a82 100644
--- a/Makefile
+++ b/Makefile
@@ -425,7 +425,8 @@ KBUILD_AFLAGS_KERNEL :=
 KBUILD_CFLAGS_KERNEL :=
 KBUILD_AFLAGS_MODULE  := -DMODULE
 KBUILD_CFLAGS_MODULE  := -DMODULE
-KBUILD_LDFLAGS_MODULE := -T $(srctree)/scripts/module-common.lds
+KBUILD_LDFLAGS_MODULE := -T $(srctree)/scripts/module-common.lds \
+			 -T $(srctree)/scripts/build-id.lds
 GCC_PLUGINS_CFLAGS :=
 
 export ARCH SRCARCH CONFIG_SHELL HOSTCC HOSTCFLAGS CROSS_COMPILE AS LD CC
@@ -995,6 +996,7 @@ export KBUILD_VMLINUX_INIT := $(head-y) $(init-y)
 export KBUILD_VMLINUX_MAIN := $(core-y) $(libs-y2) $(drivers-y) $(net-y) $(virt-y)
 export KBUILD_VMLINUX_LIBS := $(libs-y1)
 export KBUILD_LDS          := arch/$(SRCARCH)/kernel/vmlinux.lds
+export EXTRA_LDS           := scripts/build-id.lds
 export LDFLAGS_vmlinux
 # used by scripts/package/Makefile
 export KBUILD_ALLDIRS := $(sort $(filter-out arch/%,$(vmlinux-alldirs)) arch Documentation include samples scripts tools)
diff --git a/scripts/.gitignore b/scripts/.gitignore
index 0442c06eefcb..6211a33c6f59 100644
--- a/scripts/.gitignore
+++ b/scripts/.gitignore
@@ -13,3 +13,4 @@ asn1_compiler
 extract-cert
 sign-file
 insert-sys-cert
+build-id.lds
diff --git a/scripts/Makefile b/scripts/Makefile
index 25ab143cbe14..d343dab5d934 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -25,7 +25,7 @@ HOSTCFLAGS_asn1_compiler.o = -I$(srctree)/include
 HOSTLOADLIBES_sign-file = -lcrypto
 HOSTLOADLIBES_extract-cert = -lcrypto
 
-always		:= $(hostprogs-y) $(hostprogs-m)
+always		:= $(hostprogs-y) $(hostprogs-m) build-id.lds
 
 # The following hostprogs-y programs are only build on demand
 hostprogs-y += unifdef
diff --git a/scripts/build-id.lds.S b/scripts/build-id.lds.S
new file mode 100644
index 000000000000..bbc3a8e260c1
--- /dev/null
+++ b/scripts/build-id.lds.S
@@ -0,0 +1,5 @@
+#include <generated/build-salt.h>
+
+SECTIONS {
+	ID_TAG
+}
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index be56a1153014..2b57e0139acb 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -93,6 +93,7 @@ modpost_link()
 vmlinux_link()
 {
 	local lds="${objtree}/${KBUILD_LDS}"
+	local extra_lds="${objtree}/${EXTRA_LDS}"
 	local objects
 
 	if [ "${SRCARCH}" != "um" ]; then
@@ -114,7 +115,7 @@ vmlinux_link()
 		fi
 
 		${LD} ${LDFLAGS} ${LDFLAGS_vmlinux} -o ${2}		\
-			-T ${lds} ${objects}
+			-T ${lds} -T ${extra_lds} ${objects}
 	else
 		if [ -n "${CONFIG_THIN_ARCHIVES}" ]; then
 			objects="-Wl,--whole-archive			\
-- 
2.16.2
