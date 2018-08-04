Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E765C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13F40217C5
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:12:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13F40217C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389335AbeHDLMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 07:12:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50358 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732902AbeHDLMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 07:12:00 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id AABD5BBF;
        Sat,  4 Aug 2018 09:11:59 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Floris Bos <bos@je-eigen-domein.nl>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 104/124] net: lan78xx: fix rx handling before first packet is send
Date:   Sat,  4 Aug 2018 11:01:33 +0200
Message-Id: <20180804082706.358731134@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180804082702.434482435@linuxfoundation.org>
References: <20180804082702.434482435@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Wahren <stefan.wahren@i2se.com>

[ Upstream commit 136f55f660192ce04af091642efc75d85e017364 ]

As long the bh tasklet isn't scheduled once, no packet from the rx path
will be handled. Since the tx path also schedule the same tasklet
this situation only persits until the first packet transmission.
So fix this issue by scheduling the tasklet after link reset.

Link: https://github.com/raspberrypi/linux/issues/2617
Fixes: 55d7de9de6c3 ("Microchip's LAN7800 family USB 2/3 to 10/100/1000 Ethernet")
Suggested-by: Floris Bos <bos@je-eigen-domein.nl>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/lan78xx.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1361,6 +1361,8 @@ static void lan78xx_init_mac_address(str
 			netif_dbg(dev, ifup, dev->net,
 				  "MAC address set to random addr");
 		}
+
+		tasklet_schedule(&dev->bh);
 	}
 
 	ret = lan78xx_write_reg(dev, MAF_LO(0), addr_lo);


