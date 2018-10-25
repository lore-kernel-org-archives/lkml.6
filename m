Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5ABC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E657D20834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1s86O7q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E657D20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbeJYToq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 15:44:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:49026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728126AbeJYTop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 15:44:45 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04CB220847;
        Thu, 25 Oct 2018 11:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540465946;
        bh=5vlh4ix0GcE8cKbO/iyamQhuqFlg/TX/ybVqcMjehGU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U1s86O7qCkgTFvjmZag0arpGmnJmVU05F2dn5n/KvTgjKRYyCb9i8GYc25tzfaf8K
         3cH26TfbeYkgHkvrWo5o/aBZbKp1yQVbVlqC4GNGGmloHAg9JT+pkYRDDt/3mja8ut
         uFxiGL6xk3QqhXTuleWhMgNmVX2QLP+L5rGoHajI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Andi Kleen <andi@firstfloor.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 37/37] perf script: Support total cycles count
Date:   Thu, 25 Oct 2018 08:10:31 -0300
Message-Id: <20181025111031.3440-38-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181025111031.3440-1-acme@kernel.org>
References: <20181025111031.3440-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

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
-- 
2.14.4

