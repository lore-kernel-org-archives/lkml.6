Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77604C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48CF921919
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691288;
	bh=iCCSXK/Lkk6+ccBTbCCmQn/WVVsaCZUwrXp2Z63VazE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HwrKbtWj6sdq0853BugilZpeLqMouVOYq4jux6RAfCATuHsStdGFFIxkzcP1Tobmb
	 qOgk961vqUV9J1YZXEZzTl8d5rEG66UHzsF3j0h+hf9aJOdDB4+wZWfnyhgFfKqYpC
	 f5iLdhYpb2RV9knrTbB/Cu23Ujg/EfM59o+eO+G8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731042AbfA1QB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:01:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:46666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728400AbfA1QBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:01:24 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28C7621852;
        Mon, 28 Jan 2019 16:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691283;
        bh=iCCSXK/Lkk6+ccBTbCCmQn/WVVsaCZUwrXp2Z63VazE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w8DffjvfOU4enS1JKTWfNM1YLIR6VQ/o+LMgmZAdDDSgA1O+Ig23CUribqgQ3WYwS
         MKfR/+dyCZWhmmt6c1X/K80Gz5iYAsa2zxM6rc317CbqDb8P3dXUSbpeqOCK3vJqWY
         7CMDz77BWvPXwoEFMqa6vnVKfQlqCP54KG3il87A=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 045/258] usbnet: smsc95xx: fix rx packet alignment
Date:   Mon, 28 Jan 2019 10:55:51 -0500
Message-Id: <20190128155924.51521-45-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Dooks <ben.dooks@codethink.co.uk>

[ Upstream commit 810eeb1f41a9a272eedc94ca18c072e75678ede4 ]

The smsc95xx driver already takes into account the NET_IP_ALIGN
parameter when setting up the receive packet data, which means
we do not need to worry about aligning the packets in the usbnet
driver.

Adding the EVENT_NO_IP_ALIGN means that the IPv4 header is now
passed to the ip_rcv() routine with the start on an aligned address.

Tested on Raspberry Pi B3.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/smsc95xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
index f2d01cb6f958..6e971628bb50 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -1295,6 +1295,7 @@ static int smsc95xx_bind(struct usbnet *dev, struct usb_interface *intf)
 		dev->net->features |= NETIF_F_RXCSUM;
 
 	dev->net->hw_features = NETIF_F_IP_CSUM | NETIF_F_RXCSUM;
+	set_bit(EVENT_NO_IP_ALIGN, &dev->flags);
 
 	smsc95xx_init_mac_address(dev);
 
-- 
2.19.1

