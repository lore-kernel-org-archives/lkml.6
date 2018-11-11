Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA49C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C713620866
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZ6QBXm0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C713620866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732236AbeKLJ5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:57:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:33814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731776AbeKLIRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:17:38 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C03621731;
        Sun, 11 Nov 2018 22:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975263;
        bh=UKfFkHX1ZHMOipsEkEKQX99rH48sGpcRDgcuUfRZ3ew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JZ6QBXm0D9AIZpXKxK0qIgG6tLEyJ4/s5nIs/IgoPQ8pcCVgn0CwNSGdlsaBdorWO
         rVg1Z64vOv+Q2TTmNhYissj3VKyawo6KSouaZnxf2wRxbr7nFoIIdhJGj8MN6gQKNl
         O6VFmiLOFHuY3GMiz01PdMpEnefFjQFtbIydV1Ec=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 151/361] tpm: suppress transmit cmd error logs when TPM 1.2 is disabled/deactivated
Date:   Sun, 11 Nov 2018 14:18:18 -0800
Message-Id: <20181111221641.574157382@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/tpm/tpm-interface.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -663,7 +663,8 @@ ssize_t tpm_transmit_cmd(struct tpm_chip
 		return len;
 
 	err = be32_to_cpu(header->return_code);
-	if (err != 0 && desc)
+	if (err != 0 && err != TPM_ERR_DISABLED && err != TPM_ERR_DEACTIVATED
+	    && desc)
 		dev_err(&chip->dev, "A TPM error (%d) occurred %s\n", err,
 			desc);
 	if (err)


