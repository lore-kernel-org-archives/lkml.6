Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753970AbeCWMAs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 08:00:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:39530 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753586AbeCWMAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 08:00:45 -0400
From: Petr Mladek <pmladek@suse.com>
To: Jiri Kosina <jikos@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Cc: Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH 0/8] livepatch: Atomic replace feature
Date: Fri, 23 Mar 2018 13:00:20 +0100
Message-Id: <20180323120028.31451-1-pmladek@suse.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The atomic replace allows to create cumulative patches. They
are useful when you maintain many livepatches and want to remove
one that is lower on the stack. In addition it is very useful when
more patches touch the same function and there are dependencies
between them.

This version is heavily refactored and cleaned based on feedback from Josh.
There are actually only three functional changes.

It still passes the first draft of the selfttest from Joe that can
be found at https://lkml.kernel.org/r/1520881024-29386-1-git-send-email-joe.lawrence@redhat.com


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


Jason Baron (3):
  livepatch: Use lists to manage patches, objects and functions
  livepatch: Add atomic replace
  livepatch: Remove replaced patches from the stack

Petr Mladek (5):
  livepatch: Free only structures with initialized kobject
  livepatch: Add an extra flag to distinguish registered patches
  livepatch: Remove Nop structures when unused
  livepatch: Allow to replace even disabled patches
  livepatch: Atomic replace and cumulative patches documentation

 Documentation/livepatch/cumulative-patches.txt | 105 ++++++++
 include/linux/livepatch.h                      |  33 ++-
 kernel/livepatch/core.c                        | 355 ++++++++++++++++++++++---
 kernel/livepatch/core.h                        |   4 +
 kernel/livepatch/patch.c                       |  39 ++-
 kernel/livepatch/patch.h                       |   1 +
 kernel/livepatch/transition.c                  |  27 ++
 7 files changed, 519 insertions(+), 45 deletions(-)
 create mode 100644 Documentation/livepatch/cumulative-patches.txt

-- 
2.13.6
