Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0360C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F76820855
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731309AbfA3OY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 09:24:59 -0500
Received: from mga04.intel.com ([192.55.52.120]:27017 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731004AbfA3OYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 09:24:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2019 06:24:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,540,1539673200"; 
   d="scan'208";a="271154279"
Received: from otc-lr-04.jf.intel.com ([10.54.39.129])
  by orsmga004.jf.intel.com with ESMTP; 30 Jan 2019 06:24:47 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, jolsa@redhat.com, namhyung@kernel.org,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 04/13] perf sort: Add sort option for data page size
Date:   Wed, 30 Jan 2019 06:23:45 -0800
Message-Id: <1548858234-8872-4-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548858234-8872-1-git-send-email-kan.liang@linux.intel.com>
References: <1548858234-8872-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Add a new sort option "data_page_size" for --mem-mode sort.  With this
option applied, perf can sort and report by sample's data page size.

Here is an example.
perf report --stdio --mem-mode
--sort=comm,symbol,phys_daddr,data_page_size

 # To display the perf.data header info, please use
 # --header/--header-only options.
 #
 #
 # Total Lost Samples: 0
 #
 # Samples: 9K of event 'mem-loads:uP'
 # Total weight : 9028
 # Sort order   : comm,symbol,phys_daddr,data_page_size
 #
 # Overhead  Command  Symbol                        Data Physical
 # Address
 # Data Page Size
 # ........  .......  ............................
 # ......................  ......................
 #
    11.19%  dtlb     [.] touch_buffer              [.]
0x00000003fec82ea8  4K
     8.61%  dtlb     [.] GetTickCount              [.]
0x00000003c4f2c8a8  4K
     4.52%  dtlb     [.] GetTickCount              [.]
0x00000003fec82f58  4K
     4.33%  dtlb     [.] __gettimeofday            [.]
0x00000003fec82f48  4K
     4.32%  dtlb     [.] GetTickCount              [.]
0x00000003fec82f78  4K
     4.28%  dtlb     [.] GetTickCount              [.]
0x00000003fec82f50  4K
     4.23%  dtlb     [.] GetTickCount              [.]
0x00000003fec82f70  4K
     4.11%  dtlb     [.] GetTickCount              [.]
0x00000003fec82f68  4K
     4.00%  dtlb     [.] Calibrate                 [.]
0x00000003fec82f98  4K
     3.91%  dtlb     [.] Calibrate                 [.]
0x00000003fec82f90  4K
     3.43%  dtlb     [.] touch_buffer              [.]
0x00000003fec82e98  4K
     3.42%  dtlb     [.] touch_buffer              [.]
0x00000003fec82e90  4K
     0.09%  dtlb     [.] DoDependentLoads          [.]
0x000000036ea084c0  2M
     0.08%  dtlb     [.] DoDependentLoads          [.]
0x000000032b010b80  2M

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

No changes since V1

 tools/perf/Documentation/perf-report.txt |  1 +
 tools/perf/util/hist.c                   |  3 +++
 tools/perf/util/hist.h                   |  1 +
 tools/perf/util/machine.c                |  7 +++++--
 tools/perf/util/sort.c                   | 28 ++++++++++++++++++++++++++++
 tools/perf/util/sort.h                   |  1 +
 tools/perf/util/symbol.h                 |  1 +
 7 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 1a27bfe..2ca0477 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -147,6 +147,7 @@ OPTIONS
 	- snoop: type of snoop (if any) for the data at the time of the sample
 	- dcacheline: the cacheline the data address is on at the time of the sample
 	- phys_daddr: physical address of data being executed on at the time of sample
+	- data_page_size: the data page size of data being executed on at the time of sample
 
 	And the default sort keys are changed to local_weight, mem, sym, dso,
 	symbol_daddr, dso_daddr, snoop, tlb, locked, see '--mem-mode'.
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 9e7a8e0..253bf3f 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -174,6 +174,9 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
 		hists__new_col_len(hists, HISTC_MEM_PHYS_DADDR,
 				   unresolved_col_width + 4 + 2);
 
+		hists__new_col_len(hists, HISTC_MEM_DATA_PAGE_SIZE,
+				   unresolved_col_width + 4 + 2);
+
 	} else {
 		symlen = unresolved_col_width + 4 + 2;
 		hists__new_col_len(hists, HISTC_MEM_DADDR_SYMBOL, symlen);
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 08267af..2b72d03 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -49,6 +49,7 @@ enum hist_column {
 	HISTC_MEM_DADDR_SYMBOL,
 	HISTC_MEM_DADDR_DSO,
 	HISTC_MEM_PHYS_DADDR,
+	HISTC_MEM_DATA_PAGE_SIZE,
 	HISTC_MEM_LOCKED,
 	HISTC_MEM_TLB,
 	HISTC_MEM_LVL,
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 66f019f..00dc249 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1914,11 +1914,12 @@ static void ip__resolve_ams(struct thread *thread,
 	ams->sym = al.sym;
 	ams->map = al.map;
 	ams->phys_addr = 0;
+	ams->data_page_size = PERF_PAGE_SIZE_NONE;
 }
 
 static void ip__resolve_data(struct thread *thread,
 			     u8 m, struct addr_map_symbol *ams,
-			     u64 addr, u64 phys_addr)
+			     u64 addr, u64 phys_addr, u64 daddr_page_size)
 {
 	struct addr_location al;
 
@@ -1931,6 +1932,7 @@ static void ip__resolve_data(struct thread *thread,
 	ams->sym = al.sym;
 	ams->map = al.map;
 	ams->phys_addr = phys_addr;
+	ams->data_page_size = daddr_page_size;
 }
 
 struct mem_info *sample__resolve_mem(struct perf_sample *sample,
@@ -1943,7 +1945,8 @@ struct mem_info *sample__resolve_mem(struct perf_sample *sample,
 
 	ip__resolve_ams(al->thread, &mi->iaddr, sample->ip);
 	ip__resolve_data(al->thread, al->cpumode, &mi->daddr,
-			 sample->addr, sample->phys_addr);
+			 sample->addr, sample->phys_addr,
+			 sample->data_page_size);
 	mi->data_src.val = sample->data_src;
 
 	return mi;
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 6c1a837..93d1391 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -1393,6 +1393,33 @@ struct sort_entry sort_mem_phys_daddr = {
 };
 
 static int64_t
+sort__data_page_size_cmp(struct hist_entry *left, struct hist_entry *right)
+{
+	uint64_t l = 0, r = 0;
+
+	if (left->mem_info)
+		l = left->mem_info->daddr.data_page_size;
+	if (right->mem_info)
+		r = right->mem_info->daddr.data_page_size;
+
+	return (int64_t)(r - l);
+}
+
+static int hist_entry__data_page_size_snprintf(struct hist_entry *he, char *bf,
+					  size_t size, unsigned int width)
+{
+	return repsep_snprintf(bf, size, "%-*s", width,
+			       get_page_size_name(he->mem_info->daddr.data_page_size));
+}
+
+struct sort_entry sort_mem_data_page_size = {
+	.se_header	= "Data Page Size",
+	.se_cmp		= sort__data_page_size_cmp,
+	.se_snprintf	= hist_entry__data_page_size_snprintf,
+	.se_width_idx	= HISTC_MEM_DATA_PAGE_SIZE,
+};
+
+static int64_t
 sort__abort_cmp(struct hist_entry *left, struct hist_entry *right)
 {
 	if (!left->branch_info || !right->branch_info)
@@ -1668,6 +1695,7 @@ static struct sort_dimension memory_sort_dimensions[] = {
 	DIM(SORT_MEM_SNOOP, "snoop", sort_mem_snoop),
 	DIM(SORT_MEM_DCACHELINE, "dcacheline", sort_mem_dcacheline),
 	DIM(SORT_MEM_PHYS_DADDR, "phys_daddr", sort_mem_phys_daddr),
+	DIM(SORT_MEM_DATA_PAGE_SIZE, "data_page_size", sort_mem_data_page_size),
 };
 
 #undef DIM
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index dd63128..2e324ae 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -256,6 +256,7 @@ enum sort_type {
 	SORT_MEM_DCACHELINE,
 	SORT_MEM_IADDR_SYMBOL,
 	SORT_MEM_PHYS_DADDR,
+	SORT_MEM_DATA_PAGE_SIZE,
 };
 
 /*
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 56e2bcb..3c563ab 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -126,6 +126,7 @@ struct addr_map_symbol {
 	u64	      addr;
 	u64	      al_addr;
 	u64	      phys_addr;
+	u64	      data_page_size;
 };
 
 struct branch_info {
-- 
2.7.4

