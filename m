Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932193AbeCHTxv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 14:53:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:32878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751999AbeCHTxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 14:53:11 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1C3121796
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 53/54] perf annotate: Handle s390 PC relative load and store instruction.
Date: Thu,  8 Mar 2018 16:50:28 -0300
Message-Id: <20180308195029.14991-54-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180308195029.14991-1-acme@kernel.org>
References: <20180308195029.14991-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Richter <tmricht@linux.vnet.ibm.com>

S390 has several load and store instructions with target operand
addressing relative to the program counter, for example lrl, lgrl, strl,
stgrl.

These instructions are handled similar to x86. Objdump output displays
those instructions as:

   9595c: c4 2d 00 09 9c 54   lgrl   %r7,1c8540 <mp_+0x60>

This output is parsed (like on x86) and perf annotate shows those lines
as:

   lgrl   %r7,mp_+0x60

This patch handles the s390 specific instruction parsing for PC relative
load and store instructions.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20180308120913.14802-1-tmricht@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/s390/annotate/instructions.c | 63 ++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/tools/perf/arch/s390/annotate/instructions.c b/tools/perf/arch/s390/annotate/instructions.c
index e80589fc5b58..46c21831f2ac 100644
--- a/tools/perf/arch/s390/annotate/instructions.c
+++ b/tools/perf/arch/s390/annotate/instructions.c
@@ -52,6 +52,61 @@ static struct ins_ops s390_call_ops = {
 	.scnprintf = call__scnprintf,
 };
 
+static int s390_mov__parse(struct arch *arch __maybe_unused,
+			   struct ins_operands *ops,
+			   struct map *map __maybe_unused)
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
+	ops->target.name = strdup(s + 1);
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
+static struct ins_ops s390_mov_ops = {
+	.parse	   = s390_mov__parse,
+	.scnprintf = mov__scnprintf,
+};
+
 static struct ins_ops *s390__associate_ins_ops(struct arch *arch, const char *name)
 {
 	struct ins_ops *ops = NULL;
@@ -68,6 +123,14 @@ static struct ins_ops *s390__associate_ins_ops(struct arch *arch, const char *na
 		ops = &s390_call_ops;
 	if (!strcmp(name, "br"))
 		ops = &ret_ops;
+	/* override load/store relative to PC */
+	if (!strcmp(name, "lrl") ||
+	    !strcmp(name, "lgrl") ||
+	    !strcmp(name, "lgfrl") ||
+	    !strcmp(name, "llgfrl") ||
+	    !strcmp(name, "strl") ||
+	    !strcmp(name, "stgrl"))
+		ops = &s390_mov_ops;
 
 	if (ops)
 		arch__associate_ins_ops(arch, name, ops);
-- 
2.14.3
