Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9103C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A7521A07
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:53:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1A7521A07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730362AbeHFNB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 09:01:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52398 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730229AbeHFNB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 09:01:28 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w76An5u6147263
        for <linux-kernel@vger.kernel.org>; Mon, 6 Aug 2018 06:52:58 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kpkksumm3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 06:52:58 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Mon, 6 Aug 2018 11:52:55 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 6 Aug 2018 11:52:53 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w76AqqvI10420372
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Aug 2018 10:52:52 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD21211C05C;
        Mon,  6 Aug 2018 13:53:00 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D34711C04A;
        Mon,  6 Aug 2018 13:52:58 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.115])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  6 Aug 2018 13:52:58 +0100 (BST)
Received: by rapoport-lnx (sSMTP sendmail emulation); Mon, 06 Aug 2018 13:52:48 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Sam Ravnborg <sam@ravnborg.org>, Michal Hocko <mhocko@kernel.org>,
        sparclinux@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH v2 3/3] sparc32: split ramdisk detection and reservation to a helper function
Date:   Mon,  6 Aug 2018 13:52:35 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533552755-16679-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1533552755-16679-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18080610-0028-0000-0000-000002E62309
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080610-0029-0000-0000-0000239E4474
Message-Id: <1533552755-16679-4-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-06_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808060117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The detection and reservation of ramdisk memory were separated to allow
bootmem bitmap initialization after the ramdisk boundaries are detected.
Since the bootmem initialization is removed, the reservation of ramdisk
memory is done immediately after its boundaries are found.

Split the entire block into a separate helper function.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Suggested-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/mm/init_32.c | 56 +++++++++++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 25 deletions(-)

diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index e786fe0..92634d4 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -102,6 +102,36 @@ static unsigned long calc_max_low_pfn(void)
 	return tmp;
 }
 
+static void __init find_ramdisk(unsigned long end_of_phys_memory)
+{
+#ifdef CONFIG_BLK_DEV_INITRD
+	unsigned long size;
+
+	/* Now have to check initial ramdisk, so that it won't pass
+	 * the end of memory
+	 */
+	if (sparc_ramdisk_image) {
+		if (sparc_ramdisk_image >= (unsigned long)&_end - 2 * PAGE_SIZE)
+			sparc_ramdisk_image -= KERNBASE;
+		initrd_start = sparc_ramdisk_image + phys_base;
+		initrd_end = initrd_start + sparc_ramdisk_size;
+		if (initrd_end > end_of_phys_memory) {
+			printk(KERN_CRIT "initrd extends beyond end of memory "
+			       "(0x%016lx > 0x%016lx)\ndisabling initrd\n",
+			       initrd_end, end_of_phys_memory);
+			initrd_start = 0;
+		} else {
+			/* Reserve the initrd image area. */
+			size = initrd_end - initrd_start;
+			memblock_reserve(initrd_start, size);
+
+			initrd_start = (initrd_start - phys_base) + PAGE_OFFSET;
+			initrd_end = (initrd_end - phys_base) + PAGE_OFFSET;
+		}
+	}
+#endif
+}
+
 unsigned long __init bootmem_init(unsigned long *pages_avail)
 {
 	unsigned long start_pfn, bytes_avail, size;
@@ -160,32 +190,8 @@ unsigned long __init bootmem_init(unsigned long *pages_avail)
 		    high_pages >> (20 - PAGE_SHIFT));
 	}
 
-#ifdef CONFIG_BLK_DEV_INITRD
-	/* Now have to check initial ramdisk, so that it won't pass
-	 * the end of memory
-	 */
-	if (sparc_ramdisk_image) {
-		if (sparc_ramdisk_image >= (unsigned long)&_end - 2 * PAGE_SIZE)
-			sparc_ramdisk_image -= KERNBASE;
-		initrd_start = sparc_ramdisk_image + phys_base;
-		initrd_end = initrd_start + sparc_ramdisk_size;
-		if (initrd_end > end_of_phys_memory) {
-			printk(KERN_CRIT "initrd extends beyond end of memory "
-		                 	 "(0x%016lx > 0x%016lx)\ndisabling initrd\n",
-			       initrd_end, end_of_phys_memory);
-			initrd_start = 0;
-		}
-	}
-
-	if (initrd_start) {
-		/* Reserve the initrd image area. */
-		size = initrd_end - initrd_start;
-		memblock_reserve(initrd_start, size);
+	find_ramdisk(end_of_phys_memory);
 
-		initrd_start = (initrd_start - phys_base) + PAGE_OFFSET;
-		initrd_end = (initrd_end - phys_base) + PAGE_OFFSET;
-	}
-#endif
 	/* Reserve the kernel text/data/bss. */
 	size = (start_pfn << PAGE_SHIFT) - phys_base;
 	memblock_reserve(phys_base, size);
-- 
2.7.4

