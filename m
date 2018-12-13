Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB77C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B8620870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544676509;
	bh=ZpKd/gnzNEjzIF2AqdfhXPzlyFhrhyRSpbSbBDsIslM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=knQNFTjdRV0lCd3oEw0n8OYBwogo/HhI7C6tlTyr+w37p9dVJ4RWeNnkDUIo4abSv
	 dEmezit+55r+Pct81OUPWrA/LPyNDAEpjVRX1BBbK7/Q+16Ds+cTOwNX5/uVLhgx7t
	 0IeROXx05wZ8Aly9v9NyzlBXXOckPrYKK25TGLU4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0B8620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbeLMEaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:30:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:43064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727995AbeLMEaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:30:05 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F98620879;
        Thu, 13 Dec 2018 04:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675404;
        bh=ZpKd/gnzNEjzIF2AqdfhXPzlyFhrhyRSpbSbBDsIslM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dlUv4NepjoXrRGdxgxKJWFa74xO+OQWSy5ioaixJo4JO/48V0pBnXB84szOQzl45i
         vYfdD8dhw60tTvvN7VGxspkng+BGE0tmMKFFrJrv/TBd1ip3F4e8sFoAZurYjhKLaZ
         TmSaa3pe1ekC2uWnrLA08++kVAnScwJRx1VF7rAQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 45/73] net: phy: micrel: add toggling phy reset if PHY is not attached
Date:   Wed, 12 Dec 2018 23:28:10 -0500
Message-Id: <20181213042838.75160-45-sashal@kernel.org>
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

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

[ Upstream commit 8c85f4b81296a530b8af2796c110fa482ac42d4f ]

This patch adds toggling phy reset if PHY is not attached. Otherwise,
some boards (e.g. R-Car H3 Salvator-XS) cannot link up correctly if
we do the following method:

 1) Kernel boots by using initramfs.
 --> No open the nic, so phy_device_register() and phy_probe()
     deasserts the reset.
 2) Kernel enters the suspend.
 --> So, keep the reset signal as deassert.
 --> On R-Car Salvator-XS board, unfortunately, the board power is
     turned off.
 3) Kernel returns from suspend.
 4) ifconfig eth0 up
 --> Then, since edge signal of the reset doesn't happen,
     it cannot link up.
 5) ifconfig eth0 down
 6) ifconfig eth0 up
 --> In this case, it can link up.

Reported-by: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/micrel.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 3db06b40580d..327f00034d01 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -23,6 +23,7 @@
  *			 ksz9477
  */
 
+#include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/phy.h>
@@ -725,6 +726,13 @@ static int kszphy_resume(struct phy_device *phydev)
 {
 	int ret;
 
+	if (!phydev->attached_dev) {
+		/* If the PHY is not attached, toggle the reset */
+		phy_device_reset(phydev, 1);
+		udelay(1);
+		phy_device_reset(phydev, 0);
+	}
+
 	genphy_resume(phydev);
 
 	ret = kszphy_config_reset(phydev);
-- 
2.19.1

