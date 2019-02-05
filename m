Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C36C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 304622175B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730770AbfBEWsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 17:48:05 -0500
Received: from mga03.intel.com ([134.134.136.65]:37645 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730368AbfBEWsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 17:48:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2019 14:48:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,337,1544515200"; 
   d="scan'208";a="113982141"
Received: from ibanaga-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.171])
  by orsmga006.jf.intel.com with ESMTP; 05 Feb 2019 14:47:55 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <PeterHuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: [PATCH v11 04/16] tpm: print tpm2_commit_space() error inside tpm2_commit_space()
Date:   Wed,  6 Feb 2019 00:47:11 +0200
Message-Id: <20190205224723.19671-5-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190205224723.19671-1-jarkko.sakkinen@linux.intel.com>
References: <20190205224723.19671-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The error logging for tpm2_commit_space() is in a wrong place. This
commit moves it inside that function.

Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Tested-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Reviewed-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/char/tpm/tpm-interface.c | 2 --
 drivers/char/tpm/tpm2-space.c    | 9 ++++++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 5ef5c1e6947d..d594ea27810c 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -277,8 +277,6 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
 	}
 
 	rc = tpm2_commit_space(chip, space, ordinal, buf, &len);
-	if (rc)
-		dev_err(&chip->dev, "tpm2_commit_space: error %d\n", rc);
 
 out:
 	/* may fail but do not override previous error value in rc */
diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
index 1131a8e7b79b..5ecc73988f7c 100644
--- a/drivers/char/tpm/tpm2-space.c
+++ b/drivers/char/tpm/tpm2-space.c
@@ -501,19 +501,19 @@ int tpm2_commit_space(struct tpm_chip *chip, struct tpm_space *space,
 	rc = tpm2_map_response_header(chip, cc, buf, *bufsiz);
 	if (rc) {
 		tpm2_flush_space(chip);
-		return rc;
+		goto out;
 	}
 
 	rc = tpm2_map_response_body(chip, cc, buf, *bufsiz);
 	if (rc) {
 		tpm2_flush_space(chip);
-		return rc;
+		goto out;
 	}
 
 	rc = tpm2_save_space(chip);
 	if (rc) {
 		tpm2_flush_space(chip);
-		return rc;
+		goto out;
 	}
 
 	*bufsiz = be32_to_cpu(header->length);
@@ -526,4 +526,7 @@ int tpm2_commit_space(struct tpm_chip *chip, struct tpm_space *space,
 	memcpy(space->session_buf, chip->work_space.session_buf, PAGE_SIZE);
 
 	return 0;
+out:
+	dev_err(&chip->dev, "%s: error %d\n", __func__, rc);
+	return rc;
 }
-- 
2.19.1

