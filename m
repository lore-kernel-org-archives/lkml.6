Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CB7C6787F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC9A2148C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:56:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BC9A2148C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbeJMBaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 21:30:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35710 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727051AbeJMBaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 21:30:22 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D098080F7D;
        Fri, 12 Oct 2018 17:56:42 +0000 (UTC)
Received: from llong.com (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 268EC82779;
        Fri, 12 Oct 2018 17:56:41 +0000 (UTC)
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
Subject: [PATCH v13 10/11] cpuset: Add documentation about the new "cpuset.sched.partition" flag
Date:   Fri, 12 Oct 2018 13:55:50 -0400
Message-Id: <1539366951-8498-11-git-send-email-longman@redhat.com>
In-Reply-To: <1539366951-8498-1-git-send-email-longman@redhat.com>
References: <1539366951-8498-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 12 Oct 2018 17:56:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cgroup-v2.rst file is updated to document the purpose of the new
"cpuset.sched.partition" flag and how its usage.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 66 +++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 533e85c..178cda4 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1686,6 +1686,72 @@ Cpuset Interface Files
 
 	Its value will be affected by memory nodes hotplug events.
 
+  cpuset.sched.partition
+	A read-write single value file which exists on non-root
+	cpuset-enabled cgroups.  It accepts either "0" (off) or "1"
+	(on) when written to.  This flag is set and owned by the
+	parent cgroup.
+
+	If set, it indicates that the current cgroup is the root of a
+	new partition or scheduling domain that comprises itself and
+	all its descendants except those that are separate partition
+	roots themselves and their descendants.  The root cgroup is
+	always a partition root.
+
+	There are constraints on where this flag can be set.  It can
+	only be set in a cgroup if all the following conditions are true.
+
+	1) The "cpuset.cpus" is not empty and the list of CPUs are
+	   exclusive, i.e. they are not shared by any of its siblings.
+	2) The parent cgroup is a partition root.
+	3) The "cpuset.cpus" is also a proper subset of the parent's
+	   "cpuset.cpus.effective".
+	4) There is no child cgroups with cpuset enabled.  This is for
+	   eliminating corner cases that have to be handled if such a
+	   condition is allowed.
+
+	Setting this flag will take the CPUs away from the effective
+	CPUs of the parent cgroup.  Once it is set, this flag cannot
+	be cleared if there are any child cgroups with cpuset enabled.
+
+	A parent partition cannot distribute all its CPUs to its
+	child partitions.  There must be at least one cpu left in the
+	parent partition.
+
+	Once becoming a partition root, changes to "cpuset.cpus" is
+	generally allowed as long as the first condition above is true,
+	the change will not take away all the CPUs from the parent
+	partition and the new "cpuset.cpus" value is a superset of its
+	children's "cpuset.cpus" values.
+
+	Sometimes, external factors like changes to ancestors'
+	"cpuset.cpus" or cpu hotplug can cause the state of the partition
+	root to change.  On read, the "cpuset.sched.partition" file
+	can show the following values.
+
+	"0"  Not a partition root
+	"1"  Partition root
+	"-1" Erroneous partition root
+
+	It is a partition root if the first 2 partition root conditions
+	above are true and at least one CPU from "cpuset.cpus" is
+	granted by the parent cgroup.
+
+	A partition root can become an erroneous partition root if none
+	of CPUs requested in "cpuset.cpus" can be granted by the parent
+	cgroup or the parent cgroup is no longer a partition root.
+	In this case, it is not a real partition even though the
+	restriction of the first partition root condition above will
+	still apply.  All the tasks in the cgroup will be migrated to
+	the nearest ancestor partition.
+
+	An erroneous partition root can be transitioned back to a real
+	partition root if at least one of the requested CPUs can now be
+	granted by its parent.	In this case, the tasks will be migrated
+	back to the newly created partition.  Clearing the partition
+	flag of an erroneous partition root is always allowed even if
+	child cpusets are present.
+
 
 Device controller
 -----------------
-- 
1.8.3.1

