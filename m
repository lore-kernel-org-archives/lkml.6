Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752756AbeCEOet (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 09:34:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:53084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752681AbeCEOav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 09:30:51 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F23821770
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 15/28] perf kvm: Switch to new perf_mmap__read_event() interface
Date: Mon,  5 Mar 2018 11:29:19 -0300
Message-Id: <20180305142932.16921-16-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180305142932.16921-1-acme@kernel.org>
References: <20180305142932.16921-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The perf kvm still use the legacy interface.

Switch to the new perf_mmap__read_event() interface for perf kvm.

No functional change.

Committer notes:

Tested before and after running:

  # perf kvm stat record

On a machine with a kvm guest, then used:

  # perf kvm stat report

Before/after results match and look like:

  # perf kvm stat record -a sleep 5
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 2.132 MB perf.data.guest (1828 samples) ]
  # perf kvm stat report

  Analyze events for all VMs, all VCPUs:

             VM-EXIT Samples Samples%  Time% Min Time    Max Time    Avg time

      IO_INSTRUCTION     258   40.06%  0.08%   3.51us    122.54us     14.87us (+- 6.76%)
           MSR_WRITE     178   27.64%  0.01%   0.47us      6.34us      2.18us (+- 4.80%)
       EPT_MISCONFIG     148   22.98%  0.03%   3.76us     65.60us     11.22us (+- 8.14%)
                 HLT      47    7.30% 99.88% 181.69us 249988.06us 102061.36us (+-13.49%)
   PAUSE_INSTRUCTION       5    0.78%  0.00%   0.38us      0.79us      0.47us (+-17.05%)
            MSR_READ       4    0.62%  0.00%   1.14us      3.33us      2.67us (+-19.35%)
  EXTERNAL_INTERRUPT       2    0.31%  0.00%   2.15us      2.17us      2.16us (+- 0.30%)
   PENDING_INTERRUPT       1    0.16%  0.00%   2.56us      2.56us      2.56us (+- 0.00%)
    PREEMPTION_TIMER       1    0.16%  0.00%   3.21us      3.21us      3.21us (+- 0.00%)

  Total Samples:644, Total events handled time:4802790.72us.

  #

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1519945751-37786-1-git-send-email-kan.liang@linux.intel.com
[ Changed bool parameters from 0 to 'false', as per Jiri comment ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-kvm.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 55d919dc5bc6..d2703d3b8366 100644
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
+	err = perf_mmap__read_init(md, false, &start, &end);
+	if (err < 0)
+		return (err == -EAGAIN) ? 0 : -1;
+
+	while ((event = perf_mmap__read_event(md, false, &start, end)) != NULL) {
+		err = perf_evlist__parse_sample_timestamp(evlist, event, &timestamp);
 		if (err) {
-			perf_evlist__mmap_consume(kvm->evlist, idx);
+			perf_mmap__consume(md, false);
 			pr_err("Failed to parse sample\n");
 			return -1;
 		}
@@ -762,7 +770,7 @@ static s64 perf_kvm__mmap_read_idx(struct perf_kvm_stat *kvm, int idx,
 		 * FIXME: Here we can't consume the event, as perf_session__queue_event will
 		 *        point to it, and it'll get possibly overwritten by the kernel.
 		 */
-		perf_evlist__mmap_consume(kvm->evlist, idx);
+		perf_mmap__consume(md, false);
 
 		if (err) {
 			pr_err("Failed to enqueue sample: %d\n", err);
@@ -779,6 +787,7 @@ static s64 perf_kvm__mmap_read_idx(struct perf_kvm_stat *kvm, int idx,
 			break;
 	}
 
+	perf_mmap__read_done(md);
 	return n;
 }
 
-- 
2.14.3
