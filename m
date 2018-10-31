Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4005C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7905F20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="q9zNulno"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7905F20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731748AbeKAILh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:11:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:35402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731717AbeKAILf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:11:35 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B29020880;
        Wed, 31 Oct 2018 23:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027483;
        bh=RWXbBJtmaMm32DMGkI0IVylxevzO18eICw3L80EFb9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q9zNulnoHU9zzC/WJ9hQx7QiDQTbKyKoaLRUPnHzD/FOONIPzLMtiqK0cXk3Zez+P
         hawwimKJojfuJt+3qaap9u5CHEWZjdKhODSHcvANgcg+Alzjua8A5Oo/MPk2IcrP94
         Dr20q69+fTOnMUmfieS1Xpvf2Fm28h3tEryBUeqE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 33/48] tpm: suppress transmit cmd error logs when TPM 1.2 is disabled/deactivated
Date:   Wed, 31 Oct 2018 19:10:39 -0400
Message-Id: <20181031231054.29333-33-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031231054.29333-1-sashal@kernel.org>
References: <20181031231054.29333-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Javier Martinez Canillas <javierm@redhat.com>

[ Upstream commit 0d6d0d62d9505a9816716aa484ebd0b04c795063 ]

For TPM 1.2 chips the system setup utility allows to set the TPM device in
one of the following states:

  * Active: Security chip is functional
  * Inactive: Security chip is visible, but is not functional
  * Disabled: Security chip is hidden and is not functional

When choosing the "Inactive" state, the TPM 1.2 device is enumerated and
registered, but sending TPM commands fail with either TPM_DEACTIVATED or
TPM_DISABLED depending if the firmware deactivated or disabled the TPM.

Since these TPM 1.2 error codes don't have special treatment, inactivating
the TPM leads to a very noisy kernel log buffer that shows messages like
the following:

  tpm_tis 00:05: 1.2 TPM (device-id 0x0, rev-id 78)
  tpm tpm0: A TPM error (6) occurred attempting to read a pcr value
  tpm tpm0: TPM is disabled/deactivated (0x6)
  tpm tpm0: A TPM error (6) occurred attempting get random
  tpm tpm0: A TPM error (6) occurred attempting to read a pcr value
  ima: No TPM chip found, activating TPM-bypass! (rc=6)
  tpm tpm0: A TPM error (6) occurred attempting get random
  tpm tpm0: A TPM error (6) occurred attempting get random
  tpm tpm0: A TPM error (6) occurred attempting get random
  tpm tpm0: A TPM error (6) occurred attempting get random

Let's just suppress error log messages for the TPM_{DEACTIVATED,DISABLED}
return codes, since this is expected when the TPM 1.2 is set to Inactive.

In that case the kernel log is cleaner and less confusing for users, i.e:

  tpm_tis 00:05: 1.2 TPM (device-id 0x0, rev-id 78)
  tpm tpm0: TPM is disabled/deactivated (0x6)
  ima: No TPM chip found, activating TPM-bypass! (rc=6)

Reported-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/tpm/tpm-interface.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index faf2db122ab9..4f0b1945d020 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -420,7 +420,8 @@ ssize_t tpm_transmit_cmd(struct tpm_chip *chip, const void *cmd,
 	header = cmd;
 
 	err = be32_to_cpu(header->return_code);
-	if (err != 0 && desc)
+	if (err != 0 && err != TPM_ERR_DISABLED && err != TPM_ERR_DEACTIVATED
+	    && desc)
 		dev_err(&chip->dev, "A TPM error (%d) occurred %s\n", err,
 			desc);
 
-- 
2.17.1

