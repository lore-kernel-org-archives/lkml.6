Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752434AbeCMJN6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 05:13:58 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:41662 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752074AbeCMJN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 05:13:56 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w2D9CIo6016505
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 05/11] kconfig: tests: test if new symbols in choice are asked
Date: Tue, 13 Mar 2018 18:12:06 +0900
Message-Id: <1520932332-2449-6-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520932332-2449-1-git-send-email-yamada.masahiro@socionext.com>
References: <1520932332-2449-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If new choice values are added with new dependency, and they become
visible during user configuration, oldconfig should recognize them
as (NEW), and ask the user for choice.

This issue was fixed by commit 5d09598d488f ("kconfig: fix new choices
being skipped upon config update").

This is a subtle corner case.  Add a test case to avoid breakage.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Ulf Magnusson <ulfalizer@gmail.com>
---

Changes in v3: None
Changes in v2:
  - coding style clean-up based on PEP8, PEP257

 scripts/kconfig/tests/new_choice_with_dep/Kconfig  | 37 ++++++++++++++++++++++
 .../kconfig/tests/new_choice_with_dep/__init__.py  | 14 ++++++++
 scripts/kconfig/tests/new_choice_with_dep/config   |  3 ++
 .../tests/new_choice_with_dep/expected_stdout      | 10 ++++++
 4 files changed, 64 insertions(+)
 create mode 100644 scripts/kconfig/tests/new_choice_with_dep/Kconfig
 create mode 100644 scripts/kconfig/tests/new_choice_with_dep/__init__.py
 create mode 100644 scripts/kconfig/tests/new_choice_with_dep/config
 create mode 100644 scripts/kconfig/tests/new_choice_with_dep/expected_stdout

diff --git a/scripts/kconfig/tests/new_choice_with_dep/Kconfig b/scripts/kconfig/tests/new_choice_with_dep/Kconfig
new file mode 100644
index 0000000..53ef1b8
--- /dev/null
+++ b/scripts/kconfig/tests/new_choice_with_dep/Kconfig
@@ -0,0 +1,37 @@
+config A
+	bool "A"
+	help
+	  This is a new symbol.
+
+choice
+	prompt "Choice ?"
+	depends on A
+	help
+	  "depends on A" has been newly added.
+
+config CHOICE_B
+	bool "Choice B"
+
+config CHOICE_C
+	bool "Choice C"
+	help
+	  This is a new symbol, so should be asked.
+
+endchoice
+
+choice
+	prompt "Choice2 ?"
+
+config CHOICE_D
+	bool "Choice D"
+
+config CHOICE_E
+	bool "Choice E"
+
+config CHOICE_F
+	bool "Choice F"
+	depends on A
+	help
+	  This is a new symbol, so should be asked.
+
+endchoice
diff --git a/scripts/kconfig/tests/new_choice_with_dep/__init__.py b/scripts/kconfig/tests/new_choice_with_dep/__init__.py
new file mode 100644
index 0000000..f0e0ead
--- /dev/null
+++ b/scripts/kconfig/tests/new_choice_with_dep/__init__.py
@@ -0,0 +1,14 @@
+"""
+Ask new choice values when they become visible.
+
+If new choice values are added with new dependency, and they become
+visible during user configuration, oldconfig should recognize them
+as (NEW), and ask the user for choice.
+
+Related Linux commit: 5d09598d488f081e3be23f885ed65cbbe2d073b5
+"""
+
+
+def test(conf):
+    assert conf.oldconfig('config', 'y') == 0
+    assert conf.stdout_contains('expected_stdout')
diff --git a/scripts/kconfig/tests/new_choice_with_dep/config b/scripts/kconfig/tests/new_choice_with_dep/config
new file mode 100644
index 0000000..47ef95d
--- /dev/null
+++ b/scripts/kconfig/tests/new_choice_with_dep/config
@@ -0,0 +1,3 @@
+CONFIG_CHOICE_B=y
+# CONFIG_CHOICE_D is not set
+CONFIG_CHOICE_E=y
diff --git a/scripts/kconfig/tests/new_choice_with_dep/expected_stdout b/scripts/kconfig/tests/new_choice_with_dep/expected_stdout
new file mode 100644
index 0000000..74dc0bc
--- /dev/null
+++ b/scripts/kconfig/tests/new_choice_with_dep/expected_stdout
@@ -0,0 +1,10 @@
+A (A) [N/y/?] (NEW) y
+  Choice ?
+  > 1. Choice B (CHOICE_B)
+    2. Choice C (CHOICE_C) (NEW)
+  choice[1-2?]: 
+Choice2 ?
+  1. Choice D (CHOICE_D)
+> 2. Choice E (CHOICE_E)
+  3. Choice F (CHOICE_F) (NEW)
+choice[1-3?]: 
-- 
2.7.4
