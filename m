Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3E6ECDE46
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 01:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7FE320827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 01:46:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7FE320827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbeKELDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 06:03:41 -0500
Received: from mga03.intel.com ([134.134.136.65]:22211 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbeKELDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 06:03:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2018 17:46:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,466,1534834800"; 
   d="scan'208";a="271354200"
Received: from unknown (HELO localhost) ([10.249.254.144])
  by orsmga005.jf.intel.com with ESMTP; 04 Nov 2018 17:46:24 -0800
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
Subject: [PATCH v3 03/16] tpm: return 0 from pcrs_show() when tpm1_pcr_read() fails
Date:   Mon,  5 Nov 2018 03:45:36 +0200
Message-Id: <20181105014552.20262-4-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181105014552.20262-1-jarkko.sakkinen@linux.intel.com>
References: <20181105014552.20262-1-jarkko.sakkinen@linux.intel.com>
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
 drivers/char/tpm/tpm-sysfs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
index 7ed7eb6f906a..d3b05c7526c8 100644
--- a/drivers/char/tpm/tpm-sysfs.c
+++ b/drivers/char/tpm/tpm-sysfs.c
@@ -115,13 +115,15 @@ static ssize_t pcrs_show(struct device *dev, struct device_attribute *attr,
 	for (i = 0; i < num_pcrs; i++) {
 		rc = tpm1_pcr_read(chip, i, digest);
 		if (rc)
-			break;
+			goto out;
 		str += sprintf(str, "PCR-%02d: ", i);
 		for (j = 0; j < TPM_DIGEST_SIZE; j++)
 			str += sprintf(str, "%02X ", digest[j]);
 		str += sprintf(str, "\n");
 	}
-	return str - buf;
+	rc = str - buf;
+out:
+	return rc;
 }
 static DEVICE_ATTR_RO(pcrs);
 
-- 
2.19.1

