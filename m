Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F644C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11F4E2086B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsRyokz+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11F4E2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbeIFCkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:40:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:55390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727518AbeIFCkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:40:21 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6633820861;
        Wed,  5 Sep 2018 22:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536185288;
        bh=C9N1K5i24gMuvKBqPj/mVPJrM7e29i2OZjXeajHcOQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hsRyokz+zC0lTV0UG/FNokyuv50q80afBSIJQ8GOg0Pmlf2vEw+b22r/htCP/PPo2
         tPYpVXAXUKM/GgogPOpWnp5bnoqMI9o/6Pa62NVtIzuDhxTevKOk4D2oV4L3XaAgi9
         246N9KmbxFmKkjIc03BksBnRWKhz63q6g4i6woSs=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Kim Phillips <kim.phillips@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 70/77] perf annotate: Handle arm64 move instructions
Date:   Wed,  5 Sep 2018 19:04:33 -0300
Message-Id: <20180905220440.20256-71-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kim Phillips <kim.phillips@arm.com>

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
@@ -100,8 +100,6 @@ static int s390_mov__parse(struct arch *arch __maybe_unused,
 	return -1;
 }
 
-static int mov__scnprintf(struct ins *ins, char *bf, size_t size,
-			  struct ins_operands *ops);
 
 static struct ins_ops s390_mov_ops = {
 	.parse	   = s390_mov__parse,
-- 
2.14.4

