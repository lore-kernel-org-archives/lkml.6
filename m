Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A99C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26A3320874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:44:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26A3320874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933572AbeFTUoA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 16:44:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36178 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933384AbeFTUmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 16:42:47 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5KKenCV143811
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 16:42:47 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jqvwx2ud3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 16:42:47 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Wed, 20 Jun 2018 14:42:46 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 20 Jun 2018 14:42:42 -0600
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5KKggZM000414
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Jun 2018 13:42:42 -0700
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EBDDC6A051;
        Wed, 20 Jun 2018 14:42:41 -0600 (MDT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C2DA6A047;
        Wed, 20 Jun 2018 14:42:41 -0600 (MDT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 20 Jun 2018 14:42:41 -0600 (MDT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        zohar@linux.vnet.ibm.com
Cc:     jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH v2 2/4] ima: Implement ima_shutdown and register it as a reboot_notifier
Date:   Wed, 20 Jun 2018 16:42:34 -0400
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180620204236.1572523-1-stefanb@linux.vnet.ibm.com>
References: <20180620204236.1572523-1-stefanb@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062020-0036-0000-0000-00000A018A63
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009228; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01049869; UDB=6.00537986; IPR=6.00828842;
 MB=3.00021764; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-20 20:42:44
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062020-0037-0000-0000-000047CF8C29
Message-Id: <20180620204236.1572523-3-stefanb@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-20_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806200224
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement ima_shutdown so that we can release the tpm_chip before
devices are shut down. Register it as a low-priority reboot_notifier.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 security/integrity/ima/ima_init.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 29b72cd2502e..8a5258eb32b6 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -21,6 +21,7 @@
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
 #include <linux/err.h>
+#include <linux/reboot.h>
 
 #include "ima.h"
 
@@ -104,11 +105,24 @@ void __init ima_load_x509(void)
 }
 #endif
 
+static int ima_shutdown(struct notifier_block *this, unsigned long action,
+			void *data)
+{
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block ima_reboot_notifier = {
+	.notifier_call = ima_shutdown,
+	.priority = 0,
+};
+
 int __init ima_init(void)
 {
 	u8 pcr_i[TPM_DIGEST_SIZE];
 	int rc;
 
+	register_reboot_notifier(&ima_reboot_notifier);
+
 	ima_used_chip = 0;
 	rc = tpm_pcr_read(NULL, 0, pcr_i);
 	if (rc == 0)
-- 
2.13.6

