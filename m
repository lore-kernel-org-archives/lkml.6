Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751763AbeCUBqw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 21:46:52 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:38872 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751459AbeCUBqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 21:46:43 -0400
X-Google-Smtp-Source: AG47ELsmZ97QloDZg/T0F6BSr3LtZu9RuNGSKBuJAVM3aoq9VAzDhT2I0r+ESmo4YR9KAkL1WjPNVQ==
From: Laura Abbott <labbott@redhat.com>
To: Andy Lutomirski <luto@kernel.org>, mjw@fedoraproject.org,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Laura Abbott <labbott@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, linux-kernel@vger.kernel.org,
        Nick Clifton <nickc@redhat.com>, Cary Coutant <ccoutant@gmail.com>
Subject: [RFC PATCH 1/3] kbuild: Introduce build-salt generated header
Date: Tue, 20 Mar 2018 18:46:33 -0700
Message-Id: <20180321014635.29113-2-labbott@redhat.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180321014635.29113-1-labbott@redhat.com>
References: <20180321014635.29113-1-labbott@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The build id generated from --build-id can be generated in several different
ways, with the default being the sha1 on the output of the linked file. For
distributions, it can be useful to make sure this ID is unique, even if the
actual file contents don't change. The easiest way to do this is to insert
a comment section with some data.

Introduce a header which is generated from an environment varible, BUILD_TAG.
If this variable is set, an appropriate .comment section is generated. If
the environment variable isn't set, the define is simply empty and there
is no change to the build.

Suggested-by: Nick Clifton <nickc@redhat.com>
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 Makefile           |  9 ++++++++-
 scripts/gencomment | 19 +++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)
 create mode 100755 scripts/gencomment

diff --git a/Makefile b/Makefile
index d65e2e229017..de360625aec5 100644
--- a/Makefile
+++ b/Makefile
@@ -1087,7 +1087,7 @@ endif
 prepare2: prepare3 prepare-compiler-check outputmakefile asm-generic
 
 prepare1: prepare2 $(version_h) include/generated/utsrelease.h \
-                   include/config/auto.conf
+                   include/config/auto.conf include/generated/build-salt.h
 	$(cmd_crmodverdir)
 
 archprepare: archheaders archscripts prepare1 scripts_basic
@@ -1175,6 +1175,13 @@ $(version_h): $(srctree)/Makefile FORCE
 include/generated/utsrelease.h: include/config/kernel.release FORCE
 	$(call filechk,utsrelease.h)
 
+define filechk_build-salt.h
+	($(CONFIG_SHELL) $(srctree)/scripts/gencomment)
+endef
+
+include/generated/build-salt.h: $(srctree)/Makefile FORCE
+	$(call filechk,build-salt.h)
+
 PHONY += headerdep
 headerdep:
 	$(Q)find $(srctree)/include/ -name '*.h' | xargs --max-args 1 \
diff --git a/scripts/gencomment b/scripts/gencomment
new file mode 100755
index 000000000000..13b6e7739ef7
--- /dev/null
+++ b/scripts/gencomment
@@ -0,0 +1,19 @@
+#!/bin/sh
+
+if [ -z $BUILD_TAG ]; then
+	echo "#define ID_TAG"
+	exit 0
+fi
+
+echo "#define ID_TAG \\"
+echo ".comment (INFO) : \\"
+echo " { \\"
+
+_TAG=`echo $BUILD_TAG | sed -e 's/\(.\)/\1 /g'`
+for c in $_TAG; do
+	_HEX=`echo -n $c | od -A n -t x1 | tr -d ' ' `
+	echo "BYTE(0x$_HEX); \\"
+done
+echo "BYTE(0x00); \\"
+
+echo " } "
-- 
2.16.2
