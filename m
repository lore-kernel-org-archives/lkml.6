Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30864C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0641020685
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbfAIWLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 17:11:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54402 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727190AbfAIWLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 17:11:13 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x09MAnQc055025
        for <linux-kernel@vger.kernel.org>; Wed, 9 Jan 2019 17:11:12 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pwq5ewyrd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 17:11:12 -0500
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Wed, 9 Jan 2019 22:11:11 -0000
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Jan 2019 22:11:08 -0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x09MB7we15400982
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jan 2019 22:11:07 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C308DBE71C;
        Wed,  9 Jan 2019 22:11:07 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C4F5BE704;
        Wed,  9 Jan 2019 22:11:07 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  9 Jan 2019 22:11:07 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH 1/5] tpm: ppi: pass function revision ID to tpm_eval_dsm()
Date:   Wed,  9 Jan 2019 17:10:59 -0500
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190109221103.1897677-1-stefanb@linux.vnet.ibm.com>
References: <20190109221103.1897677-1-stefanb@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19010922-0036-0000-0000-00000A783D21
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010375; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01144159; UDB=6.00595717; IPR=6.00924421;
 MB=3.00025056; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-09 22:11:10
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010922-0037-0000-0000-00004A4858FD
Message-Id: <20190109221103.1897677-2-stefanb@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-09_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901090176
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we will need to pass different function revision numbers
to tpm_eval_dsm, convert this function now to take the function revision
as an additional parameter.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 drivers/char/tpm/tpm_ppi.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/char/tpm/tpm_ppi.c b/drivers/char/tpm/tpm_ppi.c
index 86dd8521feef..90b69aeadc99 100644
--- a/drivers/char/tpm/tpm_ppi.c
+++ b/drivers/char/tpm/tpm_ppi.c
@@ -38,12 +38,11 @@ static const guid_t tpm_ppi_guid =
 
 static inline union acpi_object *
 tpm_eval_dsm(acpi_handle ppi_handle, int func, acpi_object_type type,
-	     union acpi_object *argv4)
+	     union acpi_object *argv4, u64 rev)
 {
 	BUG_ON(!ppi_handle);
 	return acpi_evaluate_dsm_typed(ppi_handle, &tpm_ppi_guid,
-				       TPM_PPI_REVISION_ID,
-				       func, argv4, type);
+				       rev, func, argv4, type);
 }
 
 static ssize_t tpm_show_ppi_version(struct device *dev,
@@ -62,7 +61,7 @@ static ssize_t tpm_show_ppi_request(struct device *dev,
 	struct tpm_chip *chip = to_tpm_chip(dev);
 
 	obj = tpm_eval_dsm(chip->acpi_dev_handle, TPM_PPI_FN_GETREQ,
-			   ACPI_TYPE_PACKAGE, NULL);
+			   ACPI_TYPE_PACKAGE, NULL, TPM_PPI_REVISION_ID);
 	if (!obj)
 		return -ENXIO;
 
@@ -126,7 +125,7 @@ static ssize_t tpm_store_ppi_request(struct device *dev,
 	}
 
 	obj = tpm_eval_dsm(chip->acpi_dev_handle, func, ACPI_TYPE_INTEGER,
-			   &argv4);
+			   &argv4, TPM_PPI_REVISION_ID);
 	if (!obj) {
 		return -ENXIO;
 	} else {
@@ -170,7 +169,7 @@ static ssize_t tpm_show_ppi_transition_action(struct device *dev,
 	if (strcmp(chip->ppi_version, "1.2") < 0)
 		obj = &tmp;
 	obj = tpm_eval_dsm(chip->acpi_dev_handle, TPM_PPI_FN_GETACT,
-			   ACPI_TYPE_INTEGER, obj);
+			   ACPI_TYPE_INTEGER, obj, TPM_PPI_REVISION_ID);
 	if (!obj) {
 		return -ENXIO;
 	} else {
@@ -196,7 +195,7 @@ static ssize_t tpm_show_ppi_response(struct device *dev,
 	struct tpm_chip *chip = to_tpm_chip(dev);
 
 	obj = tpm_eval_dsm(chip->acpi_dev_handle, TPM_PPI_FN_GETRSP,
-			   ACPI_TYPE_PACKAGE, NULL);
+			   ACPI_TYPE_PACKAGE, NULL, TPM_PPI_REVISION_ID);
 	if (!obj)
 		return -ENXIO;
 
@@ -272,7 +271,8 @@ static ssize_t show_ppi_operations(acpi_handle dev_handle, char *buf, u32 start,
 	for (i = start; i <= end; i++) {
 		tmp.integer.value = i;
 		obj = tpm_eval_dsm(dev_handle, TPM_PPI_FN_GETOPR,
-				   ACPI_TYPE_INTEGER, &argv);
+				   ACPI_TYPE_INTEGER, &argv,
+				   TPM_PPI_REVISION_ID);
 		if (!obj) {
 			return -ENOMEM;
 		} else {
-- 
2.17.1

