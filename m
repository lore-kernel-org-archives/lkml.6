Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43C7C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70FCC20818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6VkEmUE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70FCC20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390807AbeKLIvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:51:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:53192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390666AbeKLIWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:22:32 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 575B92154B;
        Sun, 11 Nov 2018 22:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975555;
        bh=lA9o59XAIbiRPSSTwTeCFIoKQb0yJfPpQr2uKMRt/DY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u6VkEmUE0LQ3pAntoUmJ7Nhjy9i79YXqwGt1dbA+YSQ2o1X1/98PnDKdknQsRWyJI
         IieBKtfIP2tT2c4TaRi5s1JVFQrAb74akAeloQXvjcxp+D8d7EVnJ3+OQSVpiRpXOL
         VodG1KMoV1MCB/QiGV4FPgRPvO7Yk1SO1ZNR+1OU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 071/222] net: dsa: mv88e6xxx: Fix writing to a PHY page.
Date:   Sun, 11 Nov 2018 14:22:48 -0800
Message-Id: <20181111221654.491589444@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrew Lunn <andrew@lunn.ch>

[ Upstream commit c309b158090d788e96ee597444965cb79b040484 ]

After changing to the needed page, actually write the value to the
register!

Fixes: 09cb7dfd3f14 ("net: dsa: mv88e6xxx: describe PHY page and SerDes")
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/dsa/mv88e6xxx/phy.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/dsa/mv88e6xxx/phy.c
+++ b/drivers/net/dsa/mv88e6xxx/phy.c
@@ -110,6 +110,9 @@ int mv88e6xxx_phy_page_write(struct mv88
 	err = mv88e6xxx_phy_page_get(chip, phy, page);
 	if (!err) {
 		err = mv88e6xxx_phy_write(chip, phy, MV88E6XXX_PHY_PAGE, page);
+		if (!err)
+			err = mv88e6xxx_phy_write(chip, phy, reg, val);
+
 		mv88e6xxx_phy_page_put(chip, phy);
 	}
 


