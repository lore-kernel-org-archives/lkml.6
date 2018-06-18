Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988E6C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 04:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 573CC20864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 04:14:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 573CC20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752877AbeFREOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 00:14:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41958 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750762AbeFREOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 00:14:41 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6C5EB400E9AF;
        Mon, 18 Jun 2018 04:14:40 +0000 (UTC)
Received: from llong.com (ovpn-121-11.rdu2.redhat.com [10.10.121.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 08623201E288;
        Mon, 18 Jun 2018 04:14:33 +0000 (UTC)
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
Subject: [PATCH v10 0/9] cpuset: Enable cpuset controller in default hierarchy
Date:   Mon, 18 Jun 2018 12:13:59 +0800
Message-Id: <1529295249-5207-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 18 Jun 2018 04:14:40 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 18 Jun 2018 04:14:40 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

v8:
 - Remove cpuset.cpus.isolated and add a new cpuset.sched.domain flag
   and rework the code accordingly.

v7:
 - Add a root-only cpuset.cpus.isolated control file for CPU isolation.
 - Enforce that load_balancing can only be turned off on cpusets with
   CPUs from the isolated list.
 - Update sched domain generation to allow cpusets with CPUs only
   from the isolated CPU list to be in separate root domains.

v6:
 - Hide cpuset control knobs in root cgroup.
 - Rename effective_cpus and effective_mems to cpus.effective and
   mems.effective respectively.
 - Remove cpuset.flags and add cpuset.sched_load_balance instead
   as the behavior of sched_load_balance has changed and so is
   not a simple flag.
 - Update cgroup-v2.txt accordingly.

v5:
 - Add patch 2 to provide the cpuset.flags control knob for the
   sched_load_balance flag which should be the only feature that is
   essential as a replacement of the "isolcpus" kernel boot parameter.

v4:
 - Further minimize the feature set by removing the flags control knob.

v3:
 - Further trim the additional features down to just memory_migrate.
 - Update Documentation/cgroup-v2.txt.

v7 patch: https://lkml.org/lkml/2018/4/19/448
v8 patch: https://lkml.org/lkml/2018/5/17/939
v9 patch: https://lkml.org/lkml/2018/5/29/507

The purpose of this patchset is to provide a basic set of cpuset control
files for cgroup v2. This basic set includes the non-root "cpus", "mems"
and "sched.domain_root". The "cpus.effective" and "mems.effective"
will appear in all cpuset-enabled cgroups.

The new control file that is unique to v2 is "sched.domain_root". It
is a boolean flag file that designates if a cgroup is the root of a new
scheduling domain or partition with its own set of unique list of CPUs
from scheduling perspective disjointed from other partitions. The root
cgroup is always a scheduling domain root. Multiple levels of scheduling
domains are supported with some limitations. So a container scheduling
domain root can behave like a real root.

When a scheduling domain root cgroup is removed, its list of exclusive
CPUs will be returned to the parent's cpus.effective automatically.

This patchset does not exclude the possibility of adding more features
in the future after careful consideration.

Patch 1 enables cpuset in cgroup v2 with cpus, mems and their effective
counterparts.

Patch 2 adds a new "sched.domain_root" control file for setting up
multiple scheduling domains or partitions. A scheduling domain root
implies cpu_exclusive.

Patch 3 handles the proper deletion of a domain root cgroup by turning
off the domain_root flag automatically before deletion.

Patch 4 allows "cpuset.cpus" of a domain root cgroup to be changed
subject to certain constraints.

Patch 5 makes the hotplug code deal with domain root properly.

Patch 6 updates the scheduling domain genaration code to work with
the new domain root feature.

Patch 7 exposes cpus.effective and mems.effective to the root cgroup as
enabling child scheduling domains will take CPUs away from the root cgroup.
So it will be nice to monitor what CPUs are left there.

Patch 8 eliminates the need to rebuild sched domains for v2 if cpu list
changes occur to non-domain root cpusets only.

Patch 9 enables the printing the debug information about scheduling
domain generation.

Waiman Long (9):
  cpuset: Enable cpuset controller in default hierarchy
  cpuset: Add new v2 cpuset.sched.domain_root flag
  cpuset: Simulate auto-off of sched.domain_root at cgroup removal
  cpuset: Allow changes to cpus in a domain root
  cpuset: Make sure that domain roots work properly with CPU hotplug
  cpuset: Make generate_sched_domains() recognize reserved_cpus
  cpuset: Expose cpus.effective and mems.effective on cgroup v2 root
  cpuset: Don't rebuild sched domains if cpu changes in non-domain root
  cpuset: Allow reporting of sched domain generation info

 Documentation/admin-guide/cgroup-v2.rst | 158 ++++++++++++-
 kernel/cgroup/cpuset.c                  | 406 ++++++++++++++++++++++++++++++--
 2 files changed, 543 insertions(+), 21 deletions(-)

-- 
1.8.3.1

