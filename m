Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752483AbeEQGUf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 02:20:35 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:26311 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752380AbeEQGT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 02:19:59 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w4H6HbUK002841
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>, Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>, x86@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v4 22/31] kconfig: add basic helper macros to scripts/Kconfig.include
Date: Thu, 17 May 2018 15:17:01 +0900
Message-Id: <1526537830-22606-23-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526537830-22606-1-git-send-email-yamada.masahiro@socionext.com>
References: <1526537830-22606-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kconfig got text processing tools like we see in Make.  Add Kconfig
helper macros to scripts/Kconfig.include like we collect Makefile
macros in scripts/Kbuild.include.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Ulf Magnusson <ulfalizer@gmail.com>
---

Changes in v4:
  - source scripts/Kconfig.include
    from arch/x86/um/Kconfig since UML is special
  - Use { $(1); } for 'success' macro for better performance
  - Use -E instead of -c for 'cc-option' macro for better performance
  - Add 'if-success' macro

Changes in v3:
  - Move helpers to scripts/Kconfig.include

Changes in v2: None

 Kconfig                 |  2 ++
 MAINTAINERS             |  1 +
 arch/x86/um/Kconfig     |  2 ++
 scripts/Kconfig.include | 24 ++++++++++++++++++++++++
 4 files changed, 29 insertions(+)
 create mode 100644 scripts/Kconfig.include

diff --git a/Kconfig b/Kconfig
index 5b55d87..a90d9f9 100644
--- a/Kconfig
+++ b/Kconfig
@@ -7,4 +7,6 @@ mainmenu "Linux/$(ARCH) $(KERNELVERSION) Kernel Configuration"
 
 comment "Compiler: $(CC_VERSION_TEXT)"
 
+source "scripts/Kconfig.include"
+
 source "arch/$(SRCARCH)/Kconfig"
diff --git a/MAINTAINERS b/MAINTAINERS
index b7d7ae61..1667cee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7634,6 +7634,7 @@ L:	linux-kbuild@vger.kernel.org
 S:	Maintained
 F:	Documentation/kbuild/kconfig*
 F:	scripts/kconfig/
+F:	scripts/Kconfig.include
 
 KDUMP
 M:	Dave Young <dyoung@redhat.com>
diff --git a/arch/x86/um/Kconfig b/arch/x86/um/Kconfig
index a992f8e..9d529f2 100644
--- a/arch/x86/um/Kconfig
+++ b/arch/x86/um/Kconfig
@@ -3,6 +3,8 @@ mainmenu "User Mode Linux/$(SUBARCH) $(KERNELVERSION) Kernel Configuration"
 
 comment "Compiler: $(CC_VERSION_TEXT)"
 
+source "scripts/Kconfig.include"
+
 source "arch/um/Kconfig.common"
 
 menu "UML-specific options"
diff --git a/scripts/Kconfig.include b/scripts/Kconfig.include
new file mode 100644
index 0000000..b1502f4
--- /dev/null
+++ b/scripts/Kconfig.include
@@ -0,0 +1,24 @@
+# Kconfig helper macros
+
+# Convenient variables
+comma   := ,
+quote   := "
+squote  := '
+empty   :=
+space   := $(empty) $(empty)
+
+# $(if-success,<command>,<then-part>,<else-part>)
+# <then-part> if <command> exits with 0, <else-part> otherwise.
+if-success = $(shell, { $(1); } >/dev/null 2>&1 && echo "$(2)" || echo "$(3)")
+
+# $(success,<command>)
+# y if <command> exits with 0, n otherwise
+success = $(if-success, $(1),y,n)
+
+# $(cc-option,<flag>)
+# y if the compiler supports <flag>, n otherwise
+cc-option = $(success, $(CC) -Werror $(1) -E -x c /dev/null -o /dev/null)
+
+# $(ld-option,<flag>)
+# y if the linker supports <flag>, n otherwise
+ld-option = $(success, $(LD) -v $(1))
-- 
2.7.4
