Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68509C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B80D26291
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gOpOaUtE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B80D26291
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934117AbeFYXHL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 19:07:11 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:40745 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932629AbeFYXHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 19:07:09 -0400
Received: by mail-pg0-f68.google.com with SMTP id w8-v6so6719448pgp.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 16:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TlrWWiQPCjtC68tVmQ7b4F+X4V3UVnh2azcLgqQiihM=;
        b=gOpOaUtEyQm5hxkLy4fzL4zVrzBvd1+vaggtcqxOR/FT2wdnfXV8ipNwp8sbqJeiG6
         /SA+8YFQMHKnds9lrpq2qiyFRAJVDFJ/l/kaugd+SZp8sl+zqvSyh69vJ3khxE3vZy4/
         L/EzZo8d67oIjiOBLf1ar7eN16junnNtYW8GhAWFlcmOPEPiNMdm6l9rj6QlnPBKBFrb
         r7p8qwt5laYAYibUqOP02gUmVo+m9DoxcmReTyPDZAYPQRni/miJTW8awwzUPilLfJmh
         vMWhdiSiLuqPCuhCogSkBnlbYBhbkKZxtRNV0VnVX+UnTgol1OCmPB9caNSlIbp3Twcy
         7YmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TlrWWiQPCjtC68tVmQ7b4F+X4V3UVnh2azcLgqQiihM=;
        b=MInowPidgd2UoRQKSP8dq9rmdFOm3vZTJc4v2gevjHxGpzAPtT5lVCE3DBmSxBOPGE
         VXisx2J1MzHeohbH/UXdo0f1sYlQvjhiGIzUWP7m4I3GLhbQh/BXwamy1K6/n+U/8Zmv
         fzf0IqukHOD1QSc+T8U4gTVQir3FTkUI+F+5fIaU0zjsUlOvjxrMWwNnFm+GLHUeTEkq
         5J0kWn1FpLH1qBPR1GUhXuj0vso+pbNPGi0FA4kUPN/4Y3fUbzgbQqX3PBZuUymPfU0d
         iQt/wDY7a1qcGJUgmYaUXfsKCQeQPKDCNRqFwDVBvECN9E3jzgbDDQtQ+9MURsiRfW+9
         NaVg==
X-Gm-Message-State: APt69E2d12i2JUmqQQGEYxJaCbRO8EubIGp/m5iA/zxYoOfZioiwJ66O
        zPPRNpTfX5Y/RYaWKO3RxVqPxw==
X-Google-Smtp-Source: ADUXVKI4qqi/bvY9Kt3EEaXJl3r/a0KPjRNcAXENL3yClnEDlQFSJQBHDM/1dvsVCzLY1lxgKSftbw==
X-Received: by 2002:a63:342:: with SMTP id 63-v6mr11937257pgd.290.1529968028618;
        Mon, 25 Jun 2018 16:07:08 -0700 (PDT)
Received: from shakeelb.mtv.corp.google.com ([2620:15c:2cb:201:3a5f:3a4f:fa44:6b63])
        by smtp.gmail.com with ESMTPSA id p73-v6sm116657pfa.142.2018.06.25.16.07.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 16:07:07 -0700 (PDT)
From:   Shakeel Butt <shakeelb@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jan Kara <jack@suse.com>, Greg Thelen <gthelen@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>
Subject: [PATCH v7 0/2] Directed kmem charging
Date:   Mon, 25 Jun 2018 16:06:57 -0700
Message-Id: <20180625230659.139822-1-shakeelb@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux kernel's memory cgroup allows limiting the memory usage of
the jobs running on the system to provide isolation between the jobs.
All the kernel memory allocated in the context of the job and marked
with __GFP_ACCOUNT will also be included in the memory usage and be
limited by the job's limit.

The kernel memory can only be charged to the memcg of the process in
whose context kernel memory was allocated. However there are cases where
the allocated kernel memory should be charged to the memcg different
from the current processes's memcg. This patch series contains two such
concrete use-cases i.e. fsnotify and buffer_head.

The fsnotify event objects can consume a lot of system memory for large
or unlimited queues if there is either no or slow listener. The events
are allocated in the context of the event producer. However they should
be charged to the event consumer. Similarly the buffer_head objects can
be allocated in a memcg different from the memcg of the page for which
buffer_head objects are being allocated.

To solve this issue, this patch series introduces mechanism to charge
kernel memory to a given memcg. In case of fsnotify events, the memcg of
the consumer can be used for charging and for buffer_head, the memcg of
the page can be charged. For directed charging, the caller can use the
scope API memalloc_[un]use_memcg() to specify the memcg to charge for
all the __GFP_ACCOUNT allocations within the scope.

Shakeel Butt (2):
  fs: fsnotify: account fsnotify metadata to kmemcg
  fs, mm: account buffer_head to kmemcg

 fs/buffer.c                          | 15 ++++++-
 fs/notify/dnotify/dnotify.c          |  5 ++-
 fs/notify/fanotify/fanotify.c        | 17 ++++++--
 fs/notify/fanotify/fanotify_user.c   |  5 ++-
 fs/notify/group.c                    |  4 ++
 fs/notify/inotify/inotify_fsnotify.c | 15 ++++++-
 fs/notify/inotify/inotify_user.c     |  5 ++-
 include/linux/fsnotify_backend.h     | 12 ++++--
 include/linux/memcontrol.h           | 14 +++++++
 include/linux/sched.h                |  3 ++
 include/linux/sched/mm.h             | 41 +++++++++++++++++++
 kernel/fork.c                        |  3 ++
 mm/memcontrol.c                      | 60 ++++++++++++++++++++++++++--
 13 files changed, 182 insertions(+), 17 deletions(-)

-- 
2.18.0.rc2.346.g013aa6912e-goog

