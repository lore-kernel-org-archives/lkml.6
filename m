Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EEAECDE39
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD7221565
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:36:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BD7221565
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbeJRAcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 20:32:53 -0400
Received: from mga04.intel.com ([192.55.52.120]:44176 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727061AbeJRAcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 20:32:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2018 09:36:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,393,1534834800"; 
   d="scan'208";a="100048430"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by fmsmga001.fm.intel.com with ESMTP; 17 Oct 2018 09:36:21 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Nayna Jain <nayna@linux.vnet.ibm.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH] tpm: tpm_i2c_nuvoton: use correct command duration for TPM 2.x
Date:   Wed, 17 Oct 2018 19:32:23 +0300
Message-Id: <20181017163223.25141-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tpm_i2c_nuvoton calculated commands duration using TPM 1.x
values via tpm_calc_ordinal_duration() also for TPM 2.x chips.
Call tpm2_calc_ordinal_duration() for retrieving ordinal
duration for TPM 2.X chips.

Cc: Nayna Jain <nayna@linux.vnet.ibm.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/char/tpm/tpm_i2c_nuvoton.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm_i2c_nuvoton.c b/drivers/char/tpm/tpm_i2c_nuvoton.c
index caa86b19c76d..f74f451baf6a 100644
--- a/drivers/char/tpm/tpm_i2c_nuvoton.c
+++ b/drivers/char/tpm/tpm_i2c_nuvoton.c
@@ -369,6 +369,7 @@ static int i2c_nuvoton_send(struct tpm_chip *chip, u8 *buf, size_t len)
 	struct device *dev = chip->dev.parent;
 	struct i2c_client *client = to_i2c_client(dev);
 	u32 ordinal;
+	unsigned long duration;
 	size_t count = 0;
 	int burst_count, bytes2write, retries, rc = -EIO;
 
@@ -455,10 +456,12 @@ static int i2c_nuvoton_send(struct tpm_chip *chip, u8 *buf, size_t len)
 		return rc;
 	}
 	ordinal = be32_to_cpu(*((__be32 *) (buf + 6)));
-	rc = i2c_nuvoton_wait_for_data_avail(chip,
-					     tpm_calc_ordinal_duration(chip,
-								       ordinal),
-					     &priv->read_queue);
+	if (chip->flags & TPM_CHIP_FLAG_TPM2)
+		duration = tpm2_calc_ordinal_duration(chip, ordinal);
+	else
+		duration = tpm_calc_ordinal_duration(chip, ordinal);
+
+	rc = i2c_nuvoton_wait_for_data_avail(chip, duration, &priv->read_queue);
 	if (rc) {
 		dev_err(dev, "%s() timeout command duration\n", __func__);
 		i2c_nuvoton_ready(chip);
-- 
2.14.4

