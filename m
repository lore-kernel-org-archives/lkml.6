Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DF2C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1411320880
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690333;
	bh=iCCSXK/Lkk6+ccBTbCCmQn/WVVsaCZUwrXp2Z63VazE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rhGWf7hlUyTLLYoZEE1GwzFlb2ZHffdt+C4Z/XxdfW33SQGHBeOfVFLxq8rjXL9Uf
	 pR6jLMEaRFzniWwtjOXTF+m5WsUPmWgPKweSdjSr1sLQsbTWpfD8Dd0xZCfyJkn/di
	 2UoFmHmDf8yHiihQrfmO5rJgZwoS2SaOhpVe7qhw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbfA1Ppb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:45:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:58800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726904AbfA1Pp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:45:26 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 932B92147A;
        Mon, 28 Jan 2019 15:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690326;
        bh=iCCSXK/Lkk6+ccBTbCCmQn/WVVsaCZUwrXp2Z63VazE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=riQfXMPN/3Q1w+q9NW1cU3Tbn/XWu8LDqlrsKZbCGgjJg+NvSTuchRFetXjfRz5bi
         UHfMHMOnx+fd99dZOOZTpzYtTYYu4YWmMiqgNqTI/ywX5JOiPsSluajguzRrj08TPd
         kwHkk73kJbCY8Zl3SifHtI9SSDwJMp/0kHumWsF8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 052/304] usbnet: smsc95xx: fix rx packet alignment
Date:   Mon, 28 Jan 2019 10:39:29 -0500
Message-Id: <20190128154341.47195-52-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
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

