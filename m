Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754333AbeCGNng (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 08:43:36 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54552 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751151AbeCGNnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 08:43:33 -0500
From: Thomas Richter <tmricht@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCH v2] perf annotate: Fix s390 target function disassembly
Date: Wed,  7 Mar 2018 14:43:25 +0100
X-Mailer: git-send-email 2.13.5
X-TM-AS-GCONF: 00
x-cbid: 18030713-0012-0000-0000-000005B9ED09
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030713-0013-0000-0000-0000193608DE
Message-Id: <20180307134325.96106-1-tmricht@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-07_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803070159
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf annotate displays function call assembler instructions
with a right arrow. Hitting enter on this line/instruction
causes the browser to disassemble this target function and
show it on the screen.  On s390 this results in an error
message 'The called function was not found.'

The function call assembly line parsing does not handle
the s390 bras and brasl instructions. Function call__parse
expects the target as first operand:
	callq	e9140 <__fxstat>
S390 has a register number as first operand:
	brasl	%r14,41d60 <abort>
Therefore the target addresses on s390 are always zero
which is an invalid address.

Introduce a s390 specific call parsing function which skips
the first operand on s390.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
---
 tools/perf/arch/s390/annotate/instructions.c | 53 +++++++++++++++++++++++++++-
 tools/perf/util/annotate.c                   |  2 +-
 2 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/s390/annotate/instructions.c b/tools/perf/arch/s390/annotate/instructions.c
index 8c72b44444cb..0a3e39b5143d 100644
--- a/tools/perf/arch/s390/annotate/instructions.c
+++ b/tools/perf/arch/s390/annotate/instructions.c
@@ -1,6 +1,57 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/compiler.h>
 
+static int s390_call__parse(struct arch *arch, struct ins_operands *ops,
+			    struct map *map)
+{
+	char *endptr, *tok, *name;
+	struct addr_map_symbol target = {
+		.map = map,
+	};
+
+	tok = strchr(ops->raw, ',');
+	if (!tok)
+		return -1;
+
+	ops->target.addr = strtoull(tok + 1, &endptr, 16);
+
+	name = strchr(endptr, '<');
+	if (name == NULL)
+		return -1;
+
+	name++;
+
+	if (arch->objdump.skip_functions_char &&
+	    strchr(name, arch->objdump.skip_functions_char))
+		return -1;
+
+	tok = strchr(name, '>');
+	if (tok == NULL)
+		return -1;
+
+	*tok = '\0';
+	ops->target.name = strdup(name);
+	*tok = '>';
+
+	if (ops->target.name == NULL)
+		return -1;
+	target.addr = map__objdump_2mem(map, ops->target.addr);
+
+	if (map_groups__find_ams(&target) == 0 &&
+	    map__rip_2objdump(target.map, map->map_ip(target.map, target.addr)) == ops->target.addr)
+		ops->target.sym = target.sym;
+
+	return 0;
+}
+
+static int call__scnprintf(struct ins *ins, char *bf, size_t size,
+			   struct ins_operands *ops);
+
+static struct ins_ops s390_call_ops = {
+	.parse	   = s390_call__parse,
+	.scnprintf = call__scnprintf,
+};
+
 static struct ins_ops *s390__associate_ins_ops(struct arch *arch, const char *name)
 {
 	struct ins_ops *ops = NULL;
@@ -14,7 +65,7 @@ static struct ins_ops *s390__associate_ins_ops(struct arch *arch, const char *na
 	if (!strcmp(name, "bras") ||
 	    !strcmp(name, "brasl") ||
 	    !strcmp(name, "basr"))
-		ops = &call_ops;
+		ops = &s390_call_ops;
 	if (!strcmp(name, "br"))
 		ops = &ret_ops;
 
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 49ff825f745c..bc3302da702b 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -248,7 +248,7 @@ static struct ins_ops call_ops = {
 
 bool ins__is_call(const struct ins *ins)
 {
-	return ins->ops == &call_ops;
+	return ins->ops == &call_ops || ins->ops == &s390_call_ops;
 }
 
 static int jump__parse(struct arch *arch __maybe_unused, struct ins_operands *ops, struct map *map __maybe_unused)
-- 
2.14.3
