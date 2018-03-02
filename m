Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165024AbeCBEd4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 23:33:56 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:53154 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164424AbeCBEdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 23:33:47 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w224WURE022085
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
Subject: [PATCH v2 03/11] kconfig: unittest: add basic 'choice' tests
Date: Fri,  2 Mar 2018 13:31:53 +0900
Message-Id: <1519965121-12017-4-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519965121-12017-1-git-send-email-yamada.masahiro@socionext.com>
References: <1519965121-12017-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The calculation of 'choice' is a bit complicated part in Kconfig.

The behavior of 'y' choice is intuitive.  If choice values are tristate,
the choice can be 'm' where each value can be enabled independently.
Also, if a choice is marked as 'optional', the whole choice can be
invisible.

Test basic functionality of choice.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Ulf Magnusson <ulfalizer@gmail.com>
---

Changes in v2:
  - coding style clean-up based on PEP8, PEP257

 scripts/kconfig/tests/choice/Kconfig               | 54 ++++++++++++++++++++++
 scripts/kconfig/tests/choice/__init__.py           | 40 ++++++++++++++++
 .../kconfig/tests/choice/alldef_expected_config    |  5 ++
 .../kconfig/tests/choice/allmod_expected_config    |  9 ++++
 scripts/kconfig/tests/choice/allno_expected_config |  5 ++
 .../kconfig/tests/choice/allyes_expected_config    |  9 ++++
 .../kconfig/tests/choice/oldask0_expected_stdout   | 10 ++++
 scripts/kconfig/tests/choice/oldask1_config        |  2 +
 .../kconfig/tests/choice/oldask1_expected_stdout   | 15 ++++++
 9 files changed, 149 insertions(+)
 create mode 100644 scripts/kconfig/tests/choice/Kconfig
 create mode 100644 scripts/kconfig/tests/choice/__init__.py
 create mode 100644 scripts/kconfig/tests/choice/alldef_expected_config
 create mode 100644 scripts/kconfig/tests/choice/allmod_expected_config
 create mode 100644 scripts/kconfig/tests/choice/allno_expected_config
 create mode 100644 scripts/kconfig/tests/choice/allyes_expected_config
 create mode 100644 scripts/kconfig/tests/choice/oldask0_expected_stdout
 create mode 100644 scripts/kconfig/tests/choice/oldask1_config
 create mode 100644 scripts/kconfig/tests/choice/oldask1_expected_stdout

diff --git a/scripts/kconfig/tests/choice/Kconfig b/scripts/kconfig/tests/choice/Kconfig
new file mode 100644
index 0000000..cc60e9c
--- /dev/null
+++ b/scripts/kconfig/tests/choice/Kconfig
@@ -0,0 +1,54 @@
+config MODULES
+	bool "Enable loadable module support"
+	option modules
+	default y
+
+choice
+	prompt "boolean choice"
+	default BOOL_CHOICE1
+
+config BOOL_CHOICE0
+	bool "choice 0"
+
+config BOOL_CHOICE1
+	bool "choice 1"
+
+endchoice
+
+choice
+	prompt "optional boolean choice"
+	optional
+	default OPT_BOOL_CHOICE1
+
+config OPT_BOOL_CHOICE0
+	bool "choice 0"
+
+config OPT_BOOL_CHOICE1
+	bool "choice 1"
+
+endchoice
+
+choice
+	prompt "tristate choice"
+	default TRI_CHOICE1
+
+config TRI_CHOICE0
+	tristate "choice 0"
+
+config TRI_CHOICE1
+	tristate "choice 1"
+
+endchoice
+
+choice
+	prompt "optional tristate choice"
+	optional
+	default OPT_TRI_CHOICE1
+
+config OPT_TRI_CHOICE0
+	tristate "choice 0"
+
+config OPT_TRI_CHOICE1
+	tristate "choice 1"
+
+endchoice
diff --git a/scripts/kconfig/tests/choice/__init__.py b/scripts/kconfig/tests/choice/__init__.py
new file mode 100644
index 0000000..9edcc52
--- /dev/null
+++ b/scripts/kconfig/tests/choice/__init__.py
@@ -0,0 +1,40 @@
+"""
+Basic choice tests.
+
+The handling of 'choice' is a bit complicated part in Kconfig.
+
+The behavior of 'y' choice is intuitive.  If choice values are tristate,
+the choice can be 'm' where each value can be enabled independently.
+Also, if a choice is marked as 'optional', the whole choice can be
+invisible.
+"""
+
+
+def test_oldask0(conf):
+    assert conf.oldaskconfig() == 0
+    assert conf.stdout_contains('oldask0_expected_stdout')
+
+
+def test_oldask1(conf):
+    assert conf.oldaskconfig('oldask1_config') == 0
+    assert conf.stdout_contains('oldask1_expected_stdout')
+
+
+def test_allyes(conf):
+    assert conf.allyesconfig() == 0
+    assert conf.config_contains('allyes_expected_config')
+
+
+def test_allmod(conf):
+    assert conf.allmodconfig() == 0
+    assert conf.config_contains('allmod_expected_config')
+
+
+def test_allno(conf):
+    assert conf.allnoconfig() == 0
+    assert conf.config_contains('allno_expected_config')
+
+
+def test_alldef(conf):
+    assert conf.alldefconfig() == 0
+    assert conf.config_contains('alldef_expected_config')
diff --git a/scripts/kconfig/tests/choice/alldef_expected_config b/scripts/kconfig/tests/choice/alldef_expected_config
new file mode 100644
index 0000000..7a754bf
--- /dev/null
+++ b/scripts/kconfig/tests/choice/alldef_expected_config
@@ -0,0 +1,5 @@
+CONFIG_MODULES=y
+# CONFIG_BOOL_CHOICE0 is not set
+CONFIG_BOOL_CHOICE1=y
+# CONFIG_TRI_CHOICE0 is not set
+# CONFIG_TRI_CHOICE1 is not set
diff --git a/scripts/kconfig/tests/choice/allmod_expected_config b/scripts/kconfig/tests/choice/allmod_expected_config
new file mode 100644
index 0000000..f1f5dcd
--- /dev/null
+++ b/scripts/kconfig/tests/choice/allmod_expected_config
@@ -0,0 +1,9 @@
+CONFIG_MODULES=y
+# CONFIG_BOOL_CHOICE0 is not set
+CONFIG_BOOL_CHOICE1=y
+# CONFIG_OPT_BOOL_CHOICE0 is not set
+CONFIG_OPT_BOOL_CHOICE1=y
+CONFIG_TRI_CHOICE0=m
+CONFIG_TRI_CHOICE1=m
+CONFIG_OPT_TRI_CHOICE0=m
+CONFIG_OPT_TRI_CHOICE1=m
diff --git a/scripts/kconfig/tests/choice/allno_expected_config b/scripts/kconfig/tests/choice/allno_expected_config
new file mode 100644
index 0000000..b88ee7a
--- /dev/null
+++ b/scripts/kconfig/tests/choice/allno_expected_config
@@ -0,0 +1,5 @@
+# CONFIG_MODULES is not set
+# CONFIG_BOOL_CHOICE0 is not set
+CONFIG_BOOL_CHOICE1=y
+# CONFIG_TRI_CHOICE0 is not set
+CONFIG_TRI_CHOICE1=y
diff --git a/scripts/kconfig/tests/choice/allyes_expected_config b/scripts/kconfig/tests/choice/allyes_expected_config
new file mode 100644
index 0000000..e5a062a
--- /dev/null
+++ b/scripts/kconfig/tests/choice/allyes_expected_config
@@ -0,0 +1,9 @@
+CONFIG_MODULES=y
+# CONFIG_BOOL_CHOICE0 is not set
+CONFIG_BOOL_CHOICE1=y
+# CONFIG_OPT_BOOL_CHOICE0 is not set
+CONFIG_OPT_BOOL_CHOICE1=y
+# CONFIG_TRI_CHOICE0 is not set
+CONFIG_TRI_CHOICE1=y
+# CONFIG_OPT_TRI_CHOICE0 is not set
+CONFIG_OPT_TRI_CHOICE1=y
diff --git a/scripts/kconfig/tests/choice/oldask0_expected_stdout b/scripts/kconfig/tests/choice/oldask0_expected_stdout
new file mode 100644
index 0000000..b251bba
--- /dev/null
+++ b/scripts/kconfig/tests/choice/oldask0_expected_stdout
@@ -0,0 +1,10 @@
+Enable loadable module support (MODULES) [Y/n/?] (NEW) 
+boolean choice
+  1. choice 0 (BOOL_CHOICE0) (NEW)
+> 2. choice 1 (BOOL_CHOICE1) (NEW)
+choice[1-2?]: 
+optional boolean choice [N/y/?] (NEW) 
+tristate choice [M/y/?] (NEW) 
+  choice 0 (TRI_CHOICE0) [N/m/?] (NEW) 
+  choice 1 (TRI_CHOICE1) [N/m/?] (NEW) 
+optional tristate choice [N/m/y/?] (NEW) 
diff --git a/scripts/kconfig/tests/choice/oldask1_config b/scripts/kconfig/tests/choice/oldask1_config
new file mode 100644
index 0000000..b67bfe3
--- /dev/null
+++ b/scripts/kconfig/tests/choice/oldask1_config
@@ -0,0 +1,2 @@
+# CONFIG_MODULES is not set
+CONFIG_OPT_BOOL_CHOICE0=y
diff --git a/scripts/kconfig/tests/choice/oldask1_expected_stdout b/scripts/kconfig/tests/choice/oldask1_expected_stdout
new file mode 100644
index 0000000..c2125e9b
--- /dev/null
+++ b/scripts/kconfig/tests/choice/oldask1_expected_stdout
@@ -0,0 +1,15 @@
+Enable loadable module support (MODULES) [N/y/?] 
+boolean choice
+  1. choice 0 (BOOL_CHOICE0) (NEW)
+> 2. choice 1 (BOOL_CHOICE1) (NEW)
+choice[1-2?]: 
+optional boolean choice [Y/n/?] (NEW) 
+optional boolean choice
+> 1. choice 0 (OPT_BOOL_CHOICE0)
+  2. choice 1 (OPT_BOOL_CHOICE1) (NEW)
+choice[1-2?]: 
+tristate choice
+  1. choice 0 (TRI_CHOICE0) (NEW)
+> 2. choice 1 (TRI_CHOICE1) (NEW)
+choice[1-2?]: 
+optional tristate choice [N/y/?] 
-- 
2.7.4
