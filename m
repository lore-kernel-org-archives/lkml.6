Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D9DC71130
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E455A2064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:18:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E455A2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbeJOTD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 15:03:27 -0400
Received: from mga18.intel.com ([134.134.136.126]:15518 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbeJOTD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 15:03:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2018 04:18:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,384,1534834800"; 
   d="scan'208";a="92070327"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by orsmga003.jf.intel.com with ESMTP; 15 Oct 2018 04:18:35 -0700
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
Subject: [PATCH] tpm: tpm_try_transmit() ignore value of go_to_idle()
Date:   Mon, 15 Oct 2018 14:14:34 +0300
Message-Id: <20181015111434.7777-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ignore the return value of go_to_idle() in tpm_try_transmit().
Once it may shadow the return value of actual tpm operation,
second the consequent command will fail as well and the error
will be caought anyway.
Last fix wrong goto, that jumped back instead of forward.

Fixes: 627448e85c76 ("tpm: separate cmd_ready/go_idle from runtime_pm")
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/char/tpm/tpm-interface.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 129f640424b7..f69c711bf74a 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -547,9 +547,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
 		dev_err(&chip->dev, "tpm2_commit_space: error %d\n", rc);
 
 out:
-	rc = tpm_go_idle(chip, flags);
-	if (rc)
-		goto out;
+	(void)tpm_go_idle(chip, flags);
 
 	if (need_locality)
 		tpm_relinquish_locality(chip, flags);
-- 
2.14.4

