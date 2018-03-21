Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752639AbeCUCai (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 22:30:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:44956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751501AbeCUCVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 22:21:24 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D83D217D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180321022123.412991729@goodmis.org>
User-Agent: quilt/0.63-1
Date: Tue, 20 Mar 2018 22:20:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vedang Patel <vedang.patel@intel.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [for-next][PATCH 03/46] tracing: Add support to detect and avoid duplicates
References: <20180321022052.030055576@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0003-tracing-Add-support-to-detect-and-avoid-duplicates.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vedang Patel <vedang.patel@intel.com>

A duplicate in the tracing_map hash table is when 2 different entries
have the same key and, as a result, the key_hash. This is possible due
to a race condition in the algorithm. This race condition is inherent to
the algorithm and not a bug. This was fine because, until now, we were
only interested in the sum of all the values related to a particular
key (the duplicates are dealt with in tracing_map_sort_entries()). But,
with the inclusion of variables[1], we are interested in individual
values. So, it will not be clear what value to choose when
there are duplicates. So, the duplicates need to be removed.

The duplicates can occur in the code in the following scenarios:

- A thread is in the process of adding a new element. It has
successfully executed cmpxchg() and inserted the key. But, it is still
not done acquiring the trace_map_elt struct, populating it and storing
the pointer to the struct in the value field of tracing_map hash table.
If another thread comes in at this time and wants to add an element with
the same key, it will not see the current element and add a new one.

- There are multiple threads trying to execute cmpxchg at the same time,
one of the threads will succeed and the others will fail. The ones which
fail will go ahead increment 'idx' and add a new element there creating
a duplicate.

This patch detects and avoids the first condition by asking the thread
which detects the duplicate to loop one more time. There is also a
possibility of infinite loop if the thread which is trying to insert
goes to sleep indefinitely and the one which is trying to insert a new
element detects a duplicate. Which is why, the thread loops for
map_size iterations before returning NULL.

The second scenario is avoided by preventing the threads which failed
cmpxchg() from incrementing idx. This way, they will loop
around and check if the thread which succeeded in executing cmpxchg()
had the same key.

[1] http://lkml.kernel.org/r/cover.1498510759.git.tom.zanussi@linux.intel.com

Link: http://lkml.kernel.org/r/e178e89ec399240331d383bd5913d649713110f4.1516069914.git.tom.zanussi@linux.intel.com

Signed-off-by: Vedang Patel <vedang.patel@intel.com>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/tracing_map.c | 41 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
index 07e75344725b..b30f3439f27f 100644
--- a/kernel/trace/tracing_map.c
+++ b/kernel/trace/tracing_map.c
@@ -414,7 +414,9 @@ static inline struct tracing_map_elt *
 __tracing_map_insert(struct tracing_map *map, void *key, bool lookup_only)
 {
 	u32 idx, key_hash, test_key;
+	int dup_try = 0;
 	struct tracing_map_entry *entry;
+	struct tracing_map_elt *val;
 
 	key_hash = jhash(key, map->key_size, 0);
 	if (key_hash == 0)
@@ -426,11 +428,33 @@ __tracing_map_insert(struct tracing_map *map, void *key, bool lookup_only)
 		entry = TRACING_MAP_ENTRY(map->map, idx);
 		test_key = entry->key;
 
-		if (test_key && test_key == key_hash && entry->val &&
-		    keys_match(key, entry->val->key, map->key_size)) {
-			if (!lookup_only)
-				atomic64_inc(&map->hits);
-			return entry->val;
+		if (test_key && test_key == key_hash) {
+			val = READ_ONCE(entry->val);
+			if (val &&
+			    keys_match(key, val->key, map->key_size)) {
+				if (!lookup_only)
+					atomic64_inc(&map->hits);
+				return val;
+			} else if (unlikely(!val)) {
+				/*
+				 * The key is present. But, val (pointer to elt
+				 * struct) is still NULL. which means some other
+				 * thread is in the process of inserting an
+				 * element.
+				 *
+				 * On top of that, it's key_hash is same as the
+				 * one being inserted right now. So, it's
+				 * possible that the element has the same
+				 * key as well.
+				 */
+
+				dup_try++;
+				if (dup_try > map->map_size) {
+					atomic64_inc(&map->drops);
+					break;
+				}
+				continue;
+			}
 		}
 
 		if (!test_key) {
@@ -452,6 +476,13 @@ __tracing_map_insert(struct tracing_map *map, void *key, bool lookup_only)
 				atomic64_inc(&map->hits);
 
 				return entry->val;
+			} else {
+				/*
+				 * cmpxchg() failed. Loop around once
+				 * more to check what key was inserted.
+				 */
+				dup_try++;
+				continue;
 			}
 		}
 
-- 
2.15.1
