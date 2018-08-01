Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5ABC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C68A20844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:34:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C68A20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732535AbeHAXWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 19:22:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49668 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732505AbeHAXWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 19:22:17 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w71LYUJB106296
        for <linux-kernel@vger.kernel.org>; Wed, 1 Aug 2018 17:34:30 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kkjahwnns-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 17:34:30 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <muriloo@linux.ibm.com>;
        Wed, 1 Aug 2018 17:34:21 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 1 Aug 2018 17:34:16 -0400
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w71LYFmX9044476
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 1 Aug 2018 21:34:15 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE377AC064;
        Wed,  1 Aug 2018 17:34:53 -0400 (EDT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A946AC05B;
        Wed,  1 Aug 2018 17:34:49 -0400 (EDT)
Received: from kermit-br-ibm-com.ibmmodules.com (unknown [9.80.99.86])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  1 Aug 2018 17:34:49 -0400 (EDT)
From:   Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Alastair D'Silva" <alastair@d-silva.org>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Cyril Bur <cyrilbur@gmail.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Joe Perches <joe@perches.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Simon Guo <wei.guo.simon@gmail.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        "Tobin C . Harding" <me@tobin.cc>, linuxppc-dev@lists.ozlabs.org,
        Segher Boessenkool <segher@kernel.crashing.org>
Subject: [PATCH v4 5/6] powerpc: Add show_user_instructions()
Date:   Wed,  1 Aug 2018 18:33:19 -0300
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180801213320.11203-1-muriloo@linux.ibm.com>
References: <20180801213320.11203-1-muriloo@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18080121-0064-0000-0000-00000332C542
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009468; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01068949; UDB=6.00549596; IPR=6.00847297;
 MB=3.00022446; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-01 21:34:21
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080121-0065-0000-0000-00003A26141A
Message-Id: <20180801213320.11203-6-muriloo@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-01_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1808010218
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

show_user_instructions() is a slightly modified version of
show_instructions() that allows userspace instruction dump.

This will be useful within show_signal_msg() to dump userspace
instructions of the faulty location.

Here is a sample of what show_user_instructions() outputs:

  pandafault[10850]: code: 4bfffeec 4bfffee8 3c401002 38427f00 fbe1fff8 f821ffc1 7c3f0b78 3d22fffe
  pandafault[10850]: code: 392988d0 f93f0020 e93f0020 39400048 <99490000> 39200000 7d234b78 383f0040

The current->comm and current->pid printed can serve as a glue that
links the instructions dump to its originator, allowing messages to be
interleaved in the logs.

Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
---
 arch/powerpc/include/asm/stacktrace.h | 13 +++++++++
 arch/powerpc/kernel/process.c         | 40 +++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)
 create mode 100644 arch/powerpc/include/asm/stacktrace.h

diff --git a/arch/powerpc/include/asm/stacktrace.h b/arch/powerpc/include/asm/stacktrace.h
new file mode 100644
index 000000000000..6149b53b3bc8
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
+void show_user_instructions(struct pt_regs *regs);
+
+#endif /* _ASM_POWERPC_STACKTRACE_H */
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index e9533b4d2f08..364645ac732c 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1299,6 +1299,46 @@ static void show_instructions(struct pt_regs *regs)
 	pr_cont("\n");
 }
 
+void show_user_instructions(struct pt_regs *regs)
+{
+	int i;
+	const char *prefix = KERN_INFO "%s[%d]: code: ";
+	unsigned long pc = regs->nip - (instructions_to_print * 3 / 4 *
+					sizeof(int));
+
+	printk(prefix, current->comm, current->pid);
+
+	for (i = 0; i < instructions_to_print; i++) {
+		int instr;
+
+		if (!(i % 8) && (i > 0)) {
+			pr_cont("\n");
+			printk(prefix, current->comm, current->pid);
+		}
+
+#if !defined(CONFIG_BOOKE)
+		/* If executing with the IMMU off, adjust pc rather
+		 * than print XXXXXXXX.
+		 */
+		if (!(regs->msr & MSR_IR))
+			pc = (unsigned long)phys_to_virt(pc);
+#endif
+
+		if (probe_kernel_address((unsigned int __user *)pc, instr)) {
+			pr_cont("XXXXXXXX ");
+		} else {
+			if (regs->nip == pc)
+				pr_cont("<%08x> ", instr);
+			else
+				pr_cont("%08x ", instr);
+		}
+
+		pc += sizeof(int);
+	}
+
+	pr_cont("\n");
+}
+
 struct regbit {
 	unsigned long bit;
 	const char *name;
-- 
2.17.1

