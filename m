Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE73C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0A4B21479
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730958AbfACNNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 08:13:49 -0500
Received: from terminus.zytor.com ([198.137.202.136]:42285 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729569AbfACNNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 08:13:48 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x03DDZN11384108
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 3 Jan 2019 05:13:35 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x03DDZLW1384105;
        Thu, 3 Jan 2019 05:13:35 -0800
Date:   Thu, 3 Jan 2019 05:13:35 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-61f611593f2c90547cb09c0bf6977414454a27e6@git.kernel.org>
Cc:     hpa@zytor.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, ak@linux.intel.com, adrian.hunter@intel.com,
        acme@redhat.com, mingo@kernel.org, milian.wolff@kdab.com
Reply-To: mingo@kernel.org, acme@redhat.com, milian.wolff@kdab.com,
          hpa@zytor.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
          adrian.hunter@intel.com, ak@linux.intel.com, jolsa@kernel.org
In-Reply-To: <20181120050617.4119-1-andi@firstfloor.org>
References: <20181120050617.4119-1-andi@firstfloor.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf script: Fix LBR skid dump problems in
 brstackinsn
Git-Commit-ID: 61f611593f2c90547cb09c0bf6977414454a27e6
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

Commit-ID:  61f611593f2c90547cb09c0bf6977414454a27e6
Gitweb:     https://git.kernel.org/tip/61f611593f2c90547cb09c0bf6977414454a27e6
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Mon, 19 Nov 2018 21:06:17 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 28 Dec 2018 16:33:02 -0300

perf script: Fix LBR skid dump problems in brstackinsn

This is a fix for another instance of the skid problem Milian recently
found [1]

The LBRs don't freeze at the exact same time as the PMI is triggered.
The perf script brstackinsn code that dumps LBR assembler assumes that
the last branch in the LBR leads to the sample point.  But with skid
it's possible that the CPU executes one or more branches before the
sample, but which do not appear in the LBR.

What happens then is either that the sample point is before the last LBR
branch. In this case the dumper sees a negative length and ignores it.
Or it the sample point is long after the last branch. Then the dumper
sees a very long block and dumps it upto its block limit (16k bytes),
which is noise in the output.

On typical sample session this can happen regularly.

This patch tries to detect and handle the situation. On the last block
that is dumped by the LBR dumper we always stop on the first branch. If
the block length is negative just scan forward to the first branch.
Otherwise scan until a branch is found.

The PT decoder already has a function that uses the instruction decoder
to detect branches, so we can just reuse it here.

Then when a terminating branch is found print an indication and stop
dumping. This might miss a few instructions, but at least shows no
runaway blocks.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Milian Wolff <milian.wolff@kdab.com>
Link: http://lkml.kernel.org/r/20181120050617.4119-1-andi@firstfloor.org
[ Resolved conflict with dd2e18e9ac20 ("perf tools: Support 'srccode' output") ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c                             | 17 ++++++++++++++++-
 tools/perf/util/dump-insn.c                             |  8 ++++++++
 tools/perf/util/dump-insn.h                             |  2 ++
 .../perf/util/intel-pt-decoder/intel-pt-insn-decoder.c  |  8 ++++++++
 4 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 3728b50e52e2..88d52ed85ffc 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1073,9 +1073,18 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 
 	/*
 	 * Print final block upto sample
+	 *
+	 * Due to pipeline delays the LBRs might be missing a branch
+	 * or two, which can result in very large or negative blocks
+	 * between final branch and sample. When this happens just
+	 * continue walking after the last TO until we hit a branch.
 	 */
 	start = br->entries[0].to;
 	end = sample->ip;
+	if (end < start) {
+		/* Missing jump. Scan 128 bytes for the next branch */
+		end = start + 128;
+	}
 	len = grab_bb(buffer, start, end, machine, thread, &x.is64bit, &x.cpumode, true);
 	printed += ip__fprintf_sym(start, thread, x.cpumode, x.cpu, &lastsym, attr, fp);
 	if (len <= 0) {
@@ -1084,7 +1093,6 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 			      machine, thread, &x.is64bit, &x.cpumode, false);
 		if (len <= 0)
 			goto out;
-
 		printed += fprintf(fp, "\t%016" PRIx64 "\t%s\n", sample->ip,
 			dump_insn(&x, sample->ip, buffer, len, NULL));
 		if (PRINT_FIELD(SRCCODE))
@@ -1096,6 +1104,13 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 				   dump_insn(&x, start + off, buffer + off, len - off, &ilen));
 		if (ilen == 0)
 			break;
+		if (arch_is_branch(buffer + off, len - off, x.is64bit) && start + off != sample->ip) {
+			/*
+			 * Hit a missing branch. Just stop.
+			 */
+			printed += fprintf(fp, "\t... not reaching sample ...\n");
+			break;
+		}
 		if (PRINT_FIELD(SRCCODE))
 			print_srccode(thread, x.cpumode, start + off);
 	}
diff --git a/tools/perf/util/dump-insn.c b/tools/perf/util/dump-insn.c
index 10988d3de7ce..2bd8585db93c 100644
--- a/tools/perf/util/dump-insn.c
+++ b/tools/perf/util/dump-insn.c
@@ -13,3 +13,11 @@ const char *dump_insn(struct perf_insn *x __maybe_unused,
 		*lenp = 0;
 	return "?";
 }
+
+__weak
+int arch_is_branch(const unsigned char *buf __maybe_unused,
+		   size_t len __maybe_unused,
+		   int x86_64 __maybe_unused)
+{
+	return 0;
+}
diff --git a/tools/perf/util/dump-insn.h b/tools/perf/util/dump-insn.h
index 0e06280a8860..650125061530 100644
--- a/tools/perf/util/dump-insn.h
+++ b/tools/perf/util/dump-insn.h
@@ -20,4 +20,6 @@ struct perf_insn {
 
 const char *dump_insn(struct perf_insn *x, u64 ip,
 		      u8 *inbuf, int inlen, int *lenp);
+int arch_is_branch(const unsigned char *buf, size_t len, int x86_64);
+
 #endif
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
index 54818828023b..1c0e289f01e6 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
@@ -180,6 +180,14 @@ int intel_pt_get_insn(const unsigned char *buf, size_t len, int x86_64,
 	return 0;
 }
 
+int arch_is_branch(const unsigned char *buf, size_t len, int x86_64)
+{
+	struct intel_pt_insn in;
+	if (intel_pt_get_insn(buf, len, x86_64, &in) < 0)
+		return -1;
+	return in.branch != INTEL_PT_BR_NO_BRANCH;
+}
+
 const char *dump_insn(struct perf_insn *x, uint64_t ip __maybe_unused,
 		      u8 *inbuf, int inlen, int *lenp)
 {
