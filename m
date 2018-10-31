Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A51C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71E0720847
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dX1bATN7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71E0720847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731117AbeKAIKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:10:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:33140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731001AbeKAIKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:10:32 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A91A2081B;
        Wed, 31 Oct 2018 23:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027420;
        bh=aI7q6VQukiSf6ZccOqjFF6D9PoIpUC453PfGRqcup0Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dX1bATN77wsY4jzLChpBwsEA8BOXSy2kUn9M3G5+lpjo/xPv9mKuw9z6nzPLw5fGa
         NqJDqsovgKGRsz6hUuxVXFE9oyCZfPuEn3UQ62gx/tcfljCk0ncomwUZnZSFqq4u+J
         7EfFJlBh1A3TYg7zJyfImQRb3tCWBj+eRfNG6pfE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 35/73] net: dsa: mv88e6xxx: Fix writing to a PHY page.
Date:   Wed, 31 Oct 2018 19:09:10 -0400
Message-Id: <20181031230948.29203-35-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230948.29203-1-sashal@kernel.org>
References: <20181031230948.29203-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Lunn <andrew@lunn.ch>

[ Upstream commit c309b158090d788e96ee597444965cb79b040484 ]

After changing to the needed page, actually write the value to the
register!

Fixes: 09cb7dfd3f14 ("net: dsa: mv88e6xxx: describe PHY page and SerDes")
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/phy.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/phy.c b/drivers/net/dsa/mv88e6xxx/phy.c
index 436668bd50dc..e53ce9610fee 100644
--- a/drivers/net/dsa/mv88e6xxx/phy.c
+++ b/drivers/net/dsa/mv88e6xxx/phy.c
@@ -110,6 +110,9 @@ int mv88e6xxx_phy_page_write(struct mv88e6xxx_chip *chip, int phy,
 	err = mv88e6xxx_phy_page_get(chip, phy, page);
 	if (!err) {
 		err = mv88e6xxx_phy_write(chip, phy, MV88E6XXX_PHY_PAGE, page);
+		if (!err)
+			err = mv88e6xxx_phy_write(chip, phy, reg, val);
+
 		mv88e6xxx_phy_page_put(chip, phy);
 	}
 
-- 
2.17.1

