Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751426AbeBUDBi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 22:01:38 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36039 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751163AbeBUDBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 22:01:36 -0500
X-Google-Smtp-Source: AH8x225EZfWIKGouhfkpqkRr/DHkN1DkXE615y89MfflK7P04XN9hdYxnpnwqRsm0Kzejf4Shv6law==
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
Subject: [PATCH v2 0/3] Directed kmem charging
Date: Tue, 20 Feb 2018 19:00:58 -0800
Message-Id: <20180221030101.221206-1-shakeelb@google.com>
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
charged for the allocation instead of the memcg of the caller. However
the caller must have a reference to the remote memcg.

Fixed the build for SLOB in v2.

Shakeel Butt (3):
  mm: memcg: plumbing memcg for kmem cache allocations
  mm: memcg: plumbing memcg for kmalloc allocations
  fs: fsnotify: account fsnotify metadata to kmemcg

 fs/notify/dnotify/dnotify.c          |   5 +-
 fs/notify/fanotify/fanotify.c        |  12 ++-
 fs/notify/fanotify/fanotify.h        |   3 +-
 fs/notify/fanotify/fanotify_user.c   |   7 +-
 fs/notify/group.c                    |   4 +
 fs/notify/inotify/inotify_fsnotify.c |   2 +-
 fs/notify/inotify/inotify_user.c     |   5 +-
 fs/notify/mark.c                     |   6 +-
 include/linux/fsnotify_backend.h     |  12 ++-
 include/linux/memcontrol.h           |  13 ++-
 include/linux/slab.h                 |  86 +++++++++++++++-
 mm/memcontrol.c                      |  29 ++++--
 mm/page_alloc.c                      |   2 +-
 mm/slab.c                            | 107 ++++++++++++++++----
 mm/slab.h                            |   6 +-
 mm/slab_common.c                     |  41 +++++++-
 mm/slob.c                            |  13 +++
 mm/slub.c                            | 140 ++++++++++++++++++++++-----
 18 files changed, 415 insertions(+), 78 deletions(-)

-- 
2.16.1.291.g4437f3f132-goog
