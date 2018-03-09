Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751262AbeCII6V (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:58:21 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60863 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750883AbeCII6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:58:19 -0500
Date: Fri, 9 Mar 2018 00:58:11 -0800
From: tip-bot for Thomas Richter <tipbot@zytor.com>
Message-ID: <tip-0b4b6b78a3ce07023052e44b967f5d42fa3d802c@git.kernel.org>
Cc: hpa@zytor.com, heiko.carstens@de.ibm.com, brueckner@linux.vnet.ibm.com,
        tmricht@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, schwidefsky@de.ibm.com, tglx@linutronix.de,
        acme@redhat.com
Reply-To: acme@redhat.com, tglx@linutronix.de, schwidefsky@de.ibm.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        tmricht@linux.vnet.ibm.com, brueckner@linux.vnet.ibm.com,
        heiko.carstens@de.ibm.com, hpa@zytor.com
In-Reply-To: <20180308120913.14802-1-tmricht@linux.vnet.ibm.com>
References: <20180308120913.14802-1-tmricht@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf annotate: Handle s390 PC relative load and
 store instruction.
Git-Commit-ID: 0b4b6b78a3ce07023052e44b967f5d42fa3d802c
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  0b4b6b78a3ce07023052e44b967f5d42fa3d802c
Gitweb:     https://git.kernel.org/tip/0b4b6b78a3ce07023052e44b967f5d42fa3d802c
Author:     Thomas Richter <tmricht@linux.vnet.ibm.com>
AuthorDate: Thu, 8 Mar 2018 13:09:13 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 8 Mar 2018 11:30:53 -0300

perf annotate: Handle s390 PC relative load and store instruction.

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
