Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7BFC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 14:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78616208B8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 14:42:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78616208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbeH0S2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 14:28:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34436 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726953AbeH0S2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 14:28:34 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3D88683221;
        Mon, 27 Aug 2018 14:41:38 +0000 (UTC)
Received: from llong.com (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6E24E2026D6B;
        Mon, 27 Aug 2018 14:41:33 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        luto@amacapital.net, Mike Galbraith <efault@gmx.de>,
        torvalds@linux-foundation.org, Roman Gushchin <guro@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v12 0/9] cpuset: Enable cpuset controller in default hierarchy
Date:   Mon, 27 Aug 2018 10:41:15 -0400
Message-Id: <1535380884-31308-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 27 Aug 2018 14:41:38 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 27 Aug 2018 14:41:38 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v12:
 - Take out the debugging patch to print partitions.
 - Add a patch to force turning off partition flag if newly modified CPU
   list doesn't meet the requirement of being a partition root.
 - Remove some unneeded checking code in update_reserved_cpumask().

v11:
 - Change the "domain_root" name to "partition" as suggested by Peter and
   update the documentation and code accordingly.
 - Remove the dying cgroup check in update_reserved_cpus() as the check
   may not be needed after all.
 - Document the effect of losing CPU affinity after offling all the cpus
   in a partition.
 - There is no other major code changes in this version.

v10:
 - Remove the cpuset.sched.load_balance patch for now as it may not
   be that useful.
 - Break the large patch 2 into smaller patches to make them a bit
   easier to review.
 - Test and fix issues related to changing "cpuset.cpus" and cpu
   online/offline in a domain root.
 - Rename isolated_cpus to reserved_cpus as this cpumask holds CPUs
   reserved for child sched domains.
 - Rework the scheduling domain debug printing code in the last patch.
 - Document update to the newly moved
   Documentation/admin-guide/cgroup-v2.rst.

v9:
 - Rename cpuset.sched.domain to cpuset.sched.domain_root to better
   identify its purpose as the root of a new scheduling domain or
   partition.
 - Clarify in the document about the purpose of domain_root and
   load_balance. Using domain_root is th only way to create new
   partition.
 - Fix a lockdep warning in update_isolated_cpumask() function.
 - Add a new patch to eliminate call to generate_sched_domains() for
   v2 when a change in cpu list does not touch a domain_root.

 v9 patch: https://lkml.org/lkml/2018/5/29/507
v10 patch: https://lkml.org/lkml/2018/6/18/3
v11 patch: https://lkml.org/lkml/2018/6/24/30

The purpose of this patchset is to provide a basic set of cpuset control
files for cgroup v2. This basic set includes the non-root "cpus",
"mems" and "sched.partition". The "cpus.effective" and "mems.effective"
will appear in all cpuset-enabled cgroups.

The new control file that is unique to v2 is "sched.partition". It
is a boolean flag file that designates if a cgroup is the root of a
new scheduling domain or partition with its own set of unique list of
CPUs from scheduling perspective disjointed from other partitions. The
root cgroup is always a partition root. Multiple levels of partitions
are supported with some limitations. So a container partition root can
behave like a real root.

When a partition root cgroup is removed, its list of exclusive
CPUs will be returned to the parent's cpus.effective automatically.

A container root can be a partition root with sub-partitions
created underneath it. One difference from the real root is that the
"cpuset.sched.partition" flag isn't present in the real root, but is
present in a container root. This is also true for other cpuset control
files as well as those from the other controllers. This is a general
issue that is not going to be addressed here in this patchset.

This patchset does not exclude the possibility of adding more features
in the future after careful consideration.

Patch 1 enables cpuset in cgroup v2 with cpus, mems and their effective
counterparts.

Patch 2 adds a new "sched.partition" control file for setting up multiple
scheduling domains or partitions. A partition root implies cpu_exclusive.

Patch 3 handles the proper deletion of a partition root cgroup by turning
off the partition flag automatically before deletion.

Patch 4 allows "cpuset.cpus" of a partition root cgroup to be changed
subject to certain constraints.

Patch 5 makes the hotplug code deal with partition root properly.

Patch 6 updates the scheduling domain genaration code to work with
the new domain root feature.

Patch 7 exposes cpus.effective and mems.effective to the root cgroup as
enabling child scheduling domains will take CPUs away from the root cgroup.
So it will be nice to monitor what CPUs are left there.

Patch 8 eliminates the need to rebuild sched domains for v2 if cpu list
changes occur to non-domain root cpusets only.

Patch 9 enables the forced turnning off of partition flag if changes
made to "cpuset.cpus" makes a partition root cpuset not qualified to
be a partition root anymore. Forced clearing of the partition flag,
though allowed, is not recommended and a warning will be printed.

With the addition of forced turning off of partition flag, any changes
made to the "cpuset.cpus" allowable on a non-partition root cpuset
can be made to a parition root with the exception that the implied
cpu_exclusive nature of a partition root will forbid adding cpus that
have been allocated to its siblings.

Waiman Long (9):
  cpuset: Enable cpuset controller in default hierarchy
  cpuset: Add new v2 cpuset.sched.partition flag
  cpuset: Simulate auto-off of sched.partition at cgroup removal
  cpuset: Allow changes to cpus in a partition root
  cpuset: Make sure that partition flag work properly with CPU hotplug
  cpuset: Make generate_sched_domains() recognize reserved_cpus
  cpuset: Expose cpus.effective and mems.effective on cgroup v2 root
  cpuset: Don't rebuild sched domains if cpu changes in non-partition
    root
  cpuset: Support forced turning off of partition flag

 Documentation/admin-guide/cgroup-v2.rst | 174 ++++++++++++-
 kernel/cgroup/cpuset.c                  | 441 ++++++++++++++++++++++++++++++--
 2 files changed, 593 insertions(+), 22 deletions(-)

-- 
1.8.3.1

