Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932182AbeB1Ndt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 08:33:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45500 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752638AbeB1Ndd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 08:33:33 -0500
From: Thomas Richter <tmricht@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCH 2/2] perf annotate: Fix s390 target function disassembly
Date: Wed, 28 Feb 2018 14:33:09 +0100
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20180228133309.15758-1-tmricht@linux.vnet.ibm.com>
References: <20180228133309.15758-1-tmricht@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18022813-0020-0000-0000-000003FCDF3A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022813-0021-0000-0000-000042910958
Message-Id: <20180228133309.15758-2-tmricht@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-28_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802280163
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf annotate displays function call assembler instructions
with a right arrow. Hitting enter on this line/instruction
causes the browser to disassemble this target function and
show it on the screen.  On s390 this results in an error
message 'symbol not found'.

The function call assembly line parsing does not handle
the s390 bras and brasl instructions. Function call__parse
expects the target as first operand:
	callq	e9140 <__fxstat>
S390 has a register number as first operand:
	brasl	%r14,41d60 <abort>
Therefore the target addresses on s390 are always zero
which is an invalid address.

Fix this by skipping the first operand on s390.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
---
 tools/perf/util/annotate.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 28b233c3dcbe..5a90aa88076d 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -188,7 +188,13 @@ static int call__parse(struct arch *arch, struct ins_operands *ops, struct map *
 {
 	char *endptr, *tok, *name;
 
-	ops->target.addr = strtoull(ops->raw, &endptr, 16);
+	if (!strcmp(arch->name, "s390")) {
+		ops->target.addr =  0;
+		tok = strchr(ops->raw, ',');
+		if (tok)
+			ops->target.addr = strtoull(tok + 1, &endptr, 16);
+	} else
+		ops->target.addr = strtoull(ops->raw, &endptr, 16);
 
 	name = strchr(endptr, '<');
 	if (name == NULL)
-- 
2.14.3
