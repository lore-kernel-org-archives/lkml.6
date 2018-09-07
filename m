Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE455C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1EAD20855
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1EAD20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbeIHCYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:24:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54886 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728265AbeIHCYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:24:07 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 53FC4FF0;
        Fri,  7 Sep 2018 21:41:12 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "stable@vger.kernel.org, Stefan Wahren" <stefan.wahren@i2se.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 04/47] net: lan78xx: Fix misplaced tasklet_schedule() call
Date:   Fri,  7 Sep 2018 23:10:00 +0200
Message-Id: <20180907210904.911462382@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210904.607934824@linuxfoundation.org>
References: <20180907210904.607934824@linuxfoundation.org>
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

From: Ben Hutchings <ben.hutchings@codethink.co.uk>

Commit 136f55f66019 ("net: lan78xx: fix rx handling before first
packet is send") was not correctly backported to 4.4.  The call to
tasklet_schedule() belongs in lan78xx_link_reset().

Fixes: d1fc12d8475c ("net: lan78xx: fix rx handling before first packet is send")
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
This is for 4.4 only; the backports to other stable branches look OK.
I didn't test the driver on any branch though.

Ben.

 drivers/net/usb/lan78xx.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -902,6 +902,8 @@ static int lan78xx_link_reset(struct lan
 
 		ret = lan78xx_update_flowcontrol(dev, ecmd.duplex, ladv, radv);
 		netif_carrier_on(dev->net);
+
+		tasklet_schedule(&dev->bh);
 	}
 
 	return ret;
@@ -1361,8 +1363,6 @@ static void lan78xx_init_mac_address(str
 			netif_dbg(dev, ifup, dev->net,
 				  "MAC address set to random addr");
 		}
-
-		tasklet_schedule(&dev->bh);
 	}
 
 	ret = lan78xx_write_reg(dev, MAF_LO(0), addr_lo);


