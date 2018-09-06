Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA49EC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67D292075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:45:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67D292075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbeIFSVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:21:33 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48539 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729233AbeIFSVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:21:33 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86DjKoN310886
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:45:20 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86DjK1U310883;
        Thu, 6 Sep 2018 06:45:20 -0700
Date:   Thu, 6 Sep 2018 06:45:20 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kim Phillips <tipbot@zytor.com>
Message-ID: <tip-58094c48f4079cfc784f53a73caaa446db436389@git.kernel.org>
Cc:     gregkh@linuxfoundation.org, kim.phillips@arm.com,
        linux-kernel@vger.kernel.org, tmricht@linux.vnet.ibm.com,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        jolsa@redhat.com, acme@redhat.com, peterz@infradead.org,
        hpa@zytor.com, mingo@kernel.org, brueckner@linux.vnet.ibm.com,
        namhyung@kernel.org
Reply-To: namhyung@kernel.org, mingo@kernel.org,
          brueckner@linux.vnet.ibm.com, peterz@infradead.org,
          hpa@zytor.com, jolsa@redhat.com, acme@redhat.com,
          tglx@linutronix.de, tmricht@linux.vnet.ibm.com,
          alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
          gregkh@linuxfoundation.org, kim.phillips@arm.com
In-Reply-To: <20180827150807.304110d2e9919a17c832ca48@arm.com>
References: <20180827150807.304110d2e9919a17c832ca48@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf annotate: Handle arm64 move instructions
Git-Commit-ID: 58094c48f4079cfc784f53a73caaa446db436389
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

Commit-ID:  58094c48f4079cfc784f53a73caaa446db436389
Gitweb:     https://git.kernel.org/tip/58094c48f4079cfc784f53a73caaa446db436389
Author:     Kim Phillips <kim.phillips@arm.com>
AuthorDate: Mon, 27 Aug 2018 15:08:07 -0500
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:52:25 -0300

perf annotate: Handle arm64 move instructions

Add default handler for non-jump instructions.  This really only has an
effect on instructions that compute a PC-relative address, such as
'adrp,' as seen in these couple of examples:

BEFORE: adrp   x0, ffff20000aa11000 <kallsyms_token_index+0xce000>
AFTER:  adrp   x0, kallsyms_token_index+0xce000

BEFORE: adrp   x23, ffff20000ae94000 <__per_cpu_load>
AFTER:  adrp   x23, __per_cpu_load

The implementation is identical to that of s390, but with a slight
adjustment for objdump whitespace propagation (arm64 objdump puts spaces
after commas, whereas s390's presumably doesn't).

The mov__scnprintf() declaration is moved from s390's to arm64's
instructions.c because arm64's gets included before s390's.

Committer testing:

Ran 'perf annotate --stdio2 > /tmp/{before,after}' no diff.

Signed-off-by: Kim Phillips <kim.phillips@arm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20180827150807.304110d2e9919a17c832ca48@arm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm64/annotate/instructions.c | 59 ++++++++++++++++++++++++++-
 tools/perf/arch/s390/annotate/instructions.c  |  2 -
 2 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/tools/perf/arch/arm64/annotate/instructions.c b/tools/perf/arch/arm64/annotate/instructions.c
index 6688977e4ac7..76c6345a57d5 100644
--- a/tools/perf/arch/arm64/annotate/instructions.c
+++ b/tools/perf/arch/arm64/annotate/instructions.c
@@ -8,6 +8,63 @@ struct arm64_annotate {
 		jump_insn;
 };
 
+static int arm64_mov__parse(struct arch *arch __maybe_unused,
+			    struct ins_operands *ops,
+			    struct map_symbol *ms __maybe_unused)
+{
+	char *s = strchr(ops->raw, ','), *target, *endptr;
+
+	if (s == NULL)
+		return -1;
+
+	*s = '\0';
+	ops->source.raw = strdup(ops->raw);
+	*s = ',';
+
+	if (ops->source.raw == NULL)
+		return -1;
+
+	target = ++s;
+	ops->target.raw = strdup(target);
+	if (ops->target.raw == NULL)
+		goto out_free_source;
+
+	ops->target.addr = strtoull(target, &endptr, 16);
+	if (endptr == target)
+		goto out_free_target;
+
+	s = strchr(endptr, '<');
+	if (s == NULL)
+		goto out_free_target;
+	endptr = strchr(s + 1, '>');
+	if (endptr == NULL)
+		goto out_free_target;
+
+	*endptr = '\0';
+	*s = ' ';
+	ops->target.name = strdup(s);
+	*s = '<';
+	*endptr = '>';
+	if (ops->target.name == NULL)
+		goto out_free_target;
+
+	return 0;
+
+out_free_target:
+	zfree(&ops->target.raw);
+out_free_source:
+	zfree(&ops->source.raw);
+	return -1;
+}
+
+static int mov__scnprintf(struct ins *ins, char *bf, size_t size,
+			  struct ins_operands *ops);
+
+static struct ins_ops arm64_mov_ops = {
+	.parse	   = arm64_mov__parse,
+	.scnprintf = mov__scnprintf,
+};
+
 static struct ins_ops *arm64__associate_instruction_ops(struct arch *arch, const char *name)
 {
 	struct arm64_annotate *arm = arch->priv;
@@ -21,7 +78,7 @@ static struct ins_ops *arm64__associate_instruction_ops(struct arch *arch, const
 	else if (!strcmp(name, "ret"))
 		ops = &ret_ops;
 	else
-		return NULL;
+		ops = &arm64_mov_ops;
 
 	arch__associate_ins_ops(arch, name, ops);
 	return ops;
diff --git a/tools/perf/arch/s390/annotate/instructions.c b/tools/perf/arch/s390/annotate/instructions.c
index cee4e2f7c057..de0dd66dbb48 100644
--- a/tools/perf/arch/s390/annotate/instructions.c
+++ b/tools/perf/arch/s390/annotate/instructions.c
@@ -100,8 +100,6 @@ out_free_source:
 	return -1;
 }
 
-static int mov__scnprintf(struct ins *ins, char *bf, size_t size,
-			  struct ins_operands *ops);
 
 static struct ins_ops s390_mov_ops = {
 	.parse	   = s390_mov__parse,
