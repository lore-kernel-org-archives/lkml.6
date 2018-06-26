Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D7AC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27C8F26F0D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:31:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27C8F26F0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755022AbeFZTbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 15:31:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44684 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754946AbeFZTat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 15:30:49 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5QJTXI7175409
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 15:30:48 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2juuamguvy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 15:30:48 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Tue, 26 Jun 2018 15:30:47 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Jun 2018 15:30:43 -0400
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5QJUgip6422996
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 19:30:42 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 622BBAC060;
        Tue, 26 Jun 2018 15:31:52 -0400 (EDT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47B9CAC05E;
        Tue, 26 Jun 2018 15:31:52 -0400 (EDT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Jun 2018 15:31:52 -0400 (EDT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        zohar@linux.vnet.ibm.com, jejb@linux.vnet.ibm.com
Cc:     jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, dhowells@redhat.com,
        keyrings@vger.kernel.org,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Stefan Berger <stefanb@liux.vnet.ibm.com>
Subject: [PATCH 1/2] tpm: Implement public tpm_put_chip() to release reference to chip
Date:   Tue, 26 Jun 2018 15:30:39 -0400
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180626193040.2509798-1-stefanb@linux.vnet.ibm.com>
References: <20180626193040.2509798-1-stefanb@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062619-0040-0000-0000-00000445861B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009259; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052715; UDB=6.00539697; IPR=6.00830640;
 MB=3.00021867; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 19:30:45
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062619-0041-0000-0000-0000084B9C87
Message-Id: <20180626193040.2509798-2-stefanb@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-26_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=801 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806260215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some subsystems that got a hold of a TPM chip through tpm_default_chip()
need a way to release the reference to the TPM chip when they shut down.
The tpm_put_chip() function enables this.

Signed-off-by: Stefan Berger <stefanb@liux.vnet.ibm.com>
---
 drivers/char/tpm/tpm-chip.c | 10 ++++++++++
 include/linux/tpm.h         |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 46caadca916a..c744289d82e0 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -80,6 +80,16 @@ void tpm_put_ops(struct tpm_chip *chip)
 }
 EXPORT_SYMBOL_GPL(tpm_put_ops);
 
+/**
+ * tpm_put_chip() - Releae a ref to the tpm_chip
+ * @chip: Chip to put
+ */
+void tpm_put_chip(struct tpm_chip *chip)
+{
+	put_device(&chip->dev);
+}
+EXPORT_SYMBOL_GPL(tpm_put_chip);
+
 /**
  * tpm_default_chip() - find a TPM chip and get a reference to it
  */
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index e0e51c49a0e6..889dafe739e1 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -62,6 +62,7 @@ extern int tpm_unseal_trusted(struct tpm_chip *chip,
 			      struct trusted_key_payload *payload,
 			      struct trusted_key_options *options);
 extern struct tpm_chip *tpm_default_chip(void);
+extern void tpm_put_chip(struct tpm_chip *chip);
 #else
 static inline int tpm_is_tpm2(struct tpm_chip *chip)
 {
@@ -101,5 +102,8 @@ static inline struct tpm_chip *tpm_default_chip(void)
 {
 	return NULL;
 }
+static inline void tpm_put_chip(struct tpm_chip *chip)
+{
+}
 #endif
 #endif
-- 
2.17.1

