Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686FCC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 254BB22513
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6+cEQCr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 254BB22513
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731549AbeKOI12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:27:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:34402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729087AbeKOI11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:27:27 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 408ED22526;
        Wed, 14 Nov 2018 22:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234144;
        bh=OYwdI72nSvEeMaRKCm8f623xRMFUREu5VxKiANAzODY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U6+cEQCrqbPEDgW5iXbzXT1qDPBjQtdgNnZgAdb8FN8vAOBHOJENB11aRsoUrIlVu
         VCL90/4q4XaYQ8Ef+zRzbOP/HK2EAPwzt0GnjrG7JlSyiWKf/ONv2DQO+TM90B+A+h
         0tpp4vadb6PZHXUW5lrLpK8vyWC89RGNBd736aQk=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 65/73] net: smsc95xx: Fix MTU range
Date:   Wed, 14 Nov 2018 17:21:59 -0500
Message-Id: <20181114222207.98701-65-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222207.98701-1-sashal@kernel.org>
References: <20181114222207.98701-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Wahren <stefan.wahren@i2se.com>

[ Upstream commit 85b18b0237ce9986a81a1b9534b5e2ee116f5504 ]

The commit f77f0aee4da4 ("net: use core MTU range checking in USB NIC
drivers") introduce a common MTU handling for usbnet. But it's missing
the necessary changes for smsc95xx. So set the MTU range accordingly.

This patch has been tested on a Raspberry Pi 3.

Fixes: f77f0aee4da4 ("net: use core MTU range checking in USB NIC drivers")
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/smsc95xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
index 2d17f3b9bb16..f2d01cb6f958 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -1321,6 +1321,8 @@ static int smsc95xx_bind(struct usbnet *dev, struct usb_interface *intf)
 	dev->net->ethtool_ops = &smsc95xx_ethtool_ops;
 	dev->net->flags |= IFF_MULTICAST;
 	dev->net->hard_header_len += SMSC95XX_TX_OVERHEAD_CSUM;
+	dev->net->min_mtu = ETH_MIN_MTU;
+	dev->net->max_mtu = ETH_DATA_LEN;
 	dev->hard_mtu = dev->net->mtu + dev->net->hard_header_len;
 
 	pdata->dev = dev;
-- 
2.17.1

