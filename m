Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BC8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C8A2084F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550760147;
	bh=6MHA8/5JP46Zw0ix4rVp9xpMW8XJNAKUBUAyLjwK2nQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s9RlfxogZQLJxhsgYUq0zbvQYk5IhgL6cqOQQeQZJGnVCTBSmPN3lNSz7AJBnAmZm
	 Qxsj6SZUtHQL6LBXJ1fNGhjuaK6tF/wJWM5S73EHoNQm+xPBkMzsZxO1XMo66XtAfV
	 uiFyMiw4pZoEcLkBm4jMlW3Kh/Y415ZVdX82nams=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbfBUOmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:42:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:37736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729499AbfBUOmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:42:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E6FF2075A;
        Thu, 21 Feb 2019 14:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550760135;
        bh=6MHA8/5JP46Zw0ix4rVp9xpMW8XJNAKUBUAyLjwK2nQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XhsZp/vXyOKl1ANz6Vt2diWJ64qJOLpBOlZcC+C7FCYBeAPjfnqAsscSj0WpQSi3+
         4rkgQuz4Lk668bBURKKFFTp7NbFrnc7tmAeTN+Zpx4IufD746c2Qvz1IFrGi9O+cmT
         n8HcStrYkTiwFIUqNqKlLnLV0J16M3/Sw2qlRiHg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 09/30] net: phy: xgmiitorgmii: Support generic PHY status read
Date:   Thu, 21 Feb 2019 15:35:51 +0100
Message-Id: <20190221125251.046637974@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221125250.543158526@linuxfoundation.org>
References: <20190221125250.543158526@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 197f9ab7f08ce4b9ece662f747c3991b2f0fbb57 ]

Some PHY drivers like the generic one do not provide a read_status
callback on their own but rely on genphy_read_status being called
directly.

With the current code, this results in a NULL function pointer call.
Call genphy_read_status instead when there is no specific callback.

Fixes: f411a6160bd4 ("net: phy: Add gmiitorgmii converter support")
Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/xilinx_gmii2rgmii.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/xilinx_gmii2rgmii.c b/drivers/net/phy/xilinx_gmii2rgmii.c
index 74a8782313cf5..bd6084e315de2 100644
--- a/drivers/net/phy/xilinx_gmii2rgmii.c
+++ b/drivers/net/phy/xilinx_gmii2rgmii.c
@@ -44,7 +44,10 @@ static int xgmiitorgmii_read_status(struct phy_device *phydev)
 	u16 val = 0;
 	int err;
 
-	err = priv->phy_drv->read_status(phydev);
+	if (priv->phy_drv->read_status)
+		err = priv->phy_drv->read_status(phydev);
+	else
+		err = genphy_read_status(phydev);
 	if (err < 0)
 		return err;
 
-- 
2.19.1



