Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBBCC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7BD126E1B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:09:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7BD126E1B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754847AbeFZTJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 15:09:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54002 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754777AbeFZTJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 15:09:45 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5QJ8XFo051897
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 15:09:44 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jutw9h9gg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 15:09:44 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Tue, 26 Jun 2018 13:09:43 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Jun 2018 13:09:42 -0600
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5QJ9fB79568648
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 12:09:41 -0700
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E53A6A05F;
        Tue, 26 Jun 2018 13:09:41 -0600 (MDT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D4296A04F;
        Tue, 26 Jun 2018 13:09:40 -0600 (MDT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 26 Jun 2018 13:09:40 -0600 (MDT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        zohar@linux.vnet.ibm.com
Cc:     jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH v7 3/5] tpm: Convert tpm_find_get_ops() to use tpm_default_chip()
Date:   Tue, 26 Jun 2018 15:09:31 -0400
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180626190933.2508821-1-stefanb@linux.vnet.ibm.com>
References: <20180626190933.2508821-1-stefanb@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062619-0016-0000-0000-000008FFC33F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009259; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052708; UDB=6.00539692; IPR=6.00830633;
 MB=3.00021866; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 19:09:43
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062619-0017-0000-0000-00003F6B72A2
Message-Id: <20180626190933.2508821-4-stefanb@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-26_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=793 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806260213
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert tpm_find_get_ops() to use tpm_default_chip() in case no chip
is passed in.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/tpm-chip.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index f551061262c9..46caadca916a 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -124,29 +124,23 @@ EXPORT_SYMBOL_GPL(tpm_default_chip);
  */
 struct tpm_chip *tpm_find_get_ops(struct tpm_chip *chip)
 {
-	struct tpm_chip *res = NULL;
-	int chip_num = 0;
-	int chip_prev;
-
-	mutex_lock(&idr_lock);
+	int rc;
 
-	if (!chip) {
-		do {
-			chip_prev = chip_num;
-			chip = idr_get_next(&dev_nums_idr, &chip_num);
-			if (chip && !tpm_try_get_ops(chip)) {
-				res = chip;
-				break;
-			}
-		} while (chip_prev != chip_num);
-	} else {
+	if (chip) {
 		if (!tpm_try_get_ops(chip))
-			res = chip;
+			return chip;
+		return NULL;
 	}
 
-	mutex_unlock(&idr_lock);
-
-	return res;
+	chip = tpm_default_chip();
+	if (!chip)
+		return NULL;
+	rc = tpm_try_get_ops(chip);
+	/* release additional reference we got from tpm_default_chip() */
+	put_device(&chip->dev);
+	if (rc)
+		return NULL;
+	return chip;
 }
 
 /**
-- 
2.17.1

