Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55331C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 15:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F049206B6
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 15:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbfBXPhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 10:37:32 -0500
Received: from mga18.intel.com ([134.134.136.126]:17101 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728431AbfBXPhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 10:37:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Feb 2019 07:37:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,407,1544515200"; 
   d="scan'208";a="321674207"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga006.fm.intel.com with ESMTP; 24 Feb 2019 07:37:30 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 8C8133010AD; Sun, 24 Feb 2019 07:37:30 -0800 (PST)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org, linux-perf-users@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, eranian@google.com,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 02/11] perf tools script: Support insn output for normal samples
Date:   Sun, 24 Feb 2019 07:37:13 -0800
Message-Id: <20190224153722.27020-3-andi@firstfloor.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190224153722.27020-1-andi@firstfloor.org>
References: <20190224153722.27020-1-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

perf script -F +insn was only working for PT traces because
the PT instruction decoder was filling in the insn/insn_len
sample attributes. Support it for non PT samples too on x86
using the existing x86 instruction decoder.

% perf record -a sleep 1
% perf script -F ip,sym,insn --xed
 ffffffff811704c9 remote_function               movl  %eax, 0x18(%rbx)
 ffffffff8100bb50 intel_bts_enable_local                retq
 ffffffff81048612 native_apic_mem_write                 movl  %esi, -0xa04000(%rdi)
 ffffffff81048612 native_apic_mem_write                 movl  %esi, -0xa04000(%rdi)
 ffffffff81048612 native_apic_mem_write                 movl  %esi, -0xa04000(%rdi)
 ffffffff810f1f79 generic_exec_single           xor %eax, %eax
 ffffffff811704c9 remote_function               movl  %eax, 0x18(%rbx)
 ffffffff8100bb34 intel_bts_enable_local                movl  0x2000(%rax), %edx
 ffffffff81048610 native_apic_mem_write                 mov %edi, %edi
...

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/arch/x86/util/Build      |  1 +
 tools/perf/arch/x86/util/archinsn.c | 41 +++++++++++++++++++++++++++++
 tools/perf/builtin-script.c         | 10 +++++++
 tools/perf/util/archinsn.h          | 12 +++++++++
 4 files changed, 64 insertions(+)
 create mode 100644 tools/perf/arch/x86/util/archinsn.c
 create mode 100644 tools/perf/util/archinsn.h

diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/Build
index 7aab0be5fc5f..7b8e69bbbdfe 100644
--- a/tools/perf/arch/x86/util/Build
+++ b/tools/perf/arch/x86/util/Build
@@ -6,6 +6,7 @@ perf-y += perf_regs.o
 perf-y += group.o
 perf-y += machine.o
 perf-y += event.o
+perf-y += archinsn.o
 
 perf-$(CONFIG_DWARF) += dwarf-regs.o
 perf-$(CONFIG_BPF_PROLOGUE) += dwarf-regs.o
diff --git a/tools/perf/arch/x86/util/archinsn.c b/tools/perf/arch/x86/util/archinsn.c
new file mode 100644
index 000000000000..9e3b0828b018
--- /dev/null
+++ b/tools/perf/arch/x86/util/archinsn.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "perf.h"
+#include "archinsn.h"
+#include "util/intel-pt-decoder/insn.h"
+#include "machine.h"
+#include "thread.h"
+#include "symbol.h"
+#include "map.h"
+
+void arch_fetch_insn(struct perf_sample *sample,
+		     struct thread *thread,
+		     struct machine *machine)
+{
+	struct addr_location al;
+	u8 cpumode;
+	long offset;
+	struct insn insn;
+	int len;
+
+	if (!sample->ip)
+		return;
+
+	if (machine__kernel_ip(machine, sample->ip))
+		cpumode = PERF_RECORD_MISC_KERNEL;
+	else
+		cpumode = PERF_RECORD_MISC_USER;
+	if (!thread__find_map(thread, cpumode, sample->ip, &al) || !al.map->dso)
+		return;
+	if (al.map->dso->data.status == DSO_DATA_STATUS_ERROR)
+		return;
+	map__load(al.map);
+	offset = al.map->map_ip(al.map, sample->ip);
+	len = dso__data_read_offset(al.map->dso, machine, offset, (u8 *)sample->insn,
+				   sizeof(sample->insn));
+	if (len <= 0)
+		return;
+	insn_init(&insn, sample->insn, len, al.map->dso->is_64_bit);
+	insn_get_length(&insn);
+	if (insn_complete(&insn) && insn.length <= len)
+		sample->insn_len = insn.length;
+}
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 29e95a25c6e6..261055302d08 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -29,6 +29,7 @@
 #include "util/time-utils.h"
 #include "util/path.h"
 #include "print_binary.h"
+#include "archinsn.h"
 #include <linux/bitmap.h>
 #include <linux/kernel.h>
 #include <linux/stringify.h>
@@ -1227,6 +1228,12 @@ static int perf_sample__fprintf_callindent(struct perf_sample *sample,
 	return len + dlen;
 }
 
+__weak void arch_fetch_insn(struct perf_sample *sample __maybe_unused,
+			    struct thread *thread __maybe_unused,
+			    struct machine *machine __maybe_unused)
+{
+}
+
 static int perf_sample__fprintf_insn(struct perf_sample *sample,
 				     struct perf_event_attr *attr,
 				     struct thread *thread,
@@ -1234,6 +1241,9 @@ static int perf_sample__fprintf_insn(struct perf_sample *sample,
 {
 	int printed = 0;
 
+	if (sample->insn_len == 0)
+		arch_fetch_insn(sample, thread, machine);
+
 	if (PRINT_FIELD(INSNLEN))
 		printed += fprintf(fp, " ilen: %d", sample->insn_len);
 	if (PRINT_FIELD(INSN)) {
diff --git a/tools/perf/util/archinsn.h b/tools/perf/util/archinsn.h
new file mode 100644
index 000000000000..448cbb6b8d7e
--- /dev/null
+++ b/tools/perf/util/archinsn.h
@@ -0,0 +1,12 @@
+#ifndef INSN_H
+#define INSN_H 1
+
+struct perf_sample;
+struct machine;
+struct thread;
+
+void arch_fetch_insn(struct perf_sample *sample,
+		     struct thread *thread,
+		     struct machine *machine);
+
+#endif
-- 
2.17.2

