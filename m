Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66925C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21DC72146F
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544131697;
	bh=gTf3UgD10ikyQcGkhHAFw5FukzgFdTaqmYpOi7WZ16I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QS5amRPj2BBAM8f5v9mAUOeezLP06idpRd9vFKxZvC1Ur1qKX3F4BYRm6Who952/Z
	 O5WzNDp3G2acoNYZ+rldJU339gN9ZLKgseMFeFjm1e7aCS9z582hvAZFfJQAIetQyt
	 iTi2eNodEcxqJY2fgOCsNmjM3NrbwnN1eANBVrm0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21DC72146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbeLFV2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:28:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:46900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbeLFV2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:28:06 -0500
Received: from quaco.ghostprotocols.net (179.187.13.223.dynamic.adsl.gvt.net.br [179.187.13.223])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C1D6208E7;
        Thu,  6 Dec 2018 21:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544131685;
        bh=gTf3UgD10ikyQcGkhHAFw5FukzgFdTaqmYpOi7WZ16I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gK+JBnq6YXUD4p+e7Ac4+WAMPNlXtYckX5hkE7eGzTKYtkJWHAgAKMNsSvxfkiLP9
         +zE/OlamUNsWxFp06YqhM80hUV9T/nBY4wBnSRmnkpVxVareZ5i1RwGOH5gTXikN9R
         LWeB88CyM957xLUuUGZJamy73Ofk8RG8V042aYc0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Jin Yao <yao.jin@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 23/75] perf annotate: Compute average IPC and IPC coverage per symbol
Date:   Thu,  6 Dec 2018 18:25:10 -0300
Message-Id: <20181206212602.20474-24-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

Add support to 'perf report' annotate view or 'perf annotate --stdio2'
to aggregate the IPC derived from timed LBRs per symbol. We compute the
average IPC and the IPC coverage percentage.

For example:

  $ perf annotate --stdio2

  Percent  IPC Cycle (Average IPC: 2.30, IPC Coverage: 54.8%)

                          Disassembly of section .text:

                          000000000003aac0 <random@@GLIBC_2.2.5>:
    8.32  3.28              sub    $0x18,%rsp
          3.28              mov    $0x1,%esi
          3.28              xor    %eax,%eax
          3.28              cmpl   $0x0,argp_program_version_hook@@GLIBC_2.2.5+0x1e0
   11.57  3.28     1      ↓ je     20
                            lock   cmpxchg %esi,__abort_msg@@GLIBC_PRIVATE+0x8a0
                          ↓ jne    29
                          ↓ jmp    43
   11.57  1.10        20:   cmpxchg %esi,__abort_msg@@GLIBC_PRIVATE+0x8a0
    0.00  1.10     1      ↓ je     43
                      29:   lea    __abort_msg@@GLIBC_PRIVATE+0x8a0,%rdi
                            sub    $0x80,%rsp
                          → callq  __lll_lock_wait_private
                            add    $0x80,%rsp
    0.00  3.00        43:   lea    __ctype_b@GLIBC_2.2.5+0x38,%rdi
          3.00              lea    0xc(%rsp),%rsi
    8.49  3.00     1      → callq  __random_r
    7.91  1.94              cmpl   $0x0,argp_program_version_hook@@GLIBC_2.2.5+0x1e0
    0.00  1.94     1      ↓ je     68
                            lock   decl   __abort_msg@@GLIBC_PRIVATE+0x8a0
                          ↓ jne    70
                          ↓ jmp    8a
    0.00  2.00        68:   decl   __abort_msg@@GLIBC_PRIVATE+0x8a0
   21.56  2.00     1      ↓ je     8a
                      70:   lea    __abort_msg@@GLIBC_PRIVATE+0x8a0,%rdi
                            sub    $0x80,%rsp
                          → callq  __lll_unlock_wake_private
                            add    $0x80,%rsp
   21.56  2.90        8a:   movslq 0xc(%rsp),%rax
          2.90              add    $0x18,%rsp
    9.03  2.90     1      ← retq

It shows for this symbol the average IPC is 2.30 and the IPC coverage is
54.8%.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1543586097-27632-2-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 41 +++++++++++++++++++++++++++++++++++---
 tools/perf/util/annotate.h |  5 +++++
 2 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 6936daf89ddd..4b2b1b09b8f1 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1000,6 +1000,7 @@ static unsigned annotation__count_insn(struct annotation *notes, u64 start, u64
 static void annotation__count_and_fill(struct annotation *notes, u64 start, u64 end, struct cyc_hist *ch)
 {
 	unsigned n_insn;
+	unsigned int cover_insn = 0;
 	u64 offset;
 
 	n_insn = annotation__count_insn(notes, start, end);
@@ -1013,21 +1014,34 @@ static void annotation__count_and_fill(struct annotation *notes, u64 start, u64
 		for (offset = start; offset <= end; offset++) {
 			struct annotation_line *al = notes->offsets[offset];
 
-			if (al)
+			if (al && al->ipc == 0.0) {
 				al->ipc = ipc;
+				cover_insn++;
+			}
+		}
+
+		if (cover_insn) {
+			notes->hit_cycles += ch->cycles;
+			notes->hit_insn += n_insn * ch->num;
+			notes->cover_insn += cover_insn;
 		}
 	}
 }
 
 void annotation__compute_ipc(struct annotation *notes, size_t size)
 {
-	u64 offset;
+	s64 offset;
 
 	if (!notes->src || !notes->src->cycles_hist)
 		return;
 
+	notes->total_insn = annotation__count_insn(notes, 0, size - 1);
+	notes->hit_cycles = 0;
+	notes->hit_insn = 0;
+	notes->cover_insn = 0;
+
 	pthread_mutex_lock(&notes->lock);
-	for (offset = 0; offset < size; ++offset) {
+	for (offset = size - 1; offset >= 0; --offset) {
 		struct cyc_hist *ch;
 
 		ch = &notes->src->cycles_hist[offset];
@@ -2563,6 +2577,22 @@ static void disasm_line__write(struct disasm_line *dl, struct annotation *notes,
 	disasm_line__scnprintf(dl, bf, size, !notes->options->use_offset);
 }
 
+static void ipc_coverage_string(char *bf, int size, struct annotation *notes)
+{
+	double ipc = 0.0, coverage = 0.0;
+
+	if (notes->hit_cycles)
+		ipc = notes->hit_insn / ((double)notes->hit_cycles);
+
+	if (notes->total_insn) {
+		coverage = notes->cover_insn * 100.0 /
+			((double)notes->total_insn);
+	}
+
+	scnprintf(bf, size, "(Average IPC: %.2f, IPC Coverage: %.1f%%)",
+		  ipc, coverage);
+}
+
 static void __annotation_line__write(struct annotation_line *al, struct annotation *notes,
 				     bool first_line, bool current_entry, bool change_color, int width,
 				     void *obj, unsigned int percent_type,
@@ -2658,6 +2688,11 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 					    ANNOTATION__MINMAX_CYCLES_WIDTH - 1,
 					    "Cycle(min/max)");
 		}
+
+		if (show_title && !*al->line) {
+			ipc_coverage_string(bf, sizeof(bf), notes);
+			obj__printf(obj, "%*s", ANNOTATION__AVG_IPC_WIDTH, bf);
+		}
 	}
 
 	obj__printf(obj, " ");
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 5399ba2321bb..fb6463730ba4 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -64,6 +64,7 @@ bool ins__is_fused(struct arch *arch, const char *ins1, const char *ins2);
 #define ANNOTATION__IPC_WIDTH 6
 #define ANNOTATION__CYCLES_WIDTH 6
 #define ANNOTATION__MINMAX_CYCLES_WIDTH 19
+#define ANNOTATION__AVG_IPC_WIDTH 36
 
 struct annotation_options {
 	bool hide_src_code,
@@ -262,6 +263,10 @@ struct annotation {
 	pthread_mutex_t		lock;
 	u64			max_coverage;
 	u64			start;
+	u64			hit_cycles;
+	u64			hit_insn;
+	unsigned int		total_insn;
+	unsigned int		cover_insn;
 	struct annotation_options *options;
 	struct annotation_line	**offsets;
 	int			nr_events;
-- 
2.19.2

