Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCAFC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 256AD20844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:07:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 256AD20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbeIFRnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:43:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54835 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbeIFRnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:43:19 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86D7Fpe303539
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:07:15 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86D7EeB303535;
        Thu, 6 Sep 2018 06:07:14 -0700
Date:   Thu, 6 Sep 2018 06:07:14 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kim Phillips <tipbot@zytor.com>
Message-ID: <tip-4e67b2a5df5d3f341776d12ee575e00ca3ef92de@git.kernel.org>
Cc:     mingo@kernel.org, mark.rutland@arm.com, treeze.taeung@gmail.com,
        namhyung@kernel.org, anton@samba.org, robin.murphy@arm.com,
        acme@redhat.com, jolsa@redhat.com, tglx@linutronix.de,
        peterz@infradead.org, borntraeger@de.ibm.com,
        linux-kernel@vger.kernel.org, kim.phillips@arm.com,
        alexander.shishkin@linux.intel.com, hpa@zytor.com,
        ravi.bangoria@linux.vnet.ibm.com
Reply-To: borntraeger@de.ibm.com, ravi.bangoria@linux.vnet.ibm.com,
          hpa@zytor.com, alexander.shishkin@linux.intel.com,
          kim.phillips@arm.com, linux-kernel@vger.kernel.org,
          namhyung@kernel.org, treeze.taeung@gmail.com, mingo@kernel.org,
          mark.rutland@arm.com, peterz@infradead.org, jolsa@redhat.com,
          tglx@linutronix.de, robin.murphy@arm.com, acme@redhat.com,
          anton@samba.org
In-Reply-To: <20180827125340.a2f7e291901d17cea05daba4@arm.com>
References: <20180827125340.a2f7e291901d17cea05daba4@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf annotate: Fix parsing aarch64 branch
 instructions after objdump update
Git-Commit-ID: 4e67b2a5df5d3f341776d12ee575e00ca3ef92de
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

Commit-ID:  4e67b2a5df5d3f341776d12ee575e00ca3ef92de
Gitweb:     https://git.kernel.org/tip/4e67b2a5df5d3f341776d12ee575e00ca3ef92de
Author:     Kim Phillips <kim.phillips@arm.com>
AuthorDate: Mon, 27 Aug 2018 12:53:40 -0500
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:51:54 -0300

perf annotate: Fix parsing aarch64 branch instructions after objdump update

Starting with binutils 2.28, aarch64 objdump adds comments to the
disassembly output to show the alternative names of a condition code
[1].

It is assumed that commas in objdump comments could occur in other
arches now or in the future, so this fix is arch-independent.

The fix could have been done with arm64 specific jump__parse and
jump__scnprintf functions, but the jump__scnprintf instruction would
have to have its comment character be a literal, since the scnprintf
functions cannot receive a struct arch easily.

This inconvenience also applies to the generic jump__scnprintf, which is
why we add a raw_comment pointer to struct ins_operands, so the __parse
function assigns it to be re-used by its corresponding __scnprintf
function.

Example differences in 'perf annotate --stdio2' output on an aarch64
perf.data file:

BEFORE: → b.cs   ffff200008133d1c <unwind_frame+0x18c>  // b.hs, dffff7ecc47b
AFTER : ↓ b.cs   18c

BEFORE: → b.cc   ffff200008d8d9cc <get_alloc_profile+0x31c>  // b.lo, b.ul, dffff727295b
AFTER : ↓ b.cc   31c

The branch target labels 18c and 31c also now appear in the output:

BEFORE:        add    x26, x29, #0x80
AFTER : 18c:   add    x26, x29, #0x80

BEFORE:        add    x21, x21, #0x8
AFTER : 31c:   add    x21, x21, #0x8

The Fixes: tag below is added so stable branches will get the update; it
doesn't necessarily mean that commit was broken at the time, rather it
didn't withstand the aarch64 objdump update.

Tested no difference in output for sample x86_64, power arch perf.data files.

[1] https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;a=commit;h=bb7eff5206e4795ac79c177a80fe9f4630aaf730

Signed-off-by: Kim Phillips <kim.phillips@arm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Anton Blanchard <anton@samba.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Taeung Song <treeze.taeung@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org
Fixes: b13bbeee5ee6 ("perf annotate: Fix branch instruction with multiple operands")
Link: http://lkml.kernel.org/r/20180827125340.a2f7e291901d17cea05daba4@arm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 22 +++++++++++++++++++++-
 tools/perf/util/annotate.h |  1 +
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index e62b69ea87cd..28cd6a17491b 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -282,7 +282,19 @@ bool ins__is_call(const struct ins *ins)
 	return ins->ops == &call_ops || ins->ops == &s390_call_ops;
 }
 
-static int jump__parse(struct arch *arch __maybe_unused, struct ins_operands *ops, struct map_symbol *ms)
+/*
+ * Prevents from matching commas in the comment section, e.g.:
+ * ffff200008446e70:       b.cs    ffff2000084470f4 <generic_exec_single+0x314>  // b.hs, b.nlast
+ */
+static inline const char *validate_comma(const char *c, struct ins_operands *ops)
+{
+	if (ops->raw_comment && c > ops->raw_comment)
+		return NULL;
+
+	return c;
+}
+
+static int jump__parse(struct arch *arch, struct ins_operands *ops, struct map_symbol *ms)
 {
 	struct map *map = ms->map;
 	struct symbol *sym = ms->sym;
@@ -291,6 +303,10 @@ static int jump__parse(struct arch *arch __maybe_unused, struct ins_operands *op
 	};
 	const char *c = strchr(ops->raw, ',');
 	u64 start, end;
+
+	ops->raw_comment = strchr(ops->raw, arch->objdump.comment_char);
+	c = validate_comma(c, ops);
+
 	/*
 	 * Examples of lines to parse for the _cpp_lex_token@@Base
 	 * function:
@@ -310,6 +326,7 @@ static int jump__parse(struct arch *arch __maybe_unused, struct ins_operands *op
 		ops->target.addr = strtoull(c, NULL, 16);
 		if (!ops->target.addr) {
 			c = strchr(c, ',');
+			c = validate_comma(c, ops);
 			if (c++ != NULL)
 				ops->target.addr = strtoull(c, NULL, 16);
 		}
@@ -367,9 +384,12 @@ static int jump__scnprintf(struct ins *ins, char *bf, size_t size,
 		return scnprintf(bf, size, "%-6s %s", ins->name, ops->target.sym->name);
 
 	c = strchr(ops->raw, ',');
+	c = validate_comma(c, ops);
+
 	if (c != NULL) {
 		const char *c2 = strchr(c + 1, ',');
 
+		c2 = validate_comma(c2, ops);
 		/* check for 3-op insn */
 		if (c2 != NULL)
 			c = c2;
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 005a5fe8a8c6..5399ba2321bb 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -22,6 +22,7 @@ struct ins {
 
 struct ins_operands {
 	char	*raw;
+	char	*raw_comment;
 	struct {
 		char	*raw;
 		char	*name;
