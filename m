Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753675AbeCFMkM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 07:40:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34862 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753636AbeCFMkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 07:40:08 -0500
From: Thomas Richter <tmricht@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCH Resent] perf annotate: Fix s390 target function disassembly
Date: Tue,  6 Mar 2018 13:39:55 +0100
X-Mailer: git-send-email 2.13.5
X-TM-AS-GCONF: 00
x-cbid: 18030612-0016-0000-0000-0000052D6C1E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030612-0017-0000-0000-0000286A826E
Message-Id: <20180306123955.98802-1-tmricht@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-06_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803060145
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

Fix this by skipping the first operand on s390.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
---
 tools/perf/util/annotate.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 49ff825f745c..feb6006b676d 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -192,6 +192,14 @@ static int call__parse(struct arch *arch, struct ins_operands *ops, struct map *
 	};
 
 	ops->target.addr = strtoull(ops->raw, &endptr, 16);
+	if (!strcmp(arch->name, "s390")) {
+		/* s390 function call 1st operand is register */
+		tok = strchr(ops->raw, ',');
+		if (tok)
+			ops->target.addr = strtoull(tok + 1, &endptr, 16);
+		else
+			ops->target.addr = 0;
+	} else
+		ops->target.addr = strtoull(ops->raw, &endptr, 16);
 
 	name = strchr(endptr, '<');
 	if (name == NULL)
-- 
2.14.3
