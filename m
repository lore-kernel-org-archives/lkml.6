Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946114AbeCBK3u (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 05:29:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:35585 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1945990AbeCBK3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 05:29:44 -0500
From: Petr Mladek <pmladek@suse.com>
To: Jiri Kosina <jikos@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Cc: Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v9 0/9] livepatch: Atomic replace feature
Date: Fri,  2 Mar 2018 11:29:26 +0100
Message-Id: <20180302102935.14564-1-pmladek@suse.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The atomic replace allows to create cumulative patches. They
are useful when you maintain many livepatches and want to remove
one that is lower on the stack. In addition it is very useful when
more patches touch the same function and there are dependencies
between them.

I fixed the bug found by Joe in separate patch. It should make
the review easier for those who already did one. Feel free
to ask me to squash it though.


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


Jason Baron (5):
  livepatch: Use lists to manage patches, objects and functions
  livepatch: Initial support for dynamic structures
  livepatch: Allow to unpatch only functions of the given type
  livepatch: Support separate list for replaced patches.
  livepatch: Add atomic replace

Petr Mladek (4):
  livepatch: Free only structures with initialized kobject
  livepatch: Correctly handle atomic replace for not yet loaded modules
  livepatch: Improve dynamic struct klp_object detection and
    manipulation
  livepatch: Atomic replace and cumulative patches documentation

 Documentation/livepatch/cumulative-patches.txt |  83 +++++
 include/linux/livepatch.h                      |  65 +++-
 kernel/livepatch/core.c                        | 406 ++++++++++++++++++++++---
 kernel/livepatch/core.h                        |   4 +
 kernel/livepatch/patch.c                       |  31 +-
 kernel/livepatch/patch.h                       |   4 +-
 kernel/livepatch/transition.c                  |  41 ++-
 7 files changed, 584 insertions(+), 50 deletions(-)
 create mode 100644 Documentation/livepatch/cumulative-patches.txt

-- 
2.13.6
