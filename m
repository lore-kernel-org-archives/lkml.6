Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751776AbeCVVxw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 17:53:52 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36877 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751541AbeCVVxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 17:53:48 -0400
X-Google-Smtp-Source: AG47ELu8Unuy3SsGSYAhecbiba7c/gLL06MFMdkaft6oDMJB1q2RRMD8h4lyaOWxM+xa03OaNcw7hQ==
Date: Thu, 22 Mar 2018 14:53:46 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>
cc: Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [patch v2 -mm 0/6] rewrite cgroup aware oom killer for general use
In-Reply-To: <alpine.DEB.2.20.1803161405410.209509@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.20.1803221451370.17056@chino.kir.corp.google.com>
References: <alpine.DEB.2.20.1803121755590.192200@chino.kir.corp.google.com> <alpine.DEB.2.20.1803151351140.55261@chino.kir.corp.google.com> <alpine.DEB.2.20.1803161405410.209509@chino.kir.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rewrite cgroup aware oom killer for general use

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

This patchset fixes (1) and (2) completely and, by doing so, introduces a
completely extensible user interface that can be expanded in the future.

Concern (3) could subsequently be addressed either before or after the
cgroup-aware oom killer feature is merged.

It preserves all functionality that currently exists in -mm and extends
it to be generally useful outside of very specialized usecases.

It eliminates the mount option for the cgroup aware oom killer entirely
since it is now enabled through the root mem cgroup's oom policy.
---
 - Rebased to next-20180322
 - Fixed get_nr_swap_pages() build bug found by kbuild test robot

 Documentation/cgroup-v2.txt | 100 ++++++++--------
 include/linux/cgroup-defs.h |   5 -
 include/linux/memcontrol.h  |  21 ++++
 kernel/cgroup/cgroup.c      |  13 +--
 mm/memcontrol.c             | 221 +++++++++++++++++++++---------------
 5 files changed, 204 insertions(+), 156 deletions(-)
