Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76A7C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C1C21741
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864907;
	bh=zwSoUtDKO+6kCG6FQ3aAIfRQdXcoOMx284ILeoDPiKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PTzJLcA40cmf8VA/DvTmw1JVNruFN4lZzGQ34lK+eP7BOQzNSe4aZUr2BHSVesqWA
	 zpWlhvnOqyVY59kROn2GCje2lyH9VP0IFd+w303BbN3qmSwXouPMjFFcTtP1lw2h6V
	 TMUWV7gRJBAmsbdTdvaF+QnFw20ug/TdKWwS6kWg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730327AbeLZWzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:55:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:56362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730299AbeLZWy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:54:58 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 684CD218E2;
        Wed, 26 Dec 2018 22:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545864898;
        bh=zwSoUtDKO+6kCG6FQ3aAIfRQdXcoOMx284ILeoDPiKw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w67CQWpTW4sj+X64pWynePifggSRz+Gmzoulu9z5KQA6pW4U5CvQTxJqsaNtLYXys
         SdAMmPw96QbFx8SluQmEs3AcAS2WrQua6bf2Oxvdzwv0FV8cbtxmAXDocwyRdVohVy
         YYhIi4o74bYz7R5CUnqruOTKA8Jm0Fg70eYx27q4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 34/35] net: netxen: fix a missing check and an uninitialized use
Date:   Wed, 26 Dec 2018 17:41:41 -0500
Message-Id: <20181226224142.150866-34-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226224142.150866-1-sashal@kernel.org>
References: <20181226224142.150866-1-sashal@kernel.org>
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
index 7b43a3b4abdc..5cf551914767 100644
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

