Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162860AbeCAXJx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 18:09:53 -0500
Received: from mga04.intel.com ([192.55.52.120]:30247 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162810AbeCAXJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 18:09:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,409,1515484800";
   d="scan'208";a="208164980"
From: kan.liang@linux.intel.com
To: acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc: jolsa@redhat.com, namhyung@kernel.org, wangnan0@huawei.com,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 01/14] perf kvm: Apply new perf_mmap__read_event() interface
Date: Thu,  1 Mar 2018 18:08:58 -0500
Message-Id: <1519945751-37786-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.4.11
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The perf kvm still use the legacy interface.

Apply the new perf_mmap__read_event() interface for perf kvm.
No functional change.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/builtin-kvm.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 55d919d..cc2b680 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -743,16 +743,24 @@ static bool verify_vcpu(int vcpu)
 static s64 perf_kvm__mmap_read_idx(struct perf_kvm_stat *kvm, int idx,
 				   u64 *mmap_time)
 {
+	struct perf_evlist *evlist = kvm->evlist;
 	union perf_event *event;
+	struct perf_mmap *md;
+	u64 end, start;
 	u64 timestamp;
 	s64 n = 0;
 	int err;
 
 	*mmap_time = ULLONG_MAX;
-	while ((event = perf_evlist__mmap_read(kvm->evlist, idx)) != NULL) {
-		err = perf_evlist__parse_sample_timestamp(kvm->evlist, event, &timestamp);
+	md = &evlist->mmap[idx];
+	err = perf_mmap__read_init(md, 0, &start, &end);
+	if (err < 0)
+		return (err == -EAGAIN) ? 0 : -1;
+
+	while ((event = perf_mmap__read_event(md, 0, &start, end)) != NULL) {
+		err = perf_evlist__parse_sample_timestamp(evlist, event, &timestamp);
 		if (err) {
-			perf_evlist__mmap_consume(kvm->evlist, idx);
+			perf_mmap__consume(md, 0);
 			pr_err("Failed to parse sample\n");
 			return -1;
 		}
@@ -762,7 +770,7 @@ static s64 perf_kvm__mmap_read_idx(struct perf_kvm_stat *kvm, int idx,
 		 * FIXME: Here we can't consume the event, as perf_session__queue_event will
 		 *        point to it, and it'll get possibly overwritten by the kernel.
 		 */
-		perf_evlist__mmap_consume(kvm->evlist, idx);
+		perf_mmap__consume(md, 0);
 
 		if (err) {
 			pr_err("Failed to enqueue sample: %d\n", err);
@@ -779,6 +787,7 @@ static s64 perf_kvm__mmap_read_idx(struct perf_kvm_stat *kvm, int idx,
 			break;
 	}
 
+	perf_mmap__read_done(md);
 	return n;
 }
 
-- 
2.4.11
