Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7909C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B1B20882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762185;
	bh=8wFraE8MNYODkcPjQHilWcWrO1hHFoaAzzNSzO8zbOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qwlqOkwIYnbVF0z9ccTTTa+jyq7UGgbCo6O/QWjjLPvqFnL+Wti36zlSce08JDUIQ
	 bG7Y7ZQIIELROMcwMazrpwAD72TtIma/s0mfK2b50k23+uUKBjZz7hbgtRGj096xOu
	 FZNm3U0POwrLW5JFb7nlpnqJX7Ay6noerQgo9+Fc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730219AbfA2LnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:43:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:32778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730193AbfA2LnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:43:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE74320857;
        Tue, 29 Jan 2019 11:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762180;
        bh=8wFraE8MNYODkcPjQHilWcWrO1hHFoaAzzNSzO8zbOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZXJJZFLau4LhCzwgBKoBZ1wudoWZQezAadlvBCJ9ufsgbIYHk8uM9Ew8GxQtxS66b
         32uSK0GQh+4FdRLC611wOSayNPmCXkymq56eEuRQ5t0wjfwv2zEft2KAgeyhw2fRlY
         DikdfdTIBPN/akJd0RIVzbcxSyxPTOrIKKtM8lvo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?=C3=85ke=20Rehnman?= <ake.rehnman@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 019/103] net: phy: marvell: Fix deadlock from wrong locking
Date:   Tue, 29 Jan 2019 12:34:56 +0100
Message-Id: <20190129113200.683226399@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113159.567154026@linuxfoundation.org>
References: <20190129113159.567154026@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1451,7 +1451,7 @@ static int m88e1318_set_wol(struct phy_d
 		 * before enabling it if !phy_interrupt_is_valid()
 		 */
 		if (!phy_interrupt_is_valid(phydev))
-			phy_read(phydev, MII_M1011_IEVENT);
+			__phy_read(phydev, MII_M1011_IEVENT);
 
 		/* Enable the WOL interrupt */
 		err = __phy_modify(phydev, MII_88E1318S_PHY_CSIER, 0,


