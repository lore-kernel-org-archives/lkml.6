Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752811AbeBFKev (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 05:34:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:59940 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752187AbeBFKen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 05:34:43 -0500
From: Petr Mladek <pmladek@suse.com>
To: Jiri Kosina <jikos@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Cc: Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v7 0/7] livepatch: Atomic replace feature
Date: Tue,  6 Feb 2018 11:34:17 +0100
Message-Id: <20180206103424.10829-1-pmladek@suse.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The atomic replace allows to create cumulative patches. They
are useful when you maintain many livepatches and want to remove
one that is lower on the stack. In addition it is very useful when
more patches touch the same function and there are dependencies
between them.

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

Petr Mladek (2):
  livepatch: Free only structures with initialized kobject
  livepatch: Atomic replace and cumulative patches documentation

 Documentation/livepatch/cumulative-patches.txt |  76 +++++
 include/linux/livepatch.h                      |  59 +++-
 kernel/livepatch/core.c                        | 378 ++++++++++++++++++++++---
 kernel/livepatch/core.h                        |   4 +
 kernel/livepatch/patch.c                       |  29 +-
 kernel/livepatch/patch.h                       |   4 +-
 kernel/livepatch/transition.c                  |  41 ++-
 7 files changed, 543 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/livepatch/cumulative-patches.txt

-- 
2.13.6
