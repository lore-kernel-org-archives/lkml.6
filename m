Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D81BC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DCC522404
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:38:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DCC522404
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbeHJQIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 12:08:01 -0400
Received: from mga12.intel.com ([192.55.52.136]:31368 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728089AbeHJQIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 12:08:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Aug 2018 06:38:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,219,1531810800"; 
   d="scan'208";a="80633160"
Received: from otc-lr-04.jf.intel.com ([10.54.39.114])
  by orsmga001.jf.intel.com with ESMTP; 10 Aug 2018 06:37:59 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, jolsa@redhat.com, namhyung@kernel.org,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH RFC 6/7] perf mem: Support page size
Date:   Fri, 10 Aug 2018 06:36:26 -0700
Message-Id: <1533908187-25204-6-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533908187-25204-1-git-send-email-kan.liang@linux.intel.com>
References: <1533908187-25204-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Add option --page-size in "perf mem" to record/report page size.

Here are some examples.
perf mem --phys-data --page-size report -D

 # PID, TID, IP, ADDR, PHYS ADDR, PAGE SIZE, LOCAL WEIGHT, DSRC, SYMBOL
20134 20134 0xffffffffb5bd2fd0 0x016ffff9a274e96a308 0x000000044e96a308
4K  1168 0x5080144
/lib/modules/4.18.0-rc7+/build/vmlinux:perf_ctx_unlock
20134 20134 0xffffffffb63f645c 0xffffffffb752b814 0xcfb52b814 2M 225
0x26a100142 /lib/modules/4.18.0-rc7+/build/vmlinux:_raw_spin_lock
20134 20134 0xffffffffb660300c 0xfffffe00016b8bb0 0x0 4K 0 0x5080144
/lib/modules/4.18.0-rc7+/build/vmlinux:__x86_indirect_thunk_rax


perf mem --phys-data --page-size report --stdio

 # To display the perf.data header info, please use
 # --header/--header-only options.
 #
 #
 # Total Lost Samples: 0
 #
 # Samples: 5K of event 'cpu/mem-loads,ldlat=30/P'
 # Total weight : 281234
 # Sort order   :
 # mem,sym,dso,symbol_daddr,dso_daddr,tlb,locked,phys_daddr,page_size
 #
 # Overhead       Samples  Memory access             Symbol
 # Shared Object     Data Symbol                                  Data
 # Object              TLB access              Locked  Data Physical
 # Address   Page Size
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
 tools/perf/Documentation/perf-mem.txt |  4 ++++
 tools/perf/builtin-mem.c              | 17 +++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/tools/perf/Documentation/perf-mem.txt b/tools/perf/Documentation/perf-mem.txt
index f8d2167..1708689 100644
--- a/tools/perf/Documentation/perf-mem.txt
+++ b/tools/perf/Documentation/perf-mem.txt
@@ -63,6 +63,10 @@ OPTIONS
 --phys-data::
 	Record/Report sample physical addresses
 
+-s::
+--page-size::
+	Record/Report sample page size
+
 RECORD OPTIONS
 --------------
 -e::
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 6048fca..0dad6c2 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -26,6 +26,7 @@ struct perf_mem {
 	bool			dump_raw;
 	bool			force;
 	bool			phys_addr;
+	bool			page_size;
 	int			operation;
 	const char		*cpu_list;
 	DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
@@ -107,6 +108,9 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
 	if (mem->phys_addr)
 		rec_argv[i++] = "--phys-data";
 
+	if (mem->phys_addr)
+		rec_argv[i++] = "--page-size";
+
 	for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
 		if (!perf_mem_events[j].record)
 			continue;
@@ -195,6 +199,12 @@ dump_raw_samples(struct perf_tool *tool,
 			symbol_conf.field_sep);
 	}
 
+	if (mem->page_size) {
+		printf("%s%s",
+			get_page_size_name(sample->page_size),
+			symbol_conf.field_sep);
+	}
+
 	if (field_sep)
 		fmt = "%"PRIu64"%s0x%"PRIx64"%s%s:%s\n";
 	else
@@ -253,6 +263,9 @@ static int report_raw_events(struct perf_mem *mem)
 	if (mem->phys_addr)
 		printf("PHYS ADDR, ");
 
+	if (mem->page_size)
+		printf("PAGE SIZE, ");
+
 	printf("LOCAL WEIGHT, DSRC, SYMBOL\n");
 
 	ret = perf_session__process_events(session);
@@ -277,6 +290,9 @@ static char *get_sort_order(struct perf_mem *mem)
 	if (mem->phys_addr)
 		strcat(sort, ",phys_daddr");
 
+	if (mem->page_size)
+		strcat(sort, ",page_size");
+
 	return strdup(sort);
 }
 
@@ -418,6 +434,7 @@ int cmd_mem(int argc, const char **argv)
 		   " between columns '.' is reserved."),
 	OPT_BOOLEAN('f', "force", &mem.force, "don't complain, do it"),
 	OPT_BOOLEAN('p', "phys-data", &mem.phys_addr, "Record/Report sample physical addresses"),
+	OPT_BOOLEAN('s', "page-size", &mem.page_size, "Record/Report sample page size"),
 	OPT_END()
 	};
 	const char *const mem_subcommands[] = { "record", "report", NULL };
-- 
2.7.4

