Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CDEC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFC1820449
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865143;
	bh=/JwgHL11vRQ0EdsWh6oGVWOuoMBJUqhIHJaDmRJRD4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IP7O4JKBnBjUziVivVVzdazMbI+inFWeJCSdBah2lfQSH+WwWuEEbo2GF1Dari1K+
	 2H9omWjDYRMC2LQKNvr+gshKU4UdcG3NPa9qiSG5jG+KOnVF4z6uumdd9kNgnFqszO
	 aV6S9eggV/p1dhQ0V9lsThWE32JUb+sxW5IbqVFc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbfAGMpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:45:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:35112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728908AbfAGMpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:45:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7151220449;
        Mon,  7 Jan 2019 12:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865138;
        bh=/JwgHL11vRQ0EdsWh6oGVWOuoMBJUqhIHJaDmRJRD4Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WGgkn0j0PvRdVywE23wN4YLPa0NfM2FD5SVTxByzxNHIQDVI+gI/WnDYOxeridRwF
         tnoKMpTHu9rIzPUPxSAjvMzvQRp0JEgcf2daHaI05yn+V9W6kKyy+kHx6AnGCsxr3/
         kuvLmVzUEGJFgW+gQpuvBqhurItbZYoD96MiDrs8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 016/170] net: mvpp2: 10G modes arent supported on all ports
Date:   Mon,  7 Jan 2019 13:30:43 +0100
Message-Id: <20190107104454.946153140@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
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

From: Antoine Tenart <antoine.tenart@bootlin.com>

[ Upstream commit 006791772084383de779ef29f2e06f3a6e111e7d ]

The mvpp2_phylink_validate() function sets all modes that are
supported by a given PPv2 port. A recent change made all ports to
advertise they support 10G modes in certain cases. This is not true,
as only the port #0 can do so. This patch fixes it.

Fixes: 01b3fd5ac97c ("net: mvpp2: fix detection of 10G SFP modules")
Cc: Baruch Siach <baruch@tkos.co.il>
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -4292,12 +4292,14 @@ static void mvpp2_phylink_validate(struc
 	case PHY_INTERFACE_MODE_10GKR:
 	case PHY_INTERFACE_MODE_XAUI:
 	case PHY_INTERFACE_MODE_NA:
-		phylink_set(mask, 10000baseCR_Full);
-		phylink_set(mask, 10000baseSR_Full);
-		phylink_set(mask, 10000baseLR_Full);
-		phylink_set(mask, 10000baseLRM_Full);
-		phylink_set(mask, 10000baseER_Full);
-		phylink_set(mask, 10000baseKR_Full);
+		if (port->gop_id == 0) {
+			phylink_set(mask, 10000baseCR_Full);
+			phylink_set(mask, 10000baseSR_Full);
+			phylink_set(mask, 10000baseLR_Full);
+			phylink_set(mask, 10000baseLRM_Full);
+			phylink_set(mask, 10000baseER_Full);
+			phylink_set(mask, 10000baseKR_Full);
+		}
 		/* Fall-through */
 	case PHY_INTERFACE_MODE_RGMII:
 	case PHY_INTERFACE_MODE_RGMII_ID:


