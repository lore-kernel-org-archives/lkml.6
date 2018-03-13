Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752535AbeCMJOC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 05:14:02 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:41651 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752395AbeCMJN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 05:13:56 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w2D9CIo1016505
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/11] Add Kconfig unit tests
Date: Tue, 13 Mar 2018 18:12:01 +0900
Message-Id: <1520932332-2449-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am applying various cleanups to Kconfig these days.

However, I fear regressions.  I have been thinking of unit-tests.

There are various cryptic parts in Kconfig and corner cases where
it is difficult to notice breakage.  If unit-tests cover those,
I will be able to apply changes more confidently.

This series introduces a unit-tests.  The framework is written based
on pytest.  Also, this is written in Python 3.  Python 2 will retire
in 2020.  So, I believe new python tools should be written in Python 3.

This is my Python 3 and pytest versions.

$ python3 --version
Python 3.5.2
$ python3 -m pytest --version
This is pytest version 3.4.1, imported from /home/masahiro/.local/lib/python3.5/site-packages/pytest.py

How to use?
-----------

Please make sure Python3 and pytest are installed on your system.

Then, run "make testconfig"

The result looks like as follows:

$ make testconfig
python3 -B -m pytest ./scripts/kconfig/tests \
-o cache_dir=/home/masahiro/workspace/bsp/linux-yamada/scripts/kconfig/tests/.cache \

================================= test session starts =================================
platform linux -- Python 3.5.2, pytest-3.4.1, py-1.5.2, pluggy-0.6.0 -- /usr/bin/python3
cachedir: scripts/kconfig/tests/.cache
rootdir: /home/masahiro/workspace/bsp/linux-yamada/scripts/kconfig/tests, inifile: pytest.ini
collected 14 items

scripts/kconfig/tests/auto_submenu/__init__.py::test PASSED                     [  7%]
scripts/kconfig/tests/choice/__init__.py::test_oldask0 PASSED                   [ 14%]
scripts/kconfig/tests/choice/__init__.py::test_oldask1 PASSED                   [ 21%]
scripts/kconfig/tests/choice/__init__.py::test_allyes PASSED                    [ 28%]
scripts/kconfig/tests/choice/__init__.py::test_allmod PASSED                    [ 35%]
scripts/kconfig/tests/choice/__init__.py::test_allno PASSED                     [ 42%]
scripts/kconfig/tests/choice/__init__.py::test_alldef PASSED                    [ 50%]
scripts/kconfig/tests/choice_value_with_m_dep/__init__.py::test PASSED          [ 57%]
scripts/kconfig/tests/err_recursive_inc/__init__.py::test PASSED                [ 64%]
scripts/kconfig/tests/inter_choice/__init__.py::test PASSED                     [ 71%]
scripts/kconfig/tests/new_choice_with_dep/__init__.py::test PASSED              [ 78%]
scripts/kconfig/tests/no_write_if_dep_unmet/__init__.py::test PASSED            [ 85%]
scripts/kconfig/tests/rand_nested_choice/__init__.py::test PASSED               [ 92%]
scripts/kconfig/tests/warn_recursive_dep/__init__.py::test PASSED               [100%]


Masahiro Yamada (11):
  kbuild: add PYTHON2 and PYTHON3 variables
  kconfig: tests: add framework for Kconfig unit testing
  kconfig: tests: add basic choice tests
  kconfig: tests: test automatic submenu creation
  kconfig: tests: test if new symbols in choice are asked
  kconfig: tests: check unneeded "is not set" with unmet dependency
  kconfig: tests: check visibility of tristate choice values in y choice
  kconfig: tests: test defconfig when two choices interact
  kconfig: tests: test randconfig for choice in choice
  kconfig: tests: test if recursive dependencies are detected
  kconfig: tests: test if recursive inclusion is detected

 Makefile                                           |   4 +-
 scripts/kconfig/Makefile                           |   8 +
 scripts/kconfig/tests/auto_submenu/Kconfig         |  50 ++++
 scripts/kconfig/tests/auto_submenu/__init__.py     |  12 +
 scripts/kconfig/tests/auto_submenu/expected_stdout |  10 +
 scripts/kconfig/tests/choice/Kconfig               |  54 ++++
 scripts/kconfig/tests/choice/__init__.py           |  40 +++
 .../kconfig/tests/choice/alldef_expected_config    |   5 +
 .../kconfig/tests/choice/allmod_expected_config    |   9 +
 scripts/kconfig/tests/choice/allno_expected_config |   5 +
 .../kconfig/tests/choice/allyes_expected_config    |   9 +
 .../kconfig/tests/choice/oldask0_expected_stdout   |  10 +
 scripts/kconfig/tests/choice/oldask1_config        |   2 +
 .../kconfig/tests/choice/oldask1_expected_stdout   |  15 ++
 .../kconfig/tests/choice_value_with_m_dep/Kconfig  |  19 ++
 .../tests/choice_value_with_m_dep/__init__.py      |  15 ++
 .../kconfig/tests/choice_value_with_m_dep/config   |   2 +
 .../tests/choice_value_with_m_dep/expected_config  |   3 +
 .../tests/choice_value_with_m_dep/expected_stdout  |   4 +
 scripts/kconfig/tests/conftest.py                  | 291 +++++++++++++++++++++
 scripts/kconfig/tests/err_recursive_inc/Kconfig    |   1 +
 scripts/kconfig/tests/err_recursive_inc/Kconfig2   |   1 +
 scripts/kconfig/tests/err_recursive_inc/Kconfig3   |   1 +
 .../kconfig/tests/err_recursive_inc/__init__.py    |  10 +
 .../tests/err_recursive_inc/expected_stderr        |   5 +
 scripts/kconfig/tests/inter_choice/Kconfig         |  23 ++
 scripts/kconfig/tests/inter_choice/__init__.py     |  14 +
 scripts/kconfig/tests/inter_choice/defconfig       |   1 +
 scripts/kconfig/tests/inter_choice/expected_config |   4 +
 scripts/kconfig/tests/new_choice_with_dep/Kconfig  |  37 +++
 .../kconfig/tests/new_choice_with_dep/__init__.py  |  14 +
 scripts/kconfig/tests/new_choice_with_dep/config   |   3 +
 .../tests/new_choice_with_dep/expected_stdout      |  10 +
 .../kconfig/tests/no_write_if_dep_unmet/Kconfig    |  14 +
 .../tests/no_write_if_dep_unmet/__init__.py        |  19 ++
 scripts/kconfig/tests/no_write_if_dep_unmet/config |   1 +
 .../tests/no_write_if_dep_unmet/expected_config    |   5 +
 scripts/kconfig/tests/pytest.ini                   |   7 +
 scripts/kconfig/tests/rand_nested_choice/Kconfig   |  33 +++
 .../kconfig/tests/rand_nested_choice/__init__.py   |  16 ++
 .../tests/rand_nested_choice/expected_stdout0      |   2 +
 .../tests/rand_nested_choice/expected_stdout1      |   4 +
 .../tests/rand_nested_choice/expected_stdout2      |   5 +
 scripts/kconfig/tests/warn_recursive_dep/Kconfig   |  62 +++++
 .../kconfig/tests/warn_recursive_dep/__init__.py   |   9 +
 .../tests/warn_recursive_dep/expected_stderr       |  30 +++
 46 files changed, 897 insertions(+), 1 deletion(-)
 create mode 100644 scripts/kconfig/tests/auto_submenu/Kconfig
 create mode 100644 scripts/kconfig/tests/auto_submenu/__init__.py
 create mode 100644 scripts/kconfig/tests/auto_submenu/expected_stdout
 create mode 100644 scripts/kconfig/tests/choice/Kconfig
 create mode 100644 scripts/kconfig/tests/choice/__init__.py
 create mode 100644 scripts/kconfig/tests/choice/alldef_expected_config
 create mode 100644 scripts/kconfig/tests/choice/allmod_expected_config
 create mode 100644 scripts/kconfig/tests/choice/allno_expected_config
 create mode 100644 scripts/kconfig/tests/choice/allyes_expected_config
 create mode 100644 scripts/kconfig/tests/choice/oldask0_expected_stdout
 create mode 100644 scripts/kconfig/tests/choice/oldask1_config
 create mode 100644 scripts/kconfig/tests/choice/oldask1_expected_stdout
 create mode 100644 scripts/kconfig/tests/choice_value_with_m_dep/Kconfig
 create mode 100644 scripts/kconfig/tests/choice_value_with_m_dep/__init__.py
 create mode 100644 scripts/kconfig/tests/choice_value_with_m_dep/config
 create mode 100644 scripts/kconfig/tests/choice_value_with_m_dep/expected_config
 create mode 100644 scripts/kconfig/tests/choice_value_with_m_dep/expected_stdout
 create mode 100644 scripts/kconfig/tests/conftest.py
 create mode 100644 scripts/kconfig/tests/err_recursive_inc/Kconfig
 create mode 100644 scripts/kconfig/tests/err_recursive_inc/Kconfig2
 create mode 100644 scripts/kconfig/tests/err_recursive_inc/Kconfig3
 create mode 100644 scripts/kconfig/tests/err_recursive_inc/__init__.py
 create mode 100644 scripts/kconfig/tests/err_recursive_inc/expected_stderr
 create mode 100644 scripts/kconfig/tests/inter_choice/Kconfig
 create mode 100644 scripts/kconfig/tests/inter_choice/__init__.py
 create mode 100644 scripts/kconfig/tests/inter_choice/defconfig
 create mode 100644 scripts/kconfig/tests/inter_choice/expected_config
 create mode 100644 scripts/kconfig/tests/new_choice_with_dep/Kconfig
 create mode 100644 scripts/kconfig/tests/new_choice_with_dep/__init__.py
 create mode 100644 scripts/kconfig/tests/new_choice_with_dep/config
 create mode 100644 scripts/kconfig/tests/new_choice_with_dep/expected_stdout
 create mode 100644 scripts/kconfig/tests/no_write_if_dep_unmet/Kconfig
 create mode 100644 scripts/kconfig/tests/no_write_if_dep_unmet/__init__.py
 create mode 100644 scripts/kconfig/tests/no_write_if_dep_unmet/config
 create mode 100644 scripts/kconfig/tests/no_write_if_dep_unmet/expected_config
 create mode 100644 scripts/kconfig/tests/pytest.ini
 create mode 100644 scripts/kconfig/tests/rand_nested_choice/Kconfig
 create mode 100644 scripts/kconfig/tests/rand_nested_choice/__init__.py
 create mode 100644 scripts/kconfig/tests/rand_nested_choice/expected_stdout0
 create mode 100644 scripts/kconfig/tests/rand_nested_choice/expected_stdout1
 create mode 100644 scripts/kconfig/tests/rand_nested_choice/expected_stdout2
 create mode 100644 scripts/kconfig/tests/warn_recursive_dep/Kconfig
 create mode 100644 scripts/kconfig/tests/warn_recursive_dep/__init__.py
 create mode 100644 scripts/kconfig/tests/warn_recursive_dep/expected_stderr

-- 
2.7.4
