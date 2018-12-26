Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6917BC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 23:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3454620811
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 23:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545866552;
	bh=CW7vhhe6PHr+QIU9qWh8jo1dqKbrgB7q8QH/7JK4m0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zvDQzGaFNr/bbtRzRttWOy0h7jEuHmA+Q98JwkzvLXsC+vVaMQBJb8IXn8Os/qxNQ
	 gcXjFggsptGnDdY1JdHQOQeT06cZ4/xR74FdYmSNFgAN/TnI21IFi6CmF5HZauoJdA
	 R/l5rFqkksQYaoUgTNWa1y3GNfO+XimoHCcFzhhY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbeLZXWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 18:22:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:44068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728306AbeLZXWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 18:22:22 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E339218A5;
        Wed, 26 Dec 2018 23:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545866542;
        bh=CW7vhhe6PHr+QIU9qWh8jo1dqKbrgB7q8QH/7JK4m0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hgs6VLad8Z7bSsxSfJUwnV3iguM2yQhmls0AiXA5Ur5WJd0KbMhXX7fLzTFCNQFkO
         wwhEgk8ZBrh6QjjyZJWxGAZXUOQevv4fVxYqPNt7XuKj/VSTa+oNUWIuoDXfqZOfOx
         yW/5nrc9CzOJJWb1XNYNCeJe8yvZMmTh0H7oltSs=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 3.18 11/12] net: netxen: fix a missing check and an uninitialized use
Date:   Wed, 26 Dec 2018 17:57:39 -0500
Message-Id: <20181226225741.151608-11-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226225741.151608-1-sashal@kernel.org>
References: <20181226225741.151608-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kangjie Lu <kjlu@umn.edu>

[ Upstream commit d134e486e831defd26130770181f01dfc6195f7d ]

When netxen_rom_fast_read() fails, "bios" is left uninitialized and may
contain random value, thus should not be used.

The fix ensures that if netxen_rom_fast_read() fails, we return "-EIO".

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c b/drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c
index 5c4068353f66..746612a88515 100644
--- a/drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c
+++ b/drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c
@@ -1125,7 +1125,8 @@ netxen_validate_firmware(struct netxen_adapter *adapter)
 		return -EINVAL;
 	}
 	val = nx_get_bios_version(adapter);
-	netxen_rom_fast_read(adapter, NX_BIOS_VERSION_OFFSET, (int *)&bios);
+	if (netxen_rom_fast_read(adapter, NX_BIOS_VERSION_OFFSET, (int *)&bios))
+		return -EIO;
 	if ((__force u32)val != bios) {
 		dev_err(&pdev->dev, "%s: firmware bios is incompatible\n",
 				fw_name[fw_type]);
-- 
2.19.1

