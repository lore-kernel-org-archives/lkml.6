Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752565AbeCMJOO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 05:14:14 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:41840 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752302AbeCMJOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 05:14:01 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w2D9CIoC016505
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/11] kconfig: tests: test if recursive inclusion is detected
Date: Tue, 13 Mar 2018 18:12:12 +0900
Message-Id: <1520932332-2449-12-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520932332-2449-1-git-send-email-yamada.masahiro@socionext.com>
References: <1520932332-2449-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If recursive inclusion is detected, it should fail with error
messages.  Test this.

This also tests the line numbers in the error message, fixed by
commit 5ae6fcc4bb82 ("kconfig: fix line number in recursive inclusion
error message").

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Ulf Magnusson <ulfalizer@gmail.com>
---

Changes in v3:
  - Replace the test code with the one used by commit

Changes in v2:
  - coding style clean-up based on PEP8, PEP257

 scripts/kconfig/tests/err_recursive_inc/Kconfig         |  1 +
 scripts/kconfig/tests/err_recursive_inc/Kconfig2        |  1 +
 scripts/kconfig/tests/err_recursive_inc/Kconfig3        |  1 +
 scripts/kconfig/tests/err_recursive_inc/__init__.py     | 10 ++++++++++
 scripts/kconfig/tests/err_recursive_inc/expected_stderr |  5 +++++
 5 files changed, 18 insertions(+)
 create mode 100644 scripts/kconfig/tests/err_recursive_inc/Kconfig
 create mode 100644 scripts/kconfig/tests/err_recursive_inc/Kconfig2
 create mode 100644 scripts/kconfig/tests/err_recursive_inc/Kconfig3
 create mode 100644 scripts/kconfig/tests/err_recursive_inc/__init__.py
 create mode 100644 scripts/kconfig/tests/err_recursive_inc/expected_stderr

diff --git a/scripts/kconfig/tests/err_recursive_inc/Kconfig b/scripts/kconfig/tests/err_recursive_inc/Kconfig
new file mode 100644
index 0000000..f21c890
--- /dev/null
+++ b/scripts/kconfig/tests/err_recursive_inc/Kconfig
@@ -0,0 +1 @@
+source "Kconfig2"
diff --git a/scripts/kconfig/tests/err_recursive_inc/Kconfig2 b/scripts/kconfig/tests/err_recursive_inc/Kconfig2
new file mode 100644
index 0000000..b341502
--- /dev/null
+++ b/scripts/kconfig/tests/err_recursive_inc/Kconfig2
@@ -0,0 +1 @@
+source "Kconfig3"
diff --git a/scripts/kconfig/tests/err_recursive_inc/Kconfig3 b/scripts/kconfig/tests/err_recursive_inc/Kconfig3
new file mode 100644
index 0000000..1fab1c1
--- /dev/null
+++ b/scripts/kconfig/tests/err_recursive_inc/Kconfig3
@@ -0,0 +1 @@
+source "Kconfig"
diff --git a/scripts/kconfig/tests/err_recursive_inc/__init__.py b/scripts/kconfig/tests/err_recursive_inc/__init__.py
new file mode 100644
index 0000000..0e4c839
--- /dev/null
+++ b/scripts/kconfig/tests/err_recursive_inc/__init__.py
@@ -0,0 +1,10 @@
+"""
+Detect recursive inclusion error.
+
+If recursive inclusion is detected, it should fail with error messages.
+"""
+
+
+def test(conf):
+    assert conf.oldaskconfig() != 0
+    assert conf.stderr_contains('expected_stderr')
diff --git a/scripts/kconfig/tests/err_recursive_inc/expected_stderr b/scripts/kconfig/tests/err_recursive_inc/expected_stderr
new file mode 100644
index 0000000..84cc0a1
--- /dev/null
+++ b/scripts/kconfig/tests/err_recursive_inc/expected_stderr
@@ -0,0 +1,5 @@
+Kconfig:1: recursive inclusion detected. Inclusion path:
+  current file : 'Kconfig'
+  included from: 'Kconfig3:1'
+  included from: 'Kconfig2:1'
+  included from: 'Kconfig:1'
-- 
2.7.4
