Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64E8C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A645120866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjhd3Prp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A645120866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730431AbeJPMFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:05:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730380AbeJPMFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:05:22 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FDE3214AB;
        Tue, 16 Oct 2018 04:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663418;
        bh=IzSN/ddr+exqrnNogNI0Cro+lViGvzKoNEOUvX9oit8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kjhd3PrpbmP5qWhBSX1Z1wD6Xw2tSu/JO7V35d+t1CuUHK+7J3Tu2ac9/4NWCyab9
         G/WjBt/tNE1zDJ/BhxG7lcP0s5dFWGaULpv8pPH0A057KSgnJeklKMnqs93FF41jxE
         BH0ibgblNVsu04IKQ18vHcxAQWQDc2G8RyImwJR4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 07/15] ax88179_178a: Check for supported Wake-on-LAN modes
Date:   Tue, 16 Oct 2018 00:16:42 -0400
Message-Id: <20181016041650.135958-7-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041650.135958-1-sashal@kernel.org>
References: <20181016041650.135958-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit 5ba6b4aa9a410c5e2c6417df52b5e2118ea9b467 ]

The driver currently silently accepts unsupported Wake-on-LAN modes
(other than WAKE_PHY or WAKE_MAGIC) without reporting that to the user,
which is confusing.

Fixes: e2ca90c276e1 ("ax88179_178a: ASIX AX88179_178A USB 3.0/2.0 to gigabit ethernet adapter driver")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/ax88179_178a.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index e6338c16081a..e3f2e6098db4 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -566,6 +566,9 @@ ax88179_set_wol(struct net_device *net, struct ethtool_wolinfo *wolinfo)
 	struct usbnet *dev = netdev_priv(net);
 	u8 opt = 0;
 
+	if (wolinfo->wolopts & ~(WAKE_PHY | WAKE_MAGIC))
+		return -EINVAL;
+
 	if (wolinfo->wolopts & WAKE_PHY)
 		opt |= AX_MONITOR_MODE_RWLC;
 	if (wolinfo->wolopts & WAKE_MAGIC)
-- 
2.17.1

