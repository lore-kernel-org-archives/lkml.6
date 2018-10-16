Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEA3C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B671D20881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:41:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B671D20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbeJPVb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 17:31:59 -0400
Received: from mga11.intel.com ([192.55.52.93]:28953 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727002AbeJPVb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 17:31:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2018 06:41:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,388,1534834800"; 
   d="scan'208";a="92433279"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by orsmga003.jf.intel.com with ESMTP; 16 Oct 2018 06:41:15 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Nayna Jain <nayna@linux.vnet.ibm.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>, stable@vger.kernel.org
Subject: [PATCH] tpm: tpm_try_transmit() refactor error flow.
Date:   Tue, 16 Oct 2018 16:37:16 +0300
Message-Id: <20181016133716.17842-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First, rename out_no_locality to out_locality for bailing out on
both tpm_cmd_ready() and tpm_request_locality() failure.
Second, ignore the return value of go_to_idle() as  it may override
the return value of the actual tpm operation, the go_to_idle() error
will be caught on any consequent command.
Last, fix the wrong 'goto out', that jumped back instead of forward.

Cc: stable@vger.kernel.org
Fixes: 627448e85c76 ("tpm: separate cmd_ready/go_idle from runtime_pm")
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/char/tpm/tpm-interface.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 129f640424b7..95db630dd722 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -477,13 +477,15 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
 
 	if (need_locality) {
 		rc = tpm_request_locality(chip, flags);
-		if (rc < 0)
-			goto out_no_locality;
+		if (rc < 0) {
+			need_locality = false;
+			goto out_locality;
+		}
 	}
 
 	rc = tpm_cmd_ready(chip, flags);
 	if (rc)
-		goto out;
+		goto out_locality;
 
 	rc = tpm2_prepare_space(chip, space, ordinal, buf);
 	if (rc)
@@ -547,14 +549,13 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
 		dev_err(&chip->dev, "tpm2_commit_space: error %d\n", rc);
 
 out:
-	rc = tpm_go_idle(chip, flags);
-	if (rc)
-		goto out;
+	/* may fail but do not override previous error value in rc */
+	tpm_go_idle(chip, flags);
 
+out_locality:
 	if (need_locality)
 		tpm_relinquish_locality(chip, flags);
 
-out_no_locality:
 	if (chip->ops->clk_enable != NULL)
 		chip->ops->clk_enable(chip, false);
 
-- 
2.14.4

