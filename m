Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753382AbeC1Ttx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 15:49:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50200 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753290AbeC1Ttv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 15:49:51 -0400
From: Joe Lawrence <joe.lawrence@redhat.com>
To: live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Add livepatch kselftests
Date: Wed, 28 Mar 2018 15:49:47 -0400
Message-Id: <1522266588-11806-1-git-send-email-joe.lawrence@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch was motivated by the increasing corner cases in the livepatch
code.  These tests don't cover anywhere near all of them, but were
mostly already written up as demonstrations / documentation of the
livepatch callback functionality.  Converting them into a test rig
didn't take long.

So the testing methodology is a little hokey as it relies on dmesg order
and filtering.  That said, it's already been used to verify livepatch
callback for "livepatch: Atomic replace feature" patchset.  Any
suggestions for better testing would be welcome.

I didn't get to the shadow variable testing script yet.  I figured that
I'd share the current state before I got too far along in writing tests.
Suggestions for additional tests and test categories welcome as well.

To try out the tests, configure with:
CONFIG_TEST_LIVEPATCH=m
  
Build kernel, modules, install, etc. then reboot and kick off:
% make -C tools/testing/selftests TARGETS=livepatch run_tests

The tests expect to on top of v10+ of the "livepatch: Atomic replace
feature" series and take ~2.5 minutes to complete.

rfc changes:
- SPDX-License-Identifiers
- Moved livepatch test modules into lib/livepatch
- Renamed livepatch.sh (filename suffix)
- Reduced between-test delay time
- Split off common functions.sh file
- Split into separate livepatch, callbacks, and shadow-vars scrips
- Gave the tests short descriptions instead of TEST1, TEST2, etc.

Joe Lawrence (1):
  selftests/livepatch: introduce tests

 lib/Kconfig.debug                                  |  12 +
 lib/Makefile                                       |   2 +
 lib/livepatch/Makefile                             |  18 +
 lib/livepatch/test_klp_atomic_replace.c            |  69 +++
 lib/livepatch/test_klp_callbacks_busy.c            |  43 ++
 lib/livepatch/test_klp_callbacks_demo.c            | 132 ++++++
 lib/livepatch/test_klp_callbacks_demo2.c           | 104 ++++
 lib/livepatch/test_klp_callbacks_mod.c             |  24 +
 lib/livepatch/test_klp_livepatch.c                 |  62 +++
 tools/testing/selftests/Makefile                   |   1 +
 tools/testing/selftests/livepatch/Makefile         |   8 +
 tools/testing/selftests/livepatch/config           |   1 +
 tools/testing/selftests/livepatch/functions.sh     | 202 ++++++++
 .../testing/selftests/livepatch/test-callbacks.sh  | 526 +++++++++++++++++++++
 .../testing/selftests/livepatch/test-livepatch.sh  | 177 +++++++
 .../selftests/livepatch/test-shadow-vars.sh        |  13 +
 16 files changed, 1394 insertions(+)
 create mode 100644 lib/livepatch/Makefile
 create mode 100644 lib/livepatch/test_klp_atomic_replace.c
 create mode 100644 lib/livepatch/test_klp_callbacks_busy.c
 create mode 100644 lib/livepatch/test_klp_callbacks_demo.c
 create mode 100644 lib/livepatch/test_klp_callbacks_demo2.c
 create mode 100644 lib/livepatch/test_klp_callbacks_mod.c
 create mode 100644 lib/livepatch/test_klp_livepatch.c
 create mode 100644 tools/testing/selftests/livepatch/Makefile
 create mode 100644 tools/testing/selftests/livepatch/config
 create mode 100644 tools/testing/selftests/livepatch/functions.sh
 create mode 100755 tools/testing/selftests/livepatch/test-callbacks.sh
 create mode 100755 tools/testing/selftests/livepatch/test-livepatch.sh
 create mode 100755 tools/testing/selftests/livepatch/test-shadow-vars.sh

-- 
1.8.3.1
