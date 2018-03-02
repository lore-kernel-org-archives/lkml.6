Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422697AbeCBEf3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 23:35:29 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:53187 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164991AbeCBEdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 23:33:47 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w224WURH022085
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
Subject: [PATCH v2 06/11] kconfig: unittest: check unneeded "is not set" with unmet dependency
Date: Fri,  2 Mar 2018 13:31:56 +0900
Message-Id: <1519965121-12017-7-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519965121-12017-1-git-send-email-yamada.masahiro@socionext.com>
References: <1519965121-12017-1-git-send-email-yamada.masahiro@socionext.com>
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
