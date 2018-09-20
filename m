Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E59DC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 04:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECA092150E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 04:39:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECA092150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731159AbeITKVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 06:21:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44490 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726902AbeITKVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 06:21:06 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8K4dZZE086611
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 00:39:40 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mm3h7jd47-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 00:39:37 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Thu, 20 Sep 2018 00:39:18 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 20 Sep 2018 00:39:15 -0400
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8K4dEld26149036
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Sep 2018 04:39:14 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5752C112062;
        Thu, 20 Sep 2018 00:38:42 -0400 (EDT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A090F112061;
        Thu, 20 Sep 2018 00:38:40 -0400 (EDT)
Received: from morokweng.localdomain.com (unknown [9.80.234.67])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 20 Sep 2018 00:38:40 -0400 (EDT)
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ram Pai <linuxram@us.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [PATCH] powerpc/pkeys: Fix reading of ibm,processor-storage-keys property
Date:   Thu, 20 Sep 2018 01:38:58 -0300
X-Mailer: git-send-email 2.14.4
X-TM-AS-GCONF: 00
x-cbid: 18092004-0060-0000-0000-000002B2623C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009737; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01090896; UDB=6.00563608; IPR=6.00870914;
 MB=3.00023401; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-20 04:39:16
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092004-0061-0000-0000-00004691ADD4
Message-Id: <20180920043858.28773-1-bauerman@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-20_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=733 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809200048
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

scan_pkey_feature() uses of_property_read_u32_array() to read the
ibm,processor-storage-keys property and calls be32_to_cpu() on the
value it gets. The problem is that of_property_read_u32_array() already
returns the value converted to the CPU byte order.

The value of pkeys_total ends up more or less sane because there's a min()
call in pkey_initialize() which reduces pkeys_total to 32. So in practice
the kernel ignores the fact that the hypervisor reserved one key for
itself (the device tree advertises 31 keys in my test VM).

This is wrong, but the effect in practice is that when a process tries to
allocate the 32nd key, it gets an -EINVAL error instead of -ENOSPC which
would indicate that there aren't any keys available

Fixes: cf43d3b26452 ("powerpc: Enable pkey subsystem")
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 arch/powerpc/mm/pkeys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
index 333b1f80c435..b271b283c785 100644
--- a/arch/powerpc/mm/pkeys.c
+++ b/arch/powerpc/mm/pkeys.c
@@ -45,7 +45,7 @@ static void scan_pkey_feature(void)
 	 * Since any pkey can be used for data or execute, we will just treat
 	 * all keys as equal and track them as one entity.
 	 */
-	pkeys_total = be32_to_cpu(vals[0]);
+	pkeys_total = vals[0];
 	pkeys_devtree_defined = true;
 }
 

