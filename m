Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86005C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B3C82147A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:26:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B3C82147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbeHXUCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 16:02:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57462 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726488AbeHXUCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 16:02:10 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7OGNvAW124290
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 12:26:47 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m2msehw1e-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 12:26:47 -0400
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Fri, 24 Aug 2018 10:26:46 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 24 Aug 2018 10:26:42 -0600
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7OGQfGD27721902
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Aug 2018 09:26:41 -0700
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F4277805E;
        Fri, 24 Aug 2018 10:26:41 -0600 (MDT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D3127805F;
        Fri, 24 Aug 2018 10:26:38 -0600 (MDT)
Received: from morokweng.localdomain.com (unknown [9.80.232.133])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 24 Aug 2018 10:26:37 -0600 (MDT)
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
Subject: [RFC PATCH 10/11] powerpc/svm: Force the use of bounce buffers
Date:   Fri, 24 Aug 2018 13:25:34 -0300
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180824162535.22798-1-bauerman@linux.ibm.com>
References: <20180824162535.22798-1-bauerman@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082416-0012-0000-0000-000016A594FA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009603; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01078233; UDB=6.00555984; IPR=6.00858207;
 MB=3.00022909; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-24 16:26:45
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082416-0013-0000-0000-0000542852B0
Message-Id: <20180824162535.22798-11-bauerman@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-24_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=866 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808240172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anshuman Khandual <khandual@linux.vnet.ibm.com>

SWIOTLB checks range of incoming CPU addresses to be bounced and see if the
device can access it through it's DMA window without requiring bouncing. In
such cases it just chooses to skip bouncing. But for cases like secure
guests on powerpc platform all addresses need to be bounced into the shared
pool of memory because the host cannot access it otherwise. Hence the need
to do the bouncing is not related to device's DMA window. Hence force the
use of bouncing by setting the swiotlb_force variable on secure guests.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 arch/powerpc/kernel/svm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/svm.c b/arch/powerpc/kernel/svm.c
index 1af5caa955f5..f0576ad65cd0 100644
--- a/arch/powerpc/kernel/svm.c
+++ b/arch/powerpc/kernel/svm.c
@@ -17,6 +17,7 @@ static int __init init_svm(void)
 		return 0;
 
 	ppc_swiotlb_enable = 1;
+	swiotlb_force = SWIOTLB_FORCE;
 	swiotlb_update_mem_attributes();
 
 	return 0;

