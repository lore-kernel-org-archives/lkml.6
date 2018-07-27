Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18767C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C589F208AC
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:58:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C589F208AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388697AbeG0QVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 12:21:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35388 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730561AbeG0QVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 12:21:12 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6REsJUc072553
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 10:58:54 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kg41dvg4q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 10:58:54 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <muriloo@linux.ibm.com>;
        Fri, 27 Jul 2018 10:58:52 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 27 Jul 2018 10:58:47 -0400
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6REwkfp9175456
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 27 Jul 2018 14:58:46 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 864F0AC059;
        Fri, 27 Jul 2018 10:59:29 -0400 (EDT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 036A0AC05B;
        Fri, 27 Jul 2018 10:59:24 -0400 (EDT)
Received: from kermit-br-ibm-com.ibmmodules.com (unknown [9.80.82.251])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 27 Jul 2018 10:59:23 -0400 (EDT)
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
Subject: [PATCH v2 01/10] powerpc/traps: Print unhandled signals in a separate function
Date:   Fri, 27 Jul 2018 11:58:02 -0300
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180727145811.12334-1-muriloo@linux.ibm.com>
References: <20180727145811.12334-1-muriloo@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18072714-0060-0000-0000-00000293125D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009438; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01066907; UDB=6.00548186; IPR=6.00844773;
 MB=3.00022354; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-27 14:58:51
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072714-0061-0000-0000-000045F32764
Message-Id: <20180727145811.12334-2-muriloo@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-27_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807270153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Isolate the logic of printing unhandled signals out of _exception_pkey().
No functional change, only code rearrangement.

Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
---
 arch/powerpc/kernel/traps.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 0e17dcb48720..cbd3dc365193 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -301,26 +301,32 @@ void user_single_step_siginfo(struct task_struct *tsk,
 	info->si_addr = (void __user *)regs->nip;
 }
 
+static void show_signal_msg(int signr, struct pt_regs *regs, int code,
+			    unsigned long addr)
+{
+	const char fmt32[] = KERN_INFO "%s[%d]: unhandled signal %d " \
+		"at %08lx nip %08lx lr %08lx code %x\n";
+	const char fmt64[] = KERN_INFO "%s[%d]: unhandled signal %d " \
+		"at %016lx nip %016lx lr %016lx code %x\n";
+
+	if (show_unhandled_signals && unhandled_signal(current, signr)) {
+		printk_ratelimited(regs->msr & MSR_64BIT ? fmt64 : fmt32,
+				   current->comm, current->pid, signr,
+				   addr, regs->nip, regs->link, code);
+	}
+}
 
 void _exception_pkey(int signr, struct pt_regs *regs, int code,
-		unsigned long addr, int key)
+		     unsigned long addr, int key)
 {
 	siginfo_t info;
-	const char fmt32[] = KERN_INFO "%s[%d]: unhandled signal %d " \
-			"at %08lx nip %08lx lr %08lx code %x\n";
-	const char fmt64[] = KERN_INFO "%s[%d]: unhandled signal %d " \
-			"at %016lx nip %016lx lr %016lx code %x\n";
 
 	if (!user_mode(regs)) {
 		die("Exception in kernel mode", regs, signr);
 		return;
 	}
 
-	if (show_unhandled_signals && unhandled_signal(current, signr)) {
-		printk_ratelimited(regs->msr & MSR_64BIT ? fmt64 : fmt32,
-				   current->comm, current->pid, signr,
-				   addr, regs->nip, regs->link, code);
-	}
+	show_signal_msg(signr, regs, code, addr);
 
 	if (arch_irqs_disabled() && !arch_irq_disabled_regs(regs))
 		local_irq_enable();
-- 
2.17.1

