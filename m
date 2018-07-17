Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85610ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 411FC2083B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:01:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 411FC2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730503AbeGQQeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:34:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51106 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730185AbeGQQeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:34:11 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6HG0hig094061
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 12:00:51 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k9h49fbt5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 12:00:49 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
        Tue, 17 Jul 2018 10:00:35 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 17 Jul 2018 10:00:32 -0600
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6HG0VPL17629666
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Jul 2018 09:00:31 -0700
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6186778067;
        Tue, 17 Jul 2018 10:00:31 -0600 (MDT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E96E078068;
        Tue, 17 Jul 2018 10:00:30 -0600 (MDT)
Received: from sofia.ibm.com (unknown [9.77.206.69])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 17 Jul 2018 10:00:30 -0600 (MDT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id 5C1952E2F46; Tue, 17 Jul 2018 21:30:25 +0530 (IST)
From:   "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Neuling <mikey@neuling.org>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Florian Weimer <fweimer@redhat.com>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: [RESEND][PATCH] powerpc/powernv : Save/Restore SPRG3 on entry/exit from stop.
Date:   Tue, 17 Jul 2018 21:30:16 +0530
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1531826849-31838-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1531826849-31838-1-git-send-email-ego@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18071716-0036-0000-0000-00000A10AF16
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009380; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01062154; UDB=6.00545323; IPR=6.00840012;
 MB=3.00022173; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-17 16:00:35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071716-0037-0000-0000-000048225FF8
Message-Id: <1531843216-22209-1-git-send-email-ego@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-17_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807170167
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

On 64-bit servers, SPRN_SPRG3 and its userspace read-only mirror
SPRN_USPRG3 are used as userspace VDSO write and read registers
respectively.

SPRN_SPRG3 is lost when we enter stop4 and above, and is currently not
restored.  As a result, any read from SPRN_USPRG3 returns zero on an
exit from stop4 and above.

Thus in this situation, on POWER9, any call from sched_getcpu() always
returns zero, as on powerpc, we call __kernel_getcpu() which relies
upon SPRN_USPRG3 to report the CPU and NUMA node information.

Fix this by saving the SPRN_SPRG3 before entering a deep stop state,
and restoring it back on wakeup from the stop state.

Fixes: e1c1cfed5432 ("powerpc/powernv: Save/Restore additional SPRs
for stop4 cpuidle")

Reported-by: Florian Weimer <fweimer@redhat.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Michael Neuling <mikey@neuling.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/cpuidle.h | 1 +
 arch/powerpc/kernel/asm-offsets.c  | 1 +
 arch/powerpc/kernel/idle_book3s.S  | 5 +++++
 3 files changed, 7 insertions(+)

diff --git a/arch/powerpc/include/asm/cpuidle.h b/arch/powerpc/include/asm/cpuidle.h
index e210a83..03fa904 100644
--- a/arch/powerpc/include/asm/cpuidle.h
+++ b/arch/powerpc/include/asm/cpuidle.h
@@ -77,6 +77,7 @@ struct stop_sprs {
 	u64 mmcr1;
 	u64 mmcr2;
 	u64 mmcra;
+	u64 sprg3;
 };
 
 extern u32 pnv_fastsleep_workaround_at_entry[];
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 89cf155..a35ebfc 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -776,6 +776,7 @@ int main(void)
 	STOP_SPR(STOP_MMCR1, mmcr1);
 	STOP_SPR(STOP_MMCR2, mmcr2);
 	STOP_SPR(STOP_MMCRA, mmcra);
+	STOP_SPR(STOP_SPRG3, sprg3);
 #endif
 
 	DEFINE(PPC_DBELL_SERVER, PPC_DBELL_SERVER);
diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index d85d551..5069d42 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -120,6 +120,9 @@ power9_save_additional_sprs:
 	mfspr	r4, SPRN_MMCR2
 	std	r3, STOP_MMCR1(r13)
 	std	r4, STOP_MMCR2(r13)
+
+	mfspr	r3, SPRN_SPRG3
+	std	r3, STOP_SPRG3(r13)
 	blr
 
 power9_restore_additional_sprs:
@@ -144,7 +147,9 @@ power9_restore_additional_sprs:
 	mtspr	SPRN_MMCR1, r4
 
 	ld	r3, STOP_MMCR2(r13)
+	ld	r4, STOP_SPRG3(r13)
 	mtspr	SPRN_MMCR2, r3
+	mtspr	SPRN_SPRG3, r4
 	blr
 
 /*
-- 
1.9.4

