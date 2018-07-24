Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7038C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 19:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8207920852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 19:28:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8207920852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388712AbeGXUgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 16:36:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53022 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388678AbeGXUgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 16:36:18 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6OJNcD8131239
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 15:28:22 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ke8kum8gd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 15:28:22 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <muriloo@linux.ibm.com>;
        Tue, 24 Jul 2018 15:28:20 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 24 Jul 2018 15:28:16 -0400
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6OJSFuL7733732
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 24 Jul 2018 19:28:15 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A97F0AE063;
        Tue, 24 Jul 2018 15:27:31 -0400 (EDT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F11DAE05F;
        Tue, 24 Jul 2018 15:27:29 -0400 (EDT)
Received: from kermit-br-ibm-com.br.ibm.com (unknown [9.18.235.193])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 24 Jul 2018 15:27:29 -0400 (EDT)
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
Subject: [PATCH 7/7] powerpc/traps: Show instructions on exceptions
Date:   Tue, 24 Jul 2018 16:27:20 -0300
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180724192720.32417-1-muriloo@linux.ibm.com>
References: <20180724192720.32417-1-muriloo@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18072419-0064-0000-0000-0000032F2952
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009424; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01065573; UDB=6.00547380; IPR=6.00843431;
 MB=3.00022305; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-24 19:28:19
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072419-0065-0000-0000-00003A0EC691
Message-Id: <20180724192720.32417-8-muriloo@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-24_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=873 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807240204
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move show_instructions() declaration to arch/powerpc/include/asm/stacktrace.h
and include asm/stracktrace.h in arch/powerpc/kernel/process.c, which contains
the implementation.

Modify show_instructions() not to call __kernel_text_address(), allowing
userspace instruction dump.  probe_kernel_address(), which returns -EFAULT if
something goes wrong, is still being called.

Call show_instructions() in arch/powerpc/kernel/traps.c to dump instructions at
faulty location, useful to debugging.

Before this patch, an unhandled signal message looked like:

    Jul 24 09:57:00 localhost kernel: pandafault[10524]: segfault (11) at 00000000100007d0 nip 000000001000061c lr 00007fffbd295100 code 2 in pandafault[10000000+10000]

After this patch, it looks like:

    Jul 24 09:57:00 localhost kernel: pandafault[10524]: segfault (11) at 00000000100007d0 nip 000000001000061c lr 00007fffbd295100 code 2 in pandafault[10000000+10000]
    Jul 24 09:57:00 localhost kernel: Instruction dump:
    Jul 24 09:57:00 localhost kernel: 4bfffeec 4bfffee8 3c401002 38427f00 fbe1fff8 f821ffc1 7c3f0b78 3d22fffe
    Jul 24 09:57:00 localhost kernel: 392988d0 f93f0020 e93f0020 39400048 <99490000> 39200000 7d234b78 383f0040

Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
---
 arch/powerpc/include/asm/stacktrace.h | 7 +++++++
 arch/powerpc/kernel/process.c         | 6 +++---
 arch/powerpc/kernel/traps.c           | 3 +++
 3 files changed, 13 insertions(+), 3 deletions(-)
 create mode 100644 arch/powerpc/include/asm/stacktrace.h

diff --git a/arch/powerpc/include/asm/stacktrace.h b/arch/powerpc/include/asm/stacktrace.h
new file mode 100644
index 000000000000..46e5ef451578
--- /dev/null
+++ b/arch/powerpc/include/asm/stacktrace.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_STACKTRACE_H
+#define _ASM_POWERPC_STACKTRACE_H
+
+void show_instructions(struct pt_regs *regs);
+
+#endif /* _ASM_POWERPC_STACKTRACE_H */
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index b1af3390249c..ee1d63e03c52 100644
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
@@ -1283,8 +1284,7 @@ static void show_instructions(struct pt_regs *regs)
 			pc = (unsigned long)phys_to_virt(pc);
 #endif
 
-		if (!__kernel_text_address(pc) ||
-		     probe_kernel_address((unsigned int __user *)pc, instr)) {
+		if (probe_kernel_address((unsigned int __user *)pc, instr)) {
 			pr_cont("XXXXXXXX ");
 		} else {
 			if (regs->nip == pc)
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index e55ee639d010..3beca17ac1b1 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -70,6 +70,7 @@
 #include <asm/hmi.h>
 #include <sysdev/fsl_pci.h>
 #include <asm/kprobes.h>
+#include <asm/stacktrace.h>
 
 #if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC_CORE)
 int (*__debugger)(struct pt_regs *regs) __read_mostly;
@@ -357,6 +358,8 @@ static void show_signal_msg(int signr, struct pt_regs *regs, int code,
 	print_vma_addr(KERN_CONT " in ", regs->nip);
 
 	pr_cont("\n");
+
+	show_instructions(regs);
 }
 
 void _exception_pkey(int signr, struct pt_regs *regs, int code,
-- 
2.17.1

