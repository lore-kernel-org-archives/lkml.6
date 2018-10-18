Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDDEC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 667CF2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="piM6i7ET"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 667CF2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbeJSB7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 21:59:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:46898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728786AbeJSB7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 21:59:09 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D0372145D;
        Thu, 18 Oct 2018 17:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885424;
        bh=1OoKbIWXXBxslYRhMoGOg5OMAa/ApiP8ZMYSzbRli3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=piM6i7ETLVjgmnQnKRc9pZXQxr5u3meIIY5yUvXAtL7cdwI+63k0yMZ1CGU1IzxMR
         kGrdjyjbr4SZa15KmM8r6WaQV6l4MN3syJViTxlBjCRdddawpQcTsphlRDyyVfjVAh
         /spU/iveYj0ko5FIyUwgCSWHb88PsdxpstgjScQc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christian Lamparter <chunkeey@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 24/53] net: emac: fix fixed-link setup for the RTL8363SB switch
Date:   Thu, 18 Oct 2018 19:54:17 +0200
Message-Id: <20181018175421.168877636@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175416.561567978@linuxfoundation.org>
References: <20181018175416.561567978@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Lamparter <chunkeey@gmail.com>

[ Upstream commit 08e39982ef64f800fd1f9b9b92968d14d5fafa82 ]

On the Netgear WNDAP620, the emac ethernet isn't receiving nor
xmitting any frames from/to the RTL8363SB (identifies itself
as a RTL8367RB).

This is caused by the emac hardware not knowing the forced link
parameters for speed, duplex, pause, etc.

This begs the question, how this was working on the original
driver code, when it was necessary to set the phy_address and
phy_map to 0xffffffff. But I guess without access to the old
PPC405/440/460 hardware, it's not possible to know.

Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/ibm/emac/core.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -2677,12 +2677,17 @@ static int emac_init_phy(struct emac_ins
 		if (of_phy_is_fixed_link(np)) {
 			int res = emac_dt_mdio_probe(dev);
 
-			if (!res) {
-				res = of_phy_register_fixed_link(np);
-				if (res)
-					mdiobus_unregister(dev->mii_bus);
+			if (res)
+				return res;
+
+			res = of_phy_register_fixed_link(np);
+			dev->phy_dev = of_phy_find_device(np);
+			if (res || !dev->phy_dev) {
+				mdiobus_unregister(dev->mii_bus);
+				return res ? res : -EINVAL;
 			}
-			return res;
+			emac_adjust_link(dev->ndev);
+			put_device(&dev->phy_dev->mdio.dev);
 		}
 		return 0;
 	}


