Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2953AECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 06:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D3820856
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 06:03:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3D3820856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbeGPG3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 02:29:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33174 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726811AbeGPG3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 02:29:32 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6G5wtxT136812
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 02:03:48 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k8js95kcf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 02:03:47 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <mahesh@linux.vnet.ibm.com>;
        Mon, 16 Jul 2018 07:03:46 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 16 Jul 2018 07:03:44 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6G63h9m42729596
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Jul 2018 06:03:43 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CBDBFAE064;
        Mon, 16 Jul 2018 09:04:00 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D3F1AE063;
        Mon, 16 Jul 2018 09:03:58 +0100 (BST)
Received: from jupiter.in.ibm.com (unknown [9.109.202.229])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 16 Jul 2018 09:03:58 +0100 (BST)
Subject: [RFC PATCH v6 3/4] powerpc/fadump: throw proper error message on
 fadump registration failure.
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
Date:   Mon, 16 Jul 2018 11:33:39 +0530
In-Reply-To: <153172096333.29252.4376707071382727345.stgit@jupiter.in.ibm.com>
References: <153172096333.29252.4376707071382727345.stgit@jupiter.in.ibm.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18071606-0012-0000-0000-0000028A8D02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071606-0013-0000-0000-000020BC4381
Message-Id: <153172101748.29252.12590745448233151667.stgit@jupiter.in.ibm.com>
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

fadump fails to register when there are holes in reserved memory area.
This can happen if user has hot-removed a memory that falls in the fadump
reserved memory area. Throw a meaningful error message to the user in
such case.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/fadump.c |   33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index ce333c1d4cb8..d1375f3f48c3 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -170,6 +170,36 @@ static int is_boot_memory_area_contiguous(void)
 	return ret;
 }
 
+/*
+ * Returns 1, if there are no holes in reserved memory area,
+ * 0 otherwise.
+ */
+static int is_reserved_memory_area_contiguous(void)
+{
+	struct memblock_region *reg;
+	unsigned long start, end;
+	unsigned long d_start = fw_dump.reserve_dump_area_start;
+	unsigned long d_end = d_start + fw_dump.reserve_dump_area_size;
+	int ret = 0;
+
+	for_each_memblock(memory, reg) {
+		start = max(d_start, (unsigned long)reg->base);
+		end = min(d_end, (unsigned long)(reg->base + reg->size));
+		if (d_start < end) {
+			/* Memory hole from d_start to start */
+			if (start > d_start)
+				break;
+
+			if (end == d_end) {
+				ret = 1;
+				break;
+			}
+			d_start = end + 1;
+		}
+	}
+	return ret;
+}
+
 /* Print firmware assisted dump configurations for debugging purpose. */
 static void fadump_show_config(void)
 {
@@ -531,6 +561,9 @@ static int register_fw_dump(struct fadump_mem_struct *fdm)
 		if (!is_boot_memory_area_contiguous())
 			pr_err("Can't have holes in boot memory area while "
 			       "registering fadump\n");
+		else if (!is_reserved_memory_area_contiguous())
+			pr_err("Can't have holes in reserved memory area while"
+			       " registering fadump\n");
 
 		printk(KERN_ERR "Failed to register firmware-assisted kernel"
 			" dump. Parameter Error(%d).\n", rc);

