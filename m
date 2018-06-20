Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3E4C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F318420874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="iZMvIJwF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F318420874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=infineon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753906AbeFTKFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 06:05:38 -0400
Received: from smtp11.infineon.com ([217.10.52.105]:5973 "EHLO
        smtp11.infineon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750821AbeFTKFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 06:05:37 -0400
X-Greylist: delayed 585 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Jun 2018 06:05:37 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1529489137; x=1561025137;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=F3M8qJOkKQDIb8hziGYpUAqjd+xaA6/TLw/ePuwZ5WM=;
  b=iZMvIJwFxpaIzMda9SYS0vNVf+tLpITDCxPU7o1YYi2Rh464uPCO4pvQ
   XJydOKaOHWYG09fZDfGxl/YhVup9yKR4ayepaRKlZK0pvvHHcrOSEVdYZ
   /fdQRoXLwQOsvNbi2pnpcyG3uWwiQGDdNBSXUgIu51LV3C3k2GiVcfLiz
   Y=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="5900,7806,8929"; a="82626083"
X-IronPort-AV: E=Sophos;i="5.51,246,1526335200"; 
   d="scan'208";a="82626083"
Received: from unknown (HELO mucxv002.muc.infineon.com) ([172.23.11.17])
  by smtp11.infineon.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Jun 2018 11:55:52 +0200
Received: from MUCSE708.infineon.com (MUCSE708.infineon.com [172.23.7.82])
        by mucxv002.muc.infineon.com (Postfix) with ESMTPS;
        Wed, 20 Jun 2018 11:55:50 +0200 (CEST)
Received: from MUCSE716.infineon.com (172.23.7.67) by MUCSE708.infineon.com
 (172.23.7.82) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1466.3; Wed, 20
 Jun 2018 11:55:51 +0200
Received: from schwaric-VirtualBox.agb.infineon.com (172.23.8.247) by
 MUCSE716.infineon.com (172.23.7.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.1.1466.3; Wed, 20 Jun 2018 11:55:50 +0200
From:   Ricardo Schwarzmeier <Ricardo.Schwarzmeier@infineon.com>
To:     <linux-integrity@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <peterhuewe@gmx.de>,
        <jarkko.sakkinen@linux.intel.com>, <jgg@ziepe.ca>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>,
        Ricardo Schwarzmeier <Ricardo.Schwarzmeier@infineon.com>
Subject: [PATCH v2] tpm: Return the actual size when receiving an unsupported command
Date:   Wed, 20 Jun 2018 11:55:07 +0200
Message-ID: <20180620095507.682-1-Ricardo.Schwarzmeier@infineon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.23.8.247]
X-ClientProxiedBy: MUCSE702.infineon.com (172.23.7.91) To
 MUCSE716.infineon.com (172.23.7.67)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The command size is computed for the header anyway.
It can as well indicate the correct number of bytes to read from the driver.
Fixes: 095531f891e6 ("tpm: return a TPM_RC_COMMAND_CODE response if command is not implemented")

Signed-off-by: Ricardo Schwarzmeier <Ricardo.Schwarzmeier@infineon.com>
---
 drivers/char/tpm/tpm-interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index e32f6e85dc6d..0923e81505a5 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -423,7 +423,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
 		header->tag = cpu_to_be16(TPM2_ST_NO_SESSIONS);
 		header->return_code = cpu_to_be32(TPM2_RC_COMMAND_CODE |
 						  TSS2_RESMGR_TPM_RC_LAYER);
-		return bufsiz;
+		return header->length;
 	}
 
 	if (bufsiz > TPM_BUFSIZE)
-- 
2.17.1

