Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753188AbeCFGrT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 01:47:19 -0500
Received: from terminus.zytor.com ([198.137.202.136]:35341 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750837AbeCFGrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 01:47:17 -0500
Date: Mon, 5 Mar 2018 22:47:06 -0800
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-53172f9057e92c9b27f0bbf2a46827d87f12b0d2@git.kernel.org>
Cc: acme@redhat.com, kan.liang@linux.intel.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, jolsa@redhat.com,
        namhyung@kernel.org, tglx@linutronix.de, ak@linux.intel.com,
        wangnan0@huawei.com
Reply-To: wangnan0@huawei.com, tglx@linutronix.de, namhyung@kernel.org,
        ak@linux.intel.com, hpa@zytor.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, acme@redhat.com,
        kan.liang@linux.intel.com, mingo@kernel.org
In-Reply-To: <1519945751-37786-1-git-send-email-kan.liang@linux.intel.com>
References: <1519945751-37786-1-git-send-email-kan.liang@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf kvm: Switch to new perf_mmap__read_event()
 interface
Git-Commit-ID: 53172f9057e92c9b27f0bbf2a46827d87f12b0d2
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  53172f9057e92c9b27f0bbf2a46827d87f12b0d2
Gitweb:     https://git.kernel.org/tip/53172f9057e92c9b27f0bbf2a46827d87f12b0d2
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Thu, 1 Mar 2018 18:08:58 -0500
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 5 Mar 2018 10:41:36 -0300

perf kvm: Switch to new perf_mmap__read_event() interface

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
 
