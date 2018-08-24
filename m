Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDA5C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 03:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92A4C21570
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 03:00:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92A4C21570
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbeHXGdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 02:33:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52148 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726640AbeHXGdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 02:33:05 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7O2wtjs119486
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 23:00:29 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m27bem8tc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 23:00:29 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Thu, 23 Aug 2018 23:00:28 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 23 Aug 2018 23:00:25 -0400
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7O30O4B20709590
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Aug 2018 03:00:24 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 747EFAE05F;
        Thu, 23 Aug 2018 22:59:55 -0400 (EDT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 62AA2AE063;
        Thu, 23 Aug 2018 22:59:52 -0400 (EDT)
Received: from morokweng.localdomain.com (unknown [9.85.189.29])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 23 Aug 2018 22:59:52 -0400 (EDT)
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
Subject: [RFC PATCH 07/11] powerpc/svm: Use shared memory for Debug Trace Log (DTL)
Date:   Thu, 23 Aug 2018 23:59:29 -0300
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180824025933.24319-1-bauerman@linux.ibm.com>
References: <20180824025933.24319-1-bauerman@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082403-0064-0000-0000-000003411B41
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009600; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01077964; UDB=6.00555823; IPR=6.00857939;
 MB=3.00022897; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-24 03:00:27
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082403-0065-0000-0000-00003A687679
Message-Id: <20180824025933.24319-8-bauerman@linux.ibm.com>
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

On Ultravisor platform kmem_cache for DTL buffers must use a constructor
function which converts the underlying buddy allocated SLUB cache pages
into shared memory so that they are accessible to the hypervisor.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 arch/powerpc/include/asm/svm.h         |  1 +
 arch/powerpc/kernel/svm.c              | 30 ++++++++++++++++++++++++++++++
 arch/powerpc/platforms/pseries/setup.c |  5 ++++-
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/svm.h b/arch/powerpc/include/asm/svm.h
index 95d69e472e52..e00688761704 100644
--- a/arch/powerpc/include/asm/svm.h
+++ b/arch/powerpc/include/asm/svm.h
@@ -16,6 +16,7 @@ static bool is_svm_platform(void)
 
 extern void mem_convert_shared(unsigned long pfn, unsigned long npages);
 extern void mem_convert_secure(unsigned long pfn, unsigned long npages);
+extern void dtl_cache_ctor(void *addr);
 #else
 static inline bool is_svm_platform(void)
 {
diff --git a/arch/powerpc/kernel/svm.c b/arch/powerpc/kernel/svm.c
index 891db2de8c04..1af5caa955f5 100644
--- a/arch/powerpc/kernel/svm.c
+++ b/arch/powerpc/kernel/svm.c
@@ -66,3 +66,33 @@ int set_memory_decrypted(unsigned long addr, int numpages)
 
 	return 0;
 }
+
+/* There's one dispatch log per CPU. */
+#define NR_DTL_PAGE (DISPATCH_LOG_BYTES * CONFIG_NR_CPUS / PAGE_SIZE)
+
+static struct page *dtl_page_store[NR_DTL_PAGE];
+static long dtl_nr_pages;
+
+static bool is_dtl_page_shared(struct page *page)
+{
+	long i;
+
+	for (i = 0; i < dtl_nr_pages; i++)
+		if (dtl_page_store[i] == page)
+			return true;
+
+	return false;
+}
+
+void dtl_cache_ctor(void *addr)
+{
+	unsigned long pfn = PHYS_PFN(__pa(addr));
+	struct page *page = pfn_to_page(pfn);
+
+	if (!is_dtl_page_shared(page)) {
+		dtl_page_store[dtl_nr_pages] = page;
+		dtl_nr_pages++;
+		WARN_ON(dtl_nr_pages >= NR_DTL_PAGE);
+		mem_convert_shared(pfn, PAGE_SIZE);
+	}
+}
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 139f0af6c3d9..50ba77c802d2 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -69,6 +69,7 @@
 #include <asm/kexec.h>
 #include <asm/isa-bridge.h>
 #include <asm/security_features.h>
+#include <asm/svm.h>
 
 #include "pseries.h"
 
@@ -288,8 +289,10 @@ static inline int alloc_dispatch_logs(void)
 
 static int alloc_dispatch_log_kmem_cache(void)
 {
+	void (*ctor)(void *) = is_svm_platform() ? dtl_cache_ctor : NULL;
+
 	dtl_cache = kmem_cache_create("dtl", DISPATCH_LOG_BYTES,
-						DISPATCH_LOG_BYTES, 0, NULL);
+						DISPATCH_LOG_BYTES, 0, ctor);
 	if (!dtl_cache) {
 		pr_warn("Failed to create dispatch trace log buffer cache\n");
 		pr_warn("Stolen time statistics will be unreliable\n");

