Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4C3C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37FC32089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HB0yXc00"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37FC32089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbeJQBGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:06:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:50906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727182AbeJQBGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:06:49 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B66021477;
        Tue, 16 Oct 2018 17:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710125;
        bh=pNBxDeVaKIyrFW9XXQfDUV7ivicg1gRoXwQ9z235+Lw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HB0yXc006a4mEiggq0+z+W+BZI7cBSySfdsK5fKh00P8kkoJzix7xmJ/2/ZIooW5b
         MsQTVCy5ojwPv94svAVa/fLlcuPC1B8faqwxy70Jts/icx/IPAP9KdlEqmLNU6lVyp
         sCtJkQgTBFDpWR5e1nlGAH7LftzlIPwPI1qs0xGQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Rik van Riel <riel@surriel.com>, Josef Bacik <jbacik@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 109/135] mm: slowly shrink slabs with a relatively small number of objects
Date:   Tue, 16 Oct 2018 19:05:39 +0200
Message-Id: <20181016170522.866058144@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/vmscan.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -386,6 +386,17 @@ static unsigned long do_shrink_slab(stru
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


