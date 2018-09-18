Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24206ECE560
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 12:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA1120858
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 12:32:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAA1120858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbeIRSEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 14:04:54 -0400
Received: from mga05.intel.com ([192.55.52.43]:21172 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729279AbeIRSEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 14:04:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2018 05:32:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,389,1531810800"; 
   d="scan'208";a="263612514"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by fmsmga005.fm.intel.com with ESMTP; 18 Sep 2018 05:32:31 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 7D54030027C; Tue, 18 Sep 2018 05:32:31 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, kim.phillips@arm.com,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v5 9/9] perf, tools, script: Support total cycles count
Date:   Tue, 18 Sep 2018 05:32:14 -0700
Message-Id: <20180918123214.26728-10-andi@firstfloor.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180918123214.26728-1-andi@firstfloor.org>
References: <20180918123214.26728-1-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

For perf script brstackinsn also print a running cycles count.
This makes it easier to calculate cycle deltas for code sections
measured with LBRs.

% perf record -b -a sleep 1
% perf script -F +brstackinsn
...
        _dl_sysdep_start+330:
        00007eff9f20583a        insn: 75 c4                     # PRED 24 cycles [24]
        00007eff9f205800        insn: 48 83 e8 03
        00007eff9f205804        insn: 48 83 f8 1e
        00007eff9f205808        insn: 77 26
        00007eff9f20580a        insn: 48 63 04 81
        00007eff9f20580e        insn: 48 01 c8
        00007eff9f205811        insn: ff e0                     # MISPRED 31 cycles [7] 0.71 IPC
        00007eff9f2059c0        insn: 44 8b 62 08
        00007eff9f2059c4        insn: e9 67 fe ff ff            # PRED 55 cycles [24] 0.04 IPC
        00007eff9f205830        insn: 48 83 c2 10
        00007eff9f205834        insn: 48 8b 02
        00007eff9f205837        insn: 48 85 c0
        00007eff9f20583a        insn: 75 c4                     # PRED 68 cycles [13] 0.23 IPC

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/builtin-script.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 3b73c3226141..84895c861b84 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -913,7 +913,7 @@ static int grab_bb(u8 *buffer, u64 start, u64 end,
 
 static int ip__fprintf_jump(uint64_t ip, struct branch_entry *en,
 			    struct perf_insn *x, u8 *inbuf, int len,
-			    int insn, FILE *fp)
+			    int insn, FILE *fp, int *total_cycles)
 {
 	int printed = fprintf(fp, "\t%016" PRIx64 "\t%-30s\t#%s%s%s%s", ip,
 			      dump_insn(x, ip, inbuf, len, NULL),
@@ -922,7 +922,8 @@ static int ip__fprintf_jump(uint64_t ip, struct branch_entry *en,
 			      en->flags.in_tx ? " INTX" : "",
 			      en->flags.abort ? " ABORT" : "");
 	if (en->flags.cycles) {
-		printed += fprintf(fp, " %d cycles", en->flags.cycles);
+		*total_cycles += en->flags.cycles;
+		printed += fprintf(fp, " %d cycles [%d]", *total_cycles, en->flags.cycles);
 		if (insn)
 			printed += fprintf(fp, " %.2f IPC", (float)insn / en->flags.cycles);
 	}
@@ -979,6 +980,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 	u8 buffer[MAXBB];
 	unsigned off;
 	struct symbol *lastsym = NULL;
+	int total_cycles = 0;
 
 	if (!(br && br->nr))
 		return 0;
@@ -999,7 +1001,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 		printed += ip__fprintf_sym(br->entries[nr - 1].from, thread,
 					   x.cpumode, x.cpu, &lastsym, attr, fp);
 		printed += ip__fprintf_jump(br->entries[nr - 1].from, &br->entries[nr - 1],
-					    &x, buffer, len, 0, fp);
+					    &x, buffer, len, 0, fp, &total_cycles);
 	}
 
 	/* Print all blocks */
@@ -1027,7 +1029,9 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 
 			printed += ip__fprintf_sym(ip, thread, x.cpumode, x.cpu, &lastsym, attr, fp);
 			if (ip == end) {
-				printed += ip__fprintf_jump(ip, &br->entries[i], &x, buffer + off, len - off, insn, fp);
+				printed += ip__fprintf_jump(ip, &br->entries[i],
+						&x, buffer + off, len - off,
+						insn, fp, &total_cycles);
 				break;
 			} else {
 				printed += fprintf(fp, "\t%016" PRIx64 "\t%s\n", ip,
-- 
2.17.1

