Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29139C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE3EF20834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:48:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE3EF20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbeJZQYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 12:24:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35081 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbeJZQYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 12:24:09 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9Q7loKV141689
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 26 Oct 2018 00:47:50 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9Q7lou2141686;
        Fri, 26 Oct 2018 00:47:50 -0700
Date:   Fri, 26 Oct 2018 00:47:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-fe57120e18a1f9124ca758c89cc54f91333d1847@git.kernel.org>
Cc:     andi@firstfloor.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, hpa@zytor.com, acme@redhat.com,
        ak@linux.intel.com, mingo@kernel.org, jolsa@kernel.org
Reply-To: hpa@zytor.com, ak@linux.intel.com, acme@redhat.com,
          mingo@kernel.org, jolsa@kernel.org, andi@firstfloor.org,
          tglx@linutronix.de, linux-kernel@vger.kernel.org
In-Reply-To: <20180924170732.GA28040@tassilo.jf.intel.com>
References: <20180924170732.GA28040@tassilo.jf.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf script: Support total cycles count
Git-Commit-ID: fe57120e18a1f9124ca758c89cc54f91333d1847
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  fe57120e18a1f9124ca758c89cc54f91333d1847
Gitweb:     https://git.kernel.org/tip/fe57120e18a1f9124ca758c89cc54f91333d1847
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Mon, 24 Sep 2018 10:07:32 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 24 Oct 2018 15:29:56 -0300

perf script: Support total cycles count

For 'perf script' brstackinsn also print a running cycles count.  This
makes it easier to calculate cycle deltas for code sections measured
with LBRs.

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
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>
Link: http://lkml.kernel.org/r/20180924170732.GA28040@tassilo.jf.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 9d2249ea75e3..b5bc85bd0bbe 100644
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
