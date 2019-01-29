Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16673C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC83920869
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbfA2S7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:59:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46632 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727501AbfA2S7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 13:59:13 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6253512F910;
        Tue, 29 Jan 2019 18:59:13 +0000 (UTC)
Received: from cantor.redhat.com (ovpn-116-77.phx2.redhat.com [10.3.116.77])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F3EA15C234;
        Tue, 29 Jan 2019 18:59:12 +0000 (UTC)
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH] tpm: don't print error message in tpm_transmit_cmd when tpm still testing
Date:   Tue, 29 Jan 2019 11:59:11 -0700
Message-Id: <20190129185911.13559-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 29 Jan 2019 18:59:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently tpm_transmit_cmd will print an error message if the tpm
returns something other than TPM2_RC_SUCCESS. This means that if the
tpm returns that it is testing an error message will be printed, and
this can cause confusion for the end user. So avoid printing the error
message if TPM2_RC_TESTING is the return code.

Cc: Peter Huewe <peterhuewe@gmx.de>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
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

