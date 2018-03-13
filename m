Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752594AbeCMJOQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 05:14:16 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:41835 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752511AbeCMJOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 05:14:01 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w2D9CIo7016505
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/11] kconfig: tests: check unneeded "is not set" with unmet dependency
Date: Tue, 13 Mar 2018 18:12:07 +0900
Message-Id: <1520932332-2449-7-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520932332-2449-1-git-send-email-yamada.masahiro@socionext.com>
References: <1520932332-2449-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit cb67ab2cd2b8 ("kconfig: do not write choice values when their
dependency becomes n") fixed a problem where "# CONFIG_... is not set"
for choice values are wrongly written into the .config file when they
are once visible, then become invisible later.

Add a test for this naive case.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Ulf Magnusson <ulfalizer@gmail.com>
---

Changes in v3: None
Changes in v2:
  - coding style clean-up based on PEP8, PEP257

 scripts/kconfig/tests/no_write_if_dep_unmet/Kconfig   | 14 ++++++++++++++
 .../kconfig/tests/no_write_if_dep_unmet/__init__.py   | 19 +++++++++++++++++++
 scripts/kconfig/tests/no_write_if_dep_unmet/config    |  1 +
 .../tests/no_write_if_dep_unmet/expected_config       |  5 +++++
 4 files changed, 39 insertions(+)
 create mode 100644 scripts/kconfig/tests/no_write_if_dep_unmet/Kconfig
 create mode 100644 scripts/kconfig/tests/no_write_if_dep_unmet/__init__.py
 create mode 100644 scripts/kconfig/tests/no_write_if_dep_unmet/config
 create mode 100644 scripts/kconfig/tests/no_write_if_dep_unmet/expected_config

diff --git a/scripts/kconfig/tests/no_write_if_dep_unmet/Kconfig b/scripts/kconfig/tests/no_write_if_dep_unmet/Kconfig
new file mode 100644
index 0000000..c00b8fe
--- /dev/null
+++ b/scripts/kconfig/tests/no_write_if_dep_unmet/Kconfig
@@ -0,0 +1,14 @@
+config A
+	bool "A"
+
+choice
+	prompt "Choice ?"
+	depends on A
+
+config CHOICE_B
+	bool "Choice B"
+
+config CHOICE_C
+	bool "Choice C"
+
+endchoice
diff --git a/scripts/kconfig/tests/no_write_if_dep_unmet/__init__.py b/scripts/kconfig/tests/no_write_if_dep_unmet/__init__.py
new file mode 100644
index 0000000..207261b
--- /dev/null
+++ b/scripts/kconfig/tests/no_write_if_dep_unmet/__init__.py
@@ -0,0 +1,19 @@
+"""
+Do not write choice values to .config if the dependency is unmet.
+
+"# CONFIG_... is not set" should not be written into the .config file
+for symbols with unmet dependency.
+
+This was not working correctly for choice values because choice needs
+a bit different symbol computation.
+
+This checks that no unneeded "# COFIG_... is not set" is contained in
+the .config file.
+
+Related Linux commit: cb67ab2cd2b8abd9650292c986c79901e3073a59
+"""
+
+
+def test(conf):
+    assert conf.oldaskconfig('config', 'n') == 0
+    assert conf.config_matches('expected_config')
diff --git a/scripts/kconfig/tests/no_write_if_dep_unmet/config b/scripts/kconfig/tests/no_write_if_dep_unmet/config
new file mode 100644
index 0000000..abd280e
--- /dev/null
+++ b/scripts/kconfig/tests/no_write_if_dep_unmet/config
@@ -0,0 +1 @@
+CONFIG_A=y
diff --git a/scripts/kconfig/tests/no_write_if_dep_unmet/expected_config b/scripts/kconfig/tests/no_write_if_dep_unmet/expected_config
new file mode 100644
index 0000000..0d15e41
--- /dev/null
+++ b/scripts/kconfig/tests/no_write_if_dep_unmet/expected_config
@@ -0,0 +1,5 @@
+#
+# Automatically generated file; DO NOT EDIT.
+# Linux Kernel Configuration
+#
+# CONFIG_A is not set
-- 
2.7.4
