Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752654AbeCMJP3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 05:15:29 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:41799 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752485AbeCMJOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 05:14:01 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w2D9CIo5016505
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/11] kconfig: tests: test automatic submenu creation
Date: Tue, 13 Mar 2018 18:12:05 +0900
Message-Id: <1520932332-2449-5-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520932332-2449-1-git-send-email-yamada.masahiro@socionext.com>
References: <1520932332-2449-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a symbols has dependency on the preceding symbol, the menu entry
should become the submenu of the preceding one, and displayed with
deeper indentation.

This is done by restructuring the menu tree in menu_finalize().
It is a bit complicated computation, so let's add a test case.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Ulf Magnusson <ulfalizer@gmail.com>
---

Changes in v3: None
Changes in v2:
  - shorten directory name  'auto_submenu_creation' -> 'auto_submenu'
  - coding style clean-up based on PEP8, PEP257

 scripts/kconfig/tests/auto_submenu/Kconfig         | 50 ++++++++++++++++++++++
 scripts/kconfig/tests/auto_submenu/__init__.py     | 12 ++++++
 scripts/kconfig/tests/auto_submenu/expected_stdout | 10 +++++
 3 files changed, 72 insertions(+)
 create mode 100644 scripts/kconfig/tests/auto_submenu/Kconfig
 create mode 100644 scripts/kconfig/tests/auto_submenu/__init__.py
 create mode 100644 scripts/kconfig/tests/auto_submenu/expected_stdout

diff --git a/scripts/kconfig/tests/auto_submenu/Kconfig b/scripts/kconfig/tests/auto_submenu/Kconfig
new file mode 100644
index 0000000..c17bf2ca
--- /dev/null
+++ b/scripts/kconfig/tests/auto_submenu/Kconfig
@@ -0,0 +1,50 @@
+config A
+	bool "A"
+	default y
+
+config A0
+	bool "A0"
+	depends on A
+	default y
+	help
+	  This depends on A, so should be a submenu of A.
+
+config A0_0
+	bool "A1_0"
+	depends on A0
+	help
+	  Submenus are created recursively.
+	  This should be a submenu of A0.
+
+config A1
+	bool "A1"
+	depends on A
+	default y
+	help
+	  This should line up with A0.
+
+choice
+	prompt "choice"
+	depends on A1
+	help
+	  Choice should become a submenu as well.
+
+config A1_0
+	bool "A1_0"
+
+config A1_1
+	bool "A1_1"
+
+endchoice
+
+config B
+	bool "B"
+	help
+	  This is independent of A.
+
+config C
+	bool "C"
+	depends on A
+	help
+	  This depends on A, but not a consecutive item, so can/should not
+	  be a submenu.
diff --git a/scripts/kconfig/tests/auto_submenu/__init__.py b/scripts/kconfig/tests/auto_submenu/__init__.py
new file mode 100644
index 0000000..32e79b8
--- /dev/null
+++ b/scripts/kconfig/tests/auto_submenu/__init__.py
@@ -0,0 +1,12 @@
+"""
+Create submenu for symbols that depend on the preceding one.
+
+If a symbols has dependency on the preceding symbol, the menu entry
+should become the submenu of the preceding one, and displayed with
+deeper indentation.
+"""
+
+
+def test(conf):
+    assert conf.oldaskconfig() == 0
+    assert conf.stdout_contains('expected_stdout')
diff --git a/scripts/kconfig/tests/auto_submenu/expected_stdout b/scripts/kconfig/tests/auto_submenu/expected_stdout
new file mode 100644
index 0000000..bf5236f
--- /dev/null
+++ b/scripts/kconfig/tests/auto_submenu/expected_stdout
@@ -0,0 +1,10 @@
+A (A) [Y/n/?] (NEW) 
+  A0 (A0) [Y/n/?] (NEW) 
+    A1_0 (A0_0) [N/y/?] (NEW) 
+  A1 (A1) [Y/n/?] (NEW) 
+    choice
+    > 1. A1_0 (A1_0) (NEW)
+      2. A1_1 (A1_1) (NEW)
+    choice[1-2?]: 
+B (B) [N/y/?] (NEW) 
+C (C) [N/y/?] (NEW) 
-- 
2.7.4
