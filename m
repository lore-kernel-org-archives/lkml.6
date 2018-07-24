Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2726C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A6920852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:23:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80A6920852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388401AbeGXOaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 10:30:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44728 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388297AbeGXO37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 10:29:59 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6ODIdbR127013
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 09:23:30 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ke41mjwjb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 09:23:30 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Tue, 24 Jul 2018 14:23:28 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 24 Jul 2018 14:23:25 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6ODNOED34013316
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 24 Jul 2018 13:23:24 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EEEBFAE055;
        Tue, 24 Jul 2018 16:23:32 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A30BAE056;
        Tue, 24 Jul 2018 16:23:31 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.56])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 24 Jul 2018 16:23:31 +0100 (BST)
Received: by rapoport-lnx (sSMTP sendmail emulation); Tue, 24 Jul 2018 16:23:21 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc:     Michal Hocko <mhocko@kernel.org>, linux-um@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 2/2] um: switch to NO_BOOTMEM
Date:   Tue, 24 Jul 2018 16:23:14 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532438594-4530-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1532438594-4530-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18072413-0020-0000-0000-000002AA79AC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072413-0021-0000-0000-000020F70C25
Message-Id: <1532438594-4530-3-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-24_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=885 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807240141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace bootmem initialization with memblock_add and memblock_reserve calls
and explicit initialization of {min,max}_low_pfn.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 arch/um/Kconfig.common   |  2 ++
 arch/um/kernel/physmem.c | 20 +++++++++-----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/um/Kconfig.common b/arch/um/Kconfig.common
index 07f84c8..1487957 100644
--- a/arch/um/Kconfig.common
+++ b/arch/um/Kconfig.common
@@ -8,6 +8,8 @@ config UML
 	select HAVE_UID16
 	select HAVE_FUTEX_CMPXCHG if FUTEX
 	select HAVE_DEBUG_KMEMLEAK
+	select HAVE_MEMBLOCK
+	select NO_BOOTMEM
 	select GENERIC_IRQ_SHOW
 	select GENERIC_CPU_DEVICES
 	select GENERIC_CLOCKEVENTS
diff --git a/arch/um/kernel/physmem.c b/arch/um/kernel/physmem.c
index 0eaec0e..296a91a 100644
--- a/arch/um/kernel/physmem.c
+++ b/arch/um/kernel/physmem.c
@@ -5,6 +5,7 @@
 
 #include <linux/module.h>
 #include <linux/bootmem.h>
+#include <linux/memblock.h>
 #include <linux/mm.h>
 #include <linux/pfn.h>
 #include <asm/page.h>
@@ -80,23 +81,18 @@ void __init setup_physmem(unsigned long start, unsigned long reserve_end,
 			  unsigned long len, unsigned long long highmem)
 {
 	unsigned long reserve = reserve_end - start;
-	unsigned long pfn = PFN_UP(__pa(reserve_end));
-	unsigned long delta = (len - reserve) >> PAGE_SHIFT;
-	unsigned long offset, bootmap_size;
-	long map_size;
+	long map_size = len - reserve;
 	int err;
 
-	offset = reserve_end - start;
-	map_size = len - offset;
 	if(map_size <= 0) {
 		os_warn("Too few physical memory! Needed=%lu, given=%lu\n",
-			offset, len);
+			reserve, len);
 		exit(1);
 	}
 
 	physmem_fd = create_mem_file(len + highmem);
 
-	err = os_map_memory((void *) reserve_end, physmem_fd, offset,
+	err = os_map_memory((void *) reserve_end, physmem_fd, reserve,
 			    map_size, 1, 1, 1);
 	if (err < 0) {
 		os_warn("setup_physmem - mapping %ld bytes of memory at 0x%p "
@@ -113,9 +109,11 @@ void __init setup_physmem(unsigned long start, unsigned long reserve_end,
 	os_write_file(physmem_fd, __syscall_stub_start, PAGE_SIZE);
 	os_fsync_file(physmem_fd);
 
-	bootmap_size = init_bootmem(pfn, pfn + delta);
-	free_bootmem(__pa(reserve_end) + bootmap_size,
-		     len - bootmap_size - reserve);
+	memblock_add(__pa(start), len + highmem);
+	memblock_reserve(__pa(start), reserve);
+
+	min_low_pfn = PFN_UP(__pa(reserve_end));
+	max_low_pfn = min_low_pfn + (map_size >> PAGE_SHIFT);
 }
 
 int phys_mapping(unsigned long phys, unsigned long long *offset_out)
-- 
2.7.4

