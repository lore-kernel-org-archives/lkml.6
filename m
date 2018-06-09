Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Qqy0HxvzG1vjYgAAmS7hNA
	; Sat, 09 Jun 2018 15:33:10 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D220E608C1; Sat,  9 Jun 2018 15:33:09 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vAjVea+O"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3A90D608B8;
	Sat,  9 Jun 2018 15:33:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3A90D608B8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932605AbeFIPdG (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 11:33:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:35444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932584AbeFIPdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 11:33:02 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65290208A3;
        Sat,  9 Jun 2018 15:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528558382;
        bh=hyFoTLxLhHbvAvlW0DQ9ckczMgg/u6smRZo77UqLR88=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vAjVea+OlCLiYeSx+jeqgDOmPxReVjpPtj0QwLH25h1MkodATyeVa2jPm5bSgtq5m
         +DC8u0tWdo69zxGCy1tr4e1761/w3ckytuzTknMP6IwNFWM0GsCkYbAWaZd3Qnk+kG
         C5r1FnEEjNg30CUvW2sUe3AQ/l+6ydCKi997rpcI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 34/48] net: phy: broadcom: Fix auxiliary control register reads
Date: Sat,  9 Jun 2018 17:29:46 +0200
Message-Id: <20180609145950.135240545@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180609145947.679103414@linuxfoundation.org>
References: <20180609145947.679103414@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit 733a969a7ed14fc5786bcc59c1bdda83c7ddb46e ]

We are currently doing auxiliary control register reads with the shadow
register value 0b111 (0x7) which incidentally is also the selector value
that should be present in bits [2:0]. Fix this by using the appropriate
selector mask which is defined (MII_BCM54XX_AUXCTL_SHDWSEL_MASK).

This does not have a functional impact yet because we always access the
MII_BCM54XX_AUXCTL_SHDWSEL_MISC (0x7) register in the current code.
This might change at some point though.

Fixes: 5b4e29005123 ("net: phy: broadcom: add bcm54xx_auxctl_read")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/bcm-phy-lib.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/phy/bcm-phy-lib.c
+++ b/drivers/net/phy/bcm-phy-lib.c
@@ -56,7 +56,7 @@ int bcm54xx_auxctl_read(struct phy_devic
 	/* The register must be written to both the Shadow Register Select and
 	 * the Shadow Read Register Selector
 	 */
-	phy_write(phydev, MII_BCM54XX_AUX_CTL, regnum |
+	phy_write(phydev, MII_BCM54XX_AUX_CTL, MII_BCM54XX_AUXCTL_SHDWSEL_MASK |
 		  regnum << MII_BCM54XX_AUXCTL_SHDWSEL_READ_SHIFT);
 	return phy_read(phydev, MII_BCM54XX_AUX_CTL);
 }
