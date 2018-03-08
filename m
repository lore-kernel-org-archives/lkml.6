Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755538AbeCHMJV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 07:09:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54850 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751373AbeCHMJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 07:09:20 -0500
From: Thomas Richter <tmricht@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCH] perf annotate: Handle s390 pc relative load and store instruction.
Date: Thu,  8 Mar 2018 13:09:13 +0100
X-Mailer: git-send-email 2.13.5
X-TM-AS-GCONF: 00
x-cbid: 18030812-0020-0000-0000-0000040043B0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030812-0021-0000-0000-0000429488DB
Message-Id: <20180308120913.14802-1-tmricht@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-08_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=20
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803080142
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

S390 has several load and store instructions with target operand
addressing relative to the program counter, for example lrl, lgrl,
strl, stgrl.

These instructions are handled similar to x86. Objdump output
displays those instructions as:
   9595c: c4 2d 00 09 9c 54   lgrl   %r7,1c8540 <mp_+0x60>
This output is parsed (like on x86) and perf annotate shows those
lines as:
   lgrl   %r7,mp_+0x60

This patch handles the s390 specific instruction parsing for
pc relative load and store instructions.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
---
 tools/perf/arch/s390/annotate/instructions.c | 63 ++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/tools/perf/arch/s390/annotate/instructions.c b/tools/perf/arch/s390/annotate/instructions.c
index 0a3e39b5143d..0c54f1b33ac0 100644
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
