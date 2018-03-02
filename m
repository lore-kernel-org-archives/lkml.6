Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422726AbeCBEfd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 23:35:33 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:53192 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164992AbeCBEdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 23:33:47 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w224WURD022085
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
Subject: [PATCH v2 02/11] kconfig: unittest: add framework for Kconfig unit testing
Date: Fri,  2 Mar 2018 13:31:52 +0900
Message-Id: <1519965121-12017-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519965121-12017-1-git-send-email-yamada.masahiro@socionext.com>
References: <1519965121-12017-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many parts in Kconfig are so cryptic and need refactoring.  However,
its complexity prevents us from moving forward.  There are several
naive corner cases where it is difficult to notice breakage.  If
those are covered by unit tests, we will be able to touch the code
with more confidence.

Here is a simple test framework based on pytest.  The conftest.py
provides a fixture useful to run commands such as 'oldaskconfig' etc.
and to compare the resulted .config, stdout, stderr with expectations.

How to add test cases?
----------------------

For each test case, you should create a subdirectory under
scripts/kconfig/tests/ (so test cases are separated from each other).
Every test case directory should contain the following files:

 - __init__.py: describes test functions
 - Kconfig: the top level Kconfig file for the test

To do a useful job, test cases generally need additional data like
input .config and information about expected results.

How to run tests?
-----------------

You need Python3 and pytest.  Then, run "make testconfig".  O= option
is supported.  If V=1 is given, detailed logs captured during tests
are displayed.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Ulf Magnusson <ulfalizer@gmail.com>
---

Changes in v2:
  - Add 'randconfig' support
  - Add docstring
  - Fix various style errors detected by 'pep8' and 'pep257'

 scripts/kconfig/Makefile          |   8 ++
 scripts/kconfig/tests/conftest.py | 291 ++++++++++++++++++++++++++++++++++++++
 scripts/kconfig/tests/pytest.ini  |   6 +
 3 files changed, 305 insertions(+)
 create mode 100644 scripts/kconfig/tests/conftest.py
 create mode 100644 scripts/kconfig/tests/pytest.ini

diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index 753a6de4..085aab1 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -142,6 +142,14 @@ PHONY += tinyconfig
 tinyconfig:
 	$(Q)$(MAKE) -f $(srctree)/Makefile allnoconfig tiny.config
 
+# CHECK: -o cache_dir=<path> working?
+PHONY += testconfig
+testconfig: $(obj)/conf
+	$(PYTHON3) -B -m pytest $(srctree)/$(src)/tests \
+	-o cache_dir=$(abspath $(obj)/tests/.cache) \
+	$(if $(findstring 1,$(KBUILD_VERBOSE)),--capture=no)
+clean-dirs += tests/.cache
+
 # Help text used by make help
 help:
 	@echo  '  config	  - Update current config utilising a line-oriented program'
diff --git a/scripts/kconfig/tests/conftest.py b/scripts/kconfig/tests/conftest.py
new file mode 100644
index 0000000..0345ef6
--- /dev/null
+++ b/scripts/kconfig/tests/conftest.py
@@ -0,0 +1,291 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2018 Masahiro Yamada <yamada.masahiro@socionext.com>
+#
+
+"""
+Kconfig unit testing framework.
+
+This provides fixture functions commonly used from test files.
+"""
+
+import os
+import pytest
+import shutil
+import subprocess
+import tempfile
+
+CONF_PATH = os.path.abspath(os.path.join('scripts', 'kconfig', 'conf'))
+
+
+class Conf:
+    """Kconfig runner and result checker.
+
+    This class provides methods to run text-based interface of Kconfig
+    (scripts/kconfig/conf) and retrieve the resulted configuration,
+    stdout, and stderr.  It also provides methods to compare those
+    results with expectations.
+    """
+
+    def __init__(self, request):
+        """Create a new Conf instance.
+
+        request: object to introspect the requesting test module
+        """
+        # the directory of the test being run
+        self._test_dir = os.path.dirname(str(request.fspath))
+
+    # runners
+    def _run_conf(self, mode, dot_config=None, out_file='.config',
+                  interactive=False, in_keys=None, extra_env={}):
+        """Run text-based Kconfig executable and save the result.
+
+        mode: input mode option (--oldaskconfig, --defconfig=<file> etc.)
+        dot_config: .config file to use for configuration base
+        out_file: file name to contain the output config data
+        interactive: flag to specify the interactive mode
+        in_keys: key inputs for interactive modes
+        extra_env: additional environments
+        returncode: exit status of the Kconfig executable
+        """
+        command = [CONF_PATH, mode, 'Kconfig']
+
+        # Override 'srctree' environment to make the test as the top directory
+        extra_env['srctree'] = self._test_dir
+
+        # Run Kconfig in a temporary directory.
+        # This directory is automatically removed when done.
+        with tempfile.TemporaryDirectory() as temp_dir:
+
+            # if .config is given, copy it to the working directory
+            if dot_config:
+                shutil.copyfile(os.path.join(self._test_dir, dot_config),
+                                os.path.join(temp_dir, '.config'))
+
+            ps = subprocess.Popen(command,
+                                  stdin=subprocess.PIPE,
+                                  stdout=subprocess.PIPE,
+                                  stderr=subprocess.PIPE,
+                                  cwd=temp_dir,
+                                  env=dict(os.environ, **extra_env))
+
+            # If input key sequence is given, feed it to stdin.
+            if in_keys:
+                ps.stdin.write(in_keys.encode('utf-8'))
+
+            while ps.poll() is None:
+                # For interactive modes such as oldaskconfig, oldconfig,
+                # send 'Enter' key until the program finishes.
+                if interactive:
+                    ps.stdin.write(b'\n')
+
+            self.retcode = ps.returncode
+            self.stdout = ps.stdout.read().decode()
+            self.stderr = ps.stderr.read().decode()
+
+            # Retrieve the resulted config data only when .config is supposed
+            # to exist.  If the command fails, the .config does not exist.
+            # 'listnewconfig' does not produce .config in the first place.
+            if self.retcode == 0 and out_file:
+                with open(os.path.join(temp_dir, out_file)) as f:
+                    self.config = f.read()
+            else:
+                self.config = None
+
+        # Logging:
+        # Pytest captures the following information by default.  In failure
+        # of tests, the captured log will be displayed.  This will be useful to
+        # figure out what has happened.
+
+        print("[command]\n{}\n".format(' '.join(command)))
+
+        print("[retcode]\n{}\n".format(self.retcode))
+
+        print("[stdout]")
+        print(self.stdout)
+
+        print("[stderr]")
+        print(self.stderr)
+
+        if self.config is not None:
+            print("[output for '{}']".format(out_file))
+            print(self.config)
+
+        return self.retcode
+
+    def oldaskconfig(self, dot_config=None, in_keys=None):
+        """Run oldaskconfig.
+
+        dot_config: .config file to use for configuration base (optional)
+        in_key: key inputs (optional)
+        returncode: exit status of the Kconfig executable
+        """
+        return self._run_conf('--oldaskconfig', dot_config=dot_config,
+                              interactive=True, in_keys=in_keys)
+
+    def oldconfig(self, dot_config=None, in_keys=None):
+        """Run oldconfig.
+
+        dot_config: .config file to use for configuration base (optional)
+        in_key: key inputs (optional)
+        returncode: exit status of the Kconfig executable
+        """
+        return self._run_conf('--oldconfig', dot_config=dot_config,
+                              interactive=True, in_keys=in_keys)
+
+    def olddefconfig(self, dot_config=None):
+        """Run olddefconfig.
+
+        dot_config: .config file to use for configuration base (optional)
+        returncode: exit status of the Kconfig executable
+        """
+        return self._run_conf('--olddefconfig', dot_config=dot_config)
+
+    def defconfig(self, defconfig):
+        """Run defconfig.
+
+        defconfig: defconfig file for input
+        returncode: exit status of the Kconfig executable
+        """
+        defconfig_path = os.path.join(self._test_dir, defconfig)
+        return self._run_conf('--defconfig={}'.format(defconfig_path))
+
+    def _allconfig(self, mode, all_config):
+        if all_config:
+            all_config_path = os.path.join(self._test_dir, all_config)
+            extra_env = {'KCONFIG_ALLCONFIG': all_config_path}
+        else:
+            extra_env = {}
+
+        return self._run_conf('--{}config'.format(mode), extra_env=extra_env)
+
+    def allyesconfig(self, all_config=None):
+        """Run allyesconfig.
+
+        all_config: fragment config file for KCONFIG_ALLCONFIG (optional)
+        returncode: exit status of the Kconfig executable
+        """
+        return self._allconfig('allyes', all_config)
+
+    def allmodconfig(self, all_config=None):
+        """Run allmodconfig.
+
+        all_config: fragment config file for KCONFIG_ALLCONFIG (optional)
+        returncode: exit status of the Kconfig executable
+        """
+        return self._allconfig('allmod', all_config)
+
+    def allnoconfig(self, all_config=None):
+        """Run allnoconfig.
+
+        all_config: fragment config file for KCONFIG_ALLCONFIG (optional)
+        returncode: exit status of the Kconfig executable
+        """
+        return self._allconfig('allno', all_config)
+
+    def alldefconfig(self, all_config=None):
+        """Run alldefconfig.
+
+        all_config: fragment config file for KCONFIG_ALLCONFIG (optional)
+        returncode: exit status of the Kconfig executable
+        """
+        return self._allconfig('alldef', all_config)
+
+    def randconfig(self, all_config=None):
+        """Run randconfig.
+
+        all_config: fragment config file for KCONFIG_ALLCONFIG (optional)
+        returncode: exit status of the Kconfig executable
+        """
+        return self._allconfig('rand', all_config)
+
+    def savedefconfig(self, dot_config):
+        """Run savedefconfig.
+
+        dot_config: .config file for input
+        returncode: exit status of the Kconfig executable
+        """
+        return self._run_conf('--savedefconfig', out_file='defconfig')
+
+    def listnewconfig(self, dot_config=None):
+        """Run listnewconfig.
+
+        dot_config: .config file to use for configuration base (optional)
+        returncode: exit status of the Kconfig executable
+        """
+        return self._run_conf('--listnewconfig', dot_config=dot_config,
+                              out_file=None)
+
+    # checkers
+    def _read_and_compare(self, compare, expected):
+        """Compare the result with expectation.
+
+        compare: function to compare the result with expectation
+        expected: file that contains the expected data
+        """
+        with open(os.path.join(self._test_dir, expected)) as f:
+            expected_data = f.read()
+        return compare(self, expected_data)
+
+    def _contains(self, attr, expected):
+        return self._read_and_compare(
+                                    lambda s, e: getattr(s, attr).find(e) >= 0,
+                                    expected)
+
+    def _matches(self, attr, expected):
+        return self._read_and_compare(lambda s, e: getattr(s, attr) == e,
+                                      expected)
+
+    def config_contains(self, expected):
+        """Check if resulted configuration contains expected data.
+
+        expected: file that contains the expected data
+        returncode: True if result contains the expected data, False otherwise
+        """
+        return self._contains('config', expected)
+
+    def config_matches(self, expected):
+        """Check if resulted configuration exactly matches expected data.
+
+        expected: file that contains the expected data
+        returncode: True if result matches the expected data, False otherwise
+        """
+        return self._matches('config', expected)
+
+    def stdout_contains(self, expected):
+        """Check if resulted stdout contains expected data.
+
+        expected: file that contains the expected data
+        returncode: True if result contains the expected data, False otherwise
+        """
+        return self._contains('stdout', expected)
+
+    def stdout_matches(self, expected):
+        """Check if resulted stdout exactly matches expected data.
+
+        expected: file that contains the expected data
+        returncode: True if result matches the expected data, False otherwise
+        """
+        return self._matches('stdout', expected)
+
+    def stderr_contains(self, expected):
+        """Check if resulted stderr contains expected data.
+
+        expected: file that contains the expected data
+        returncode: True if result contains the expected data, False otherwise
+        """
+        return self._contains('stderr', expected)
+
+    def stderr_matches(self, expected):
+        """Check if resulted stderr exactly matches expected data.
+
+        expected: file that contains the expected data
+        returncode: True if result matches the expected data, False otherwise
+        """
+        return self._matches('stderr', expected)
+
+
+@pytest.fixture(scope="module")
+def conf(request):
+    """Create a Conf instance and provide it to test functions."""
+    return Conf(request)
diff --git a/scripts/kconfig/tests/pytest.ini b/scripts/kconfig/tests/pytest.ini
new file mode 100644
index 0000000..07b94e0
--- /dev/null
+++ b/scripts/kconfig/tests/pytest.ini
@@ -0,0 +1,6 @@
+[pytest]
+addopts = --verbose
+# Pytest requires that test files have unique names, because pytest imports
+# them as top-level modules.  It is silly to prefix or suffix a test file with
+# the directory name that contains it.  Use __init__.py for all test files.
+python_files = __init__.py
-- 
2.7.4
