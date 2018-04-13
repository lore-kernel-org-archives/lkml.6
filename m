Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753668AbeDMFMn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 01:12:43 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:54529 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751076AbeDMFIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 01:08:16 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w3D56lgH029209
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>, Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>, x86@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 23/30] kconfig: add CC_IS_CLANG and CLANG_VERSION
Date: Fri, 13 Apr 2018 14:06:32 +0900
Message-Id: <1523595999-27433-24-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523595999-27433-1-git-send-email-yamada.masahiro@socionext.com>
References: <1523595999-27433-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will be useful to describe the clang version dependency.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---

Changes in v3: None
Changes in v2: None

 init/Kconfig             |  7 +++++++
 scripts/clang-version.sh | 18 ++++--------------
 2 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 145a534..c8f4ba3 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -16,6 +16,13 @@ config GCC_VERSION
 	default $(shell $(srctree)/scripts/gcc-version.sh -p $(CC) | sed 's/^0*//') if CC_IS_GCC
 	default 0
 
+config CC_IS_CLANG
+	def_bool $(success $(CC) --version | grep -q clang)
+
+config CLANG_VERSION
+	int
+	default $(shell $(srctree)/scripts/clang-version.sh $(CC))
+
 config CONSTRUCTORS
 	bool
 	depends on !UML
diff --git a/scripts/clang-version.sh b/scripts/clang-version.sh
index 9780efa..dbf0a31 100755
--- a/scripts/clang-version.sh
+++ b/scripts/clang-version.sh
@@ -10,24 +10,14 @@
 # clang-5.0.1 etc.
 #
 
-if [ "$1" = "-p" ] ; then
-	with_patchlevel=1;
-	shift;
-fi
-
 compiler="$*"
 
-if [ ${#compiler} -eq 0 ]; then
-	echo "Error: No compiler specified."
-	printf "Usage:\n\t$0 <clang-command>\n"
+if !( $compiler --version | grep -q clang) ; then
+	echo 0
 	exit 1
 fi
 
 MAJOR=$(echo __clang_major__ | $compiler -E -x c - | tail -n 1)
 MINOR=$(echo __clang_minor__ | $compiler -E -x c - | tail -n 1)
-if [ "x$with_patchlevel" != "x" ] ; then
-	PATCHLEVEL=$(echo __clang_patchlevel__ | $compiler -E -x c - | tail -n 1)
-	printf "%02d%02d%02d\\n" $MAJOR $MINOR $PATCHLEVEL
-else
-	printf "%02d%02d\\n" $MAJOR $MINOR
-fi
+PATCHLEVEL=$(echo __clang_patchlevel__ | $compiler -E -x c - | tail -n 1)
+printf "%d%02d%02d\\n" $MAJOR $MINOR $PATCHLEVEL
-- 
2.7.4
