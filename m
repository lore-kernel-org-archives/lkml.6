Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752901AbeEGURA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 16:17:00 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36689 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752081AbeEGUQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 16:16:58 -0400
X-Google-Smtp-Source: AB8JxZrjeNtyydkZCKZJ0DGYxw2qebuHIwIatNBHR0r0GXnYhks7qqb/DG9uA+xvIvJmfJ6s9irOBg==
From: Shakeel Butt <shakeelb@google.com>
To: Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Linux MM <linux-mm@kvack.org>, Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Junaid Shahid <junaids@google.com>, Junaid Shahid <juanids@google.com>,
        Shakeel Butt <shakeelb@google.com>
Subject: [PATCH] mm: memcontrol: drain memcg stock on force_empty
Date: Mon,  7 May 2018 13:16:51 -0700
Message-Id: <20180507201651.165879-1-shakeelb@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Junaid Shahid <junaids@google.com>

The per-cpu memcg stock can retain a charge of upto 32 pages. On a
machine with large number of cpus, this can amount to a decent amount
of memory. Additionally force_empty interface might be triggering
unneeded memcg reclaims.

Signed-off-by: Junaid Shahid <juanids@google.com>
Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 mm/memcontrol.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e2d33a37f971..2c3c69524b49 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2841,6 +2841,9 @@ static int mem_cgroup_force_empty(struct mem_cgroup *memcg)
 
 	/* we call try-to-free pages for make this cgroup empty */
 	lru_add_drain_all();
+
+	drain_all_stock(memcg);
+
 	/* try to free all pages in this cgroup */
 	while (nr_retries && page_counter_read(&memcg->memory)) {
 		int progress;
-- 
2.17.0.441.gb46fe60e1d-goog
