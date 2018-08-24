Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1346C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91E122147A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:26:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91E122147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbeHXUBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 16:01:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56324 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726488AbeHXUBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 16:01:22 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7OGNpBn119519
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 12:26:00 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m2jx06xpj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 12:26:00 -0400
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Fri, 24 Aug 2018 10:25:59 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e36.co.us.ibm.com (192.168.1.136) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 24 Aug 2018 10:25:55 -0600
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7OGPrJL49479842
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Aug 2018 09:25:53 -0700
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BEE407805F;
        Fri, 24 Aug 2018 10:25:53 -0600 (MDT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D55277805E;
        Fri, 24 Aug 2018 10:25:49 -0600 (MDT)
Received: from morokweng.localdomain.com (unknown [9.80.232.133])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 24 Aug 2018 10:25:49 -0600 (MDT)
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
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [RFC PATCH 01/11] powerpc/svm: Detect Secure Virtual Machine (SVM) platform
Date:   Fri, 24 Aug 2018 13:25:25 -0300
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180824162535.22798-1-bauerman@linux.ibm.com>
References: <20180824162535.22798-1-bauerman@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082416-0020-0000-0000-00000E57A3A3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009603; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01078233; UDB=6.00555984; IPR=6.00858207;
 MB=3.00022909; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-24 16:25:58
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082416-0021-0000-0000-000062CAB5A6
Message-Id: <20180824162535.22798-2-bauerman@linux.ibm.com>
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

A guest requests to be moved to secure memory early at the kernel
startup (in prom_init). Define a flag that can be easily checked by other
parts of the kernel so that they can set things up accordingly. This is
done by checking the MSR(S) bit, which is always set for secure VMs.

Also add a new config option CONFIG_PPC_SVM to wrap all these code to
prevent it from being executed from non subscribing platforms. This SVM
platform detection is applicable only to guest kernels that will run under
an Ultravisor as a secure guest.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 arch/powerpc/Kconfig           | 11 +++++++++++
 arch/powerpc/include/asm/reg.h |  3 +++
 arch/powerpc/include/asm/svm.h | 22 ++++++++++++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 9f2b75fe2c2d..f786c962edf0 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -440,6 +440,17 @@ config MATH_EMULATION_HW_UNIMPLEMENTED
 
 endchoice
 
+config PPC_SVM
+       bool "Secure virtual machine (SVM) support for POWERPC"
+       default n
+       depends on PPC_PSERIES
+       help
+         Support secure guests on POWERPC. There are certain POWER platforms
+	 which support secure guests with the help of an Ultravisor executing
+	 below the hypervisor layer. This enables the support for those guests.
+
+	 If unsure, say "N".
+
 config PPC_TRANSACTIONAL_MEM
        bool "Transactional Memory support for POWERPC"
        depends on PPC_BOOK3S_64
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 562568414cf4..fcf7b79356d0 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -36,6 +36,7 @@
 #define MSR_TM_LG	32		/* Trans Mem Available */
 #define MSR_VEC_LG	25	        /* Enable AltiVec */
 #define MSR_VSX_LG	23		/* Enable VSX */
+#define MSR_S_LG	22		/* Secure VM bit */
 #define MSR_POW_LG	18		/* Enable Power Management */
 #define MSR_WE_LG	18		/* Wait State Enable */
 #define MSR_TGPR_LG	17		/* TLB Update registers in use */
@@ -69,11 +70,13 @@
 #define MSR_SF		__MASK(MSR_SF_LG)	/* Enable 64 bit mode */
 #define MSR_ISF		__MASK(MSR_ISF_LG)	/* Interrupt 64b mode valid on 630 */
 #define MSR_HV 		__MASK(MSR_HV_LG)	/* Hypervisor state */
+#define MSR_S 		__MASK(MSR_S_LG)	/* Secure state */
 #else
 /* so tests for these bits fail on 32-bit */
 #define MSR_SF		0
 #define MSR_ISF		0
 #define MSR_HV		0
+#define MSR_S		0
 #endif
 
 /*
diff --git a/arch/powerpc/include/asm/svm.h b/arch/powerpc/include/asm/svm.h
new file mode 100644
index 000000000000..6f89e5d6d37f
--- /dev/null
+++ b/arch/powerpc/include/asm/svm.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * SVM helper functions
+ *
+ * Copyright 2018 Anshuman Khandual, IBM Corporation.
+ */
+
+#ifndef _ASM_POWERPC_SVM_H
+#define _ASM_POWERPC_SVM_H
+
+#ifdef CONFIG_PPC_SVM
+static bool is_svm_platform(void)
+{
+	return mfmsr() & MSR_S;
+}
+#else
+static inline bool is_svm_platform(void)
+{
+	return false;
+}
+#endif
+#endif /* _ASM_POWERPC_SVM_H */

