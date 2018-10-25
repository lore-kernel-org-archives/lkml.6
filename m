Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3B7C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85ADA20834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wOkr9Txl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85ADA20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbeJYWoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:44:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:52764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727739AbeJYWoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:44:10 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0079120834;
        Thu, 25 Oct 2018 14:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476674;
        bh=gi1w3Mvq/PbrZVZSG2F+yIsbqCZ2ka80YPId1QSYqgw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wOkr9Txl7d/YMGFXODRtCH6Aq0449vtw1BXKbSZvUQI7UjU7HBPF5DuPFX+79kxxq
         bUri981UZV2BOvFQnJSlcp7JSpL9qiz9DFL0HRs7xpKIu9MRnnLfn3Ro2aSHZhXL6Z
         eHOXrd4hM7Lj/b5vc5ex5T758saWs6JU7Jfn2JoA=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Kevin Hao <haokexin@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 14/46] net: phy: realtek: Use the dummy stubs for MMD register access for rtl8211b
Date:   Thu, 25 Oct 2018 10:10:21 -0400
Message-Id: <20181025141053.213330-14-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141053.213330-1-sashal@kernel.org>
References: <20181025141053.213330-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Hao <haokexin@gmail.com>

[ Upstream commit 0231b1a074c672f8c00da00a57144072890d816b ]

The Ethernet on mpc8315erdb is broken since commit b6b5e8a69118
("gianfar: Disable EEE autoneg by default"). The reason is that
even though the rtl8211b doesn't support the MMD extended registers
access, it does return some random values if we trying to access
the MMD register via indirect method. This makes it seem that the
EEE is supported by this phy device. And the subsequent writing to
the MMD registers does cause the phy malfunction. So use the dummy
stubs for the MMD register access to fix this issue.

Fixes: b6b5e8a69118 ("gianfar: Disable EEE autoneg by default")
Signed-off-by: Kevin Hao <haokexin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/realtek.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 9cbe645e3d89..7d38af5ed4b5 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -138,6 +138,8 @@ static struct phy_driver realtek_drvs[] = {
 		.read_status	= &genphy_read_status,
 		.ack_interrupt	= &rtl821x_ack_interrupt,
 		.config_intr	= &rtl8211b_config_intr,
+		.read_mmd	= &genphy_read_mmd_unsupported,
+		.write_mmd	= &genphy_write_mmd_unsupported,
 	}, {
 		.phy_id		= 0x001cc914,
 		.name		= "RTL8211DN Gigabit Ethernet",
-- 
2.17.1

