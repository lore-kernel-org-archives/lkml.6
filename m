Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F29C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC20420856
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbfAQRmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 12:42:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46240 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729176AbfAQRlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 12:41:44 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0HHY5l9071540
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 12:41:43 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q2x1v8r1w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 12:41:42 -0500
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <stefanb@linux.ibm.com>;
        Thu, 17 Jan 2019 17:41:41 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 17 Jan 2019 17:41:38 -0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0HHfbs221037196
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Jan 2019 17:41:37 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B62502805E;
        Thu, 17 Jan 2019 17:41:37 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A917B28064;
        Thu, 17 Jan 2019 17:41:37 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 17 Jan 2019 17:41:37 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 1/5] tpm: ppi: pass function revision ID to tpm_eval_dsm()
Date:   Thu, 17 Jan 2019 12:41:31 -0500
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190117174135.2117937-1-stefanb@linux.ibm.com>
References: <20190117174135.2117937-1-stefanb@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19011717-0064-0000-0000-000003984A7F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010425; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000275; SDB=6.01147865; UDB=6.00597964; IPR=6.00928164;
 MB=3.00025175; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-17 17:41:40
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011717-0065-0000-0000-00003C1276E5
Message-Id: <20190117174135.2117937-2-stefanb@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-17_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901170125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we will need to pass different function revision numbers
to tpm_eval_dsm, convert this function now to take the function revision
as an additional parameter.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Tested-by: David Safford <david.safford@ge.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
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
2.13.6

