Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FACC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A22721479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GweR150Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A22721479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbeJHWiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:38:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:56574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727579AbeJHWiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:38:13 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D6B4214FF;
        Mon,  8 Oct 2018 15:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539012358;
        bh=rltvIn4o2zcs/1arH//lVR2leOxioqCz5oojeZJD01A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GweR150QZAEp5FNzci3/jhFPFtki/BOT4Mv8UKQepDh9jZNfTafikwdVbChoff3Cw
         X4eEbwBQYPats20jy7LxLbp51Z5Ib88VoSNXeKFTijUio8CKK5WR3TpEITx+Ql+Ndn
         jR61rIyaoXxZ8e3hLM04W/VHWJ9nHZlmGc1GiSOE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 33/58] sfp: fix oops with ethtool -m
Date:   Mon,  8 Oct 2018 11:24:58 -0400
Message-Id: <20181008152523.70705-33-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008152523.70705-1-sashal@kernel.org>
References: <20181008152523.70705-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

[ Upstream commit 126d6848ef13958e1cb959e96c21d19bc498ade9 ]

If a network interface is created prior to the SFP socket being
available, ethtool can request module information.  This unfortunately
leads to an oops:

Unable to handle kernel NULL pointer dereference at virtual address 00000008
pgd = (ptrval)
[00000008] *pgd=7c400831, *pte=00000000, *ppte=00000000
Internal error: Oops: 17 [#1] SMP ARM
Modules linked in:
CPU: 0 PID: 1480 Comm: ethtool Not tainted 4.19.0-rc3 #138
Hardware name: Broadcom Northstar Plus SoC
PC is at sfp_get_module_info+0x8/0x10
LR is at dev_ethtool+0x218c/0x2afc

Fix this by not filling in the network device's SFP bus pointer until
SFP is fully bound, thereby avoiding the core calling into the SFP bus
code.

Fixes: ce0aa27ff3f6 ("sfp: add sfp-bus to bridge between network devices and sfp cages")
Reported-by: Florian Fainelli <f.fainelli@gmail.com>
Tested-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/phy/sfp-bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/sfp-bus.c b/drivers/net/phy/sfp-bus.c
index 740655261e5b..83060fb349f4 100644
--- a/drivers/net/phy/sfp-bus.c
+++ b/drivers/net/phy/sfp-bus.c
@@ -349,6 +349,7 @@ static int sfp_register_bus(struct sfp_bus *bus)
 	}
 	if (bus->started)
 		bus->socket_ops->start(bus->sfp);
+	bus->netdev->sfp_bus = bus;
 	bus->registered = true;
 	return 0;
 }
@@ -357,6 +358,7 @@ static void sfp_unregister_bus(struct sfp_bus *bus)
 {
 	const struct sfp_upstream_ops *ops = bus->upstream_ops;
 
+	bus->netdev->sfp_bus = NULL;
 	if (bus->registered) {
 		if (bus->started)
 			bus->socket_ops->stop(bus->sfp);
@@ -438,7 +440,6 @@ static void sfp_upstream_clear(struct sfp_bus *bus)
 {
 	bus->upstream_ops = NULL;
 	bus->upstream = NULL;
-	bus->netdev->sfp_bus = NULL;
 	bus->netdev = NULL;
 }
 
@@ -467,7 +468,6 @@ struct sfp_bus *sfp_register_upstream(struct fwnode_handle *fwnode,
 		bus->upstream_ops = ops;
 		bus->upstream = upstream;
 		bus->netdev = ndev;
-		ndev->sfp_bus = bus;
 
 		if (bus->sfp) {
 			ret = sfp_register_bus(bus);
-- 
2.17.1

