Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936887AbeE2CoC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 22:44:02 -0400
Received: from mail-qk0-f201.google.com ([209.85.220.201]:37538 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932498AbeE2Cn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 22:43:58 -0400
X-Google-Smtp-Source: ADUXVKKhasWRMO53OomcShIZum8mluW7W3M4S7nFal5Kt7MoAZlTOmnETanznHV8SJ1Yoqp8u+892uTdz7ca
MIME-Version: 1.0
Date: Mon, 28 May 2018 19:40:25 -0700
Message-Id: <20180529024025.58353-1-gthelen@google.com>
X-Mailer: git-send-email 2.17.0.921.gf22659ad46-goog
Subject: [PATCH] mm: convert scan_control.priority int => byte
From: Greg Thelen <gthelen@google.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reclaim priorities range from 0..12(DEF_PRIORITY).
scan_control.priority is a 4 byte int, which is overkill.

Since commit 6538b8ea886e ("x86_64: expand kernel stack to 16K") x86_64
stack overflows are not an issue.  But it's inefficient to use 4 bytes
for priority.

Use s8 (signed byte) rather than u8 to allow for loops like:
	do {
		...
	} while (--sc.priority >= 0);

This reduces sizeof(struct scan_control) from 96 => 88 bytes (x86_64),
which saves some stack.

scan_control.priority field order is changed to occupy otherwise unused
padding.

Signed-off-by: Greg Thelen <gthelen@google.com>
---
 mm/vmscan.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 9b697323a88c..541c334bd176 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -83,9 +83,6 @@ struct scan_control {
 	 */
 	struct mem_cgroup *target_mem_cgroup;
 
-	/* Scan (total_size >> priority) pages at once */
-	int priority;
-
 	/* The highest zone to isolate pages for reclaim from */
 	enum zone_type reclaim_idx;
 
@@ -111,6 +108,9 @@ struct scan_control {
 	/* One of the zones is ready for compaction */
 	unsigned int compaction_ready:1;
 
+	/* Scan (total_size >> priority) pages at once */
+	s8 priority;
+
 	/* Incremented by the number of inactive pages that were scanned */
 	unsigned long nr_scanned;
 
-- 
2.17.0.921.gf22659ad46-goog
