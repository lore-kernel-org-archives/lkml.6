Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BFEECE567
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9690B21471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:39:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9690B21471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbeIRPKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 11:10:14 -0400
Received: from mga01.intel.com ([192.55.52.88]:59397 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729794AbeIRPKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 11:10:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2018 02:38:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,389,1531810800"; 
   d="scan'208";a="71724188"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by fmsmga008.fm.intel.com with ESMTP; 18 Sep 2018 02:38:23 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH v3 13/20] tpm: add tpm_auto_startup into tpm-interface
Date:   Tue, 18 Sep 2018 12:34:52 +0300
Message-Id: <20180918093459.19165-14-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180918093459.19165-1-tomas.winkler@intel.com>
References: <20180918093459.19165-1-tomas.winkler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add wrapper tpm_auto_startup() to tpm-interface.c
instead of open coded decision between tpm 1.2 and tpm 2.0
in tpm-chip.c

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
V3: new in the series

 drivers/char/tpm/tpm-chip.c      | 11 +++--------
 drivers/char/tpm/tpm-interface.c | 15 +++++++++++++++
 drivers/char/tpm/tpm.h           |  1 +
 3 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 46caadca916a..32db84683c40 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -451,14 +451,9 @@ int tpm_chip_register(struct tpm_chip *chip)
 {
 	int rc;
 
-	if (chip->ops->flags & TPM_OPS_AUTO_STARTUP) {
-		if (chip->flags & TPM_CHIP_FLAG_TPM2)
-			rc = tpm2_auto_startup(chip);
-		else
-			rc = tpm1_auto_startup(chip);
-		if (rc)
-			return rc;
-	}
+	rc = tpm_auto_startup(chip);
+	if (rc)
+		return rc;
 
 	tpm_sysfs_add_device(chip);
 
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 54e2cc592bd9..a8f8e0bcb434 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -520,6 +520,21 @@ int tpm_send(struct tpm_chip *chip, void *cmd, size_t buflen)
 }
 EXPORT_SYMBOL_GPL(tpm_send);
 
+int tpm_auto_startup(struct tpm_chip *chip)
+{
+	int rc;
+
+	if (!(chip->ops->flags & TPM_OPS_AUTO_STARTUP))
+		return 0;
+
+	if (chip->flags & TPM_CHIP_FLAG_TPM2)
+		rc = tpm2_auto_startup(chip);
+	else
+		rc = tpm1_auto_startup(chip);
+
+	return rc;
+}
+
 /*
  * We are about to suspend. Save the TPM state
  * so that it can be restored.
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index f0963a0a8acd..4ccffbb56864 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -541,6 +541,7 @@ ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_space *space,
 			 size_t min_rsp_body_length, unsigned int flags,
 			 const char *desc);
 int tpm_get_timeouts(struct tpm_chip *);
+int tpm_auto_startup(struct tpm_chip *chip);
 
 int tpm1_pm_suspend(struct tpm_chip *chip, int tpm_suspend_pcr);
 int tpm1_do_selftest(struct tpm_chip *chip);
-- 
2.14.4

