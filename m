Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753612AbeDMFOD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 01:14:03 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:54460 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751035AbeDMFIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 01:08:15 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w3D56lgE029209
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>, Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>, x86@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 20/30] kconfig: add basic helper macros to scripts/Kconfig.include
Date: Fri, 13 Apr 2018 14:06:29 +0900
Message-Id: <1523595999-27433-21-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523595999-27433-1-git-send-email-yamada.masahiro@socionext.com>
References: <1523595999-27433-1-git-send-email-yamada.masahiro@socionext.com>
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

Changes in v3:
  - Move helpers to scripts/Kconfig.include

Changes in v2: None

 Kconfig                 |  2 ++
 MAINTAINERS             |  1 +
 scripts/Kconfig.include | 17 +++++++++++++++++
 3 files changed, 20 insertions(+)
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
index b9dab38..d962f4a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7624,6 +7624,7 @@ L:	linux-kbuild@vger.kernel.org
 S:	Maintained
 F:	Documentation/kbuild/kconfig*
 F:	scripts/kconfig/
+F:	scripts/Kconfig.include
 
 KDUMP
 M:	Dave Young <dyoung@redhat.com>
diff --git a/scripts/Kconfig.include b/scripts/Kconfig.include
new file mode 100644
index 0000000..cac7a81
--- /dev/null
+++ b/scripts/Kconfig.include
@@ -0,0 +1,17 @@
+# Kconfig helper macros
+
+# Convenient variables
+comma   := ,
+quote   := "
+squote  := '
+empty   :=
+space   := $(empty) $(empty)
+
+# y if the command exits with 0, n otherwise
+success = $(shell ($(1)) >/dev/null 2>&1 && echo y || echo n)
+
+# y if the given compiler flag is supported, n otherwise
+cc-option = $(success $(CC) -Werror $(1) -c -x c /dev/null -o /dev/null)
+
+# y if the given linker flag is supported, n otherwise
+ld-option = $(success $(LD) -v $(1))
-- 
2.7.4
