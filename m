Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CE4ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E6A20892
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVD9jd4A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23E6A20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729862AbeKIHgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:36:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:53764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728496AbeKIHgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:36:22 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F8932146D;
        Thu,  8 Nov 2018 21:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714334;
        bh=39/T3iRdmRUKhFcaZrKfSQmCdXeQ7wG2GOroB8g6qAM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NVD9jd4ATwKnJU/lcnu1Spt+Ekl/nbnChzvFSlWVBqFePJA06IDb7zA35WtIcRNBY
         wO8yMNkWbB8dutRYfSZO38FQe7GJVzagcVWu9+VKfySqgKRuQgnu/QE9tuwZVExVog
         fCriHZXa5MXjo+iaFkm15wSVSNzzbPqL//CMOf2s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Woojung Huh <Woojung.Huh@Microchip.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 012/114] lan78xx: Check for supported Wake-on-LAN modes
Date:   Thu,  8 Nov 2018 13:50:27 -0800
Message-Id: <20181108215100.081022026@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215059.051093652@linuxfoundation.org>
References: <20181108215059.051093652@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit eb9ad088f96653a26b340f7c447c44cf023d5cdc ]

The driver supports a fair amount of Wake-on-LAN modes, but is not
checking that the user specified one that is supported.

Fixes: 55d7de9de6c3 ("Microchip's LAN7800 family USB 2/3 to 10/100/1000 Ethernet device driver")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Woojung Huh <Woojung.Huh@Microchip.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/lan78xx.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 1aede726052c..45a6a7cae4bf 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1051,19 +1051,10 @@ static int lan78xx_set_wol(struct net_device *netdev,
 	if (ret < 0)
 		return ret;
 
-	pdata->wol = 0;
-	if (wol->wolopts & WAKE_UCAST)
-		pdata->wol |= WAKE_UCAST;
-	if (wol->wolopts & WAKE_MCAST)
-		pdata->wol |= WAKE_MCAST;
-	if (wol->wolopts & WAKE_BCAST)
-		pdata->wol |= WAKE_BCAST;
-	if (wol->wolopts & WAKE_MAGIC)
-		pdata->wol |= WAKE_MAGIC;
-	if (wol->wolopts & WAKE_PHY)
-		pdata->wol |= WAKE_PHY;
-	if (wol->wolopts & WAKE_ARP)
-		pdata->wol |= WAKE_ARP;
+	if (wol->wolopts & ~WAKE_ALL)
+		return -EINVAL;
+
+	pdata->wol = wol->wolopts;
 
 	device_set_wakeup_enable(&dev->udev->dev, (bool)wol->wolopts);
 
-- 
2.17.1



