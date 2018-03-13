Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932526AbeCMJPa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 05:15:30 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:41800 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752483AbeCMJOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 05:14:01 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w2D9CIoA016505
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/11] kconfig: tests: test randconfig for choice in choice
Date: Tue, 13 Mar 2018 18:12:10 +0900
Message-Id: <1520932332-2449-10-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520932332-2449-1-git-send-email-yamada.masahiro@socionext.com>
References: <1520932332-2449-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 3b9a19e08960 ("kconfig: loop as long as we changed some symbols
in randconfig") fixed randconfig where a choice contains a sub-choice.
Prior to that commit, the sub-choice values were not set.

I am not sure whether this is an intended feature or just something
people discovered works, but it is used in the real world;
drivers/usb/gadget/legacy/Kconfig is source'd in a choice context,
then creates a sub-choice in it.

For the test case in this commit, there are 3 possible results.

Case 1:
  CONFIG_A=y
  # CONFIG_B is not set

Case 2:
  # CONFIG_A is not set
  CONFIG_B=y
  CONFIG_C=y
  # CONFIG_D is not set

Case 3:
  # CONFIG_A is not set
  CONFIG_B=y
  # CONFIG_C is not set
  CONFIG_D=y
  CONFIG_E=y

So, this test iterates several times, and checks if the result is
either of the three.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Ulf Magnusson <ulfalizer@gmail.com>
---

Changes in v3:
  - Fix typos

Changes in v2:
  - Newly added

 scripts/kconfig/tests/rand_nested_choice/Kconfig   | 33 ++++++++++++++++++++++
 .../kconfig/tests/rand_nested_choice/__init__.py   | 16 +++++++++++
 .../tests/rand_nested_choice/expected_stdout0      |  2 ++
 .../tests/rand_nested_choice/expected_stdout1      |  4 +++
 .../tests/rand_nested_choice/expected_stdout2      |  5 ++++
 5 files changed, 60 insertions(+)
 create mode 100644 scripts/kconfig/tests/rand_nested_choice/Kconfig
 create mode 100644 scripts/kconfig/tests/rand_nested_choice/__init__.py
 create mode 100644 scripts/kconfig/tests/rand_nested_choice/expected_stdout0
 create mode 100644 scripts/kconfig/tests/rand_nested_choice/expected_stdout1
 create mode 100644 scripts/kconfig/tests/rand_nested_choice/expected_stdout2

diff --git a/scripts/kconfig/tests/rand_nested_choice/Kconfig b/scripts/kconfig/tests/rand_nested_choice/Kconfig
new file mode 100644
index 0000000..c591d51
--- /dev/null
+++ b/scripts/kconfig/tests/rand_nested_choice/Kconfig
@@ -0,0 +1,33 @@
+choice
+	prompt "choice"
+
+config A
+	bool "A"
+
+config B
+	bool "B"
+
+if B
+choice
+	prompt "sub choice"
+
+config C
+	bool "C"
+
+config D
+	bool "D"
+
+if D
+choice
+	prompt "subsub choice"
+
+config E
+	bool "E"
+
+endchoice
+endif # D
+
+endchoice
+endif # B
+
+endchoice
diff --git a/scripts/kconfig/tests/rand_nested_choice/__init__.py b/scripts/kconfig/tests/rand_nested_choice/__init__.py
new file mode 100644
index 0000000..e729a4e
--- /dev/null
+++ b/scripts/kconfig/tests/rand_nested_choice/__init__.py
@@ -0,0 +1,16 @@
+"""
+Set random values recursively in nested choices.
+
+Kconfig can create a choice-in-choice structure by using 'if' statement.
+randconfig should correctly set random choice values.
+
+Related Linux commit: 3b9a19e08960e5cdad5253998637653e592a3c29
+"""
+
+
+def test(conf):
+    for i in range(20):
+        assert conf.randconfig() == 0
+        assert (conf.config_contains('expected_stdout0') or
+                conf.config_contains('expected_stdout1') or
+                conf.config_contains('expected_stdout2'))
diff --git a/scripts/kconfig/tests/rand_nested_choice/expected_stdout0 b/scripts/kconfig/tests/rand_nested_choice/expected_stdout0
new file mode 100644
index 0000000..05450f3
--- /dev/null
+++ b/scripts/kconfig/tests/rand_nested_choice/expected_stdout0
@@ -0,0 +1,2 @@
+CONFIG_A=y
+# CONFIG_B is not set
diff --git a/scripts/kconfig/tests/rand_nested_choice/expected_stdout1 b/scripts/kconfig/tests/rand_nested_choice/expected_stdout1
new file mode 100644
index 0000000..37ab295
--- /dev/null
+++ b/scripts/kconfig/tests/rand_nested_choice/expected_stdout1
@@ -0,0 +1,4 @@
+# CONFIG_A is not set
+CONFIG_B=y
+CONFIG_C=y
+# CONFIG_D is not set
diff --git a/scripts/kconfig/tests/rand_nested_choice/expected_stdout2 b/scripts/kconfig/tests/rand_nested_choice/expected_stdout2
new file mode 100644
index 0000000..849ff47
--- /dev/null
+++ b/scripts/kconfig/tests/rand_nested_choice/expected_stdout2
@@ -0,0 +1,5 @@
+# CONFIG_A is not set
+CONFIG_B=y
+# CONFIG_C is not set
+CONFIG_D=y
+CONFIG_E=y
-- 
2.7.4
