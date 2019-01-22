Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28CFC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 801D720870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfAVVSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 16:18:34 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39728 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726866AbfAVVSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 16:18:32 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0MLFllW000636
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 16:18:32 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q69b9bm50-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 16:18:31 -0500
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Tue, 22 Jan 2019 21:18:31 -0000
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 22 Jan 2019 21:18:27 -0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0MLIQf723724032
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Jan 2019 21:18:26 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6460DBE053;
        Tue, 22 Jan 2019 21:18:26 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 387C0BE05A;
        Tue, 22 Jan 2019 21:18:22 +0000 (GMT)
Received: from morokweng.localdomain.com (unknown [9.85.185.73])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 22 Jan 2019 21:18:21 +0000 (GMT)
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     x86@kernel.org
Cc:     kvm@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [PATCH 1/2] dma-direct: set_memory_{en,de}crypted() take number of pages
Date:   Tue, 22 Jan 2019 19:17:57 -0200
X-Mailer: git-send-email 2.17.2
X-TM-AS-GCONF: 00
x-cbid: 19012221-0004-0000-0000-000014D6A738
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010457; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000275; SDB=6.01150301; UDB=6.00599445; IPR=6.00930634;
 MB=3.00025245; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-22 21:18:31
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012221-0005-0000-0000-00008A51EFEC
Message-Id: <20190122211758.8317-1-bauerman@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-22_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901220159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ram Pai <linuxram@us.ibm.com>

set_memory_encrypted() and set_memory_decrypted() expect the number of
PAGE_SIZE pages to encrypt or decrypt. dma_direct_alloc() and
dma_direct_free() instead pass number of bytes. This encrypts/decrypts a
huge number of pages resulting in data corruption.

Fixed it.

[ bauermann: Slightly reworded commit message and added Fixes: tag. ]
Fixes: d7b417fa08d1 ("x86/mm: Add DMA support for SEV memory encryption")
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 kernel/dma/direct.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

Notes:

1. This was tested on powerpc with patches adding support for running
   under the ultravisor, which are not yet upstream.

2. The lines changed in this patch were added by commit c10f07aa27da
   ("dma/direct: Handle force decryption for DMA coherent buffers in
   common code"), but it only moves the code from an x86-specific file.
   Therefore the Fixes tag references the commit that first introduced
   the code.

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 355d16acee6d..bc78c37220ba 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -166,7 +166,7 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 
 	ret = page_address(page);
 	if (force_dma_unencrypted()) {
-		set_memory_decrypted((unsigned long)ret, 1 << get_order(size));
+		set_memory_decrypted((unsigned long)ret, 1);
 		*dma_handle = __phys_to_dma(dev, page_to_phys(page));
 	} else {
 		*dma_handle = phys_to_dma(dev, page_to_phys(page));
@@ -186,10 +186,8 @@ void __dma_direct_free_pages(struct device *dev, size_t size, struct page *page)
 void dma_direct_free_pages(struct device *dev, size_t size, void *cpu_addr,
 		dma_addr_t dma_addr, unsigned long attrs)
 {
-	unsigned int page_order = get_order(size);
-
 	if (force_dma_unencrypted())
-		set_memory_encrypted((unsigned long)cpu_addr, 1 << page_order);
+		set_memory_encrypted((unsigned long)cpu_addr, 1);
 	__dma_direct_free_pages(dev, size, virt_to_page(cpu_addr));
 }
 

