Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753623AbeEWATw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 20:19:52 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38923 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753618AbeEWATs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 20:19:48 -0400
X-Google-Smtp-Source: AB8JxZoTA0L/UQYCWyDX7oQULe2Qozx9Honuo6wH7puNJOVHw8GdgEndna9p9Qgu16fuQ/kYqQ4LCQ==
From: Laura Abbott <labbott@redhat.com>
To: Andy Lutomirski <luto@kernel.org>, mjw@fedoraproject.org,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Laura Abbott <labbott@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, linux-kernel@vger.kernel.org,
        Nick Clifton <nickc@redhat.com>, Cary Coutant <ccoutant@gmail.com>,
        linux-kbuild@vger.kernel.org
Subject: [PATCHv3 1/2] kbuild: Introduce build-salt linker script
Date: Tue, 22 May 2018 17:19:38 -0700
Message-Id: <20180523001939.9431-2-labbott@redhat.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180523001939.9431-1-labbott@redhat.com>
References: <20180523001939.9431-1-labbott@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The build id generated from --build-id can be generated in several different
ways, with the default being the sha1 on the output of the linked file. For
distributions, it can be useful to make sure this ID is unique, even if the
actual file contents don't change. The easiest way to do this is to insert
a comment section with some data.

Introduce a generated linker script to link against the kernel/modules.
This puts the kernel version in a .comment section which will generate a
unique build id if the kernel version changes.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v3: Generate the linker script directly instead of just a header.
---
 Makefile                |  4 +++-
 scripts/.gitignore      |  1 +
 scripts/Makefile        |  9 ++++++++-
 scripts/gensalt         | 22 ++++++++++++++++++++++
 scripts/link-vmlinux.sh |  3 ++-
 5 files changed, 36 insertions(+), 3 deletions(-)
 create mode 100755 scripts/gensalt

diff --git a/Makefile b/Makefile
index ec6f45928fd4..87fe8992afd8 100644
--- a/Makefile
+++ b/Makefile
@@ -428,7 +428,8 @@ KBUILD_AFLAGS_KERNEL :=
 KBUILD_CFLAGS_KERNEL :=
 KBUILD_AFLAGS_MODULE  := -DMODULE
 KBUILD_CFLAGS_MODULE  := -DMODULE
-KBUILD_LDFLAGS_MODULE := -T $(srctree)/scripts/module-common.lds
+KBUILD_LDFLAGS_MODULE := -T $(srctree)/scripts/module-common.lds \
+			 -T $(obj)/scripts/build-salt.lds
 LDFLAGS :=
 GCC_PLUGINS_CFLAGS :=
 
@@ -997,6 +998,7 @@ export KBUILD_VMLINUX_INIT := $(head-y) $(init-y)
 export KBUILD_VMLINUX_MAIN := $(core-y) $(libs-y2) $(drivers-y) $(net-y) $(virt-y)
 export KBUILD_VMLINUX_LIBS := $(libs-y1)
 export KBUILD_LDS          := arch/$(SRCARCH)/kernel/vmlinux.lds
+export EXTRA_LDS           := scripts/build-salt.lds
 export LDFLAGS_vmlinux
 # used by scripts/package/Makefile
 export KBUILD_ALLDIRS := $(sort $(filter-out arch/%,$(vmlinux-alldirs)) arch Documentation include samples scripts tools)
diff --git a/scripts/.gitignore b/scripts/.gitignore
index 0442c06eefcb..1c840ef4f0c8 100644
--- a/scripts/.gitignore
+++ b/scripts/.gitignore
@@ -13,3 +13,4 @@ asn1_compiler
 extract-cert
 sign-file
 insert-sys-cert
+build-salt.lds
diff --git a/scripts/Makefile b/scripts/Makefile
index 25ab143cbe14..019b0749ff46 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -25,7 +25,14 @@ HOSTCFLAGS_asn1_compiler.o = -I$(srctree)/include
 HOSTLOADLIBES_sign-file = -lcrypto
 HOSTLOADLIBES_extract-cert = -lcrypto
 
-always		:= $(hostprogs-y) $(hostprogs-m)
+always		:= $(hostprogs-y) $(hostprogs-m) build-salt.lds
+
+define filechk_build-salt.lds
+	($(CONFIG_SHELL) $(srctree)/scripts/gensalt $(KERNELRELEASE))
+endef
+
+$(obj)/build-salt.lds: $(src)/gensalt FORCE
+	$(call filechk,build-salt.lds)
 
 # The following hostprogs-y programs are only build on demand
 hostprogs-y += unifdef
diff --git a/scripts/gensalt b/scripts/gensalt
new file mode 100755
index 000000000000..846c0407cc43
--- /dev/null
+++ b/scripts/gensalt
@@ -0,0 +1,22 @@
+#!/bin/sh
+
+if [[ $1 = "" ]]; then
+	echo "#define BUILD_ID_SALT"
+	exit 0
+fi
+
+BUILD_ID_SALT=$1
+
+echo "SECTIONS {"
+echo ".comment (INFO) :"
+echo " {"
+
+_TAG=`echo $BUILD_ID_SALT | sed -e 's/\(.\)/\1 /g'`
+for c in $_TAG; do
+	_HEX=`echo -n $c | od -A n -t x1 | tr -d ' ' `
+	echo "BYTE(0x$_HEX);"
+done
+echo "BYTE(0x00);"
+
+echo " } "
+echo " } "
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 9045823c7be7..588946dde658 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -84,6 +84,7 @@ modpost_link()
 vmlinux_link()
 {
 	local lds="${objtree}/${KBUILD_LDS}"
+	local extra_lds="${objtree}/${EXTRA_LDS}"
 	local objects
 
 	if [ "${SRCARCH}" != "um" ]; then
@@ -96,7 +97,7 @@ vmlinux_link()
 			${1}"
 
 		${LD} ${LDFLAGS} ${LDFLAGS_vmlinux} -o ${2}	\
-			-T ${lds} ${objects}
+			-T ${lds} -T ${extra_lds} ${objects}
 	else
 		objects="-Wl,--whole-archive			\
 			built-in.a				\
-- 
2.17.0
