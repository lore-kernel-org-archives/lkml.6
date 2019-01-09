Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0493DC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBD2E20685
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbfAIWL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 17:11:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49864 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726513AbfAIWLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 17:11:18 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x09MAQJG142140
        for <linux-kernel@vger.kernel.org>; Wed, 9 Jan 2019 17:11:17 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pwsdvr9j3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 17:11:16 -0500
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Wed, 9 Jan 2019 22:11:16 -0000
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Jan 2019 22:11:13 -0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x09MBCvP14942338
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jan 2019 22:11:12 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 568EFBE71A;
        Wed,  9 Jan 2019 22:11:12 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDE94BE73C;
        Wed,  9 Jan 2019 22:11:11 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  9 Jan 2019 22:11:11 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH 4/5] tpm: ppi: Possibly show command parameter if TPM PPI 1.3 is used
Date:   Wed,  9 Jan 2019 17:11:02 -0500
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190109221103.1897677-1-stefanb@linux.vnet.ibm.com>
References: <20190109221103.1897677-1-stefanb@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19010922-0016-0000-0000-000009725C24
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010375; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01144159; UDB=6.00595717; IPR=6.00924421;
 MB=3.00025056; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-09 22:11:15
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010922-0017-0000-0000-000041B5FFFB
Message-Id: <20190109221103.1897677-5-stefanb@linux.vnet.ibm.com>
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

TPM PPI 1.3 introduces an additional optional command parameter
that may be needed for some commands. Display the parameter if the
command requires such a parameter. Only command 23 needs one.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 drivers/char/tpm/tpm_ppi.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_ppi.c b/drivers/char/tpm/tpm_ppi.c
index 72182b415c76..ab61ee208125 100644
--- a/drivers/char/tpm/tpm_ppi.c
+++ b/drivers/char/tpm/tpm_ppi.c
@@ -21,6 +21,7 @@
 #include "tpm.h"
 
 #define TPM_PPI_REVISION_1	1
+#define TPM_PPI_REVISION_2	2
 #define TPM_PPI_FN_VERSION	1
 #define TPM_PPI_FN_SUBREQ	2
 #define TPM_PPI_FN_GETREQ	3
@@ -36,6 +37,11 @@ static const guid_t tpm_ppi_guid =
 	GUID_INIT(0x3DDDFAA6, 0x361B, 0x4EB4,
 		  0xA4, 0x24, 0x8D, 0x10, 0x08, 0x9D, 0x16, 0x53);
 
+static bool tpm_ppi_req_has_parameter(u64 req)
+{
+	return req == 23;
+}
+
 static inline union acpi_object *
 tpm_eval_dsm(acpi_handle ppi_handle, int func, acpi_object_type type,
 	     union acpi_object *argv4, u64 rev)
@@ -59,9 +65,14 @@ static ssize_t tpm_show_ppi_request(struct device *dev,
 	ssize_t size = -EINVAL;
 	union acpi_object *obj;
 	struct tpm_chip *chip = to_tpm_chip(dev);
+	u64 rev = TPM_PPI_REVISION_2;
+	u64 req;
+
+	if (strcmp(chip->ppi_version, "1.2") < 0)
+		rev = TPM_PPI_REVISION_1;
 
 	obj = tpm_eval_dsm(chip->acpi_dev_handle, TPM_PPI_FN_GETREQ,
-			   ACPI_TYPE_PACKAGE, NULL, TPM_PPI_REVISION_1);
+			   ACPI_TYPE_PACKAGE, NULL, rev);
 	if (!obj)
 		return -ENXIO;
 
@@ -71,7 +82,24 @@ static ssize_t tpm_show_ppi_request(struct device *dev,
 	 * error. The second is pending TPM operation requested by the OS, 0
 	 * means none and >0 means operation value.
 	 */
-	if (obj->package.count == 2 &&
+	if (obj->package.count == 3 &&
+	    obj->package.elements[0].type == ACPI_TYPE_INTEGER &&
+	    obj->package.elements[1].type == ACPI_TYPE_INTEGER &&
+	    obj->package.elements[2].type == ACPI_TYPE_INTEGER) {
+		if (obj->package.elements[0].integer.value)
+			size = -EFAULT;
+		else {
+			req = obj->package.elements[1].integer.value;
+			if (tpm_ppi_req_has_parameter(req))
+				size = scnprintf(buf, PAGE_SIZE,
+						"%llu %llu\n",
+					req,
+					obj->package.elements[2].integer.value);
+			else
+				size = scnprintf(buf, PAGE_SIZE,
+						"%llu\n", req);
+		}
+	} else if (obj->package.count == 2 &&
 	    obj->package.elements[0].type == ACPI_TYPE_INTEGER &&
 	    obj->package.elements[1].type == ACPI_TYPE_INTEGER) {
 		if (obj->package.elements[0].integer.value)
-- 
2.17.1

