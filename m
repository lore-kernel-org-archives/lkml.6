Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEFFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E570A2192C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="0GgY+/ly"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388793AbfBOSOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 13:14:49 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:37019 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731930AbfBOSOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 13:14:39 -0500
Received: by mail-yw1-f67.google.com with SMTP id k14so4045286ywe.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 10:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VwVlGm18jJ9MvrZQxMUmMoYva3opswVp+UNaldGjONU=;
        b=0GgY+/lyZgElU35qV0NY61NN6hK+ek8EPJ3kLmflCoskr0PqbHkKUWeEIn+moimd23
         iO5cQdlDPZuB/VYeXSIVCt4gZASOIW2xhSpKnyI10nZeQEq69hwlkfUY3Nf1uyGA7koP
         8QCFrkw2XDm8Fw7urfaRmBiZbXWz5YtHI60ox1sBg95RjpK6bqKhDo01fCyu+ABeMqP4
         2V8yrChKQwZp0dR+oMK9As8ZBefzQf+A/1BskTWmeqoNINjJpUf1KRCbTrcR7Zsol8MV
         Oc6NjARafUnZxtzcX0pP8N4iTNychzLH518/RqvPLqpxeu+JY57k2WvlznoitRvG8mwm
         M1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VwVlGm18jJ9MvrZQxMUmMoYva3opswVp+UNaldGjONU=;
        b=nwORGJQwXcB40xL7a33fgBY7x2qOc9xopUKmDcckEm7yAcEWP20XPXV8/TpawUDfNI
         fnmBWXcDkDTby0EHB7prsSVqx+6TkoohFgwZGBIm7NULkUR7WasVhH8lpTnzC5oTAcy2
         MyfrhJfLB9wykYp19MVNVQdI6ry8du2dOVWDpa/G2m3c3UOmNlymvPtoSSewO+jcgWsZ
         eA3ivCRyYhmDZ8P2S2e4O1EoVpALDAhR2mt9avhk593VYCEtXgZWGxKsY/O832NvSFFf
         cBeIDuH3rE0JSflvUxtSymqBa9tGLU2DEniHv6S0cTbnj2dRctOitWplC4/i33v0Miq5
         MsLA==
X-Gm-Message-State: AHQUAuYrioysRkr7uA18tNlFjlEWQM5Hs+3y+E4lcif6EFXIHyb27zjC
        LZjL79I/6lkA5inalv1FvVukNw==
X-Google-Smtp-Source: AHgI3IYcRe3wIW9kBX8bDCesOGs4eqG5QEdDUrT6bTq55lNHWHcECKieUpmkkWiYe9mLdhGBtSpYsQ==
X-Received: by 2002:a81:8147:: with SMTP id r68mr8592233ywf.89.1550254478063;
        Fri, 15 Feb 2019 10:14:38 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::4:33c1])
        by smtp.gmail.com with ESMTPSA id 77sm2282676ywr.19.2019.02.15.10.14.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 10:14:37 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 5/6] mm: memcontrol: push down mem_cgroup_nr_lru_pages()
Date:   Fri, 15 Feb 2019 13:14:24 -0500
Message-Id: <20190215181425.32624-6-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190215181425.32624-1-hannes@cmpxchg.org>
References: <20190215181425.32624-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mem_cgroup_nr_lru_pages() is just a convenience wrapper around
memcg_page_state() that takes bitmasks of lru indexes and aggregates
the counts for those.

Replace callsites where the bitmask is simple enough with direct
memcg_page_state() call(s).

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 73eb8333bc73..6d0c3374669f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1354,7 +1354,7 @@ void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
 
 		for (i = 0; i < NR_LRU_LISTS; i++)
 			pr_cont(" %s:%luKB", mem_cgroup_lru_names[i],
-				K(mem_cgroup_nr_lru_pages(iter, BIT(i))));
+				K(memcg_page_state(iter, NR_LRU_BASE + i)));
 
 		pr_cont("\n");
 	}
@@ -2987,8 +2987,8 @@ static void accumulate_memcg_tree(struct mem_cgroup *memcg,
 				acc->events_array ? acc->events_array[i] : i);
 
 		for (i = 0; i < NR_LRU_LISTS; i++)
-			acc->lru_pages[i] +=
-				mem_cgroup_nr_lru_pages(mi, BIT(i));
+			acc->lru_pages[i] += memcg_page_state(mi,
+							      NR_LRU_BASE + i);
 	}
 }
 
@@ -3418,7 +3418,8 @@ static int memcg_stat_show(struct seq_file *m, void *v)
 
 	for (i = 0; i < NR_LRU_LISTS; i++)
 		seq_printf(m, "%s %lu\n", mem_cgroup_lru_names[i],
-			   mem_cgroup_nr_lru_pages(memcg, BIT(i)) * PAGE_SIZE);
+			   memcg_page_state(memcg, NR_LRU_BASE + i) *
+			   PAGE_SIZE);
 
 	/* Hierarchical information */
 	memory = memsw = PAGE_COUNTER_MAX;
@@ -3909,8 +3910,8 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
 
 	/* this should eventually include NR_UNSTABLE_NFS */
 	*pwriteback = memcg_page_state(memcg, NR_WRITEBACK);
-	*pfilepages = mem_cgroup_nr_lru_pages(memcg, (1 << LRU_INACTIVE_FILE) |
-						     (1 << LRU_ACTIVE_FILE));
+	*pfilepages = memcg_page_state(memcg, NR_INACTIVE_FILE) +
+		memcg_page_state(memcg, NR_ACTIVE_FILE);
 	*pheadroom = PAGE_COUNTER_MAX;
 
 	while ((parent = parent_mem_cgroup(memcg))) {
-- 
2.20.1

