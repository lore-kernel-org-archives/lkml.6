Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085C1C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 03:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABF232088E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 03:00:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABF232088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbeHXGcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 02:32:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43778 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726458AbeHXGcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 02:32:48 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7O2wrmL126239
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 23:00:12 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m26g75w28-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 23:00:12 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Thu, 23 Aug 2018 23:00:11 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 23 Aug 2018 23:00:07 -0400
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7O3062p21102668
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Aug 2018 03:00:06 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2850AE064;
        Thu, 23 Aug 2018 22:59:37 -0400 (EDT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F610AE060;
        Thu, 23 Aug 2018 22:59:34 -0400 (EDT)
Received: from morokweng.localdomain.com (unknown [9.85.189.29])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 23 Aug 2018 22:59:34 -0400 (EDT)
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
Subject: [RFC PATCH 03/11] powerpc/svm: Add memory conversion (shared/secure) helper functions
Date:   Thu, 23 Aug 2018 23:59:25 -0300
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180824025933.24319-1-bauerman@linux.ibm.com>
References: <20180824025933.24319-1-bauerman@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082403-0060-0000-0000-000002A37E25
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009600; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01077964; UDB=6.00555823; IPR=6.00857939;
 MB=3.00022897; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-24 03:00:09
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082403-0061-0000-0000-00004645DDEA
Message-Id: <20180824025933.24319-4-bauerman@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-24_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=930 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808240029
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anshuman Khandual <khandual@linux.vnet.ibm.com>

Add the following helper functions to convert PAGE_SIZE aligned memory
buffers as shared or secure (i.e., accessible to the hypervisor or not) via
Ultravisor calls.

1. mem_convert_shared(unsigned long pfn, unsigned long npages)
2. mem_convert_secure(unsigned long pfn, unsigned long npages)

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 arch/powerpc/include/asm/svm.h |  3 +++
 arch/powerpc/kernel/Makefile   |  1 +
 arch/powerpc/kernel/svm.c      | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/arch/powerpc/include/asm/svm.h b/arch/powerpc/include/asm/svm.h
index 6f89e5d6d37f..95d69e472e52 100644
--- a/arch/powerpc/include/asm/svm.h
+++ b/arch/powerpc/include/asm/svm.h
@@ -13,6 +13,9 @@ static bool is_svm_platform(void)
 {
 	return mfmsr() & MSR_S;
 }
+
+extern void mem_convert_shared(unsigned long pfn, unsigned long npages);
+extern void mem_convert_secure(unsigned long pfn, unsigned long npages);
 #else
 static inline bool is_svm_platform(void)
 {
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 2b4c40b255e4..98780b4e924c 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -113,6 +113,7 @@ ifeq ($(CONFIG_HAVE_IMA_KEXEC)$(CONFIG_IMA),yy)
 obj-y				+= ima_kexec.o
 endif
 
+obj-$(CONFIG_PPC_SVM)		+= svm.o
 obj-$(CONFIG_AUDIT)		+= audit.o
 obj64-$(CONFIG_AUDIT)		+= compat_audit.o
 
diff --git a/arch/powerpc/kernel/svm.c b/arch/powerpc/kernel/svm.c
new file mode 100644
index 000000000000..37437cf92df5
--- /dev/null
+++ b/arch/powerpc/kernel/svm.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Secure VM platform
+ *
+ * Copyright 2018 IBM Corporation
+ * Author: Anshuman Khandual <khandual@linux.vnet.ibm.com>
+ */
+
+#include <linux/mm.h>
+
+void mem_convert_shared(unsigned long pfn, unsigned long npages)
+{
+	if (!pfn_valid(pfn))
+		return;
+
+	/*
+	 * FIXME: Insert real UV call when ready
+	 *
+	 * ucall_convert_shared(paddr, size)
+	 */
+}
+
+void mem_convert_secure(unsigned long pfn, unsigned long npages)
+{
+	if (!pfn_valid(pfn))
+		return;
+
+	/*
+	 * FIXME: Insert real UV call when ready
+	 *
+	 * ucall_convert_secure(paddr, size)
+	 */
+}

