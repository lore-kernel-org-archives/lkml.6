Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A9DC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86618208AC
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:59:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86618208AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388877AbeG0QVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 12:21:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49618 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388156AbeG0QVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 12:21:44 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6RExOlr095447
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 10:59:26 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kg3p7nhhh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 10:59:26 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <muriloo@linux.ibm.com>;
        Fri, 27 Jul 2018 10:59:25 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 27 Jul 2018 10:59:22 -0400
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6RExLqs4718982
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 27 Jul 2018 14:59:21 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0FEE8AC05B;
        Fri, 27 Jul 2018 11:00:04 -0400 (EDT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 07FC0AC059;
        Fri, 27 Jul 2018 10:59:59 -0400 (EDT)
Received: from kermit-br-ibm-com.ibmmodules.com (unknown [9.80.82.251])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 27 Jul 2018 10:59:58 -0400 (EDT)
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
Subject: [PATCH v2 06/10] powerpc/traps: Print signal name for unhandled signals
Date:   Fri, 27 Jul 2018 11:58:07 -0300
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180727145811.12334-1-muriloo@linux.ibm.com>
References: <20180727145811.12334-1-muriloo@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18072714-0052-0000-0000-000003146029
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009438; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01066907; UDB=6.00548186; IPR=6.00844773;
 MB=3.00022354; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-27 14:59:25
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072714-0053-0000-0000-00005D82CED9
Message-Id: <20180727145811.12334-7-muriloo@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-27_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=762 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807270154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a human-readable name in the unhandled signal message.

Before this patch, a page fault looked like:

    pandafault[6303]: unhandled signal 11 at 00000000100007d0 nip 000000001000061c lr 00007fff93c55100 code 2 in pandafault[10000000+10000]

After this patch, a page fault looks like:

    pandafault[6352]: segfault (11) at 000000013a2a09f8 nip 000000013a2a086c lr 00007fffb63e5100 code 2 in pandafault[13a2a0000+10000]

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

