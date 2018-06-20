Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E51C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 926B020872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="UBC7+O3U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 926B020872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=infineon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754011AbeFTOwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 10:52:32 -0400
Received: from smtp11.infineon.com ([217.10.52.105]:11157 "EHLO
        smtp11.infineon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752932AbeFTOwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 10:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1529506351; x=1561042351;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=3S1dhYYVfJB8qM1C1UJRLghjn9H9eCa5nmobLZWhglE=;
  b=UBC7+O3UxZ206c/SlTXJ9SUflCeN955f6PLLTqJJhrPk08Q87P+CDu5j
   GvekxHOGL+LWpG0a0i/kIeIuGeQQ+mqFXmjMDKcmGpEE37kPjp9rd/DH2
   nCBojEX5P21uQMV0DduqT7h7K6e25hd1m/fWhV8J9N3xnMqpOsFfPFuoe
   o=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="5900,7806,8929"; a="82664088"
X-IronPort-AV: E=Sophos;i="5.51,247,1526335200"; 
   d="scan'208";a="82664088"
Received: from unknown (HELO mucxv001.muc.infineon.com) ([172.23.11.16])
  by smtp11.infineon.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Jun 2018 16:52:30 +0200
Received: from MUCSE707.infineon.com (MUCSE707.infineon.com [172.23.7.81])
        by mucxv001.muc.infineon.com (Postfix) with ESMTPS;
        Wed, 20 Jun 2018 16:52:29 +0200 (CEST)
Received: from MUCSE716.infineon.com (172.23.7.67) by MUCSE707.infineon.com
 (172.23.7.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1466.3; Wed, 20
 Jun 2018 16:52:28 +0200
Received: from schwaric-VirtualBox.agb.infineon.com (172.23.8.247) by
 MUCSE716.infineon.com (172.23.7.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.1.1466.3; Wed, 20 Jun 2018 16:52:29 +0200
From:   Ricardo Schwarzmeier <Ricardo.Schwarzmeier@infineon.com>
To:     <linux-integrity@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <peterhuewe@gmx.de>,
        <jarkko.sakkinen@linux.intel.com>, <jgg@ziepe.ca>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>,
        Ricardo Schwarzmeier <Ricardo.Schwarzmeier@infineon.com>
Subject: [PATCH v3] tpm: Return the actual size when receiving an unsupported command
Date:   Wed, 20 Jun 2018 16:38:23 +0200
Message-ID: <20180620143823.14718-1-Ricardo.Schwarzmeier@infineon.com>
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
Changes since v2:
 * Made commit message more clear
 * Avoided endianness problems
---
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

