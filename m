Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C029C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2397214DB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCGU4ngn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2397214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388304AbeKVFol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:44:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:39272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732079AbeKVFoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:44:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BB14206BB;
        Wed, 21 Nov 2018 19:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542827347;
        bh=+UFZaZNJqaLKSOUdgnC7BLcZDxCsrVXUNSBfuzr+B5s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MCGU4ngnK8xQ8sbEfHla/HJ02IqtjiSQlwj1FNUqJfFUvrneZqDuQoJNugJ8A5i/i
         FRj3SWG/cO4ytz/DfIvBHkm4x8TKw+T/27TlID+VqhqtopdSKsLFEiRacEshjjBnFm
         EGmGITFaj5sKWNQB7Y+efFKVH7E+KL0km4a6i2gM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 16/21] net: smsc95xx: Fix MTU range
Date:   Wed, 21 Nov 2018 20:07:00 +0100
Message-Id: <20181121183422.807170668@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121183422.103826775@linuxfoundation.org>
References: <20181121183422.103826775@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Wahren <stefan.wahren@i2se.com>

[ Upstream commit 85b18b0237ce9986a81a1b9534b5e2ee116f5504 ]

The commit f77f0aee4da4 ("net: use core MTU range checking in USB NIC
drivers") introduce a common MTU handling for usbnet. But it's missing
the necessary changes for smsc95xx. So set the MTU range accordingly.

This patch has been tested on a Raspberry Pi 3.

Fixes: f77f0aee4da4 ("net: use core MTU range checking in USB NIC drivers")
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/smsc95xx.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -1321,6 +1321,8 @@ static int smsc95xx_bind(struct usbnet *
 	dev->net->ethtool_ops = &smsc95xx_ethtool_ops;
 	dev->net->flags |= IFF_MULTICAST;
 	dev->net->hard_header_len += SMSC95XX_TX_OVERHEAD_CSUM;
+	dev->net->min_mtu = ETH_MIN_MTU;
+	dev->net->max_mtu = ETH_DATA_LEN;
 	dev->hard_mtu = dev->net->mtu + dev->net->hard_header_len;
 
 	pdata->dev = dev;


