Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53786C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05EC82064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:37:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05EC82064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbeJOUWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 16:22:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:52246 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726400AbeJOUWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 16:22:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EFA51AE15;
        Mon, 15 Oct 2018 12:37:20 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Cc:     Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v13 00/12] livepatch: Atomic replace feature
Date:   Mon, 15 Oct 2018 14:37:01 +0200
Message-Id: <20181015123713.25868-1-pmladek@suse.com>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The atomic replace allows to create cumulative patches. They
are useful when you maintain many livepatches and want to remove
one that is lower on the stack. In addition it is very useful when
more patches touch the same function and there are dependencies
between them.

Now, the question is if 13 is a lucky number. I hope so
and that this version might get merged. Any feedback?
Not only from Mirek, please ;-)


Changes against v12:

  + Finish freeing the patch using workqueues to prevent
    deadlock against kobject code.

  + Check for valid pointers when initializing the dynamic
    lists objects and functions.

  + Mark klp_free_objects_dynamic() static.

  + Improved documentation and fixed typos


Changes against v11:

  + Functional changes:

    + Livepatches get automatically unregistered when disabled.
      Note that the sysfs interface disappears at this point.
      It simplifies the API and code. The only drawback is that
      the patch can be enabled again only by reloading the module.

    + Refuse to load conflicting patches. The same function can
      be patched again only by a new cumulative patch that
      replaces all older ones.

    + Non-conflicting patches can be loaded and disabled in any
      order.
      

  + API related changes:

     + Change void *new_func -> unsigned long new_addr in
       struct klp_func.

     + Several new macros to hide implementation details and
       avoid casting when defining struct klp-func and klp_object.

     + Remove obsolete klp_register_patch() klp_unregister_patch() API


  + Change in selftest against v4:

     + Use new macros to define struct klp_func and klp_object.

     + Remove klp_register_patch()/klp_unregister_patch() calls.

     + Replace load_mod() + wait_for_transition() with three
       variants load_mod(), load_lp(), load_lp_nowait(). IMHO,
       it is easier to use because we need to detect the end
       of transaction another way after disable_lp() now.

     + Replaced unload_mod() with two variants unload_mod(),
       unload_lp() to match the above change.

     + Wait for the end of transition in disable_lp()
       instead of the unreliable check of the sysfs interface.

     Note that I did not touch the logs with expected result.
     They stay exactly the same as in v4 posted by Joe.
     I hope that it is a good sign ;-)


Changes against v10:

  + Bug fixes and functional changes:
    + Handle Nops in klp_ftrace_handled() to avoid infinite loop [Mirek]
    + Really add dynamically allocated klp_object into the list [Petr]
    + Clear patch->replace when transition finishes [Josh]

  + Refactoring and clean up [Josh]:
    + Replace enum types with bools
    + Avoid using ERR_PTR
    + Remove too paranoid warnings
    + Distinguish registered patches by a flag instead of a list
    + Squash some functions
    + Update comments, documentation, and commit messages
    + Squashed and split patches to do more controversial changes later

Changes against v9:

  + Fixed check of valid NOPs for already loaded objects,
    regression introduced in v9 [Joe, Mirek]
  + Allow to replace even disabled patches [Evgenii]

Changes against v8:

  + Fixed handling of statically defined struct klp_object
    with empty array of functions [Joe, Mirek]
  + Removed redundant func->new_func assignment for NOPs [Mirek]
  + Improved some wording [Mirek]

Changes against v7:

  + Fixed handling of NOPs for not-yet-loaded modules
  + Made klp_replaced_patches list static [Mirek]
  + Made klp_free_object() public later [Mirek]
  + Fixed several reported typos [Mirek, Joe]
  + Updated documentation according to the feedback [Joe]
  + Added some Acks [Mirek]

Changes against v6:

  + used list_move when disabling replaced patches [Jason]
  + renamed KLP_FUNC_ORIGINAL -> KLP_FUNC_STATIC [Mirek]
  + used klp_is_func_type() in klp_unpatch_object() [Mirek]
  + moved static definition of klp_get_or_add_object() [Mirek]
  + updated comment about synchronization in forced mode [Mirek]
  + added user documentation
  + fixed several typos



Jason Baron (2):
  livepatch: Use lists to manage patches, objects and functions
  livepatch: Add atomic replace

Joe Lawrence (1):
  selftests/livepatch: introduce tests

Petr Mladek (9):
  livepatch: Change void *new_func -> unsigned long new_addr in struct
    klp_func
  livepatch: Helper macros to define livepatch structures
  livepatch: Shuffle klp_enable_patch()/klp_disable_patch() code
  livepatch: Consolidate klp_free functions
  livepatch: Refuse to unload only livepatches available during a forced
    transition
  livepatch: Simplify API by removing registration step
  livepatch: Remove Nop structures when unused
  livepatch: Atomic replace and cumulative patches documentation
  livepatch: Remove ordering and refuse loading conflicting patches

 Documentation/livepatch/callbacks.txt              | 489 +-----------
 Documentation/livepatch/cumulative-patches.txt     | 102 +++
 Documentation/livepatch/livepatch.txt              | 131 ++--
 MAINTAINERS                                        |   1 +
 include/linux/livepatch.h                          |  84 ++-
 kernel/livepatch/core.c                            | 826 ++++++++++++++-------
 kernel/livepatch/core.h                            |   4 +
 kernel/livepatch/patch.c                           |  41 +-
 kernel/livepatch/patch.h                           |   1 +
 kernel/livepatch/transition.c                      |  33 +-
 lib/Kconfig.debug                                  |  21 +
 lib/Makefile                                       |   2 +
 lib/livepatch/Makefile                             |  15 +
 lib/livepatch/test_klp_atomic_replace.c            |  53 ++
 lib/livepatch/test_klp_callbacks_busy.c            |  43 ++
 lib/livepatch/test_klp_callbacks_demo.c            | 109 +++
 lib/livepatch/test_klp_callbacks_demo2.c           |  89 +++
 lib/livepatch/test_klp_callbacks_mod.c             |  24 +
 lib/livepatch/test_klp_livepatch.c                 |  47 ++
 lib/livepatch/test_klp_shadow_vars.c               | 236 ++++++
 samples/livepatch/livepatch-callbacks-demo.c       |  68 +-
 samples/livepatch/livepatch-sample.c               |  26 +-
 samples/livepatch/livepatch-shadow-fix1.c          |  34 +-
 samples/livepatch/livepatch-shadow-fix2.c          |  34 +-
 tools/testing/selftests/Makefile                   |   1 +
 tools/testing/selftests/livepatch/Makefile         |   8 +
 tools/testing/selftests/livepatch/README           |  43 ++
 tools/testing/selftests/livepatch/config           |   1 +
 tools/testing/selftests/livepatch/functions.sh     | 203 +++++
 .../testing/selftests/livepatch/test-callbacks.sh  | 587 +++++++++++++++
 .../testing/selftests/livepatch/test-livepatch.sh  | 168 +++++
 .../selftests/livepatch/test-shadow-vars.sh        |  60 ++
 32 files changed, 2597 insertions(+), 987 deletions(-)
 create mode 100644 Documentation/livepatch/cumulative-patches.txt
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

-- 
2.13.7

