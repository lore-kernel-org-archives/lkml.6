Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F48C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E53052146E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:29:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E53052146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbeIMAfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 20:35:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50880 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728139AbeIMAfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 20:35:06 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3FB9080401CC;
        Wed, 12 Sep 2018 19:29:06 +0000 (UTC)
Received: from llong.com (dhcp-17-55.bos.redhat.com [10.18.17.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 33D0210EE6D8;
        Wed, 12 Sep 2018 19:29:03 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.com>,
        Jeff Layton <jlayton@poochiereds.net>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <andi@firstfloor.org>,
        Dave Chinner <dchinner@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v9 0/5] vfs: Use dlock list for SB's s_inodes list
Date:   Wed, 12 Sep 2018 15:28:47 -0400
Message-Id: <1536780532-4092-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 12 Sep 2018 19:29:06 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 12 Sep 2018 19:29:06 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 v8->v9:
  - The last 2 patches in v8 were dropped because there is no more
    user that can use them.
  - Include Davidlohr's dlock_lists_empty() scaling patch.
  - Rebase the code to 4.19-rc3.

 v8 patch: https://lkml.org/lkml/2017/10/31/776

This patchset has been dormant for almost a year. Now I am going to
restart it again.

This patchset provides new APIs for a set of distributed locked lists
(one/CPU core) to minimize lock and cacheline contention. Insertion
and deletion to the list will be cheap and relatively contention free.
Lookup, on the other hand, may be a bit more costly as there are
multiple lists to iterate. This is not really a problem for the
replacement of superblock's inode list by dlock list included in
the patchset as lookup isn't needed.

Patch 1 introduces the dlock list. The list heads are allocated
by kcalloc() instead of percpu_alloc(). Each list head entry is
cacheline aligned to minimize contention.

Patch 2 replaces the use of list_for_each_entry_safe() in
evict_inodes() and invalidate_inodes() by list_for_each_entry().

Patch 3 modifies the superblock and inode structures to use the dlock
list. The corresponding functions that reference those structures
are modified.

Patch 4 makes the sibling CPUs use the same dlock list head to reduce
the number of list heads that need to be iterated.

Patch 5 improves the performance of dlock_lists_empty() call.

See patch 3 for some performance data for this patchset.

Davidlohr Bueso (1):
  lib/dlock-list: Scale dlock_lists_empty()

Jan Kara (1):
  vfs: Remove unnecessary list_for_each_entry_safe() variants

Waiman Long (3):
  lib/dlock-list: Distributed and lock-protected lists
  vfs: Use dlock list for superblock's inode list
  lib/dlock-list: Make sibling CPUs share the same linked list

 fs/block_dev.c             |   9 +-
 fs/drop_caches.c           |   9 +-
 fs/inode.c                 |  38 +++---
 fs/notify/fsnotify.c       |   9 +-
 fs/quota/dquot.c           |  14 +-
 fs/super.c                 |   7 +-
 include/linux/dlock-list.h | 250 ++++++++++++++++++++++++++++++++++
 include/linux/fs.h         |   8 +-
 lib/Makefile               |   2 +-
 lib/dlock-list.c           | 325 +++++++++++++++++++++++++++++++++++++++++++++
 10 files changed, 617 insertions(+), 54 deletions(-)
 create mode 100644 include/linux/dlock-list.h
 create mode 100644 lib/dlock-list.c

-- 
1.8.3.1

