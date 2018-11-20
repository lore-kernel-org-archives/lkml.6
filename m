Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCFDC46462
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A10E206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:52:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A10E206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbeKUEWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 23:22:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34910 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbeKUEWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 23:22:30 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4D2CBC0495A8;
        Tue, 20 Nov 2018 17:52:09 +0000 (UTC)
Received: from llong.com (ovpn-120-174.rdu2.redhat.com [10.10.120.174])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 35AF818FA5;
        Tue, 20 Nov 2018 17:52:07 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v4 0/5] cgroup: Introducing bypass mode
Date:   Tue, 20 Nov 2018 12:51:24 -0500
Message-Id: <1542736289-31338-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 20 Nov 2018 17:52:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 v4:
  - Rebased to the latest for-4.21 branch of cgroup tree.
  - Make each controller explicitly opt in to become bypassable by
    setting the bypassable cgroup_subsys flag. Currently, only cpu
    controller is made bypassable.
  - Break out the cgroup_v2.rst documentation update as separate patch.

 v3:
  - Remove invalid cgroup subdirectory creation patch.
  - Add use cases for the bypass mode and removing statements about
    control files ownership in cgroup-v2.txt.
  - Restrict bypass mode to non-domain (threaded) controllers only.

 v3 patch - https://lkml.org/lkml/2017/8/9/604

This patchset introduces a new bypass mode to the cgroup v2 core to
give more freedom and flexibility to controllers which choose to become
bypassable the freedom to shape their own unique views of the virtual
cgroup hierarchies that can best suit thier own use cases.

Because of the inherent performance overhead in enabling cpu controller,
it is made bypassable so that the controller only needs to be enabled
at those cgroups that really need it instead of in every cgroups at a
given layer if at least one of them needs it.

The cpu controller performance problem is one of the major issues
in migrating from cgroup v1 to v2.

For example,

  R - A(+) - B(#) - C(+)
                  \ D(#)

where "+" means the controller is enabled and "#" means the controller
is bypassed. For this controller's perspective, the cgroups are
equivalent to:

  R - A|B|D - C

Underneath the root R, cgoups A, B and D are controlled by one set of
knobs and cgroup C is controlled by another set of knobs as a child of
cgroups A|B|C.

This patchset is layered on top of the "for-4.21" branch of Tejun's
cgroup git tree.

Patch 1 introduces a new bypass mode that allows a bypassable
controller to be disabled in a cgroup, but to be re-enabled again in its
children. This is enabled by writing the controller name prefixed with
'#' to the "cgroup.subtree_control" file. Then all its children will
have this controller in bypass mode.

Patch 2 extends the bypass mode mechanism to allow those child cgroups
that are put into the bypass mode for a particular bypassable controller
by their parent to be re-enabled again by writing the controller name
with the '+' prefix to the "cgroup.controllers" file.

Patch 3 extends the debug controller to expose additional controller
masks introduced by this patchset.

Patch 4 makes the cpu controller bypassable.

Patch 5 documents the new bypass mode in cgroup-v2.rst file.

Waiman Long (5):
  cgroup: subtree_control bypass mode for bypassable controllers
  cgroup: Allow reenabling of controller in bypass mode
  cgroup: Make debug controller report new controller masks
  sched/core: Make cpu cgroup controller bypassable
  cgroup: Document bypass mode

 Documentation/admin-guide/cgroup-v2.rst |  66 +++++---
 include/linux/cgroup-defs.h             |  26 +++-
 kernel/cgroup/cgroup.c                  | 256 +++++++++++++++++++++++++-------
 kernel/cgroup/debug.c                   |   2 +
 kernel/sched/core.c                     |   1 +
 5 files changed, 276 insertions(+), 75 deletions(-)

-- 
1.8.3.1

