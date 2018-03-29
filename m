Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751976AbeC2SBW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 14:01:22 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:32833 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751398AbeC2SBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 14:01:19 -0400
X-Google-Smtp-Source: AIpwx49BHJYJOvBFZF5OK9Ig9Q4K3PPbsQe22Wxu2sIagjycccMhos1nqDGDs2bvQeaS8nVGzJKA0g==
From: Laura Abbott <labbott@redhat.com>
To: Andy Lutomirski <luto@kernel.org>, mjw@fedoraproject.org,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Laura Abbott <labbott@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, linux-kernel@vger.kernel.org,
        Nick Clifton <nickc@redhat.com>, Cary Coutant <ccoutant@gmail.com>,
        linux-kbuild@vger.kernel.org
Subject: [RFCv2 PATCH 1/3] kbuild: Introduce build-salt generated header
Date: Thu, 29 Mar 2018 11:01:10 -0700
Message-Id: <20180329180112.11055-2-labbott@redhat.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180329180112.11055-1-labbott@redhat.com>
References: <20180329180112.11055-1-labbott@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The build id generated from --build-id can be generated in several different
ways, with the default being the sha1 on the output of the linked file. For
distributions, it can be useful to make sure this ID is unique, even if the
actual file contents don't change. The easiest way to do this is to insert
a comment section with some data.

Introduce a header which is generated from a config setting. If this config is
set, an appropriate .comment section is generated. If the config isn't set,
the define is simply empty and there is no change to the build.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v2: Switched to Kconfig vs. environment variable per suggestion of Nick
Clifton. Changed names to be consistent.
---
 Makefile        |  9 ++++++++-
 init/Kconfig    |  8 ++++++++
 scripts/gensalt | 21 +++++++++++++++++++++
 3 files changed, 37 insertions(+), 1 deletion(-)
 create mode 100755 scripts/gensalt

diff --git a/Makefile b/Makefile
index 7ba478ab8c82..b80c2d6d0854 100644
--- a/Makefile
+++ b/Makefile
@@ -1096,7 +1096,7 @@ endif
 prepare2: prepare3 prepare-compiler-check outputmakefile asm-generic
 
 prepare1: prepare2 $(version_h) include/generated/utsrelease.h \
-                   include/config/auto.conf
+                   include/config/auto.conf include/generated/build-salt.h
 	$(cmd_crmodverdir)
 
 archprepare: archheaders archscripts prepare1 scripts_basic
@@ -1184,6 +1184,13 @@ $(version_h): $(srctree)/Makefile FORCE
 include/generated/utsrelease.h: include/config/kernel.release FORCE
 	$(call filechk,utsrelease.h)
 
+define filechk_build-salt.h
+	($(CONFIG_SHELL) $(srctree)/scripts/gensalt $(CONFIG_BUILD_ID_SALT))
+endef
+
+include/generated/build-salt.h: $(srctree)/Makefile FORCE
+	$(call filechk,build-salt.h)
+
 PHONY += headerdep
 headerdep:
 	$(Q)find $(srctree)/include/ -name '*.h' | xargs --max-args 1 \
diff --git a/init/Kconfig b/init/Kconfig
index e37f4b2a6445..01e77aef3610 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1924,3 +1924,11 @@ source "kernel/Kconfig.locks"
 
 config ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
 	bool
+
+config BUILD_ID_SALT
+	string "Build ID Salt"
+	help
+	  The build ID is used to link binaries and their debug info. Setting
+          this option will use the value in the calculation of the build id.
+          This is mostly useful for distributions which want to ensure the
+          build is unique between builds. It's safe to leave this empty.
diff --git a/scripts/gensalt b/scripts/gensalt
new file mode 100755
index 000000000000..355a3e799550
--- /dev/null
+++ b/scripts/gensalt
@@ -0,0 +1,21 @@
+#!/bin/sh
+
+if [[ $1 = "" ]]; then
+	echo "#define BUILD_ID_SALT"
+	exit 0
+fi
+
+BUILD_ID_SALT=$1
+
+echo "#define BUILD_ID_SALT \\"
+echo ".comment (INFO) : \\"
+echo " { \\"
+
+_TAG=`echo $BUILD_ID_SALT | sed -e 's/\(.\)/\1 /g'`
+for c in $_TAG; do
+	_HEX=`echo -n $c | od -A n -t x1 | tr -d ' ' `
+	echo "BYTE(0x$_HEX); \\"
+done
+echo "BYTE(0x00); \\"
+
+echo " } "
-- 
2.16.2
