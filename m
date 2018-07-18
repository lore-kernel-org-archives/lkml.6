Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C3EECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 08:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 830632075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 08:33:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 830632075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730211AbeGRJKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 05:10:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52326 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729209AbeGRJKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 05:10:12 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6I8U9Tv139871
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 04:33:25 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ka0aq4a9e-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 04:33:24 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
        Wed, 18 Jul 2018 04:33:23 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 18 Jul 2018 04:33:20 -0400
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6I8XJkl9568564
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Jul 2018 08:33:19 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 44273AC060;
        Wed, 18 Jul 2018 04:34:10 -0400 (EDT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 030DCAC066;
        Wed, 18 Jul 2018 04:34:09 -0400 (EDT)
Received: from sofia.ibm.com (unknown [9.124.35.39])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 18 Jul 2018 04:34:09 -0400 (EDT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id 6EF952E2F57; Wed, 18 Jul 2018 14:03:17 +0530 (IST)
From:   "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Neuling <mikey@neuling.org>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Florian Weimer <fweimer@redhat.com>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        <stable@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH v2] powerpc/powernv : Save/Restore SPRG3 on entry/exit from stop.
Date:   Wed, 18 Jul 2018 14:03:16 +0530
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 18071808-0068-0000-0000-00000319F33B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009385; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01062485; UDB=6.00545522; IPR=6.00840342;
 MB=3.00022184; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-18 08:33:22
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071808-0069-0000-0000-00004512AFCC
Message-Id: <1531902796-32294-1-git-send-email-ego@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-18_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807180098
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

Fix this by restoring SPRN_SPRG3 on wake up from a deep stop state
with the sprg_vdso value that is cached in PACA.

Fixes: e1c1cfed5432 ("powerpc/powernv: Save/Restore additional SPRs
for stop4 cpuidle")

Reported-by: Florian Weimer <fweimer@redhat.com>
Cc: <stable@vger.kernel.org> # 4.14
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Michael Neuling <mikey@neuling.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
Change from v1: 
  Restoring the SPRG3 from paca->sprg_vdso instead of saving
  it separately during stop-entry, as suggested by Mikey.
  
 arch/powerpc/kernel/idle_book3s.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index d85d551..672ead8 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -144,7 +144,9 @@ power9_restore_additional_sprs:
 	mtspr	SPRN_MMCR1, r4
 
 	ld	r3, STOP_MMCR2(r13)
+	ld	r4, PACA_SPRG_VDSO(r13)
 	mtspr	SPRN_MMCR2, r3
+	mtspr	SPRN_SPRG3, r4
 	blr
 
 /*
-- 
1.8.3.1

