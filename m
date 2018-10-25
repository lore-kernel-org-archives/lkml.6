Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92138ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5965A2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvvP8LZO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5965A2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbeJYWo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:44:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:53250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728157AbeJYWo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:44:27 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D588A20834;
        Thu, 25 Oct 2018 14:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476691;
        bh=Lot1eGWWiQkKGyF9EY5sk/m8VUkNFT2Cyc0Fj2TASC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JvvP8LZOVXk5HxMhLJCZpsZIItt8R2zAvu+Q97BaceT6lkUKflIm9P8NCsiNm162L
         xRg2XE7yiuXFjQiCys9dqGd+JjskAFuEsXxGYwpY1QOJtCbfN1S3zKX+tNQWl6vGkO
         fYxKpizJr+aMGzYSTd7D9F1BdmYkC1n2uKqf5nhc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Nayna Jain <nayna@linux.vnet.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 26/46] tpm: move the delay_msec increment after sleep in tpm_transmit()
Date:   Thu, 25 Oct 2018 10:10:33 -0400
Message-Id: <20181025141053.213330-26-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141053.213330-1-sashal@kernel.org>
References: <20181025141053.213330-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nayna Jain <nayna@linux.vnet.ibm.com>

[ Upstream commit 92980756979a9c51be0275f395f4e89c42cf199a ]

Commit e2fb992d82c6 ("tpm: add retry logic") introduced a new loop to
handle the TPM2_RC_RETRY error. The loop retries the command after
sleeping for the specified time, which is incremented exponentially in
every iteration.

Unfortunately, the loop doubles the time before sleeping, causing the
initial sleep to be doubled. This patch fixes the initial sleep time.

Fixes: commit e2fb992d82c6 ("tpm: add retry logic")
Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/tpm/tpm-interface.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index a2070ab86c82..89d5915b1a3f 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -611,12 +611,13 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
 		rc = be32_to_cpu(header->return_code);
 		if (rc != TPM2_RC_RETRY)
 			break;
-		delay_msec *= 2;
+
 		if (delay_msec > TPM2_DURATION_LONG) {
 			dev_err(&chip->dev, "TPM is in retry loop\n");
 			break;
 		}
 		tpm_msleep(delay_msec);
+		delay_msec *= 2;
 		memcpy(buf, save, save_size);
 	}
 	return ret;
-- 
2.17.1

