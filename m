Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C21C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 07:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E29220BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 07:10:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E29220BF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbeGLHST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 03:18:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55446 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725992AbeGLHST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 03:18:19 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6C78lAM040745
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 03:10:04 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k61axkmq6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 03:10:04 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Thu, 12 Jul 2018 08:09:58 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 12 Jul 2018 08:09:55 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6C79rX041222300
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Jul 2018 07:09:53 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C4974C044;
        Thu, 12 Jul 2018 10:10:15 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 340FE4C05C;
        Thu, 12 Jul 2018 10:10:15 +0100 (BST)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 12 Jul 2018 10:10:15 +0100 (BST)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>,
        Stefan Raspl <raspl@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH] perf kvm: Fix subcommands on s390
Date:   Thu, 12 Jul 2018 09:09:36 +0200
X-Mailer: git-send-email 2.16.4
X-TM-AS-GCONF: 00
x-cbid: 18071207-0008-0000-0000-000002523932
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071207-0009-0000-0000-000021B87063
Message-Id: <20180712070936.67547-1-tmricht@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-12_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807120073
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With commit eca0fa28cd0d ("perf record: Provide detailed information on s390 CPU")
s390 platform provides detailed type/model/capacitiy information
in the CPU indentifier string instead of just "IBM/S390".

This breaks perf kvm support which uses hard coded string IBM/S390 to
compare with the CPU identifier string. Fix this by changing the comparison.

Fixes: eca0fa28cd0d ("perf record: Provide detailed information on s390 CPU")
Cc: Stefan Raspl <raspl@linux.ibm.com>
Cc: <stable@vger.kernel.org> # 4.17

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
---
 tools/perf/arch/s390/util/kvm-stat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/s390/util/kvm-stat.c b/tools/perf/arch/s390/util/kvm-stat.c
index d233e2eb9592..aaabab5e2830 100644
--- a/tools/perf/arch/s390/util/kvm-stat.c
+++ b/tools/perf/arch/s390/util/kvm-stat.c
@@ -102,7 +102,7 @@ const char * const kvm_skip_events[] = {
 
 int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid)
 {
-	if (strstr(cpuid, "IBM/S390")) {
+	if (strstr(cpuid, "IBM")) {
 		kvm->exit_reasons = sie_exit_reasons;
 		kvm->exit_reasons_isa = "SIE";
 	} else
-- 
2.14.3

