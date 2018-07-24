Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7042C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 19:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A53620852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 19:28:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A53620852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388726AbeGXUgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 16:36:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50122 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388494AbeGXUgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 16:36:19 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6OJNcV9044005
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 15:28:22 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ke8hjvnw7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 15:28:21 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <muriloo@linux.ibm.com>;
        Tue, 24 Jul 2018 15:28:18 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 24 Jul 2018 15:28:13 -0400
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6OJSCNM7274966
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 24 Jul 2018 19:28:12 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F15BFAE062;
        Tue, 24 Jul 2018 15:27:27 -0400 (EDT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 803C0AE060;
        Tue, 24 Jul 2018 15:27:25 -0400 (EDT)
Received: from kermit-br-ibm-com.br.ibm.com (unknown [9.18.235.193])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 24 Jul 2018 15:27:25 -0400 (EDT)
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
Subject: [PATCH 6/7] powerpc/traps: Print signal name for unhandled signals
Date:   Tue, 24 Jul 2018 16:27:19 -0300
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180724192720.32417-1-muriloo@linux.ibm.com>
References: <20180724192720.32417-1-muriloo@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18072419-0060-0000-0000-0000029179C2
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009424; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01065573; UDB=6.00547380; IPR=6.00843431;
 MB=3.00022305; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-24 19:28:17
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072419-0061-0000-0000-000045E9E0BA
Message-Id: <20180724192720.32417-7-muriloo@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-24_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=777 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807240204
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a human-readable name in the unhandled signal message.

Before this patch, a page fault looked like:

    Jul 11 16:04:11 localhost kernel: pandafault[6303]: unhandled signal 11 at 00000000100007d0 nip 000000001000061c lr 00007fff93c55100 code 2 in pandafault[10000000+10000]

After this patch, a page fault looks like:

    Jul 11 18:14:48 localhost kernel: pandafault[6352]: segfault (11) at 000000013a2a09f8 nip 000000013a2a086c lr 00007fffb63e5100 code 2 in pandafault[13a2a0000+10000]

Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
---
 arch/powerpc/kernel/traps.c | 43 +++++++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index e6c43ef9fb50..e55ee639d010 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -96,6 +96,41 @@ EXPORT_SYMBOL(__debugger_fault_handler);
 #define TM_DEBUG(x...) do { } while(0)
 #endif
 
+static const char *signames[SIGRTMIN + 1] = {
+	"UNKNOWN",
+	"SIGHUP",			// 1
+	"SIGINT",			// 2
+	"SIGQUIT",			// 3
+	"SIGILL",			// 4
+	"unhandled trap",		// 5 = SIGTRAP
+	"SIGABRT",			// 6 = SIGIOT
+	"bus error",			// 7 = SIGBUS
+	"floating point exception",	// 8 = SIGFPE
+	"illegal instruction",		// 9 = SIGILL
+	"SIGUSR1",			// 10
+	"segfault",			// 11 = SIGSEGV
+	"SIGUSR2",			// 12
+	"SIGPIPE",			// 13
+	"SIGALRM",			// 14
+	"SIGTERM",			// 15
+	"SIGSTKFLT",			// 16
+	"SIGCHLD",			// 17
+	"SIGCONT",			// 18
+	"SIGSTOP",			// 19
+	"SIGTSTP",			// 20
+	"SIGTTIN",			// 21
+	"SIGTTOU",			// 22
+	"SIGURG",			// 23
+	"SIGXCPU",			// 24
+	"SIGXFSZ",			// 25
+	"SIGVTALRM",			// 26
+	"SIGPROF",			// 27
+	"SIGWINCH",			// 28
+	"SIGIO",			// 29 = SIGPOLL = SIGLOST
+	"SIGPWR",			// 30
+	"SIGSYS",			// 31 = SIGUNUSED
+};
+
 /*
  * Trap & Exception support
  */
@@ -314,10 +349,10 @@ static void show_signal_msg(int signr, struct pt_regs *regs, int code,
 	if (!unhandled_signal(current, signr))
 		return;
 
-	pr_info("%s[%d]: unhandled signal %d at "REG_FMT \
-		" nip "REG_FMT" lr "REG_FMT" code %x",
-		current->comm, current->pid, signr, addr,
-		regs->nip, regs->link, code);
+	pr_info("%s[%d]: %s (%d) at "REG_FMT" nip "REG_FMT \
+		" lr "REG_FMT" code %x",
+		current->comm, current->pid, signames[signr],
+		signr, addr, regs->nip, regs->link, code);
 
 	print_vma_addr(KERN_CONT " in ", regs->nip);
 
-- 
2.17.1

