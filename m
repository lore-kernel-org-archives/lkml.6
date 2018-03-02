Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422680AbeCBEd5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 23:33:57 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:53155 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164986AbeCBEdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 23:33:47 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w224WURL022085
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/11] kconfig: unittest: test if recursive dependencies are detected
Date: Fri,  2 Mar 2018 13:32:00 +0900
Message-Id: <1519965121-12017-11-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519965121-12017-1-git-send-email-yamada.masahiro@socionext.com>
References: <1519965121-12017-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recursive dependency should be detected and warned.  Test this.

(This indirectly tests the line number increments.)

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Ulf Magnusson <ulfalizer@gmail.com>
---

Changes in v2:
  - Fix missing end quote
  - coding style clean-up based on PEP8, PEP257

 scripts/kconfig/tests/warn_recursive_dep/Kconfig   | 62 ++++++++++++++++++++++
 .../kconfig/tests/warn_recursive_dep/__init__.py   |  9 ++++
 .../tests/warn_recursive_dep/expected_stderr       | 30 +++++++++++
 3 files changed, 101 insertions(+)
 create mode 100644 scripts/kconfig/tests/warn_recursive_dep/Kconfig
 create mode 100644 scripts/kconfig/tests/warn_recursive_dep/__init__.py
 create mode 100644 scripts/kconfig/tests/warn_recursive_dep/expected_stderr

diff --git a/scripts/kconfig/tests/warn_recursive_dep/Kconfig b/scripts/kconfig/tests/warn_recursive_dep/Kconfig
new file mode 100644
index 0000000..a65bfcb
--- /dev/null
+++ b/scripts/kconfig/tests/warn_recursive_dep/Kconfig
@@ -0,0 +1,62 @@
+# depends on itself
+
+config A
+	bool "A"
+	depends on A
+
+# select itself
+
+config B
+	bool
+	select B
+
+# depends on each other
+
+config C1
+	bool "C1"
+	depends on C2
+
+config C2
+	bool "C2"
+	depends on C1
+
+# depends on and select
+
+config D1
+	bool "D1"
+	depends on D2
+	select D2
+
+config D2
+	bool
+
+# depends on and imply
+# This is not recursive dependency
+
+config E1
+	bool "E1"
+	depends on E2
+	imply E2
+
+config E2
+	bool "E2"
+
+# property
+
+config F1
+	bool "F1"
+	default F2
+
+config F2
+	bool "F2"
+	depends on F1
+
+# menu
+
+menu "menu depending on its content"
+	depends on G
+
+config G
+	bool "G"
+
+endmenu
diff --git a/scripts/kconfig/tests/warn_recursive_dep/__init__.py b/scripts/kconfig/tests/warn_recursive_dep/__init__.py
new file mode 100644
index 0000000..adb2195
--- /dev/null
+++ b/scripts/kconfig/tests/warn_recursive_dep/__init__.py
@@ -0,0 +1,9 @@
+"""
+Warn recursive inclusion.
+
+Recursive dependency should be warned.
+"""
+
+def test(conf):
+    assert conf.oldaskconfig() == 0
+    assert conf.stderr_contains('expected_stderr')
diff --git a/scripts/kconfig/tests/warn_recursive_dep/expected_stderr b/scripts/kconfig/tests/warn_recursive_dep/expected_stderr
new file mode 100644
index 0000000..3de807d
--- /dev/null
+++ b/scripts/kconfig/tests/warn_recursive_dep/expected_stderr
@@ -0,0 +1,30 @@
+Kconfig:9:error: recursive dependency detected!
+Kconfig:9:	symbol B is selected by B
+For a resolution refer to Documentation/kbuild/kconfig-language.txt
+subsection "Kconfig recursive dependency limitations"
+
+Kconfig:3:error: recursive dependency detected!
+Kconfig:3:	symbol A depends on A
+For a resolution refer to Documentation/kbuild/kconfig-language.txt
+subsection "Kconfig recursive dependency limitations"
+
+Kconfig:15:error: recursive dependency detected!
+Kconfig:15:	symbol C1 depends on C2
+Kconfig:19:	symbol C2 depends on C1
+For a resolution refer to Documentation/kbuild/kconfig-language.txt
+subsection "Kconfig recursive dependency limitations"
+
+Kconfig:30:error: recursive dependency detected!
+Kconfig:30:	symbol D2 is selected by D1
+Kconfig:25:	symbol D1 depends on D2
+For a resolution refer to Documentation/kbuild/kconfig-language.txt
+subsection "Kconfig recursive dependency limitations"
+
+Kconfig:59:error: recursive dependency detected!
+Kconfig:59:	symbol G depends on G
+For a resolution refer to Documentation/kbuild/kconfig-language.txt
+subsection "Kconfig recursive dependency limitations"
+
+Kconfig:50:error: recursive dependency detected!
+Kconfig:50:	symbol F2 depends on F1
+Kconfig:48:	symbol F1 default value contains F2
-- 
2.7.4
