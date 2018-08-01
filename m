Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE6BC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31E9D208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:34:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31E9D208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732516AbeHAXWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 19:22:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42574 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725881AbeHAXWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 19:22:16 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w71LYHhw073163
        for <linux-kernel@vger.kernel.org>; Wed, 1 Aug 2018 17:34:30 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kkjjd5f29-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 17:34:29 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <muriloo@linux.ibm.com>;
        Wed, 1 Aug 2018 17:34:28 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 1 Aug 2018 17:34:22 -0400
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w71LYL3X5505450
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 1 Aug 2018 21:34:21 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4193AC05F;
        Wed,  1 Aug 2018 17:34:59 -0400 (EDT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70D22AC05B;
        Wed,  1 Aug 2018 17:34:55 -0400 (EDT)
Received: from kermit-br-ibm-com.ibmmodules.com (unknown [9.80.99.86])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  1 Aug 2018 17:34:55 -0400 (EDT)
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
Subject: [PATCH v4 6/6] powerpc/traps: Show instructions on exceptions
Date:   Wed,  1 Aug 2018 18:33:20 -0300
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180801213320.11203-1-muriloo@linux.ibm.com>
References: <20180801213320.11203-1-muriloo@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18080121-0060-0000-0000-000002961418
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009468; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01068949; UDB=6.00549596; IPR=6.00847297;
 MB=3.00022446; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-01 21:34:26
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080121-0061-0000-0000-00004602E5BB
Message-Id: <20180801213320.11203-7-muriloo@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-01_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=736 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1808010218
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call show_user_instructions() in arch/powerpc/kernel/traps.c to dump
instructions at faulty location, useful to debugging.

Before this patch, an unhandled signal message looked like:

  pandafault[10524]: segfault (11) at 100007d0 nip 1000061c lr 7fffbd295100 code 2 in pandafault[10000000+10000]

After this patch, it looks like:

  pandafault[10524]: segfault (11) at 100007d0 nip 1000061c lr 7fffbd295100 code 2 in pandafault[10000000+10000]
  pandafault[10524]: code: 4bfffeec 4bfffee8 3c401002 38427f00 fbe1fff8 f821ffc1 7c3f0b78 3d22fffe
  pandafault[10524]: code: 392988d0 f93f0020 e93f0020 39400048 <99490000> 39200000 7d234b78 383f0040

Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
---
 arch/powerpc/kernel/traps.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index bcefbb1ee771..8494b0ff4904 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -70,6 +70,7 @@
 #include <asm/hmi.h>
 #include <sysdev/fsl_pci.h>
 #include <asm/kprobes.h>
+#include <asm/stacktrace.h>
 
 #if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC_CORE)
 int (*__debugger)(struct pt_regs *regs) __read_mostly;
@@ -337,6 +338,8 @@ static void show_signal_msg(int signr, struct pt_regs *regs, int code,
 	print_vma_addr(KERN_CONT " in ", regs->nip);
 
 	pr_cont("\n");
+
+	show_user_instructions(regs);
 }
 
 void _exception_pkey(int signr, struct pt_regs *regs, int code,
-- 
2.17.1

