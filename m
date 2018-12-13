Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73851C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B56B20870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544676185;
	bh=LZXqW9sRkLrHNUNkZ73QWxz2lUzzitBkk37nZpIH0vw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uejh7sw6YuBXsYiO9a8Eg/vX3g5wczmwZ8a/UzCEia/vC2Sq1NV+56oD0IrQnn3DT
	 p6neT0V7/pbCVXsfnLRrH+EwzRCEvrDFpfKA/MycSJLmihKj3Rs0D97P/G5LVhrEdv
	 VeCwO4UxrmnEKlD6hcvFE48ma4x30tPjppO1BJWU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B56B20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbeLMEnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:43:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:44544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728816AbeLMEbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:31:37 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C8AE20879;
        Thu, 13 Dec 2018 04:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675497;
        bh=LZXqW9sRkLrHNUNkZ73QWxz2lUzzitBkk37nZpIH0vw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s/CZjOVSjZbmowBjSFLomjl7eGp+I5bJGwN+SKjs2uO4wtVL4rLq5eLyxocS5R8wS
         o9cBknQRbjsIudCUWrJRNKmmO21gvZdybZj71TH642v7FB2+WyF3JRzCNyc7pQVQ3d
         S/Fj2rMtcD1cw2219neryfTugWIW68fY6y8jAq2g=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Anderson Luiz Alves <alacn1@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 26/41] mv88e6060: disable hardware level MAC learning
Date:   Wed, 12 Dec 2018 23:30:39 -0500
Message-Id: <20181213043054.75891-26-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213043054.75891-1-sashal@kernel.org>
References: <20181213043054.75891-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anderson Luiz Alves <alacn1@gmail.com>

[ Upstream commit a74515604a7b171f2702bdcbd1e231225fb456d0 ]

Disable hardware level MAC learning because it breaks station roaming.
When enabled it drops all frames that arrive from a MAC address
that is on a different port at learning table.

Signed-off-by: Anderson Luiz Alves <alacn1@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/mv88e6060.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/mv88e6060.c b/drivers/net/dsa/mv88e6060.c
index f123ed57630d..86b41840f41a 100644
--- a/drivers/net/dsa/mv88e6060.c
+++ b/drivers/net/dsa/mv88e6060.c
@@ -114,8 +114,7 @@ static int mv88e6060_switch_reset(struct dsa_switch *ds)
 	/* Reset the switch. */
 	REG_WRITE(REG_GLOBAL, GLOBAL_ATU_CONTROL,
 		  GLOBAL_ATU_CONTROL_SWRESET |
-		  GLOBAL_ATU_CONTROL_ATUSIZE_1024 |
-		  GLOBAL_ATU_CONTROL_ATE_AGE_5MIN);
+		  GLOBAL_ATU_CONTROL_LEARNDIS);
 
 	/* Wait up to one second for reset to complete. */
 	timeout = jiffies + 1 * HZ;
@@ -140,13 +139,10 @@ static int mv88e6060_setup_global(struct dsa_switch *ds)
 	 */
 	REG_WRITE(REG_GLOBAL, GLOBAL_CONTROL, GLOBAL_CONTROL_MAX_FRAME_1536);
 
-	/* Enable automatic address learning, set the address
-	 * database size to 1024 entries, and set the default aging
-	 * time to 5 minutes.
+	/* Disable automatic address learning.
 	 */
 	REG_WRITE(REG_GLOBAL, GLOBAL_ATU_CONTROL,
-		  GLOBAL_ATU_CONTROL_ATUSIZE_1024 |
-		  GLOBAL_ATU_CONTROL_ATE_AGE_5MIN);
+		  GLOBAL_ATU_CONTROL_LEARNDIS);
 
 	return 0;
 }
-- 
2.19.1

