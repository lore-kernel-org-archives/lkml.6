Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED7AC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71995208DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:54:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71995208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387402AbeHBNpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 09:45:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37964 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732281AbeHBNpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 09:45:14 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w72BsLY8041925
        for <linux-kernel@vger.kernel.org>; Thu, 2 Aug 2018 07:54:24 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2km0vc1m9h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 07:54:23 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Thu, 2 Aug 2018 12:54:07 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 2 Aug 2018 12:54:04 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w72Bs32U28639266
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 2 Aug 2018 11:54:03 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E74C42042;
        Thu,  2 Aug 2018 14:54:14 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88E4B4204B;
        Thu,  2 Aug 2018 14:54:12 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.207.181])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  2 Aug 2018 14:54:12 +0100 (BST)
Received: by rapoport-lnx (sSMTP sendmail emulation); Thu, 02 Aug 2018 14:54:00 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Sam Ravnborg <sam@ravnborg.org>, Michal Hocko <mhocko@kernel.org>,
        sparclinux@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 2/2] sparc32: tidy up ramdisk memory reservation
Date:   Thu,  2 Aug 2018 14:53:53 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533210833-14748-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1533210833-14748-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18080211-0020-0000-0000-000002AFF0A7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080211-0021-0000-0000-000020FC1D25
Message-Id: <1533210833-14748-3-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-02_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=897 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1808020125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The detection and reservation of ramdisk memory were separated to allow
bootmem bitmap initialization after the ramdisk boundaries are detected.
Since the bootmem initialization is removed, the reservation of ramdisk
memory can be done immediately after its boundaries are found.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 arch/sparc/mm/init_32.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index 5117a5e..b5d8f90 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -161,6 +161,8 @@ unsigned long __init bootmem_init(unsigned long *pages_avail)
 		    high_pages >> (20 - PAGE_SHIFT));
 	}
 
+	*pages_avail = (memblock_phys_mem_size() >> PAGE_SHIFT) - high_pages;
+
 #ifdef CONFIG_BLK_DEV_INITRD
 	/*
 	 * Now have to check initial ramdisk, so that it won't pass
@@ -176,23 +178,17 @@ unsigned long __init bootmem_init(unsigned long *pages_avail)
 		                 	 "(0x%016lx > 0x%016lx)\ndisabling initrd\n",
 			       initrd_end, end_of_phys_memory);
 			initrd_start = 0;
+		} else {
+			/* Reserve the initrd image area. */
+			size = initrd_end - initrd_start;
+			memblock_reserve(initrd_start, size);
+			*pages_avail -= PAGE_ALIGN(size) >> PAGE_SHIFT;
+
+			initrd_start = (initrd_start - phys_base) + PAGE_OFFSET;
+			initrd_end = (initrd_end - phys_base) + PAGE_OFFSET;
 		}
 	}
 #endif
-
-	*pages_avail = (memblock_phys_mem_size() >> PAGE_SHIFT) - high_pages;
-
-#ifdef CONFIG_BLK_DEV_INITRD
-	if (initrd_start) {
-		/* Reserve the initrd image area. */
-		size = initrd_end - initrd_start;
-		memblock_reserve(initrd_start, size);
-		*pages_avail -= PAGE_ALIGN(size) >> PAGE_SHIFT;
-
-		initrd_start = (initrd_start - phys_base) + PAGE_OFFSET;
-		initrd_end = (initrd_end - phys_base) + PAGE_OFFSET;
-	}
-#endif
 	/* Reserve the kernel text/data/bss. */
 	size = (start_pfn << PAGE_SHIFT) - phys_base;
 	memblock_reserve(phys_base, size);
-- 
2.7.4

