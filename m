Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966654AbeBNC6E (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 21:58:04 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:42121 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966574AbeBNC6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 21:58:02 -0500
X-Google-Smtp-Source: AH8x226WkxvycPwm1O8XCpuNkhLXekmMuhM3lqrMPCbqbhdbdWECUVDWJS3CxFMnz2zR7lY5+h1pQw==
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
Subject: [RFC PATCH 0/3] Directed kmem charging
Date: Tue, 13 Feb 2018 18:56:50 -0800
Message-Id: <20180214025653.132942-1-shakeelb@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces memcg variant memory allocation functions. The
caller can explicitly pass the memcg to charge for kmem allocations.
Currently the kernel, for __GFP_ACCOUNT memory allocation requests,
extract the memcg of the current task to charge for the kmem allocation.
This patch series introduces kmem allocation functions where the caller
can pass the pointer to the remote memcg. The remote memcg will be
charged for the allocation instead of the memcg of the caller.


Shakeel Butt (3):
  mm: memcg: plumbing memcg for kmem cache allocations
  mm: memcg: plumbing memcg for kmalloc allocations
  fs: fsnotify: account fsnotify metadata to kmemcg

 fs/notify/dnotify/dnotify.c          |   5 +-
 fs/notify/fanotify/fanotify.c        |  12 ++-
 fs/notify/fanotify/fanotify.h        |   3 +-
 fs/notify/fanotify/fanotify_user.c   |   8 +-
 fs/notify/group.c                    |   4 +
 fs/notify/inotify/inotify_fsnotify.c |   2 +-
 fs/notify/inotify/inotify_user.c     |   5 +-
 fs/notify/mark.c                     |   9 +-
 include/linux/fsnotify_backend.h     |  12 ++-
 include/linux/memcontrol.h           |  12 ++-
 include/linux/slab.h                 |  86 +++++++++++++++-
 mm/memcontrol.c                      |  29 ++++--
 mm/page_alloc.c                      |   2 +-
 mm/slab.c                            | 107 ++++++++++++++++----
 mm/slab.h                            |   6 +-
 mm/slab_common.c                     |  41 +++++++-
 mm/slub.c                            | 140 ++++++++++++++++++++++-----
 17 files changed, 404 insertions(+), 79 deletions(-)

-- 
2.16.1.291.g4437f3f132-goog
