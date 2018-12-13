Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A157DC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 686942080F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544676745;
	bh=XBcIophZ7csLne9xCXqvnONuOooDZpF3ortx0KeLKfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O/vU4xTb27kUJiGNdf+U66eq5H6TJVjrDQcaOYiYLak/b/X8yoeymue0vqatbzeRQ
	 KMyY8Vv41SmumLtFl4J9f4DJiJ/eetmsZu/zNfwQI3p8qpEx0wJDumoQ8/KgROgnLm
	 4Y9UL+Cv4IfUk10/pOddoP3nJWFgTEy81qmNX0nA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 686942080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbeLMEwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:52:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:41716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727024AbeLME2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:28:50 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5ED6A2087F;
        Thu, 13 Dec 2018 04:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675330;
        bh=XBcIophZ7csLne9xCXqvnONuOooDZpF3ortx0KeLKfU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gECZglFKebpRtxU67lilQ0Gl43xP+jaSVSGFSvggGKgUysE7Dn52fwJ0Ax5rNEZMj
         d309F+N4kCuKGm/TvuLZ3Ws0LwlnirW8bs2N8CgCkhhOtdNQBTxFf7g7lxi/Dd52Ba
         TZpv88Hf7jteZz8ytyTcJxtSC3Kt0CJ32Oh46E/o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Baruch Siach <baruch@tkos.co.il>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 09/73] net: phy: sfp: correct store of detected link modes
Date:   Wed, 12 Dec 2018 23:27:34 -0500
Message-Id: <20181213042838.75160-9-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213042838.75160-1-sashal@kernel.org>
References: <20181213042838.75160-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Baruch Siach <baruch@tkos.co.il>

[ Upstream commit d7f7e0018b96fd1a30a968faa9464eb57372c1ec ]

The link modes that sfp_parse_support() detects are stored in the
'modes' bitmap. There is no reason to make an exception for 1000Base-PX
or 1000Base-BX10.

Fixes: 03145864bd0f ("sfp: support 1G BiDi (eg, FiberStore SFP-GE-BX) modules")
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/sfp-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/sfp-bus.c b/drivers/net/phy/sfp-bus.c
index 83060fb349f4..ad9db652874d 100644
--- a/drivers/net/phy/sfp-bus.c
+++ b/drivers/net/phy/sfp-bus.c
@@ -162,7 +162,7 @@ void sfp_parse_support(struct sfp_bus *bus, const struct sfp_eeprom_id *id,
 	/* 1000Base-PX or 1000Base-BX10 */
 	if ((id->base.e_base_px || id->base.e_base_bx10) &&
 	    br_min <= 1300 && br_max >= 1200)
-		phylink_set(support, 1000baseX_Full);
+		phylink_set(modes, 1000baseX_Full);
 
 	/* For active or passive cables, select the link modes
 	 * based on the bit rates and the cable compliance bytes.
-- 
2.19.1

