Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859CDECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 06:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20DC520856
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 06:03:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20DC520856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbeGPG3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 02:29:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57150 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726811AbeGPG3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 02:29:24 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6G5wc5l139007
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 02:03:39 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k8bny8y9f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 02:03:39 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <mahesh@linux.vnet.ibm.com>;
        Mon, 16 Jul 2018 07:03:36 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 16 Jul 2018 07:03:33 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6G63WTE29491294
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Jul 2018 06:03:32 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 71CD64204F;
        Mon, 16 Jul 2018 09:03:51 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D59042056;
        Mon, 16 Jul 2018 09:03:49 +0100 (BST)
Received: from jupiter.in.ibm.com (unknown [9.109.202.229])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 16 Jul 2018 09:03:48 +0100 (BST)
Subject: [RFC PATCH v6 2/4] powerpc/fadump: Reservationless firmware
 assisted dump
From:   Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To:     linuxppc-dev <linuxppc-dev@ozlabs.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Cc:     Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Michal Hocko <mhocko@suse.com>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>,
        Ananth Narayan <ananth@in.ibm.com>, kernelfans@gmail.com
Date:   Mon, 16 Jul 2018 11:33:29 +0530
In-Reply-To: <153172096333.29252.4376707071382727345.stgit@jupiter.in.ibm.com>
References: <153172096333.29252.4376707071382727345.stgit@jupiter.in.ibm.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18071606-0016-0000-0000-000001E72CE4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071606-0017-0000-0000-0000323BD3E2
Message-Id: <153172100522.29252.16969445427798362497.stgit@jupiter.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-16_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807160072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

One of the primary issues with Firmware Assisted Dump (fadump) on Power
is that it needs a large amount of memory to be reserved. On large
systems with TeraBytes of memory, this reservation can be quite
significant.

In some cases, fadump fails if the memory reserved is insufficient, or
if the reserved memory was DLPAR hot-removed.

In the normal case, post reboot, the preserved memory is filtered to
extract only relevant areas of interest using the makedumpfile tool.
While the tool provides flexibility to determine what needs to be part
of the dump and what memory to filter out, all supported distributions
default this to "Capture only kernel data and nothing else".

We take advantage of this default and the Linux kernel's zone movable
feature to fundamentally change the memory reservation model for fadump.

Instead of setting aside a significant chunk of memory nobody can use,
this patch marks a significant chunk of reserved memory as ZONE_MOVABLE
that the kernel is prevented from using (due to MIGRATE_MOVABLE),
but applications are free to use it. With this fadump will still be able
to capture all of the kernel memory and most of the user space memory
except the user pages that were present in ZONE_MOVABLE zone. But if
someone wants to capture all of user space memory and ok with reserved
memory not available to production system, then 'fadump=nonmovable' kernel
parameter can be used to fallback to old behaviour.

Essentially, on a P9 LPAR with 2 cores, 8GB RAM and current upstream:
[root@zzxx-yy10 ~]# free -m
              total        used        free      shared  buff/cache   available
Mem:           7557         193        6822          12         541        6725
Swap:          4095           0        4095

With this patch:
[root@zzxx-yy10 ~]# free -m
              total        used        free      shared  buff/cache   available
Mem:           8133         194        7464          12         475        7338
Swap:          4095           0        4095

Changes made here are completely transparent to how fadump has
traditionally worked.

Signed-off-by: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 Documentation/powerpc/firmware-assisted-dump.txt |   18 +++++
 arch/powerpc/include/asm/fadump.h                |    5 +
 arch/powerpc/kernel/fadump.c                     |   80 ++++++++++++++++++++--
 3 files changed, 95 insertions(+), 8 deletions(-)

diff --git a/Documentation/powerpc/firmware-assisted-dump.txt b/Documentation/powerpc/firmware-assisted-dump.txt
index bdd344aa18d9..f8a6343a1dcf 100644
--- a/Documentation/powerpc/firmware-assisted-dump.txt
+++ b/Documentation/powerpc/firmware-assisted-dump.txt
@@ -113,7 +113,16 @@ header, is usually reserved at an offset greater than boot memory
 size (see Fig. 1). This area is *not* released: this region will
 be kept permanently reserved, so that it can act as a receptacle
 for a copy of the boot memory content in addition to CPU state
-and HPTE region, in the case a crash does occur.
+and HPTE region, in the case a crash does occur. Since this reserved
+memory area is used only after the system crash, there is no point in
+blocking this significant chunk of memory from production kernel.
+Hence, the implementation marks the memory reserved for fadump as
+ZONE_MOVABLE. With ZONE_MOVABLE this memory will be available for
+applications to use it, while kernel is prevented from using it. With
+this fadump will still be able to capture all of the kernel memory and
+most of the user space memory except the user pages that were present
+in ZONE_MOVABLE region.
+
 
   o Memory Reservation during first kernel
 
@@ -162,6 +171,9 @@ How to enable firmware-assisted dump (fadump):
 
 1. Set config option CONFIG_FA_DUMP=y and build kernel.
 2. Boot into linux kernel with 'fadump=on' kernel cmdline option.
+   By default, the reserved memory will be marked as zone movable.
+   Alternatively, user can boot linux kernel with 'fadump=nonmovable' to
+   prevent fadump to mark reserved memory as zone movable.
 3. Optionally, user can also set 'crashkernel=' kernel cmdline
    to specify size of the memory to reserve for boot memory dump
    preservation.
@@ -172,6 +184,10 @@ NOTE: 1. 'fadump_reserve_mem=' parameter has been deprecated. Instead
       2. If firmware-assisted dump fails to reserve memory then it
          will fallback to existing kdump mechanism if 'crashkernel='
          option is set at kernel cmdline.
+      3. if user wants to capture all of user space memory and ok with
+         reserved memory not available to production system, then
+         'fadump=nonmovable' kernel parameter can be used to fallback to
+         old behaviour.
 
 Sysfs/debugfs files:
 ------------
diff --git a/arch/powerpc/include/asm/fadump.h b/arch/powerpc/include/asm/fadump.h
index 5a23010af600..5c0de4508aab 100644
--- a/arch/powerpc/include/asm/fadump.h
+++ b/arch/powerpc/include/asm/fadump.h
@@ -48,6 +48,10 @@
 
 #define memblock_num_regions(memblock_type)	(memblock.memblock_type.cnt)
 
+/* Alignement per core mm requirement. */
+#define FADUMP_PAGEBLOCK_ALIGNMENT	(PAGE_SIZE <<			\
+			max_t(unsigned long, MAX_ORDER - 1, pageblock_order))
+
 /* Firmware provided dump sections */
 #define FADUMP_CPU_STATE_DATA	0x0001
 #define FADUMP_HPTE_REGION	0x0002
@@ -141,6 +145,7 @@ struct fw_dump {
 	unsigned long	fadump_supported:1;
 	unsigned long	dump_active:1;
 	unsigned long	dump_registered:1;
+	unsigned long	nonmovable:1;		/* !ZONE_MOVABLE */
 };
 
 /*
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 07e8396d472b..ce333c1d4cb8 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -34,6 +34,7 @@
 #include <linux/crash_dump.h>
 #include <linux/kobject.h>
 #include <linux/sysfs.h>
+#include <linux/mmzone.h>
 
 #include <asm/debugfs.h>
 #include <asm/page.h>
@@ -375,8 +376,11 @@ int __init fadump_reserve_mem(void)
 	 */
 	if (fdm_active)
 		fw_dump.boot_memory_size = be64_to_cpu(fdm_active->rmr_region.source_len);
-	else
+	else {
 		fw_dump.boot_memory_size = fadump_calculate_reserve_size();
+		fw_dump.boot_memory_size = ALIGN(fw_dump.boot_memory_size,
+						FADUMP_PAGEBLOCK_ALIGNMENT);
+	}
 
 	/*
 	 * Calculate the memory boundary.
@@ -423,8 +427,7 @@ int __init fadump_reserve_mem(void)
 		fw_dump.fadumphdr_addr =
 				be64_to_cpu(fdm_active->rmr_region.destination_address) +
 				be64_to_cpu(fdm_active->rmr_region.source_len);
-		pr_debug("fadumphdr_addr = %p\n",
-				(void *) fw_dump.fadumphdr_addr);
+		pr_debug("fadumphdr_addr = %pa\n", &fw_dump.fadumphdr_addr);
 	} else {
 		size = get_fadump_area_size();
 
@@ -474,6 +477,10 @@ static int __init early_fadump_param(char *p)
 		fw_dump.fadump_enabled = 1;
 	else if (strncmp(p, "off", 3) == 0)
 		fw_dump.fadump_enabled = 0;
+	else if (strncmp(p, "nonmovable", 10) == 0) {
+		fw_dump.fadump_enabled = 1;
+		fw_dump.nonmovable = 1;
+	}
 
 	return 0;
 }
@@ -1146,7 +1153,7 @@ static int fadump_unregister_dump(struct fadump_mem_struct *fdm)
 	return 0;
 }
 
-static int fadump_invalidate_dump(struct fadump_mem_struct *fdm)
+static int fadump_invalidate_dump(const struct fadump_mem_struct *fdm)
 {
 	int rc = 0;
 	unsigned int wait_time;
@@ -1177,9 +1184,8 @@ void fadump_cleanup(void)
 {
 	/* Invalidate the registration only if dump is active. */
 	if (fw_dump.dump_active) {
-		init_fadump_mem_struct(&fdm,
-			be64_to_cpu(fdm_active->cpu_state_data.destination_address));
-		fadump_invalidate_dump(&fdm);
+		/* pass the same memory dump structure provided by platform */
+		fadump_invalidate_dump(fdm_active);
 	} else if (fw_dump.dump_registered) {
 		/* Un-register Firmware-assisted dump if it was registered. */
 		fadump_unregister_dump(&fdm);
@@ -1525,3 +1531,63 @@ int __init setup_fadump(void)
 	return 1;
 }
 subsys_initcall(setup_fadump);
+
+/*
+ * Mark the fadump reserved area as ZONE_MOVABLE.
+ * The total size of fadump reserved memory covers for boot memory size
+ * + cpu data size + hpte size and metadata. Initialize only the area
+ * equivalent to boot memory size as zone movable. The reamining portion
+ * of fadump reserved memory will be not given to movable zone and pages
+ * for thoes will stay reserved. boot memory size is aligned per core mm
+ * requirement to satisy zone_movable_init_reserved_mem() call.
+ * But for some reason even if it fails we still have the memory reservation
+ * with us and we can still continue doing fadump.
+ */
+static int __init fadump_init_reserved_mem(void)
+{
+	unsigned long long base, size;
+	int rc;
+
+	if (!fw_dump.fadump_enabled)
+		return 0;
+
+	/* Ignore if booted with fadump=nonmovable */
+	if (fw_dump.nonmovable)
+		return 0;
+
+	if (fw_dump.dump_active)
+		return 0;
+
+	/*
+	 * Mark only the size equivalent to boot memory size as movable
+	 * zone.
+	 */
+	base = fw_dump.reserve_dump_area_start;
+	size = fw_dump.boot_memory_size;
+
+	if (!size)
+		return 0;
+
+	rc = zone_movable_init_reserved_mem(base, size);
+	if (rc) {
+		pr_err("Failed to init zone movable area for firmware-assisted dump,%d\n", rc);
+		/*
+		 * Though the zone movable init has failed, we still have memory
+		 * reservation with us. The reserved memory will be
+		 * blocked from production system usage.  Hence return 1,
+		 * so that we can continue with fadump.
+		 */
+		return 1;
+	}
+
+	/*
+	 * So we now have successfully initialized reserved area as
+	 * ZONE_MOVABLE for fadump.
+	 */
+	pr_info("Initialized 0x%llx bytes as zone movable area at %ldMB from "
+		"0x%lx bytes of memory reserved for firmware-assisted dump\n",
+		size, (unsigned long)base >> 20,
+		fw_dump.reserve_dump_area_size);
+	return 1;
+}
+core_initcall(fadump_init_reserved_mem);

