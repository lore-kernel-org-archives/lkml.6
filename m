Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752977AbeFAQCL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 12:02:11 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:49006 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752552AbeFAQCE (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Fri, 1 Jun 2018 12:02:04 -0400
From: Davidlohr Bueso <dave@stgolabs.net>
To: akpm@linux-foundation.org, torvalds@linux-foundation.org
Cc: tgraf@suug.ch, herbert@gondor.apana.org.au, manfred@colorfullife.com,
        mhocko@kernel.org, guillaume.knispel@supersonicimagine.com,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH -next v2 0/5] rhashtable: guarantee first allocation
Date: Fri,  1 Jun 2018 09:01:20 -0700
Message-Id: <20180601160125.30031-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from v1
lkml.kernel.org/r/20180524211135.27760-1-dave@stgolabs.net

- patch 2 is reworked a bit based on the commments from Herbert Xu.
  o upon failure, retry immediately with GFP_NOFAIL (simpler)
  o the caller now passes the needed semantics, not bucket_table_alloc().
  o we consider min_size when resizing, not just HASH_MIN_SIZE.

- removed patch 3; not need after Michal's patch.

Hi,

This series is the result of the discussion with Linus around ipc
subsystem initialization and how it behaves with error return when
calling rhashtable_init()[1]. Instead of caring about the error
or calling the infamous BUG_ON, Linus suggested we guarantee the
rhashtable allocation.

First two patches modify rhashtable_init() to just return 0, future
patches will update more callers, particularly those that use BUG_ON.

patch 3+4 remove some ipc hacks we no longer need.

patch 5 updates the rhashtable test module. Trivial.

Please consider for v4.18.

Thanks!

[0] https://lkml.org/lkml/2018/5/23/758

Davidlohr Bueso (5):
  lib/rhashtable: convert param sanitations to WARN_ON
  lib/rhashtable: guarantee initial hashtable allocation
  ipc: get rid of ids->tables_initialized hack
  ipc: simplify ipc initialization
  lib/test_rhashtable: rhashtable_init() can no longer fail

 include/linux/ipc_namespace.h |  1 -
 ipc/msg.c                     |  9 ++++-----
 ipc/namespace.c               | 20 ++++----------------
 ipc/sem.c                     | 10 ++++------
 ipc/shm.c                     |  9 ++++-----
 ipc/util.c                    | 41 +++++++++++++----------------------------
 ipc/util.h                    | 18 +++++++++---------
 lib/rhashtable.c              | 22 ++++++++++++++--------
 lib/test_rhashtable.c         |  6 +-----
 9 files changed, 53 insertions(+), 83 deletions(-)

-- 
2.16.3
