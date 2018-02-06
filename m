Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x2253jmD3+N5T98INZeD9SptxNq1cZiq+iDHdHWc1wdmqhFQURD8ixwWwNYurfSphHmQWLrN6
ARC-Seal: i=1; a=rsa-sha256; t=1517877368; cv=none;
        d=google.com; s=arc-20160816;
        b=vw4F8/HKP9DIXxS9WB7JLL5WaSTQw693ExH2ILOL3okWgVLv6p87h6h/xs7V/AL35F
         fg/zaGvrtvN8/QsFS0rK/giRu4E2HC0bzeAjbR06ZCZ80BANCGcmdBT5QjXYZXYPfnKU
         PCPRVH9XMncmbr22lsmn8sVZya5Zm8R5Arje+1fwyJzfxflOPHnhLbhbI1KXaqsZ5pTM
         cMAX5dIVehQrCgNzlTa47juZt1RbQbHtKoTdodaJ0NQyZ3PwbwuN3tSXaks2XdYiBch1
         uR/9BerrL3QNiulCrEaB8oAZuOG2IqQfQI1Fg0sOsSUjXYYwJ047J5qDdYdsSnccUipK
         myxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=ocbZK7hfg3zBpKhDY3y6OVphvGu4HXLex29szBW3HR0=;
        b=fTPX41cfW1I4dOgqtXiulbjc4KuTYEJf+FgTd5w+JvU+XqpJmsJ80KpNPzb6ltGwf+
         fSDutJyqYwmPQPqHd4HEiFl/BeNIU4eA7qhW97307y+aNpSkI/n+NXvfX2Hh5vs2KVCU
         BSMcy2t3CHoe4QJGZ9E2LGAf05lVa3YJG8isZU5ZuiEJMN7Sz13khPQCznScdph0rgcC
         I5VPA3xSRNjfflrHJDJy7m+ggGAfPTlwqkJza5Tm1elhaYjRZUC/QQYPGrxoOwxFpYqV
         078FYaa406KXkjiDuNZeUhBO9SOUHtv0UnXkCzeZ1Kw5sw8yy5UJDRA+QxxGTswLLto8
         yrQw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=mX8c9sVz;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=mX8c9sVz;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w160ZHAm011351
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Borislav Petkov <bp@suse.de>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Yaakov Selkowitz <yselkowi@redhat.com>,
        Marc Herbert <marc.herbert@intel.com>
Subject: [PATCH 07/14] kconfig: test: add framework for Kconfig unit-tests
Date: Tue,  6 Feb 2018 09:34:47 +0900
Message-Id: <1517877294-4826-8-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517877294-4826-1-git-send-email-yamada.masahiro@socionext.com>
References: <1517877294-4826-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591609779672286216?=
X-GMAIL-MSGID: =?utf-8?q?1591609779672286216?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I admit various parts in Kconfig are cryptic and need refactoring,
but at the same time, I fear regressions.

There are several subtle corner cases where it is difficult to notice
breakage.  It is time to add unit-tests.

Here is a simple framework based on pytest.  The conftest.py provides
a fixture useful to run commands such as 'oldaskconfig' etc. and
to compare the resulted .config, stdout, stderr with expectations.

How to add test cases?
----------------------

For each test case, you should create a subdirectory under
scripts/kconfig/tests/ (so test cases are seperated from each other).
Every test case directory must contain the following files:

 - __init__.py: describes test functions
 - Kconfig: the top level Kconfig file for this test

To do a useful job, test cases generally need additional data like
input .config and information about expected results.

How to run tests?
-----------------

You need python3 and pytest.  Then, run "make testconfig".
O= option is supported.  If V=1 is given, details logs during tests
are displayed.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/Makefile          |   8 ++
 scripts/kconfig/tests/conftest.py | 255 ++++++++++++++++++++++++++++++++++++++
 scripts/kconfig/tests/pytest.ini  |   6 +
 3 files changed, 269 insertions(+)
 create mode 100644 scripts/kconfig/tests/conftest.py
 create mode 100644 scripts/kconfig/tests/pytest.ini

diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index cb3ec53..c5d1d1a 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -135,6 +135,14 @@ PHONY += tinyconfig
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
index 0000000..f0f3237
--- /dev/null
+++ b/scripts/kconfig/tests/conftest.py
@@ -0,0 +1,255 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2018 Masahiro Yamada <yamada.masahiro@socionext.com>
+#
+
+import os
+import pytest
+import shutil
+import subprocess
+import tempfile
+
+conf_path = os.path.abspath(os.path.join('scripts', 'kconfig', 'conf'))
+
+class Conf:
+
+    def __init__(self, request):
+        """Create a new Conf object, which is a scripts/kconfig/conf
+        runner and result checker.
+
+        Arguments:
+        request - object to introspect the requesting test module
+        """
+
+        # the directory of the test being run
+        self.test_dir = os.path.dirname(str(request.fspath))
+
+    def __run_conf(self, mode, dot_config=None, out_file='.config',
+                   interactive=False, in_keys=None, extra_env={}):
+        """Run scripts/kconfig/conf
+
+        mode: input mode option (--oldaskconfig, --defconfig=<file> etc.)
+        dot_config: the .config file for input.
+        out_file: file name to contain the output config data.
+        interactive: flag to specify the interactive mode.
+        in_keys: key inputs for interactive modes.
+        extra_env: additional environment.
+        """
+
+        command = [conf_path, mode, 'Kconfig']
+
+        # Override 'srctree' environment to make the test as the top directory
+        extra_env['srctree'] = self.test_dir
+
+        # scripts/kconfig/conf is run in a temporary directory.
+        # This directory is automatically removed when done.
+        with tempfile.TemporaryDirectory() as temp_dir:
+
+            # if .config is given, copy it to the working directory
+            if dot_config:
+                shutil.copyfile(os.path.join(self.test_dir, dot_config),
+                                os.path.join(temp_dir, '.config'))
+
+            ps = subprocess.Popen(command,
+                                  stdin=subprocess.PIPE,
+                                  stdout=subprocess.PIPE,
+                                  stderr=subprocess.PIPE,
+                                  cwd=temp_dir,
+                                  env=dict(os.environ, **extra_env))
+
+            # If user key input is specified, feed it into stdin.
+            if in_keys:
+                ps.stdin.write(in_keys.encode('utf-8'))
+
+            while ps.poll() == None:
+                # For interactive modes such as 'make config', 'make oldconfig',
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
+            # 'make listnewconfig' does not produce .config in the first place.
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
+        print("command: {}\n".format(' '.join(command)))
+        print("retcode: {}\n".format(self.retcode))
+
+        if dot_config:
+            print("input .config:".format(dot_config))
+
+        print("stdout:")
+        print(self.stdout)
+        print("stderr:")
+        print(self.stderr)
+
+        if self.config is not None:
+            print("output of {}:".format(out_file))
+            print(self.config)
+
+        return self.retcode
+
+    def oldaskconfig(self, dot_config=None, in_keys=None):
+        """Run oldaskconfig (make config)
+
+        dot_config: the .config file for input (optional).
+        in_key: key inputs (optional).
+        """
+        return self.__run_conf('--oldaskconfig', dot_config=dot_config,
+                             interactive=True, in_keys=in_keys)
+
+    def oldconfig(self, dot_config=None, in_keys=None):
+        """Run oldconfig
+
+        dot_config: the .config file for input (optional).
+        in_key: key inputs (optional).
+        """
+        return self.__run_conf('--oldconfig', dot_config=dot_config,
+                             interactive=True, in_keys=in_keys)
+
+    def defconfig(self, defconfig):
+        """Run defconfig
+
+        defconfig: the defconfig file for input.
+        """
+        defconfig_path = os.path.join(self.test_dir, defconfig)
+        return self.__run_conf('--defconfig={}'.format(defconfig_path))
+
+    def olddefconfig(self, dot_config=None):
+        """Run olddefconfig
+
+        dot_config: the .config file for input (optional).
+        """
+        return self.__run_conf('--olddefconfig', dot_config=dot_config)
+
+    def __allconfig(self, foo, all_config):
+        """Run all*config
+
+        all_config: fragment config file for KCONFIG_ALLCONFIG (optional).
+        """
+        if all_config:
+            all_config_path = os.path.join(self.test_dir, all_config)
+            extra_env = {'KCONFIG_ALLCONFIG': all_config_path}
+        else:
+            extra_env = {}
+
+        return self.__run_conf('--all{}config'.format(foo), extra_env=extra_env)
+
+    def allyesconfig(self, all_config=None):
+        """Run allyesconfig
+        """
+        return self.__allconfig('yes', all_config)
+
+    def allmodconfig(self, all_config=None):
+        """Run allmodconfig
+        """
+        return self.__allconfig('mod', all_config)
+
+    def allnoconfig(self, all_config=None):
+        """Run allnoconfig
+        """
+        return self.__allconfig('no', all_config)
+
+    def alldefconfig(self, all_config=None):
+        """Run alldefconfig
+        """
+        return self.__allconfig('def', all_config)
+
+    def savedefconfig(self, dot_config):
+        """Run savedefconfig
+        """
+        return self.__run_conf('--savedefconfig', out_file='defconfig')
+
+    def listnewconfig(self, dot_config=None):
+        """Run listnewconfig
+        """
+        return self.__run_conf('--listnewconfig', dot_config=dot_config,
+                               out_file=None)
+
+    # checkers
+    def __read_and_compare(self, compare, expected):
+        """Compare the result with expectation.
+
+        Arguments:
+        compare: function to compare the result with expectation
+        expected: file that contains the expected data
+        """
+        with open(os.path.join(self.test_dir, expected)) as f:
+            expected_data = f.read()
+        print(expected_data)
+        return compare(self, expected_data)
+
+    def __contains(self, attr, expected):
+        print("{0} is expected to contain '{1}':".format(attr, expected))
+        return self.__read_and_compare(lambda s, e: getattr(s, attr).find(e) >= 0,
+                                       expected)
+
+    def __matches(self, attr, expected):
+        print("{0} is expected to match '{1}':".format(attr, expected))
+        return self.__read_and_compare(lambda s, e: getattr(s, attr) == e,
+                                       expected)
+
+    def config_contains(self, expected):
+        """Check if resulted configuration contains expected data.
+
+        Arguments:
+        expected: file that contains the expected data.
+        """
+        return self.__contains('config', expected)
+
+    def config_matches(self, expected):
+        """Check if resulted configuration exactly matches expected data.
+
+        Arguments:
+        expected: file that contains the expected data.
+        """
+        return self.__matches('config', expected)
+
+    def stdout_contains(self, expected):
+        """Check if resulted stdout contains expected data.
+
+        Arguments:
+        expected: file that contains the expected data.
+        """
+        return self.__contains('stdout', expected)
+
+    def stdout_matches(self, cmp_file):
+        """Check if resulted stdout exactly matches expected data.
+
+        Arguments:
+        expected: file that contains the expected data.
+        """
+        return self.__matches('stdout', expected)
+
+    def stderr_contains(self, expected):
+        """Check if resulted stderr contains expected data.
+
+        Arguments:
+        expected: file that contains the expected data.
+        """
+        return self.__contains('stderr', expected)
+
+    def stderr_matches(self, cmp_file):
+        """Check if resulted stderr exactly matches expected data.
+
+        Arguments:
+        expected: file that contains the expected data.
+        """
+        return self.__matches('stderr', expected)
+
+@pytest.fixture(scope="module")
+def conf(request):
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
