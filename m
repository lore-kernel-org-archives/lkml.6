Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932292AbeCMA5z (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 20:57:55 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41978 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751390AbeCMA5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 20:57:54 -0400
X-Google-Smtp-Source: AG47ELufzhZGrHR+hTn8d1b508lU/MgXkW1Q26x9RmvHlU8jyG4rhZBPm+avexBSlzIBrTjwVFPDTQ==
Date: Mon, 12 Mar 2018 17:57:51 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>
cc: Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [patch -mm v3 0/3] mm, memcg: introduce oom policies
Message-ID: <alpine.DEB.2.20.1803121755590.192200@chino.kir.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are three significant concerns about the cgroup aware oom killer as
it is implemented in -mm:

 (1) allows users to evade the oom killer by creating subcontainers or
     using other controllers since scoring is done per cgroup and not
     hierarchically,

 (2) unfairly compares the root mem cgroup using completely different
     criteria than leaf mem cgroups and allows wildly inaccurate results
     if oom_score_adj is used, and

 (3) does not allow the user to influence the decisionmaking, such that
     important subtrees cannot be preferred or biased.

This patchset aims to fix (1) completely and, by doing so, introduces a
completely extensible user interface that can be expanded in the future.

It preserves all functionality that currently exists in -mm and extends
it to be generally useful outside of very specialized usecases.

It eliminates the mount option for the cgroup aware oom killer entirely
since it is now enabled through the root mem cgroup's oom policy.
---
 v3:
  - updated documentation
  - rebased to next-20180309

 Documentation/cgroup-v2.txt | 90 ++++++++++++++++++++++++-------------
 include/linux/cgroup-defs.h |  5 ---
 include/linux/memcontrol.h  | 21 +++++++++
 kernel/cgroup/cgroup.c      | 13 +-----
 mm/memcontrol.c             | 64 +++++++++++++++++++++-----
 5 files changed, 132 insertions(+), 61 deletions(-)
