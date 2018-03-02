Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165009AbeCBEdu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 23:33:50 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:53157 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164417AbeCBEdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 23:33:47 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w224WURI022085
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
Subject: [PATCH v2 07/11] kconfig: unittest: check visibility of tri-choice values in y choice
Date: Fri,  2 Mar 2018 13:31:57 +0900
Message-Id: <1519965121-12017-8-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519965121-12017-1-git-send-email-yamada.masahiro@socionext.com>
References: <1519965121-12017-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If tristate choice values depend on symbols set to 'm', they should be
hidden when the choice containing them is changed from 'm' to 'y'
(i.e. exclusive choice).

This issue was fixed by commit fa64e5f6a35e ("kconfig/symbol.c: handle
choice_values that depend on 'm' symbols").

Add a test case to avoid regression.

For the input in this unit test, there is a room for argument if
"# CONFIG_CHOICE1 is not set" should be written to the .config file.

After commit fa64e5f6a35e, this line was written to the .config file.

With commit cb67ab2cd2b8 ("kconfig: do not write choice values when
their dependency becomes n"), it is not written now.

In this test, "# CONFIG_CHOICE1 is not set" is don't care.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Ulf Magnusson <ulfalizer@gmail.com>
---

Changes in v2:
  - coding style clean-up based on PEP8, PEP257

 .../kconfig/tests/choice_value_with_m_dep/Kconfig    | 20 ++++++++++++++++++++
 .../tests/choice_value_with_m_dep/__init__.py        | 15 +++++++++++++++
 scripts/kconfig/tests/choice_value_with_m_dep/config |  2 ++
 .../tests/choice_value_with_m_dep/expected_config    |  3 +++
 .../tests/choice_value_with_m_dep/expected_stdout    |  4 ++++
 5 files changed, 44 insertions(+)
 create mode 100644 scripts/kconfig/tests/choice_value_with_m_dep/Kconfig
 create mode 100644 scripts/kconfig/tests/choice_value_with_m_dep/__init__.py
 create mode 100644 scripts/kconfig/tests/choice_value_with_m_dep/config
 create mode 100644 scripts/kconfig/tests/choice_value_with_m_dep/expected_config
 create mode 100644 scripts/kconfig/tests/choice_value_with_m_dep/expected_stdout

diff --git a/scripts/kconfig/tests/choice_value_with_m_dep/Kconfig b/scripts/kconfig/tests/choice_value_with_m_dep/Kconfig
new file mode 100644
index 0000000..dbc49e2
--- /dev/null
+++ b/scripts/kconfig/tests/choice_value_with_m_dep/Kconfig
@@ -0,0 +1,20 @@
+config MODULES
+	bool
+	default y
+	option modules
+
+config DEP
+	tristate
+	default m
+
+choice
+	prompt "Tristate Choice"
+
+config CHOICE0
+	tristate "Choice 0"
+
+config CHOICE1
+	tristate "Choice 1"
+	depends on DEP
+
+endchoice
diff --git a/scripts/kconfig/tests/choice_value_with_m_dep/__init__.py b/scripts/kconfig/tests/choice_value_with_m_dep/__init__.py
new file mode 100644
index 0000000..f8d728c
--- /dev/null
+++ b/scripts/kconfig/tests/choice_value_with_m_dep/__init__.py
@@ -0,0 +1,15 @@
+"""
+Hide tristate choice values with mod dependency in y choice.
+
+If tristate choice values depend on symbols set to 'm', they should be
+hidden when the choice containing them is changed from 'm' to 'y'
+(i.e. exclusive choice).
+
+Related Linux commit: fa64e5f6a35efd5e77d639125d973077ca506074
+"""
+
+
+def test(conf):
+    assert conf.oldaskconfig('config', 'y') == 0
+    assert conf.config_contains('expected_config')
+    assert conf.stdout_contains('expected_stdout')
diff --git a/scripts/kconfig/tests/choice_value_with_m_dep/config b/scripts/kconfig/tests/choice_value_with_m_dep/config
new file mode 100644
index 0000000..3a126b7
--- /dev/null
+++ b/scripts/kconfig/tests/choice_value_with_m_dep/config
@@ -0,0 +1,2 @@
+CONFIG_CHOICE0=m
+CONFIG_CHOICE1=m
diff --git a/scripts/kconfig/tests/choice_value_with_m_dep/expected_config b/scripts/kconfig/tests/choice_value_with_m_dep/expected_config
new file mode 100644
index 0000000..4d07b44
--- /dev/null
+++ b/scripts/kconfig/tests/choice_value_with_m_dep/expected_config
@@ -0,0 +1,3 @@
+CONFIG_MODULES=y
+CONFIG_DEP=m
+CONFIG_CHOICE0=y
diff --git a/scripts/kconfig/tests/choice_value_with_m_dep/expected_stdout b/scripts/kconfig/tests/choice_value_with_m_dep/expected_stdout
new file mode 100644
index 0000000..2b50ab6
--- /dev/null
+++ b/scripts/kconfig/tests/choice_value_with_m_dep/expected_stdout
@@ -0,0 +1,4 @@
+Tristate Choice [M/y/?] y
+Tristate Choice
+> 1. Choice 0 (CHOICE0)
+choice[1]: 1
-- 
2.7.4
