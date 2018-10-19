Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50428ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 18:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2180F21476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 18:28:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2180F21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbeJTCfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 22:35:13 -0400
Received: from mga01.intel.com ([192.55.52.88]:54192 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727547AbeJTCfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 22:35:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Oct 2018 11:28:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,401,1534834800"; 
   d="scan'208";a="267150245"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by orsmga005.jf.intel.com with ESMTP; 19 Oct 2018 11:27:56 -0700
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
Subject: [PATCH v7 13/21] tpm: add tpm_auto_startup() into tpm-interface.c
Date:   Fri, 19 Oct 2018 21:22:59 +0300
Message-Id: <20181019182307.17745-14-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181019182307.17745-1-tomas.winkler@intel.com>
References: <20181019182307.17745-1-tomas.winkler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add wrapper tpm_auto_startup() to tpm-interface.c
instead of open coded decision between TPM 1.x and TPM 2.x
in tpm-chip.c

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
V3: New in the series.
V4: Fix the commit message.
V5-7: Resend.

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
index 54b81700561b..69e007a198ce 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -545,6 +545,21 @@ int tpm_send(struct tpm_chip *chip, void *cmd, size_t buflen)
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
index 2eb73f6966c3..daca1d0190b1 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -541,6 +541,7 @@ ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_space *space,
 			 size_t min_rsp_body_length, unsigned int flags,
 			 const char *desc);
 int tpm_get_timeouts(struct tpm_chip *);
+int tpm_auto_startup(struct tpm_chip *chip);
 
 int tpm1_pm_suspend(struct tpm_chip *chip, int tpm_suspend_pcr);
 int tpm1_auto_startup(struct tpm_chip *chip);
-- 
2.14.4

