Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E3CC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD8721470
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTPpTq5t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAD8721470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730089AbeJPMHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:07:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:53732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730186AbeJPMEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:04:42 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11F8C2147E;
        Tue, 16 Oct 2018 04:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663379;
        bh=7P4wLbDhupbSQreYBK1C7bO5IVqVdLCrveTsG5SFnOU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XTPpTq5ta9GdSyZisPvaYtDKmGI3yVKtMlPqX0M92ZSulG/tuZWw2h1rn1I2OAEmu
         31NPIbAwe72GIuBaQDdj9zFXwatJqHJ9LQNpkbvZix08d+VWLQOyZ8RM7vcsyT6D26
         3rxFhs7+W3KcttEsEP47KTn6rn2HQdP8vDmawtmo=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 13/25] asix: Check for supported Wake-on-LAN modes
Date:   Tue, 16 Oct 2018 00:15:54 -0400
Message-Id: <20181016041606.135876-13-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041606.135876-1-sashal@kernel.org>
References: <20181016041606.135876-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

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
index 7fbd8f044207..2092ef6431f2 100644
--- a/drivers/net/usb/asix_common.c
+++ b/drivers/net/usb/asix_common.c
@@ -449,6 +449,9 @@ int asix_set_wol(struct net_device *net, struct ethtool_wolinfo *wolinfo)
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

