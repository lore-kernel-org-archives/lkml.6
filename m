Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66F1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51672085A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550759939;
	bh=/QaWSLOZPhepWkkQvHacdE08gPSURnhVCBB/Sda7dIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uZUgKRtz+/bNKjqb7oWnOAHQrHp17o0z90NL1oINgbn+QDyZ/+RJfJrBysaMBT9y7
	 9NzI1pUBPd5OWX9oUJlxlsiJip77XiCcgVcLB3/UArRNQF8lREGzyBNoZvQffwWiqU
	 o2Xus6Gz3MFDbKSqyTwKGglLMLrJJESHAr4tDwTE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbfBUOi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:38:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:60790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728743AbfBUOix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:38:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B26C2075C;
        Thu, 21 Feb 2019 14:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550759932;
        bh=/QaWSLOZPhepWkkQvHacdE08gPSURnhVCBB/Sda7dIQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AkG8dA8PDpC/yrsQW0+UXz32o9nEWLdLsPAf962T+/HBNt0xN4PLSNXibycUVQUqv
         5/kmfQotZBfR3c0FZw4BP93lW0Y+TEmDX+2AfgFXftNnXSJCF81KX6aXTWnU9KBxFz
         gsOvzZ3HvURu9FPkCOEkywX26oX14vFgjw0c4GVA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 05/20] net: phy: xgmiitorgmii: Support generic PHY status read
Date:   Thu, 21 Feb 2019 15:35:43 +0100
Message-Id: <20190221125242.970936669@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221125242.153179182@linuxfoundation.org>
References: <20190221125242.153179182@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

[ Upstream commit 197f9ab7f08ce4b9ece662f747c3991b2f0fbb57 ]

Some PHY drivers like the generic one do not provide a read_status
callback on their own but rely on genphy_read_status being called
directly.

With the current code, this results in a NULL function pointer call.
Call genphy_read_status instead when there is no specific callback.

Fixes: f411a6160bd4 ("net: phy: Add gmiitorgmii converter support")
Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/xilinx_gmii2rgmii.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/net/phy/xilinx_gmii2rgmii.c
+++ b/drivers/net/phy/xilinx_gmii2rgmii.c
@@ -42,7 +42,10 @@ static int xgmiitorgmii_read_status(stru
 	u16 val = 0;
 	int err;
 
-	err = priv->phy_drv->read_status(phydev);
+	if (priv->phy_drv->read_status)
+		err = priv->phy_drv->read_status(phydev);
+	else
+		err = genphy_read_status(phydev);
 	if (err < 0)
 		return err;
 


