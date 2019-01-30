Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D284C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C5120882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731223AbfA3OYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 09:24:54 -0500
Received: from mga04.intel.com ([192.55.52.120]:27023 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbfA3OYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 09:24:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2019 06:24:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,540,1539673200"; 
   d="scan'208";a="271154289"
Received: from otc-lr-04.jf.intel.com ([10.54.39.129])
  by orsmga004.jf.intel.com with ESMTP; 30 Jan 2019 06:24:52 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, jolsa@redhat.com, namhyung@kernel.org,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 07/13] perf mem: Support data page size
Date:   Wed, 30 Jan 2019 06:23:48 -0800
Message-Id: <1548858234-8872-7-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548858234-8872-1-git-send-email-kan.liang@linux.intel.com>
References: <1548858234-8872-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Add option --data-page-size in "perf mem" to record/report data page
size.

Here are some examples.
perf mem --phys-data --data-page-size report -D

 # PID, TID, IP, ADDR, PHYS ADDR, DATA PAGE SIZE, LOCAL WEIGHT, DSRC,
 # SYMBOL
20134 20134 0xffffffffb5bd2fd0 0x016ffff9a274e96a308 0x000000044e96a308
4K  1168 0x5080144
/lib/modules/4.18.0-rc7+/build/vmlinux:perf_ctx_unlock
20134 20134 0xffffffffb63f645c 0xffffffffb752b814 0xcfb52b814 2M 225
0x26a100142 /lib/modules/4.18.0-rc7+/build/vmlinux:_raw_spin_lock
20134 20134 0xffffffffb660300c 0xfffffe00016b8bb0 0x0 4K 0 0x5080144
/lib/modules/4.18.0-rc7+/build/vmlinux:__x86_indirect_thunk_rax

perf mem --phys-data --data-page-size report --stdio

 # To display the perf.data header info, please use
 # --header/--header-only options.
 #
 #
 # Total Lost Samples: 0
 #
 # Samples: 5K of event 'cpu/mem-loads,ldlat=30/P'
 # Total weight : 281234
 # Sort order   :
 # mem,sym,dso,symbol_daddr,dso_daddr,tlb,locked,phys_daddr,data_page_size
 #
 # Overhead       Samples  Memory access             Symbol
 # Shared Object     Data Symbol                                  Data
 # Object              TLB access              Locked  Data Physical
 # Address   Data Page Size
 # ........  ............  ........................
 # ................................  ................
 # ...........................................  .......................
 # ......................  ......  ......................
 # ......................
 #
    28.54%          1826  L1 or L1 hit              [k]
__x86_indirect_thunk_rax      [kernel.vmlinux]  [k] 0xffffb0df31b0ff28
[unknown]                L1 or L2 hit            No      [k]
0000000000000000    4K
     6.02%           256  L1 or L1 hit              [.] touch_buffer
dtlb              [.] 0x00007ffd50109da8                       [stack]
L1 or L2 hit            No      [.] 0x000000042454ada8  4K
     3.23%             5  L1 or L1 hit              [k] clear_huge_page
[kernel.vmlinux]  [k] 0xffff9a2753b8ce60                       [unknown]
L1 or L2 hit            No      [k] 0x0000000453b8ce60  2M
     2.98%             4  L1 or L1 hit              [k] clear_page_erms
[kernel.vmlinux]  [k] 0xffffb0df31b0fd00                       [unknown]
L1 or L2 hit            No      [k] 0000000000000000    4K

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

changes since V2:
- Update has_extra_options 

 tools/perf/Documentation/perf-mem.txt |  3 +++
 tools/perf/builtin-mem.c              | 19 ++++++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-mem.txt b/tools/perf/Documentation/perf-mem.txt
index f8d2167..9110692 100644
--- a/tools/perf/Documentation/perf-mem.txt
+++ b/tools/perf/Documentation/perf-mem.txt
@@ -63,6 +63,9 @@ OPTIONS
 --phys-data::
 	Record/Report sample physical addresses
 
+--data-page-size::
+	Record/Report sample data address page size
+
 RECORD OPTIONS
 --------------
 -e::
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 24acc2a..efe669f 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -25,6 +25,7 @@ struct perf_mem {
 	bool			dump_raw;
 	bool			force;
 	bool			phys_addr;
+	bool			data_page_size;
 	int			operation;
 	const char		*cpu_list;
 	DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
@@ -106,6 +107,9 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
 	if (mem->phys_addr)
 		rec_argv[i++] = "--phys-data";
 
+	if (mem->data_page_size)
+		rec_argv[i++] = "--data-page-size";
+
 	for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
 		if (!perf_mem_events[j].record)
 			continue;
@@ -190,6 +194,12 @@ dump_raw_samples(struct perf_tool *tool,
 			symbol_conf.field_sep);
 	}
 
+	if (mem->data_page_size) {
+		printf("%s%s",
+			get_page_size_name(sample->data_page_size),
+			symbol_conf.field_sep);
+	}
+
 	if (field_sep)
 		fmt = "%"PRIu64"%s0x%"PRIx64"%s%s:%s\n";
 	else
@@ -248,6 +258,9 @@ static int report_raw_events(struct perf_mem *mem)
 	if (mem->phys_addr)
 		printf("PHYS ADDR, ");
 
+	if (mem->data_page_size)
+		printf("DATA PAGE SIZE, ");
+
 	printf("LOCAL WEIGHT, DSRC, SYMBOL\n");
 
 	ret = perf_session__process_events(session);
@@ -258,7 +271,7 @@ static int report_raw_events(struct perf_mem *mem)
 }
 static char *get_sort_order(struct perf_mem *mem)
 {
-	bool has_extra_options = mem->phys_addr ? true : false;
+	bool has_extra_options = (mem->phys_addr | mem->data_page_size) ? true : false;
 	char sort[128];
 
 	/*
@@ -277,6 +290,9 @@ static char *get_sort_order(struct perf_mem *mem)
 	if (mem->phys_addr)
 		strcat(sort, ",phys_daddr");
 
+	if (mem->data_page_size)
+		strcat(sort, ",data_page_size");
+
 	return strdup(sort);
 }
 
@@ -418,6 +434,7 @@ int cmd_mem(int argc, const char **argv)
 		   " between columns '.' is reserved."),
 	OPT_BOOLEAN('f', "force", &mem.force, "don't complain, do it"),
 	OPT_BOOLEAN('p', "phys-data", &mem.phys_addr, "Record/Report sample physical addresses"),
+	OPT_BOOLEAN(0, "data-page-size", &mem.data_page_size, "Record/Report sample data address page size"),
 	OPT_END()
 	};
 	const char *const mem_subcommands[] = { "record", "report", NULL };
-- 
2.7.4

