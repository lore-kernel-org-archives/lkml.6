Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932135AbeB1Ndf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 08:33:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55806 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752627AbeB1Nda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 08:33:30 -0500
From: Thomas Richter <tmricht@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCH 1/2] perf annotate: Remove s390 basr instruction from call table
Date: Wed, 28 Feb 2018 14:33:08 +0100
X-Mailer: git-send-email 2.13.5
X-TM-AS-GCONF: 00
x-cbid: 18022813-0020-0000-0000-000003FCDF37
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022813-0021-0000-0000-000042910955
Message-Id: <20180228133309.15758-1-tmricht@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-28_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802280163
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf annotate displays function call assembler instructions
with a right arrow. Hitting enter on this line/instruction
causes the browser to disassemble this target function and
show it on the screen.

S390 assembler instruction 'basr %r1,%r2'
jumps to address stored in register 2. Since the
target address is unknown to perf it can not be handled.

Therefore remove the right arrow from such an instruction
as the target function can not be identified.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
---
 tools/perf/arch/s390/annotate/instructions.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/arch/s390/annotate/instructions.c b/tools/perf/arch/s390/annotate/instructions.c
index 8c72b44444cb..05f53bd092d4 100644
--- a/tools/perf/arch/s390/annotate/instructions.c
+++ b/tools/perf/arch/s390/annotate/instructions.c
@@ -12,8 +12,7 @@ static struct ins_ops *s390__associate_ins_ops(struct arch *arch, const char *na
 		ops = &jump_ops;
 	/* override call/returns */
 	if (!strcmp(name, "bras") ||
-	    !strcmp(name, "brasl") ||
-	    !strcmp(name, "basr"))
+	    !strcmp(name, "brasl"))
 		ops = &call_ops;
 	if (!strcmp(name, "br"))
 		ops = &ret_ops;
-- 
2.14.3
