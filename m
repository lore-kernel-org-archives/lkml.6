Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A92EECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2B1C2087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:07:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2B1C2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732901AbeIXXKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 19:10:40 -0400
Received: from mga05.intel.com ([192.55.52.43]:55312 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729217AbeIXXKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 19:10:40 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2018 10:07:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,298,1534834800"; 
   d="scan'208";a="76884331"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga006.jf.intel.com with ESMTP; 24 Sep 2018 10:07:32 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 54384300554; Mon, 24 Sep 2018 10:07:32 -0700 (PDT)
Date:   Mon, 24 Sep 2018 10:07:32 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, jolsa@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 5/5] perf, tools, script: Support total cycles count
Message-ID: <20180924170732.GA28040@tassilo.jf.intel.com>
References: <20180920180540.14039-1-andi@firstfloor.org>
 <20180920180540.14039-6-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180920180540.14039-6-andi@firstfloor.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Updated patch with a bug fix. Please use this version.]

For perf script brstackinsn also print a running cycles count.
This makes it easier to calculate cycle deltas for code sections
measured with LBRs.

% perf record -b -a sleep 1
% perf script -F +brstackinsn
...
        00007f73ecc41083        insn: 74 06                     # PRED 9 cycles [17] 1.11 IPC
        00007f73ecc4108b        insn: a8 10
        00007f73ecc4108d        insn: 74 71                     # PRED 1 cycles [18] 1.00 IPC
        00007f73ecc41100        insn: 48 8b 46 10
        00007f73ecc41104        insn: 4c 8b 38
        00007f73ecc41107        insn: 4d 85 ff
        00007f73ecc4110a        insn: 0f 84 b0 00 00 00
        00007f73ecc41110        insn: 83 43 58 01
        00007f73ecc41114        insn: 48 89 df
        00007f73ecc41117        insn: e8 94 73 04 00            # PRED 6 cycles [24] 1.00 IPC

Signed-off-by: Andi Kleen <ak@linux.intel.com>

---

v2: reflow line
v3: Print cycles in correct column

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 6232658c6f31..dbb0a780225c 100644
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
+		printed += fprintf(fp, " %d cycles [%d]", en->flags.cycles, *total_cycles);
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
@@ -1027,7 +1029,8 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 
 			printed += ip__fprintf_sym(ip, thread, x.cpumode, x.cpu, &lastsym, attr, fp);
 			if (ip == end) {
-				printed += ip__fprintf_jump(ip, &br->entries[i], &x, buffer + off, len - off, insn, fp);
+				printed += ip__fprintf_jump(ip, &br->entries[i], &x, buffer + off, len - off, insn, fp,
+							    &total_cycles);
 				break;
 			} else {
 				printed += fprintf(fp, "\t%016" PRIx64 "\t%s\n", ip,
