Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD2CC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 930FC21523
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:26:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 930FC21523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbeHXUBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 16:01:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56072 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726488AbeHXUBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 16:01:36 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7OGNpWf098593
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 12:26:15 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m2msq9kdc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 12:26:14 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Fri, 24 Aug 2018 10:26:13 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 24 Aug 2018 10:26:10 -0600
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7OGQ9eN51314916
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Aug 2018 09:26:09 -0700
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 547B67805C;
        Fri, 24 Aug 2018 10:26:09 -0600 (MDT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B162B78066;
        Fri, 24 Aug 2018 10:26:05 -0600 (MDT)
Received: from morokweng.localdomain.com (unknown [9.80.232.133])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 24 Aug 2018 10:26:05 -0600 (MDT)
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
Subject: [RFC PATCH 04/11] powerpc/svm: Convert SWIOTLB buffers to shared memory
Date:   Fri, 24 Aug 2018 13:25:28 -0300
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180824162535.22798-1-bauerman@linux.ibm.com>
References: <20180824162535.22798-1-bauerman@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082416-0004-0000-0000-0000147CD83E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009603; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01078233; UDB=6.00555984; IPR=6.00858208;
 MB=3.00022910; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-24 16:26:13
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082416-0005-0000-0000-00008892DD8D
Message-Id: <20180824162535.22798-5-bauerman@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-24_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808240172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anshuman Khandual <khandual@linux.vnet.ibm.com>

Hook the shared memory conversion functions into the ARCH_HAS_MEM_ENCRYPT
framework and call swiotlb_update_mem_attributes() to convert SWIOTLB's
buffers to shared memory.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 arch/powerpc/Kconfig                   |  4 ++++
 arch/powerpc/include/asm/mem_encrypt.h | 19 +++++++++++++++++++
 arch/powerpc/kernel/svm.c              | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 90f73d15f58a..1466d1234723 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -440,12 +440,16 @@ config MATH_EMULATION_HW_UNIMPLEMENTED
 
 endchoice
 
+config ARCH_HAS_MEM_ENCRYPT
+	def_bool n
+
 config PPC_SVM
        bool "Secure virtual machine (SVM) support for POWERPC"
        default n
        depends on PPC_PSERIES
        select DMA_DIRECT_OPS
        select SWIOTLB
+       select ARCH_HAS_MEM_ENCRYPT
        help
          Support secure guests on POWERPC. There are certain POWER platforms
 	 which support secure guests with the help of an Ultravisor executing
diff --git a/arch/powerpc/include/asm/mem_encrypt.h b/arch/powerpc/include/asm/mem_encrypt.h
new file mode 100644
index 000000000000..2b6e37ea446c
--- /dev/null
+++ b/arch/powerpc/include/asm/mem_encrypt.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * SVM helper functions
+ *
+ * Copyright 2018 IBM Corporation
+ */
+
+#ifndef _ASM_POWERPC_MEM_ENCRYPT_H
+#define _ASM_POWERPC_MEM_ENCRYPT_H
+
+#define sme_me_mask	0ULL
+
+static inline bool sme_active(void) { return false; }
+static inline bool sev_active(void) { return false; }
+
+int set_memory_encrypted(unsigned long addr, int numpages);
+int set_memory_decrypted(unsigned long addr, int numpages);
+
+#endif /* _ASM_POWERPC_MEM_ENCRYPT_H */
diff --git a/arch/powerpc/kernel/svm.c b/arch/powerpc/kernel/svm.c
index 37437cf92df5..eab2a64d8643 100644
--- a/arch/powerpc/kernel/svm.c
+++ b/arch/powerpc/kernel/svm.c
@@ -7,6 +7,20 @@
  */
 
 #include <linux/mm.h>
+#include <linux/swiotlb.h>
+#include <asm/machdep.h>
+#include <asm/svm.h>
+
+static int __init init_svm(void)
+{
+	if (!is_svm_platform())
+		return 0;
+
+	swiotlb_update_mem_attributes();
+
+	return 0;
+}
+machine_early_initcall(pseries, init_svm);
 
 void mem_convert_shared(unsigned long pfn, unsigned long npages)
 {
@@ -31,3 +45,23 @@ void mem_convert_secure(unsigned long pfn, unsigned long npages)
 	 * ucall_convert_secure(paddr, size)
 	 */
 }
+
+int set_memory_encrypted(unsigned long addr, int numpages)
+{
+	if (!PAGE_ALIGNED(addr))
+		return -EINVAL;
+
+	mem_convert_secure(PHYS_PFN(__pa(addr)), numpages);
+
+	return 0;
+}
+
+int set_memory_decrypted(unsigned long addr, int numpages)
+{
+	if (!PAGE_ALIGNED(addr))
+		return -EINVAL;
+
+	mem_convert_shared(PHYS_PFN(__pa(addr)), numpages);
+
+	return 0;
+}

