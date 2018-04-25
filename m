Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756532AbeDYS27 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 14:28:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56716 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756023AbeDYS2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 14:28:54 -0400
From: Joe Lawrence <joe.lawrence@redhat.com>
To: live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Petr Mladek <pmladek@suse.com>, Miroslav Benes <mbenes@suse.cz>,
        =?UTF-8?q?Libor=20Pech=C3=A1=C4=8Dek?= <lpechacek@suse.com>,
        Nicolai Stange <nstange@suse.de>, Artem Savkov <asavkov@redhat.com>
Subject: [PATCH v4 0/1] Add livepatch kselftests
Date: Wed, 25 Apr 2018 14:28:49 -0400
Message-Id: <1524680930-28168-1-git-send-email-joe.lawrence@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This round incorporates feedback from SUSE folks, Miroslav, Petr and
Libor.  Thanks for the reviews and feedback!

Like the previous version, this applies on top of Petr's shadow variable
changes and the atomic replace patchset.

-- Joe

changes from v3:
- add MAINTAINERS entry for tools/testing/selftests/livepatch/
- make more test_klp_shadow_vars.c functions static (Miroslav)
- use git format-patch --base to generate base-commit and prerequisite
  patch info (kbuild test robot)
- tweak TEST_LIVEPATCH help text (Petr)
- add note in callbacks.txt pointing to sample/test examples (Petr)
- add a kmsg log() function (Libor)
- various whitespace and comment cleanups (Libor)
- add "$(dirname $0)/" directory prefix to functions.sh sourcing (Libor)
- add loop_until() function instead of redundant inline retry/loops (Libor)
- wait_for_transition() looks for any transition (Libor)

changes from v2:
- fix module_exit(test_klp_shadow_vars_exit) in test_klp_shadow_vars.c
- silence kbuild test robot's "XXX can be static" and "Using plain
  integer as NULL pointer" complaints
- re-run tests with CONFIG_LOCKDEP=y and CONFIG_PROVE_LOCKING=y
- use GFP_ATOMIC in test_klp_shadow_vars.c constructor code

changes from v1:
- Only add $(CC_FLAGS_FTRACE) for target modules
- Remove between test delay
- Reduce RETRY_INTERVAL to .1 sec
- Reduce test_callback_mod's busymod_work_func delay from 60 to 10 sec
- s/PASS/ok and s/FAIL/not ok for test output
- Move test descriptions from Documentation/livepatch/callbacks.txt
  into tools/testing/selftests/livepatch/test-callbacks.sh
- Add a shadow variable test script and module
- Add a short tools/testing/selftests/livepatch/README
- to += linux-kselftest@vger.kernel.org
- cc += Libor, Nicolai, Artem

changes from rfc:
- SPDX-License-Identifiers
- Moved livepatch test modules into lib/livepatch
- Renamed livepatch.sh (filename suffix)
- Reduced between-test delay time
- Split off common functions.sh file
- Split into separate livepatch, callbacks, and shadow-vars scrips
- Gave the tests short descriptions instead of TEST1, TEST2, etc.

Joe Lawrence (1):
  selftests/livepatch: introduce tests

 Documentation/livepatch/callbacks.txt         | 489 +-------------
 MAINTAINERS                                   |   1 +
 lib/Kconfig.debug                             |  21 +
 lib/Makefile                                  |   2 +
 lib/livepatch/Makefile                        |  15 +
 lib/livepatch/test_klp_atomic_replace.c       |  69 ++
 lib/livepatch/test_klp_callbacks_busy.c       |  43 ++
 lib/livepatch/test_klp_callbacks_demo.c       | 132 ++++
 lib/livepatch/test_klp_callbacks_demo2.c      | 104 +++
 lib/livepatch/test_klp_callbacks_mod.c        |  24 +
 lib/livepatch/test_klp_livepatch.c            |  62 ++
 lib/livepatch/test_klp_shadow_vars.c          | 236 +++++++
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/livepatch/Makefile    |   8 +
 tools/testing/selftests/livepatch/README      |  43 ++
 tools/testing/selftests/livepatch/config      |   1 +
 .../testing/selftests/livepatch/functions.sh  | 164 +++++
 .../selftests/livepatch/test-callbacks.sh     | 607 ++++++++++++++++++
 .../selftests/livepatch/test-livepatch.sh     | 173 +++++
 .../selftests/livepatch/test-shadow-vars.sh   |  60 ++
 20 files changed, 1771 insertions(+), 484 deletions(-)
 create mode 100644 lib/livepatch/Makefile
 create mode 100644 lib/livepatch/test_klp_atomic_replace.c
 create mode 100644 lib/livepatch/test_klp_callbacks_busy.c
 create mode 100644 lib/livepatch/test_klp_callbacks_demo.c
 create mode 100644 lib/livepatch/test_klp_callbacks_demo2.c
 create mode 100644 lib/livepatch/test_klp_callbacks_mod.c
 create mode 100644 lib/livepatch/test_klp_livepatch.c
 create mode 100644 lib/livepatch/test_klp_shadow_vars.c
 create mode 100644 tools/testing/selftests/livepatch/Makefile
 create mode 100644 tools/testing/selftests/livepatch/README
 create mode 100644 tools/testing/selftests/livepatch/config
 create mode 100644 tools/testing/selftests/livepatch/functions.sh
 create mode 100755 tools/testing/selftests/livepatch/test-callbacks.sh
 create mode 100755 tools/testing/selftests/livepatch/test-livepatch.sh
 create mode 100755 tools/testing/selftests/livepatch/test-shadow-vars.sh


base-commit: 0adb32858b0bddf4ada5f364a84ed60b196dbcda
prerequisite-patch-id: 5ed747c1a89a5dc4bba08186e21f927d7f3bf049
prerequisite-patch-id: e9800288b71a9f339ea066e58d9ef70dece67083
prerequisite-patch-id: 415f2e190b1b50142c78f2940c7b8dd39b5321a0
prerequisite-patch-id: d229d9cf08af087e0a758d9df1da467103c2c200
prerequisite-patch-id: b8c7ef99b13c6b321cba5e8919ed0b3e29f213e9
prerequisite-patch-id: 4e10c0d08f151b18310fe0b1e5013d62db94cfeb
prerequisite-patch-id: 33046b190c114d202f3a52e0e274dbb2b1907a4c
prerequisite-patch-id: 6978944a725756317dd4e005d479b6101784aaf0
prerequisite-patch-id: cce9d3c7e1ae8887f387ca9e072552dc63479749
prerequisite-patch-id: c44ccc5dd7b1be6fe2b1f32ca6abde1da73fae79
-- 
2.17.0.252.gfe0a9eaf31dd
