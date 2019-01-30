Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76442C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ED7020881
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730991AbfA3XBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:01:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37514 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728404AbfA3XBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 18:01:42 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 21655C002964;
        Wed, 30 Jan 2019 22:43:46 +0000 (UTC)
Received: from cantor.redhat.com (ovpn-116-165.phx2.redhat.com [10.3.116.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D46935D717;
        Wed, 30 Jan 2019 22:43:45 +0000 (UTC)
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH 2/2] tpm: don't print error message in tpm_transmit_cmd when tpm still testing
Date:   Wed, 30 Jan 2019 15:43:33 -0700
Message-Id: <20190130224333.20373-2-jsnitsel@redhat.com>
In-Reply-To: <20190130224333.20373-1-jsnitsel@redhat.com>
References: <20190130224333.20373-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 30 Jan 2019 22:43:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently tpm_transmit_cmd will print an error message if the tpm
returns something other than TPM2_RC_SUCCESS. This means that if the
tpm returns that it is testing an error message will be printed, and
this can cause confusion for the end user. So avoid printing the error
message if TPM2_RC_TESTING is the return code.

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
 drivers/char/tpm/tpm-interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index d9439f9abe78..6339a2e289ae 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -397,7 +397,7 @@ ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_space *space,
 
 	err = be32_to_cpu(header->return_code);
 	if (err != 0 && err != TPM_ERR_DISABLED && err != TPM_ERR_DEACTIVATED
-	    && desc)
+	    && err != TPM2_RC_TESTING && desc)
 		dev_err(&chip->dev, "A TPM error (%d) occurred %s\n", err,
 			desc);
 	if (err)
-- 
2.20.1.98.gecbdaf0899

