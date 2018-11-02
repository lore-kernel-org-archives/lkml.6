Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4FDC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56BFB2084C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTvmVURv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56BFB2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731014AbeKCEBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:01:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:56850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbeKCEA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:00:59 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E61F320848;
        Fri,  2 Nov 2018 18:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184764;
        bh=LD9Bpg2cbjSOVWVzE2chFwoE6Nlc3gnJ0+4HIf6bXR0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QTvmVURvK7kgALG6E8f6yn/3H7HPB9Cu1bbr7nJOYSCvusq6Msl2ijLVELua1xS5S
         Mgulb0FcqoO5t/DoSSG8dXdCQyHl0DGRUci5mUm0GN5ZDtI/5T9yeTwjwEos6zqFFP
         C5xmjTNzDGkW1xy3NQ2q4wdZdomEYxwA1U7oDlO0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 090/143] net: phy: phylink: Dont release NULL GPIO
Date:   Fri,  2 Nov 2018 19:34:35 +0100
Message-Id: <20181102182905.054635947@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
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

[ Upstream commit 3bcd47726c3b744fd08781795cca905cc59a1382 ]

If CONFIG_GPIOLIB is disabled, gpiod_put() becomes a stub that produces a
warning, this helped identify that we could be attempting to release a NULL
pl->link_gpio GPIO descriptor, so guard against that.

Fixes: daab3349ad1a ("net: phy: phylink: Release link GPIO")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/phylink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index e4a6ed88b9cf..79f28b9186c6 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -561,7 +561,7 @@ void phylink_destroy(struct phylink *pl)
 {
 	if (pl->sfp_bus)
 		sfp_unregister_upstream(pl->sfp_bus);
-	if (!IS_ERR(pl->link_gpio))
+	if (!IS_ERR_OR_NULL(pl->link_gpio))
 		gpiod_put(pl->link_gpio);
 
 	cancel_work_sync(&pl->resolve);
-- 
2.17.1



