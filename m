Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B84ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 22:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29FFE2086B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 22:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="cmZgfbKJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29FFE2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730027AbeGPX2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 19:28:20 -0400
Received: from vern.gendns.com ([206.190.152.46]:53819 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729151AbeGPX2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 19:28:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QSzsLw4zBQ/B0LeI8GqKoK9G/pXOPFCKy8CO3Jcq2q8=; b=cmZgfbKJqHP1r3b/xAG8yAEipm
        5y5CbxOx8q/JMKNrnJa9X386ZdmnGzFdNovjhmUYlpET52LVyZk3CqR/IRrC4T8IVg31z+vAtBu/b
        kv6GD5gntSNOONSx2R9qdVaWlYE4WJlzPOGinE1lr0TcLlbLoZISLU0pvXFNRA2wxEnlXjkRFnNci
        iyTrbfkDLyME+K8wAeTMdn3rZ5tlQOkv+LRYDKD2t0VQXX93mKk1dCDdbia73H8NRkZKqNB9n8cup
        ZiPvVt7jKx+iQLFIy38QXeE90UrnyhGDMPxSp12aruQuylGco85j3NmevvxTCNYNCEo7FraMvwE/9
        HeGgyasQ==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:49036 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1ffCS4-00CIFa-Ok; Mon, 16 Jul 2018 18:58:44 -0400
From:   David Lechner <david@lechnology.com>
To:     Petko Manolov <petkan@nucleusys.com>
Cc:     David Lechner <david@lechnology.com>,
        "David S. Miller" <davem@davemloft.net>, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: usb: rtl8150: demote allmulti message to dev_dbg()
Date:   Mon, 16 Jul 2018 17:58:10 -0500
Message-Id: <20180716225810.30741-1-david@lechnology.com>
X-Mailer: git-send-email 2.17.1
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver can spam the kernel log with multiple messages of:

    net eth0: eth0: allmulti set

Usually 4 or 8 at a time (probably because of using ConnMan).

This message doesn't seem useful, so let's demote it from dev_info()
to dev_dbg().

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/net/usb/rtl8150.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
index 0e81d4c441d9..80373a9171dd 100644
--- a/drivers/net/usb/rtl8150.c
+++ b/drivers/net/usb/rtl8150.c
@@ -682,7 +682,7 @@ static void rtl8150_set_multicast(struct net_device *netdev)
 		   (netdev->flags & IFF_ALLMULTI)) {
 		rx_creg &= 0xfffe;
 		rx_creg |= 0x0002;
-		dev_info(&netdev->dev, "%s: allmulti set\n", netdev->name);
+		dev_dbg(&netdev->dev, "%s: allmulti set\n", netdev->name);
 	} else {
 		/* ~RX_MULTICAST, ~RX_PROMISCUOUS */
 		rx_creg &= 0x00fc;
-- 
2.17.1

