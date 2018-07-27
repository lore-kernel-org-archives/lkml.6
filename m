Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AD8C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88B32208AC
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:59:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88B32208AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388849AbeG0QVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 12:21:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37820 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388282AbeG0QVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 12:21:41 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6RExNST035510
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 10:59:23 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kg4n8txv9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 10:59:22 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <muriloo@linux.ibm.com>;
        Fri, 27 Jul 2018 10:59:13 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 27 Jul 2018 10:59:08 -0400
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6REx7pd5636846
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 27 Jul 2018 14:59:07 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 82520AC059;
        Fri, 27 Jul 2018 10:59:50 -0400 (EDT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C593AAC064;
        Fri, 27 Jul 2018 10:59:44 -0400 (EDT)
Received: from kermit-br-ibm-com.ibmmodules.com (unknown [9.80.82.251])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 27 Jul 2018 10:59:44 -0400 (EDT)
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
Subject: [PATCH v2 04/10] powerpc/traps: Use REG_FMT in show_signal_msg()
Date:   Fri, 27 Jul 2018 11:58:05 -0300
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180727145811.12334-1-muriloo@linux.ibm.com>
References: <20180727145811.12334-1-muriloo@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18072714-2213-0000-0000-000002D0C570
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009438; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01066907; UDB=6.00548186; IPR=6.00844774;
 MB=3.00022354; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-27 14:59:12
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072714-2214-0000-0000-00005AFBFF6D
Message-Id: <20180727145811.12334-5-muriloo@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-27_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807270154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the message format by using REG_FMT as the register format.  This
avoids having two different formats and avoids checking for MSR_64BIT.

Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
---
 arch/powerpc/kernel/traps.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 4faab4705774..047d980ac776 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -311,17 +311,13 @@ static bool show_unhandled_signals_ratelimited(void)
 static void show_signal_msg(int signr, struct pt_regs *regs, int code,
 			    unsigned long addr)
 {
-	const char fmt32[] = KERN_INFO "%s[%d]: unhandled signal %d " \
-		"at %08lx nip %08lx lr %08lx code %x\n";
-	const char fmt64[] = KERN_INFO "%s[%d]: unhandled signal %d " \
-		"at %016lx nip %016lx lr %016lx code %x\n";
-
 	if (!unhandled_signal(current, signr))
 		return;
 
-	printk(regs->msr & MSR_64BIT ? fmt64 : fmt32,
-	       current->comm, current->pid, signr,
-	       addr, regs->nip, regs->link, code);
+	pr_info("%s[%d]: unhandled signal %d at "REG_FMT \
+		" nip "REG_FMT" lr "REG_FMT" code %x\n",
+		current->comm, current->pid, signr, addr,
+		regs->nip, regs->link, code);
 }
 
 void _exception_pkey(int signr, struct pt_regs *regs, int code,
-- 
2.17.1

