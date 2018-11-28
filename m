Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A7FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B1E92081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:34:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B1E92081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbeK2Bgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:36:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54278 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727872AbeK2Bgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:36:48 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wASEYIor008285
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 09:34:56 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p1tve62t6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 09:34:55 -0500
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Wed, 28 Nov 2018 14:34:55 -0000
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
        by e36.co.us.ibm.com (192.168.1.136) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 28 Nov 2018 14:34:52 -0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wASEYpMh16973910
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Nov 2018 14:34:51 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8CE656E059;
        Wed, 28 Nov 2018 14:34:51 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C6736E052;
        Wed, 28 Nov 2018 14:34:48 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.85.87.253])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 28 Nov 2018 14:34:48 +0000 (GMT)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     akpm@linux-foundation.org, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH V2 0/5] NestMMU pte upgrade workaround for mprotect
Date:   Wed, 28 Nov 2018 20:04:33 +0530
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18112814-0020-0000-0000-00000E918F63
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010137; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01124008; UDB=6.00583546; IPR=6.00904137;
 MB=3.00024366; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-28 14:34:54
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112814-0021-0000-0000-000063DE30C9
Message-Id: <20181128143438.29458-1-aneesh.kumar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-28_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=429 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811280129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


We can upgrade pte access (R -> RW transition) via mprotect. We need
to make sure we follow the recommended pte update sequence as outlined in
commit: bd5050e38aec ("powerpc/mm/radix: Change pte relax sequence to handle nest MMU hang")
for such updates. This patch series do that.

Changes from V1:
* Restrict ths only for R->RW upgrade. We don't need to do this for Autonuma
* Restrict this only for radix translation mode.

Aneesh Kumar K.V (5):
  mm: Update ptep_modify_prot_start/commit to take vm_area_struct as arg
  mm: update ptep_modify_prot_commit to take old pte value as arg
  arch/powerpc/mm: Nest MMU workaround for mprotect RW upgrade.
  mm/hugetlb: Add prot_modify_start/commit sequence for hugetlb update
  arch/powerpc/mm/hugetlb: NestMMU workaround for hugetlb mprotect RW
    upgrade

 arch/powerpc/include/asm/book3s/64/hugetlb.h | 12 ++++++++
 arch/powerpc/include/asm/book3s/64/pgtable.h | 18 ++++++++++++
 arch/powerpc/include/asm/book3s/64/radix.h   |  4 +++
 arch/powerpc/mm/hugetlbpage-radix.c          | 17 ++++++++++++
 arch/powerpc/mm/hugetlbpage.c                | 29 ++++++++++++++++++++
 arch/powerpc/mm/pgtable-book3s64.c           | 27 ++++++++++++++++++
 arch/powerpc/mm/pgtable-radix.c              | 18 ++++++++++++
 arch/s390/include/asm/pgtable.h              |  5 ++--
 arch/s390/mm/pgtable.c                       |  8 ++++--
 arch/x86/include/asm/paravirt.h              |  9 ++++--
 fs/proc/task_mmu.c                           |  8 ++++--
 include/asm-generic/pgtable.h                | 10 +++----
 include/linux/hugetlb.h                      | 18 ++++++++++++
 mm/hugetlb.c                                 |  8 ++++--
 mm/memory.c                                  |  8 +++---
 mm/mprotect.c                                |  6 ++--
 16 files changed, 179 insertions(+), 26 deletions(-)

-- 
2.19.1

