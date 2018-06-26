Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09965C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F1525E8E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="o+8VhsHk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5F1525E8E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=infineon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752114AbeFZPcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 11:32:06 -0400
Received: from smtp2.infineon.com ([217.10.52.18]:20228 "EHLO
        smtp2.infineon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751280AbeFZPcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 11:32:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1530027124; x=1561563124;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=8ftjibznq9nGlfuGeASch1wLZ9zMXEp5tmadRq+oqeg=;
  b=o+8VhsHkt1832DXgi677G5KlDvINgnPeTbPvJZ0J2DAFYwiGWHyzWOBj
   y9zk0ygKpNsmV70ihxR4AZCEdJRmm3XRP0OUnvbuVR8PaZ+uJwdh6UYjN
   tudwzPcm3vWNjK+4Z3hXtUQMIgUKvDGMi/5yB/lMbgaGTO1Ahsx82uMJS
   0=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="5900,7806,8935"; a="69990639"
X-IronPort-AV: E=Sophos;i="5.51,274,1526335200"; 
   d="scan'208";a="69990639"
Received: from unknown (HELO mucxv003.muc.infineon.com) ([172.23.11.20])
  by smtp2.infineon.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jun 2018 17:32:02 +0200
Received: from MUCSE706.infineon.com (MUCSE706.infineon.com [172.23.7.80])
        by mucxv003.muc.infineon.com (Postfix) with ESMTPS;
        Tue, 26 Jun 2018 17:32:02 +0200 (CEST)
Received: from MUCSE716.infineon.com (172.23.7.67) by MUCSE706.infineon.com
 (172.23.7.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1466.3; Tue, 26
 Jun 2018 17:32:02 +0200
Received: from schwaric-VirtualBox.agb.infineon.com (172.23.8.247) by
 MUCSE716.infineon.com (172.23.7.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.1.1466.3; Tue, 26 Jun 2018 17:32:02 +0200
From:   Ricardo Schwarzmeier <Ricardo.Schwarzmeier@infineon.com>
To:     <linux-integrity@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <peterhuewe@gmx.de>,
        <jarkko.sakkinen@linux.intel.com>, <jgg@ziepe.ca>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>,
        Ricardo Schwarzmeier <Ricardo.Schwarzmeier@infineon.com>
Subject: [PATCH v5] tpm: Return the actual size when receiving an unsupported command
Date:   Tue, 26 Jun 2018 17:31:45 +0200
Message-ID: <20180626153145.7408-1-Ricardo.Schwarzmeier@infineon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.23.8.247]
X-ClientProxiedBy: MUCSE715.infineon.com (172.23.7.66) To
 MUCSE716.infineon.com (172.23.7.67)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The userpace expects to read the number of bytes stated in the header.
Returning the size of the buffer instead would be unexpected.
Fixes: 095531f891e6 ("tpm: return a TPM_RC_COMMAND_CODE response if command is not implemented")

Signed-off-by: Ricardo Schwarzmeier <Ricardo.Schwarzmeier@infineon.com>
---
v2: *Add fixes tag
v3: *Avoid endianness problem
    *Make commit message more clear
v4: *Fix commit message style
v5: *Add change log

 drivers/char/tpm/tpm-interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index e32f6e85dc6d..7f2e2d54894d 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -423,7 +423,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
 		header->tag = cpu_to_be16(TPM2_ST_NO_SESSIONS);
 		header->return_code = cpu_to_be32(TPM2_RC_COMMAND_CODE |
 						  TSS2_RESMGR_TPM_RC_LAYER);
-		return bufsiz;
+		return sizeof(*header);
 	}
 
 	if (bufsiz > TPM_BUFSIZE)
-- 
2.17.1

