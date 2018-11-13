Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638CBC43610
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 12:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C4FB223C8
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 12:26:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C4FB223C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733051AbeKMWYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 17:24:40 -0500
Received: from mga14.intel.com ([192.55.52.115]:48544 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732592AbeKMWYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 17:24:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2018 04:26:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,499,1534834800"; 
   d="scan'208";a="108176444"
Received: from ibanaga-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.77])
  by orsmga002.jf.intel.com with ESMTP; 13 Nov 2018 04:26:39 -0800
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
Subject: [PATCH v6 03/17] tpm: return 0 from pcrs_show() when tpm1_pcr_read() fails
Date:   Tue, 13 Nov 2018 14:25:52 +0200
Message-Id: <20181113122609.21643-4-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181113122609.21643-1-jarkko.sakkinen@linux.intel.com>
References: <20181113122609.21643-1-jarkko.sakkinen@linux.intel.com>
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
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
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

