Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A812BC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 06:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F2CE23DF3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 06:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="hzF4VPwZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F2CE23DF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=infineon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751242AbeFVG4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 02:56:44 -0400
Received: from smtp2.infineon.com ([217.10.52.18]:7649 "EHLO
        smtp2.infineon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751213AbeFVG4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 02:56:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1529650601; x=1561186601;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=p6RZdkXjDcaaSLAxn5RUWGDMAirDy0CSHcG3vwY5WhQ=;
  b=hzF4VPwZWtwQyAUApUNyRibEX60t8+pV4/j8Zma+DoPKalM6aGyC39wf
   pvhTtcdTo4DurIUnunNUxSRWtEdqcFXrAD+WK9vnpP/TSNlmfAySoJFyx
   0kX4Mi+AQL5OGl5Icgmg0NY1hDEXK3fazOC4+FuaMXmVcBLx4VVrtBMG+
   E=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="5900,7806,8931"; a="69503222"
X-IronPort-AV: E=Sophos;i="5.51,255,1526335200"; 
   d="scan'208";a="69503222"
Received: from unknown (HELO mucxv002.muc.infineon.com) ([172.23.11.17])
  by smtp2.infineon.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jun 2018 08:56:40 +0200
Received: from MUCSE706.infineon.com (MUCSE706.infineon.com [172.23.7.80])
        by mucxv002.muc.infineon.com (Postfix) with ESMTPS;
        Fri, 22 Jun 2018 08:56:40 +0200 (CEST)
Received: from MUCSE716.infineon.com (172.23.7.67) by MUCSE706.infineon.com
 (172.23.7.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1466.3; Fri, 22
 Jun 2018 08:56:39 +0200
Received: from schwaric-VirtualBox.agb.infineon.com (172.23.8.247) by
 MUCSE716.infineon.com (172.23.7.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.1.1466.3; Fri, 22 Jun 2018 08:56:39 +0200
From:   Ricardo Schwarzmeier <Ricardo.Schwarzmeier@infineon.com>
To:     <linux-integrity@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <peterhuewe@gmx.de>,
        <jarkko.sakkinen@linux.intel.com>, <jgg@ziepe.ca>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>,
        Ricardo Schwarzmeier <Ricardo.Schwarzmeier@infineon.com>
Subject: [PATCH v4] tpm: Return the actual size when receiving an unsupported command
Date:   Fri, 22 Jun 2018 08:50:00 +0200
Message-ID: <20180622065000.31139-1-Ricardo.Schwarzmeier@infineon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.23.8.247]
X-ClientProxiedBy: MUCSE705.infineon.com (172.23.7.79) To
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

