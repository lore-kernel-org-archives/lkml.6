Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8B6C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B48DB213A2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5Pd3M9Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B48DB213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729726AbeJEXOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:14:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:52300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729628AbeJEXOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:14:32 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC2942147D;
        Fri,  5 Oct 2018 16:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538756109;
        bh=xKQ2C+xtu+1brtcVOciBSrzg6yL4rLR8R353JRRlsas=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E5Pd3M9QwYxCwIgfiYxGnppVczP27NKl/JZ902zp7XgGrre1eHMWJHp9V/ehQyKbr
         G6v/sCZck5pc4RF2koAlib71ynFBIiEPKOc3i82V5B+RzrsInhpSgePs77d4iXbJhn
         dsav6mt0aIgKAYejGexP4WOB5iz2K88EuM8PLdBU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Roman Gushchin <guro@fb.com>, Josef Bacik <jbacik@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 48/48] mm: slowly shrink slabs with a relatively small number of objects
Date:   Fri,  5 Oct 2018 12:14:24 -0400
Message-Id: <20181005161424.20521-48-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005161424.20521-1-sashal@kernel.org>
References: <20181005161424.20521-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Gushchin <guro@fb.com>

[ Upstream commit 172b06c32b949759fe6313abec514bc4f15014f4 ]

9092c71bb724 ("mm: use sc->priority for slab shrink targets") changed the
way that the target slab pressure is calculated and made it
priority-based:

    delta = freeable >> priority;
    delta *= 4;
    do_div(delta, shrinker->seeks);

The problem is that on a default priority (which is 12) no pressure is
applied at all, if the number of potentially reclaimable objects is less
than 4096 (1<<12).

This causes the last objects on slab caches of no longer used cgroups to
(almost) never get reclaimed.  It's obviously a waste of memory.

It can be especially painful, if these stale objects are holding a
reference to a dying cgroup.  Slab LRU lists are reparented on memcg
offlining, but corresponding objects are still holding a reference to the
dying cgroup.  If we don't scan these objects, the dying cgroup can't go
away.  Most likely, the parent cgroup hasn't any directly charged objects,
only remaining objects from dying children cgroups.  So it can easily hold
a reference to hundreds of dying cgroups.

If there are no big spikes in memory pressure, and new memory cgroups are
created and destroyed periodically, this causes the number of dying
cgroups grow steadily, causing a slow-ish and hard-to-detect memory
"leak".  It's not a real leak, as the memory can be eventually reclaimed,
but it could not happen in a real life at all.  I've seen hosts with a
steadily climbing number of dying cgroups, which doesn't show any signs of
a decline in months, despite the host is loaded with a production
workload.

It is an obvious waste of memory, and to prevent it, let's apply a minimal
pressure even on small shrinker lists.  E.g.  if there are freeable
objects, let's scan at least min(freeable, scan_batch) objects.

This fix significantly improves a chance of a dying cgroup to be
reclaimed, and together with some previous patches stops the steady growth
of the dying cgroups number on some of our hosts.

Link: http://lkml.kernel.org/r/20180905230759.12236-1-guro@fb.com
Fixes: 9092c71bb724 ("mm: use sc->priority for slab shrink targets")
Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Rik van Riel <riel@surriel.com>
Cc: Josef Bacik <jbacik@fb.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 mm/vmscan.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 03822f86f288..fc0436407471 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -386,6 +386,17 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	delta = freeable >> priority;
 	delta *= 4;
 	do_div(delta, shrinker->seeks);
+
+	/*
+	 * Make sure we apply some minimal pressure on default priority
+	 * even on small cgroups. Stale objects are not only consuming memory
+	 * by themselves, but can also hold a reference to a dying cgroup,
+	 * preventing it from being reclaimed. A dying cgroup with all
+	 * corresponding structures like per-cpu stats and kmem caches
+	 * can be really big, so it may lead to a significant waste of memory.
+	 */
+	delta = max_t(unsigned long long, delta, min(freeable, batch_size));
+
 	total_scan += delta;
 	if (total_scan < 0) {
 		pr_err("shrink_slab: %pF negative objects to delete nr=%ld\n",
-- 
2.17.1

