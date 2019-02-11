Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B43C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B45CE20844
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895054;
	bh=hNvfpttkZ+QDnKyPstn9n0HlFOAmGKoPkYpAnRkNq58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k2dxI8KMdmiwIOj6kua+ENI73SycrwF+tkjk3mQTokBCUs5p+sLagUb8mMRCp4QPP
	 XyppHSXeva+ZnXuurTHTsM4PDHg/Fn9aPPiwqhXIeKX3GdkqK0XYq2wbCrSgK1j4nk
	 nxEW11oWjYd5ZS8YvPrKSUFn3TP/zBF/i9p/kwc0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbfBKOYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:24:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:57270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727835AbfBKOYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:24:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57B8120821;
        Mon, 11 Feb 2019 14:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895047;
        bh=hNvfpttkZ+QDnKyPstn9n0HlFOAmGKoPkYpAnRkNq58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FCeqNJF3B4td9vPSudjLa1Omw53HanHpiIIvMpZq5QnPmUkz6MuO/IPCpSTlrMStj
         OCeU4NcvgFe+xrpv5F54ualxHKJArjjZAzwFT59lfBcpi/8otcPSTOm0u+n0SceADO
         /qjI7XGw2wEKMpV4gL+VHeuEyKaBNpWcd+EzrR1E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Dooks <ben.dooks@codethink.co.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 046/352] usbnet: smsc95xx: fix rx packet alignment
Date:   Mon, 11 Feb 2019 15:14:33 +0100
Message-Id: <20190211141849.224223353@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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



