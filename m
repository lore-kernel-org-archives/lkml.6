Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752787AbeCESae (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 13:30:34 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37695 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752154AbeCESac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 13:30:32 -0500
X-Google-Smtp-Source: AG47ELtwkWi4e+ER4cWkOSdAFgNwMgQQ1eECRlGHtvHua38UUB8RRkEMy9HQsaE4vNhcsfp6IkJfyA==
From: Shakeel Butt <shakeelb@google.com>
To: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
Subject: [PATCH v4 0/2] Directed kmem charging
Date: Mon,  5 Mar 2018 10:29:49 -0800
Message-Id: <20180305182951.34462-1-shakeelb@google.com>
X-Mailer: git-send-email 2.16.2.395.g2e18187dfd-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces memcg variant memory allocation functions. The
caller can explicitly pass the memcg to charge for kmem allocations.
Currently the kernel, for __GFP_ACCOUNT memory allocation requests,
extract the memcg of the current task to charge for the kmem allocation.
This patch series introduces kmem allocation functions where the caller
can pass the pointer to the remote memcg. The remote memcg will be
charged for the allocation instead of the memcg of the caller. However
the caller must have a reference to the remote memcg.

Fixed the build for SLOB in v2, added the target_memcg in task_struct in
v3 and in v4, added node variant for kmem allocation functions and
rebased fsnotify patch over Jan's patches.


Shakeel Butt (2):
  mm: memcg: remote memcg charging for kmem allocations
  fs: fsnotify: account fsnotify metadata to kmemcg

 fs/notify/dnotify/dnotify.c          |  5 ++-
 fs/notify/fanotify/fanotify.c        |  6 ++-
 fs/notify/fanotify/fanotify_user.c   |  5 ++-
 fs/notify/group.c                    |  4 ++
 fs/notify/inotify/inotify_fsnotify.c |  2 +-
 fs/notify/inotify/inotify_user.c     |  5 ++-
 include/linux/fsnotify_backend.h     | 12 ++++--
 include/linux/memcontrol.h           |  7 ++++
 include/linux/sched.h                |  3 ++
 include/linux/sched/mm.h             | 23 +++++++++++
 include/linux/slab.h                 | 59 ++++++++++++++++++++++++++++
 kernel/fork.c                        |  3 ++
 mm/memcontrol.c                      | 25 +++++++++---
 13 files changed, 143 insertions(+), 16 deletions(-)

-- 
2.16.2.395.g2e18187dfd-goog
