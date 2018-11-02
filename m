Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1754FC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5DD22084C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTVKULUb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5DD22084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731172AbeKCECZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:02:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:58234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729463AbeKCECY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:02:24 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F3762084A;
        Fri,  2 Nov 2018 18:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184849;
        bh=d2wfP5XDUckkHtQ9opQ7PGX7gS25PfLfhTWwTxOHbWs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JTVKULUbG3VNUpqCwgjPAUAIXH36Rdqs8Wfwk5NezOzR9WX52z+/UXLHoIaAMd3TH
         Cs18lFMXy4nAVBYRN2eeWDPVTGIdjDmqUaG/7jLAdl5bdoGcl8AzZddurpigoipnwQ
         jpga4fNSa2qP0t2iy1JHJbhbM89uLp9CYkC4YCVc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nayna Jain <nayna@linux.vnet.ibm.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 075/143] tpm: move the delay_msec increment after sleep in tpm_transmit()
Date:   Fri,  2 Nov 2018 19:34:20 +0100
Message-Id: <20181102182903.439770268@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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



