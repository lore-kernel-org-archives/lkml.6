Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C1CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA4152054F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864122;
	bh=jkmQI3b/nDhhWCKLiWe9MhmNuQHHy10Qp1TmoliNIfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fK/28J/KP3Lv6uBBkWutPdKNnKQRgbsy0UpSEOXkeDoYnYi5zbaJMeKJm8AEkcd13
	 em/0mVhnyETX//GvrNb5TmK1tj5QMJnDapijwPJqhkmZ485FLIHCfEVYXvCHKZpJUk
	 xbbajoT2P4UHsoKBdB+N/80Kd3iz3qrp4irsM3qs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729587AbeLZWmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:42:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:42162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729516AbeLZWlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:41:39 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E5DB20651;
        Wed, 26 Dec 2018 22:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545864098;
        bh=jkmQI3b/nDhhWCKLiWe9MhmNuQHHy10Qp1TmoliNIfI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kup0y7E/pJ9DZZagIBVQ9QPteEDQUoSL4VHXh+gmzLcPdQ2SJtZBZYDp+9Y3mBTJj
         4BxwNKOrTGkLgGaW243uXBC0TB5W01xkM6XB016uX75j6OusZIqse1uyi96COn7sZb
         gTBU5foXV7rZvRCCHN8gLaVr5Wt/e6lQaGWtbK9U=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 57/59] net: netxen: fix a missing check and an uninitialized use
Date:   Wed, 26 Dec 2018 17:38:37 -0500
Message-Id: <20181226223839.150262-57-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223839.150262-1-sashal@kernel.org>
References: <20181226223839.150262-1-sashal@kernel.org>
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
index 3dd973475125..4b444351ab7d 100644
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

