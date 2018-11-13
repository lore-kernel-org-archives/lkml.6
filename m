Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F3CC43610
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 12:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 175FE223C8
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 12:27:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 175FE223C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733098AbeKMWY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 17:24:58 -0500
Received: from mga02.intel.com ([134.134.136.20]:57746 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732592AbeKMWY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 17:24:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2018 04:27:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,499,1534834800"; 
   d="scan'208";a="108176504"
Received: from ibanaga-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.77])
  by orsmga002.jf.intel.com with ESMTP; 13 Nov 2018 04:26:57 -0800
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
Subject: [PATCH v6 05/17] tpm: print tpm2_commit_space() error inside tpm2_commit_space()
Date:   Tue, 13 Nov 2018 14:25:54 +0200
Message-Id: <20181113122609.21643-6-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181113122609.21643-1-jarkko.sakkinen@linux.intel.com>
References: <20181113122609.21643-1-jarkko.sakkinen@linux.intel.com>
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
---
 drivers/char/tpm/tpm-interface.c | 8 ++------
 drivers/char/tpm/tpm2-space.c    | 9 ++++++---
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index c9efd1b9fd2c..7ffb16edab6f 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -268,14 +268,10 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
 		rc = -EFAULT;
 
 out_space:
-	if (rc) {
+	if (rc)
 		tpm2_flush_space(chip);
-	} else {
+	else
 		rc = tpm2_commit_space(chip, space, ordinal, buf, &len);
-		if (rc)
-			dev_err(&chip->dev, "tpm2_commit_space: error %d\n",
-				rc);
-	}
 
 out_idle:
 	/* may fail but do not override previous error value in rc */
diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
index d53c882268ff..3d5f9577e5de 100644
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

