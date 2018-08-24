Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4120BC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 03:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC8C52156E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 03:00:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC8C52156E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbeHXGdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 02:33:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59250 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726640AbeHXGdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 02:33:14 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7O2wuGt056020
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 23:00:38 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m25ptya6j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 23:00:37 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Thu, 23 Aug 2018 23:00:36 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 23 Aug 2018 23:00:33 -0400
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7O30WDw852356
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Aug 2018 03:00:32 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DBC49AE05F;
        Thu, 23 Aug 2018 23:00:03 -0400 (EDT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C3CBAAE066;
        Thu, 23 Aug 2018 23:00:00 -0400 (EDT)
Received: from morokweng.localdomain.com (unknown [9.85.189.29])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 23 Aug 2018 23:00:00 -0400 (EDT)
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Anshuman Khandual <anshuman.linux@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christoph Hellwig <hch@lst.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Anderson <andmike@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Ram Pai <linuxram@us.ibm.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [RFC PATCH 09/11] powerpc/svm: Use shared memory for LPPACA structures
Date:   Thu, 23 Aug 2018 23:59:31 -0300
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180824025933.24319-1-bauerman@linux.ibm.com>
References: <20180824025933.24319-1-bauerman@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082403-0068-0000-0000-0000032EBE98
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009600; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01077964; UDB=6.00555823; IPR=6.00857939;
 MB=3.00022897; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-24 03:00:36
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082403-0069-0000-0000-0000457F2731
Message-Id: <20180824025933.24319-10-bauerman@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-24_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808240029
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anshuman Khandual <khandual@linux.vnet.ibm.com>

LPPACA structures need to be shared with the host. Hence they need to be on
shared memory. Instead of allocating individual chunks of memory for given
structure from memblock, a contiguous chunk of memory is allocated and then
converted into shared memory. Subsequent allocation requests will come from
the contiguous chunk which will be always shared memory for all structures.

While we were able to use a kmem_cache constructor for the Debug Trace Log,
LPPACAs are allocated very early in the boot process (before SLUB is
available) so we need to use a simpler scheme here.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 arch/powerpc/kernel/paca.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 1edf8695019d..3e2aca150ad2 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -17,6 +17,7 @@
 #include <asm/sections.h>
 #include <asm/pgtable.h>
 #include <asm/kexec.h>
+#include <asm/svm.h>
 
 #include "setup.h"
 
@@ -25,6 +26,33 @@
 #endif
 
 #define LPPACA_SIZE 0x400
+#define SHARED_LPPACA_SIZE PAGE_ALIGN(LPPACA_SIZE * CONFIG_NR_CPUS)
+
+static phys_addr_t shared_lppaca_pa;
+static unsigned long shared_lppaca_size;
+
+static void *__init alloc_shared_lppaca(unsigned long size, unsigned long align,
+				unsigned long limit, int cpu)
+{
+	unsigned long pa;
+
+	if (!shared_lppaca_pa) {
+		memblock_set_bottom_up(true);
+		shared_lppaca_pa = memblock_alloc_base_nid(SHARED_LPPACA_SIZE,
+					PAGE_SIZE, limit, -1, MEMBLOCK_NONE);
+		if (!shared_lppaca_pa)
+			panic("cannot allocate shared data");
+		memblock_set_bottom_up(false);
+		mem_convert_shared(PHYS_PFN(shared_lppaca_pa),
+				       SHARED_LPPACA_SIZE / PAGE_SIZE);
+	}
+
+	pa = shared_lppaca_pa + shared_lppaca_size;
+	shared_lppaca_size += size;
+
+	BUG_ON(shared_lppaca_size >= SHARED_LPPACA_SIZE);
+	return __va(pa);
+}
 
 static void *__init alloc_paca_data(unsigned long size, unsigned long align,
 				unsigned long limit, int cpu)
@@ -88,7 +116,11 @@ static struct lppaca * __init new_lppaca(int cpu, unsigned long limit)
 	if (early_cpu_has_feature(CPU_FTR_HVMODE))
 		return NULL;
 
-	lp = alloc_paca_data(LPPACA_SIZE, 0x400, limit, cpu);
+	if (is_svm_platform())
+		lp = alloc_shared_lppaca(LPPACA_SIZE, 0x400, limit, cpu);
+	else
+		lp = alloc_paca_data(LPPACA_SIZE, 0x400, limit, cpu);
+
 	init_lppaca(lp);
 
 	return lp;

