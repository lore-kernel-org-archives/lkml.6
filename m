Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752672AbeCMJQi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 05:16:38 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:41802 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752484AbeCMJOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 05:14:01 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w2D9CIo9016505
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/11] kconfig: tests: test defconfig when two choices interact
Date: Tue, 13 Mar 2018 18:12:09 +0900
Message-Id: <1520932332-2449-9-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520932332-2449-1-git-send-email-yamada.masahiro@socionext.com>
References: <1520932332-2449-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit fbe98bb9ed3d ("kconfig: Fix defconfig when one choice menu
selects options that another choice menu depends on") fixed defconfig
when two choices interact (i.e. calculating the visibility of a choice
requires to calculate another choice).

The test code in that commit log was based on the real world example,
and complicated.  So, I shrunk it down to the following:

defconfig.choice:
---8<---
CONFIG_CHOICE_VAL0=y
---8<---

---8<---
config MODULES
        def_bool y
        option modules

choice
        prompt "Choice"

config CHOICE_VAL0
        tristate "Choice 0"

config CHOICE_VAL1
        tristate "Choice 1"

endchoice

choice
        prompt "Another choice"
        depends on CHOICE_VAL0

config DUMMY
        bool "dummy"

endchoice
---8<---

Prior to commit fbe98bb9ed3d,

  $ scripts/kconfig/conf --defconfig=defconfig.choice Kconfig.choice

resulted in:

  CONFIG_MODULES=y
  CONFIG_CHOICE_VAL0=m
  # CONFIG_CHOICE_VAL1 is not set
  CONFIG_DUMMY=y

where the expected result would be:

  CONFIG_MODULES=y
  CONFIG_CHOICE_VAL0=y
  # CONFIG_CHOICE_VAL1 is not set
  CONFIG_DUMMY=y

Roughly, this weird behavior happened like this:

Symbols are calculated a couple of times.  First, all symbols are
calculated in conf_read().  The first 'choice' is evaluated to 'y'
due to the SYMBOL_DEF_USER flag, but sym_calc_choice() clears it
unless all of its choice values are explicitly set by the user.

conf_set_all_new_symbols() clears all SYMBOL_VALID flags.  Then, only
choices are calculated.  Here, the SYMBOL_DEF_USER for the first choice
has been forgotten, so it is evaluated to 'm'.  set_all_choice_values()
sets SYMBOL_DEF_USER again to choice symbols.

When calculating the second choice, due to 'depends on CHOICE_VAL0',
it triggers the calculation of CHOICE_VAL0.  As a result, SYMBOL_VALID
is set for CHOICE_VAL0.

Symbols except choices get the final chance of re-calculation in
conf_write().  In a normal case, CHOICE_VAL0 would be re-calculated,
then the first choice would be indirectly re-calculated with the
SYMBOL_DEF_USER which has been recalled by set_all_choice_values(),
which would be evaluated to 'y'.  But, in this case, CHOICE_VAL0 has
already been marked as SYMBOL_VALID, so this re-calculation does not
happen.  Then, =m from the conf_set_all_new_symbols() phase is written
out to the .config file.

Add a unit test for this naive case.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Ulf Magnusson <ulfalizer@gmail.com>
---

Changes in v3:
  - Use def_bool for MODULES

Changes in v2:
  - Newly added

 scripts/kconfig/tests/inter_choice/Kconfig         | 23 ++++++++++++++++++++++
 scripts/kconfig/tests/inter_choice/__init__.py     | 14 +++++++++++++
 scripts/kconfig/tests/inter_choice/defconfig       |  1 +
 scripts/kconfig/tests/inter_choice/expected_config |  4 ++++
 4 files changed, 42 insertions(+)
 create mode 100644 scripts/kconfig/tests/inter_choice/Kconfig
 create mode 100644 scripts/kconfig/tests/inter_choice/__init__.py
 create mode 100644 scripts/kconfig/tests/inter_choice/defconfig
 create mode 100644 scripts/kconfig/tests/inter_choice/expected_config

diff --git a/scripts/kconfig/tests/inter_choice/Kconfig b/scripts/kconfig/tests/inter_choice/Kconfig
new file mode 100644
index 0000000..e44449f
--- /dev/null
+++ b/scripts/kconfig/tests/inter_choice/Kconfig
@@ -0,0 +1,23 @@
+config MODULES
+	def_bool y
+	option modules
+
+choice
+	prompt "Choice"
+
+config CHOICE_VAL0
+	tristate "Choice 0"
+
+config CHOIVE_VAL1
+	tristate "Choice 1"
+
+endchoice
+
+choice
+	prompt "Another choice"
+	depends on CHOICE_VAL0
+
+config DUMMY
+	bool "dummy"
+
+endchoice
diff --git a/scripts/kconfig/tests/inter_choice/__init__.py b/scripts/kconfig/tests/inter_choice/__init__.py
new file mode 100644
index 0000000..5c7fc36
--- /dev/null
+++ b/scripts/kconfig/tests/inter_choice/__init__.py
@@ -0,0 +1,14 @@
+"""
+Do not affect user-assigned choice value by another choice.
+
+Handling of state flags for choices is complecated.  In old days,
+the defconfig result of a choice could be affected by another choice
+if those choices interact by 'depends on', 'select', etc.
+
+Related Linux commit: fbe98bb9ed3dae23e320c6b113e35f129538d14a
+"""
+
+
+def test(conf):
+    assert conf.defconfig('defconfig') == 0
+    assert conf.config_contains('expected_config')
diff --git a/scripts/kconfig/tests/inter_choice/defconfig b/scripts/kconfig/tests/inter_choice/defconfig
new file mode 100644
index 0000000..162c414
--- /dev/null
+++ b/scripts/kconfig/tests/inter_choice/defconfig
@@ -0,0 +1 @@
+CONFIG_CHOICE_VAL0=y
diff --git a/scripts/kconfig/tests/inter_choice/expected_config b/scripts/kconfig/tests/inter_choice/expected_config
new file mode 100644
index 0000000..5dceefb
--- /dev/null
+++ b/scripts/kconfig/tests/inter_choice/expected_config
@@ -0,0 +1,4 @@
+CONFIG_MODULES=y
+CONFIG_CHOICE_VAL0=y
+# CONFIG_CHOIVE_VAL1 is not set
+CONFIG_DUMMY=y
-- 
2.7.4
