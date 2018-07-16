Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0E4ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 06:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCF1420856
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 06:04:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCF1420856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbeGPG3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 02:29:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48472 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726811AbeGPG3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 02:29:44 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6G5wc2c098731
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 02:03:59 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k8h7tr4bp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 02:03:59 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <mahesh@linux.vnet.ibm.com>;
        Mon, 16 Jul 2018 07:03:57 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 16 Jul 2018 07:03:54 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6G63rxt41943164
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Jul 2018 06:03:53 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 842C811C052;
        Mon, 16 Jul 2018 09:04:11 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2AD4411C04A;
        Mon, 16 Jul 2018 09:04:09 +0100 (BST)
Received: from jupiter.in.ibm.com (unknown [9.109.202.229])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 16 Jul 2018 09:04:08 +0100 (BST)
Subject: [RFC PATCH v6 4/4] powerpc/fadump: Do not allow hot-remove memory
 from fadump reserved area.
From:   Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To:     linuxppc-dev <linuxppc-dev@ozlabs.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Michal Hocko <mhocko@suse.com>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>,
        Ananth Narayan <ananth@in.ibm.com>, kernelfans@gmail.com
Date:   Mon, 16 Jul 2018 11:33:49 +0530
In-Reply-To: <153172096333.29252.4376707071382727345.stgit@jupiter.in.ibm.com>
References: <153172096333.29252.4376707071382727345.stgit@jupiter.in.ibm.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18071606-0020-0000-0000-000002A6E677
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071606-0021-0000-0000-000020F34410
Message-Id: <153172102841.29252.14752362099821314856.stgit@jupiter.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-16_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807160072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

For fadump to work successfully there should not be any holes in reserved
memory ranges where kernel has asked firmware to move the content of old
kernel memory in event of crash. Now that fadump reserved memory is marked
as movable zone, this memory area is now not protected from hot-remove
operations. Hence, fadump service can fail to re-register after the
hot-remove operation, if hot-removed memory belongs to fadump reserved
region. To avoid this make sure that memory from fadump reserved area is
not hot-removable if fadump is registered.

However, if user still wants to remove that memory, he can do so by
manually stopping fadump service before hot-remove operation.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/fadump.h               |    2 +-
 arch/powerpc/kernel/fadump.c                    |   10 ++++++++--
 arch/powerpc/platforms/pseries/hotplug-memory.c |    7 +++++--
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/fadump.h b/arch/powerpc/include/asm/fadump.h
index 5c0de4508aab..cd28e9b59057 100644
--- a/arch/powerpc/include/asm/fadump.h
+++ b/arch/powerpc/include/asm/fadump.h
@@ -208,7 +208,7 @@ struct fad_crash_memory_ranges {
 	unsigned long long	size;
 };
 
-extern int is_fadump_boot_memory_area(u64 addr, ulong size);
+extern int is_fadump_memory_area(u64 addr, ulong size);
 extern int early_init_dt_scan_fw_dump(unsigned long node,
 		const char *uname, int depth, void *data);
 extern int fadump_reserve_mem(void);
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index d1375f3f48c3..18a35f12ffb5 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -116,13 +116,19 @@ int __init early_init_dt_scan_fw_dump(unsigned long node,
 
 /*
  * If fadump is registered, check if the memory provided
- * falls within boot memory area.
+ * falls within boot memory area and reserved memory area.
  */
-int is_fadump_boot_memory_area(u64 addr, ulong size)
+int is_fadump_memory_area(u64 addr, ulong size)
 {
+	u64 d_start = fw_dump.reserve_dump_area_start;
+	u64 d_end = d_start + fw_dump.reserve_dump_area_size;
+
 	if (!fw_dump.dump_registered)
 		return 0;
 
+	if (((addr + size) > d_start) && (addr <= d_end))
+		return 1;
+
 	return (addr + size) > RMA_START && addr <= fw_dump.boot_memory_size;
 }
 
diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index c1578f54c626..e4c658cda3a7 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -389,8 +389,11 @@ static bool lmb_is_removable(struct drmem_lmb *lmb)
 	phys_addr = lmb->base_addr;
 
 #ifdef CONFIG_FA_DUMP
-	/* Don't hot-remove memory that falls in fadump boot memory area */
-	if (is_fadump_boot_memory_area(phys_addr, block_sz))
+	/*
+	 * Don't hot-remove memory that falls in fadump boot memory area
+	 * and memory that is reserved for capturing old kernel memory.
+	 */
+	if (is_fadump_memory_area(phys_addr, block_sz))
 		return false;
 #endif
 

