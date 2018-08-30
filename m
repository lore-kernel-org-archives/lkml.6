Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96468C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58F912082C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:40:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58F912082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbeH3SnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:43:06 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38030 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729008AbeH3SnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:43:06 -0400
Received: by mail-wr1-f68.google.com with SMTP id w11-v6so8304805wrc.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 07:40:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jf71dbTDnZLg6ikV/I6nIju0h7RyInX+sBkTaw47ynU=;
        b=X8SNKNNFMRvoiK4x2GFa3RU9PD6lgREy/u3POIz8V20sdJg2MjuKDLMHRw7qVuxPXb
         f4+FYBWC2uIjPC3KeFsl66WM2FKnfwDJGIOvxf1kJWCtgz5EyaF4PiI4wNUrVdrv4nX7
         Ligolpk31o7pmnQ9A+bxswvpQU9Yx6h/fNTxOSTDr0A/frsQUffML/hPvAgiZOuJFrMN
         DnApOm5Zzd4mKbbJoo+PhelHUaV7yIo1QTKa1TLrVfB/OQQKpBdsQ2D6DuJCNydmtWvT
         hDUa9lB8LxpfjuhmB+LJONXqKkzoibaik3nE5cuJK280b9/gVCnVMPPCj+5wEzT4zOrt
         qnbQ==
X-Gm-Message-State: APzg51CwwkZGuRtiSoa0L1He7YREIcO5/e1ykapsxo0KuNrH9j2wIvb+
        Ghht+ULMSpBTWSQLxKYXyKzPB6DZnDw=
X-Google-Smtp-Source: ANB0VdYQXg5mjot/H+aOBXW+BTqBi3IldUDqTAruj94Haodejqsz+WKM5lPdUOmD/FnTYUF/Xt57sQ==
X-Received: by 2002:adf:fd12:: with SMTP id e18-v6mr8115853wrr.280.1535640036335;
        Thu, 30 Aug 2018 07:40:36 -0700 (PDT)
Received: from minerva.home ([90.168.169.92])
        by smtp.gmail.com with ESMTPSA id m129-v6sm3141600wma.1.2018.08.30.07.40.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Aug 2018 07:40:35 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org
Subject: [PATCH] tpm: suppress transmit cmd error logs when TPM 1.2 is disabled/deactivated
Date:   Thu, 30 Aug 2018 16:40:05 +0200
Message-Id: <20180830144005.6768-1-javierm@redhat.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

---

 drivers/char/tpm/tpm-interface.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 1a803b0cf98..9f61106502a 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -663,7 +663,8 @@ ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_space *space,
 		return len;
 
 	err = be32_to_cpu(header->return_code);
-	if (err != 0 && desc)
+	if (err != 0 && err != TPM_ERR_DISABLED && err != TPM_ERR_DEACTIVATED
+	    && desc)
 		dev_err(&chip->dev, "A TPM error (%d) occurred %s\n", err,
 			desc);
 	if (err)
-- 
2.17.1

