Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C9FC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3F1F20882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548761844;
	bh=63KqhiGeSjJ3z3CNYl6p5csCMQKgAc9gcwxHowk3xTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p4OpY6fjeLa1ew/qUeLDn/u6VrOAb9vlg3IYeG90DYCT4hTaCbsRsO2hO2cd/dkJ7
	 /Lh0d4txilStCCPWFHFMe80HAwV0OLn14+pDyl9rfXTTyxGi0U1xW56q00XgdPAkug
	 ZVzsaq6woIQMAKBcfco8JRIe94/IvZKpvGg4uErc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbfA2LhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:37:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:53980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728782AbfA2LhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:37:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EB8220882;
        Tue, 29 Jan 2019 11:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548761839;
        bh=63KqhiGeSjJ3z3CNYl6p5csCMQKgAc9gcwxHowk3xTQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T/eAMDby4L7aFxTYwYYqahR8Kd7RzWCM52oqxt5MDlbxywIniYu6e9SDf6vXDWIXi
         wUp0Kt0RGBfbXiZImdFwr1GgBjiRzouZR6CWDdGLeYqxvI3+qR6R5FZmcLsbHIp/NB
         sincguiotXCtjhTtqbiZgG6PIeceLd8j/T1QyMFs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?=C3=85ke=20Rehnman?= <ake.rehnman@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 019/117] net: phy: marvell: Fix deadlock from wrong locking
Date:   Tue, 29 Jan 2019 12:34:30 +0100
Message-Id: <20190129113208.612201163@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113207.477505932@linuxfoundation.org>
References: <20190129113207.477505932@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrew Lunn <andrew@lunn.ch>

[ Upstream commit e0a7328fad9979104f73e19bedca821ef3262ae1 ]

m88e1318_set_wol() takes the lock as part of phy_select_page(). Don't
take the lock again with phy_read(), use the unlocked __phy_read().

Fixes: 424ca4c55121 ("net: phy: marvell: fix paged access races")
Reported-by: Åke Rehnman <ake.rehnman@gmail.com>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/marvell.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -1430,7 +1430,7 @@ static int m88e1318_set_wol(struct phy_d
 		 * before enabling it if !phy_interrupt_is_valid()
 		 */
 		if (!phy_interrupt_is_valid(phydev))
-			phy_read(phydev, MII_M1011_IEVENT);
+			__phy_read(phydev, MII_M1011_IEVENT);
 
 		/* Enable the WOL interrupt */
 		err = __phy_modify(phydev, MII_88E1318S_PHY_CSIER, 0,


