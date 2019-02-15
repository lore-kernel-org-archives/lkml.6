Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01CFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6680721927
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550198293;
	bh=3+zc/19LEFGbhWKSdxv612tntjsURDSSB650hkgAfqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xvTWXy8xX6RJeMevHhzSR0qIPY6f4aznr3oI9v2Qo4s/THax3bvWsR18EfM8id+En
	 vk/RUqNuIENga9zACKHw73dAvkvJovi/4OZ1x1F88E6l3T6rO/OYM9mvlHjlQ7kHkw
	 c4T7a6n7CXR4qZNe3fISlNQSM1ieibY7wCoH2Sys=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbfBOCiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:38:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:50640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390391AbfBOCK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:10:28 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B4DC222C9;
        Fri, 15 Feb 2019 02:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196628;
        bh=3+zc/19LEFGbhWKSdxv612tntjsURDSSB650hkgAfqE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=koeCxxObGTxx3xPrIMVqnA+fp6UHaFz10MSt9C5GC0cubNh3amZ1w4Jb/KbFBmzan
         hvVu+hQbxJoeQN+7pRlvyQp5pvSOcw0QMjkbu5801rkDuqTkLiNfgoqzMVfPQ0Sz0e
         GvCgBIRLAS7BBp37PxS1L+2zYgps9RUyXD/XFXa8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Atsushi Nemoto <atsushi.nemoto@sord.co.jp>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 54/77] net: altera_tse: fix connect_local_phy error path
Date:   Thu, 14 Feb 2019 21:08:32 -0500
Message-Id: <20190215020855.176727-54-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215020855.176727-1-sashal@kernel.org>
References: <20190215020855.176727-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Atsushi Nemoto <atsushi.nemoto@sord.co.jp>

[ Upstream commit 17b42a20d7ca59377788c6a2409e77569570cc10 ]

The connect_local_phy should return NULL (not negative errno) on
error, since its caller expects it.

Signed-off-by: Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
Acked-by: Thor Thayer <thor.thayer@linux.intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/altera/altera_tse_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/altera/altera_tse_main.c b/drivers/net/ethernet/altera/altera_tse_main.c
index 02921d877c08..aa1d1f5339d2 100644
--- a/drivers/net/ethernet/altera/altera_tse_main.c
+++ b/drivers/net/ethernet/altera/altera_tse_main.c
@@ -714,8 +714,10 @@ static struct phy_device *connect_local_phy(struct net_device *dev)
 
 		phydev = phy_connect(dev, phy_id_fmt, &altera_tse_adjust_link,
 				     priv->phy_iface);
-		if (IS_ERR(phydev))
+		if (IS_ERR(phydev)) {
 			netdev_err(dev, "Could not attach to PHY\n");
+			phydev = NULL;
+		}
 
 	} else {
 		int ret;
-- 
2.19.1

