Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7117FECDE4C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B56120827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:16:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B56120827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbeKHXv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 18:51:56 -0500
Received: from mga18.intel.com ([134.134.136.126]:56438 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbeKHXv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 18:51:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Nov 2018 06:16:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,478,1534834800"; 
   d="scan'208";a="94663787"
Received: from ibanaga-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.75])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Nov 2018 06:16:09 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 03/17] tpm: return 0 from pcrs_show() when tpm1_pcr_read() fails
Date:   Thu,  8 Nov 2018 16:15:24 +0200
Message-Id: <20181108141541.12832-4-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108141541.12832-1-jarkko.sakkinen@linux.intel.com>
References: <20181108141541.12832-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not print partial list of PCRs when tpm1_pcr_read() fails but instead
return 0 from pcrs_show(). This is consistent behavior with other sysfs
functions.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/tpm-sysfs.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
index 7ed7eb6f906a..928d4e839bb7 100644
--- a/drivers/char/tpm/tpm-sysfs.c
+++ b/drivers/char/tpm/tpm-sysfs.c
@@ -100,22 +100,21 @@ static ssize_t pcrs_show(struct device *dev, struct device_attribute *attr,
 {
 	cap_t cap;
 	u8 digest[TPM_DIGEST_SIZE];
-	ssize_t rc;
 	u32 i, j, num_pcrs;
 	char *str = buf;
 	struct tpm_chip *chip = to_tpm_chip(dev);
 
-	rc = tpm1_getcap(chip, TPM_CAP_PROP_PCR, &cap,
-			 "attempting to determine the number of PCRS",
-			 sizeof(cap.num_pcrs));
-	if (rc)
+	if (tpm1_getcap(chip, TPM_CAP_PROP_PCR, &cap,
+			"attempting to determine the number of PCRS",
+			sizeof(cap.num_pcrs)))
 		return 0;
 
 	num_pcrs = be32_to_cpu(cap.num_pcrs);
 	for (i = 0; i < num_pcrs; i++) {
-		rc = tpm1_pcr_read(chip, i, digest);
-		if (rc)
+		if (tpm1_pcr_read(chip, i, digest)) {
+			str = buf;
 			break;
+		}
 		str += sprintf(str, "PCR-%02d: ", i);
 		for (j = 0; j < TPM_DIGEST_SIZE; j++)
 			str += sprintf(str, "%02X ", digest[j]);
-- 
2.19.1

