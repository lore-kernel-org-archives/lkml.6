Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC7BC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49289206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393478AbfAPNrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 08:47:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33352 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390676AbfAPNpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 08:45:31 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0GDfPwj113167
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 08:45:30 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q23br75ss-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 08:45:25 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 16 Jan 2019 13:45:22 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 16 Jan 2019 13:45:12 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0GDjBJN9699596
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Jan 2019 13:45:11 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00A28AE04D;
        Wed, 16 Jan 2019 13:45:11 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE7D1AE053;
        Wed, 16 Jan 2019 13:45:06 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.226])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 16 Jan 2019 13:45:06 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Wed, 16 Jan 2019 15:45:06 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guan Xuetao <gxt@pku.edu.cn>, Guo Ren <guoren@kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Mark Salter <msalter@redhat.com>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <monstr@monstr.eu>,
        Paul Burton <paul.burton@mips.com>,
        Petr Mladek <pmladek@suse.com>, Rich Felker <dalias@libc.org>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Stafford Horne <shorne@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        devicetree@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-um@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org,
        openrisc@lists.librecores.org, sparclinux@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp, x86@kernel.org,
        xen-devel@lists.xenproject.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH 09/21] memblock: drop memblock_alloc_base()
Date:   Wed, 16 Jan 2019 15:44:09 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547646261-32535-1-git-send-email-rppt@linux.ibm.com>
References: <1547646261-32535-1-git-send-email-rppt@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19011613-0016-0000-0000-00000246449C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011613-0017-0000-0000-000032A061C3
Message-Id: <1547646261-32535-10-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-16_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901160114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memblock_alloc_base() function tries to allocate a memory up to the
limit specified by its max_addr parameter and panics if the allocation
fails. Replace its usage with memblock_phys_alloc_range() and make the
callers check the return value and panic in case of error.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/powerpc/kernel/rtas.c      |  6 +++++-
 arch/powerpc/mm/hash_utils_64.c |  8 ++++++--
 arch/s390/kernel/smp.c          |  6 +++++-
 drivers/macintosh/smu.c         |  2 +-
 include/linux/memblock.h        |  2 --
 mm/memblock.c                   | 14 --------------
 6 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index de35bd8f..fbc6761 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -1187,7 +1187,11 @@ void __init rtas_initialize(void)
 		ibm_suspend_me_token = rtas_token("ibm,suspend-me");
 	}
 #endif
-	rtas_rmo_buf = memblock_alloc_base(RTAS_RMOBUF_MAX, PAGE_SIZE, rtas_region);
+	rtas_rmo_buf = memblock_phys_alloc_range(RTAS_RMOBUF_MAX, PAGE_SIZE,
+						 0, rtas_region);
+	if (!rtas_rmo_buf)
+		panic("ERROR: RTAS: Failed to allocate %lx bytes below %pa\n",
+		      PAGE_SIZE, &rtas_region);
 
 #ifdef CONFIG_RTAS_ERROR_LOGGING
 	rtas_last_error_token = rtas_token("rtas-last-error");
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index bc6be44..c7d5f48 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -882,8 +882,12 @@ static void __init htab_initialize(void)
 		}
 #endif /* CONFIG_PPC_CELL */
 
-		table = memblock_alloc_base(htab_size_bytes, htab_size_bytes,
-					    limit);
+		table = memblock_phys_alloc_range(htab_size_bytes,
+						  htab_size_bytes,
+						  0, limit);
+		if (!table)
+			panic("ERROR: Failed to allocate %pa bytes below %pa\n",
+			      &htab_size_bytes, &limit);
 
 		DBG("Hash table allocated at %lx, size: %lx\n", table,
 		    htab_size_bytes);
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index f82b3d3..9061597 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -651,7 +651,11 @@ void __init smp_save_dump_cpus(void)
 		/* No previous system present, normal boot. */
 		return;
 	/* Allocate a page as dumping area for the store status sigps */
-	page = memblock_alloc_base(PAGE_SIZE, PAGE_SIZE, 1UL << 31);
+	page = memblock_phys_alloc_range(PAGE_SIZE, PAGE_SIZE, 0, 1UL << 31);
+	if (!page)
+		panic("ERROR: Failed to allocate %x bytes below %lx\n",
+		      PAGE_SIZE, 1UL << 31);
+
 	/* Set multi-threading state to the previous system. */
 	pcpu_set_smt(sclp.mtid_prev);
 	boot_cpu_addr = stap();
diff --git a/drivers/macintosh/smu.c b/drivers/macintosh/smu.c
index 0a0b8e1..42cf68d 100644
--- a/drivers/macintosh/smu.c
+++ b/drivers/macintosh/smu.c
@@ -485,7 +485,7 @@ int __init smu_init (void)
 	 * SMU based G5s need some memory below 2Gb. Thankfully this is
 	 * called at a time where memblock is still available.
 	 */
-	smu_cmdbuf_abs = memblock_alloc_base(4096, 4096, 0x80000000UL);
+	smu_cmdbuf_abs = memblock_phys_alloc_range(4096, 4096, 0, 0x80000000UL);
 	if (smu_cmdbuf_abs == 0) {
 		printk(KERN_ERR "SMU: Command buffer allocation failed !\n");
 		ret = -EINVAL;
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 768e2b4..6874fdc 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -494,8 +494,6 @@ static inline bool memblock_bottom_up(void)
 	return memblock.bottom_up;
 }
 
-phys_addr_t memblock_alloc_base(phys_addr_t size, phys_addr_t align,
-				phys_addr_t max_addr);
 phys_addr_t memblock_phys_mem_size(void);
 phys_addr_t memblock_reserved_size(void);
 phys_addr_t memblock_mem_size(unsigned long limit_pfn);
diff --git a/mm/memblock.c b/mm/memblock.c
index e5ffdcd..531fa77 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1363,20 +1363,6 @@ phys_addr_t __init memblock_phys_alloc_nid(phys_addr_t size, phys_addr_t align,
 	return ret;
 }
 
-phys_addr_t __init memblock_alloc_base(phys_addr_t size, phys_addr_t align, phys_addr_t max_addr)
-{
-	phys_addr_t alloc;
-
-	alloc = memblock_alloc_range_nid(size, align, 0, max_addr, NUMA_NO_NODE,
-					MEMBLOCK_NONE);
-
-	if (alloc == 0)
-		panic("ERROR: Failed to allocate %pa bytes below %pa.\n",
-		      &size, &max_addr);
-
-	return alloc;
-}
-
 phys_addr_t __init memblock_phys_alloc_try_nid(phys_addr_t size, phys_addr_t align, int nid)
 {
 	phys_addr_t res = memblock_phys_alloc_nid(size, align, nid);
-- 
2.7.4

