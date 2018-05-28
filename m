Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933606AbeE1J1K (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 05:27:10 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:21909 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932110AbeE1JYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 05:24:25 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w4S9MInh027506
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v5 26/31] gcov: remove CONFIG_GCOV_FORMAT_AUTODETECT
Date: Mon, 28 May 2018 18:22:03 +0900
Message-Id: <1527499328-13213-27-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527499328-13213-1-git-send-email-yamada.masahiro@socionext.com>
References: <1527499328-13213-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_GCOV_FORMAT_AUTODETECT compiles either gcc_3_4.c or gcc_4_7.c
according to your GCC version.

We can achieve the equivalent behavior by setting reasonable dependency
with the knowledge of the compiler version.

If GCC older than 4.7 is used, GCOV_FORMAT_3_4 is the default, but users
are still allowed to select GCOV_FORMAT_4_7 in case the newer format is
back-ported.

On the other hand, If GCC 4.7 or newer is used, there is no reason to
use GCOV_FORMAT_3_4, so it should be hidden.

If you downgrade the compiler to GCC 4.7 or older, oldconfig/syncconfig
will display a prompt for the choice because GCOV_FORMAT_3_4 becomes
visible as a new symbol.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 kernel/gcov/Kconfig  | 17 +++++------------
 kernel/gcov/Makefile |  2 --
 2 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/kernel/gcov/Kconfig b/kernel/gcov/Kconfig
index 1276aab..1e3823f 100644
--- a/kernel/gcov/Kconfig
+++ b/kernel/gcov/Kconfig
@@ -53,23 +53,16 @@ config GCOV_PROFILE_ALL
 choice
 	prompt "Specify GCOV format"
 	depends on GCOV_KERNEL
-	default GCOV_FORMAT_AUTODETECT
 	---help---
-	The gcov format is usually determined by the GCC version, but there are
+	The gcov format is usually determined by the GCC version, and the
+	default is chosen according to your GCC version. However, there are
 	exceptions where format changes are integrated in lower-version GCCs.
-	In such a case use this option to adjust the format used in the kernel
-	accordingly.
-
-	If unsure, choose "Autodetect".
-
-config GCOV_FORMAT_AUTODETECT
-	bool "Autodetect"
-	---help---
-	Select this option to use the format that corresponds to your GCC
-	version.
+	In such a case, change this option to adjust the format used in the
+	kernel accordingly.
 
 config GCOV_FORMAT_3_4
 	bool "GCC 3.4 format"
+	depends on CC_IS_GCC && GCC_VERSION < 40700
 	---help---
 	Select this option to use the format defined by GCC 3.4.
 
diff --git a/kernel/gcov/Makefile b/kernel/gcov/Makefile
index c6c50e5..ff06d64 100644
--- a/kernel/gcov/Makefile
+++ b/kernel/gcov/Makefile
@@ -4,5 +4,3 @@ ccflags-y := -DSRCTREE='"$(srctree)"' -DOBJTREE='"$(objtree)"'
 obj-y := base.o fs.o
 obj-$(CONFIG_GCOV_FORMAT_3_4) += gcc_3_4.o
 obj-$(CONFIG_GCOV_FORMAT_4_7) += gcc_4_7.o
-obj-$(CONFIG_GCOV_FORMAT_AUTODETECT) += $(call cc-ifversion, -lt, 0407, \
-							gcc_3_4.o, gcc_4_7.o)
-- 
2.7.4
