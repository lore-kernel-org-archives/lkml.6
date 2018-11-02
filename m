Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07114C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDAF620837
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPhU+Amr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDAF620837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbeKCDr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:47:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:42164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728250AbeKCDrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:47:55 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F46F2082E;
        Fri,  2 Nov 2018 18:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541183984;
        bh=l90o+lEH+iQmMO05MqsdRPvwEhcDpuKRIrn+tZqWmMo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QPhU+AmrOmNmzkrgInHT745ziub27r3+mdASnDyfFoDcBnAy8FCXEYJJHRL14pxcx
         wjfGvzS6WU1iOQwtZjlgM0xNbjnCY/pfmxRQ6cmr5VeJYPyeOANZ/9GGAPBOlt6kCP
         J46kl5Fe0Yhq8GkZQQoV8SSvU79MTVH43F3gfl30=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 042/150] asix: Check for supported Wake-on-LAN modes
Date:   Fri,  2 Nov 2018 19:33:24 +0100
Message-Id: <20181102182906.315460286@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit c4ce446e33d7a0e978256ac6fea4c80e59d9de5f ]

The driver currently silently accepts unsupported Wake-on-LAN modes
(other than WAKE_PHY or WAKE_MAGIC) without reporting that to the user,
which is confusing.

Fixes: 2e55cc7210fe ("[PATCH] USB: usbnet (3/9) module for ASIX Ethernet adapters")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/asix_common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/usb/asix_common.c b/drivers/net/usb/asix_common.c
index e95dd12edec4..023b8d0bf175 100644
--- a/drivers/net/usb/asix_common.c
+++ b/drivers/net/usb/asix_common.c
@@ -607,6 +607,9 @@ int asix_set_wol(struct net_device *net, struct ethtool_wolinfo *wolinfo)
 	struct usbnet *dev = netdev_priv(net);
 	u8 opt = 0;
 
+	if (wolinfo->wolopts & ~(WAKE_PHY | WAKE_MAGIC))
+		return -EINVAL;
+
 	if (wolinfo->wolopts & WAKE_PHY)
 		opt |= AX_MONITOR_LINK;
 	if (wolinfo->wolopts & WAKE_MAGIC)
-- 
2.17.1



