Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E193EC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5359208AC
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:59:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5359208AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388922AbeG0QWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 12:22:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42652 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388901AbeG0QV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 12:21:59 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6RExE4q027913
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 10:59:41 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kg4uvt5yj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 10:59:41 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <muriloo@linux.ibm.com>;
        Fri, 27 Jul 2018 10:59:39 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 27 Jul 2018 10:59:35 -0400
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6RExYdO10224032
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 27 Jul 2018 14:59:34 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6FA96AC05B;
        Fri, 27 Jul 2018 11:00:17 -0400 (EDT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3630EAC059;
        Fri, 27 Jul 2018 11:00:12 -0400 (EDT)
Received: from kermit-br-ibm-com.ibmmodules.com (unknown [9.80.82.251])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 27 Jul 2018 11:00:11 -0400 (EDT)
From:   Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Alastair D'Silva" <alastair@d-silva.org>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Cyril Bur <cyrilbur@gmail.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Simon Guo <wei.guo.simon@gmail.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        "Tobin C . Harding" <me@tobin.cc>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 08/10] powerpc: Add stacktrace.h header
Date:   Fri, 27 Jul 2018 11:58:09 -0300
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180727145811.12334-1-muriloo@linux.ibm.com>
References: <20180727145811.12334-1-muriloo@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18072714-0040-0000-0000-00000454B59D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009438; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01066908; UDB=6.00548186; IPR=6.00844773;
 MB=3.00022354; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-27 14:59:39
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072714-0041-0000-0000-0000085AED0F
Message-Id: <20180727145811.12334-9-muriloo@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-27_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=922 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807270154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move show_instructions() declaration to
arch/powerpc/include/asm/stacktrace.h and include asm/stracktrace.h in
arch/powerpc/kernel/process.c, which contains the implementation.

This allows show_instructions() to be called on, for example,
show_signal_msg().

Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
---
 arch/powerpc/include/asm/stacktrace.h | 13 +++++++++++++
 arch/powerpc/kernel/process.c         |  3 ++-
 2 files changed, 15 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/include/asm/stacktrace.h

diff --git a/arch/powerpc/include/asm/stacktrace.h b/arch/powerpc/include/asm/stacktrace.h
new file mode 100644
index 000000000000..217ebc52ff97
--- /dev/null
+++ b/arch/powerpc/include/asm/stacktrace.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Stack trace functions.
+ *
+ * Copyright 2018, Murilo Opsfelder Araujo, IBM Corporation.
+ */
+
+#ifndef _ASM_POWERPC_STACKTRACE_H
+#define _ASM_POWERPC_STACKTRACE_H
+
+void show_instructions(struct pt_regs *regs);
+
+#endif /* _ASM_POWERPC_STACKTRACE_H */
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 04960796fcce..709bfb524b84 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -52,6 +52,7 @@
 #include <asm/machdep.h>
 #include <asm/time.h>
 #include <asm/runlatch.h>
+#include <asm/stacktrace.h>
 #include <asm/syscalls.h>
 #include <asm/switch_to.h>
 #include <asm/tm.h>
@@ -1261,7 +1262,7 @@ struct task_struct *__switch_to(struct task_struct *prev,
 
 static int instructions_to_print = 16;
 
-static void show_instructions(struct pt_regs *regs)
+void show_instructions(struct pt_regs *regs)
 {
 	int i;
 	unsigned long pc = regs->nip - (instructions_to_print * 3 / 4 *
-- 
2.17.1

