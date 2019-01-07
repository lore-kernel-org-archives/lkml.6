Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5309C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 995DC20651
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865318;
	bh=oDZnEOVhheEY33C37vyNWFRfnTOZXzzDB9UC0Gqd8NE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l2sEqzJTggfG1Q9n9ZA7OKmUICBICiAyWFERhaCqZ5oiIb2wC3s7DiUll2Ku3I1ob
	 +NHiGTW4vXrLTSCjO3uDeCoxpNIc/CVUxE2P6XpudZAfvu+nmWBeR7+1w5trOlPBqZ
	 /rgx7ojrD5RHznaeK37AHHoMZM1n3PHzJEJNS9zM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbfAGMsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:48:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:39238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728540AbfAGMsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:48:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95A71206BB;
        Mon,  7 Jan 2019 12:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865312;
        bh=oDZnEOVhheEY33C37vyNWFRfnTOZXzzDB9UC0Gqd8NE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bAYzgz/p8CMGyKTUAdmeMAsIJjUH80+iODrUk/ySdsRH++D8tzjF5UyHZ7kDgN/YD
         bs0Rm1JP7xkRrZW6fyi65qoXGyX8v1MwJv3T9/POgvNl6uWhMH4hGeqsBIV7V8vGEB
         O1ZXLvgA3BmEaFx74WiEVaI7jgrkWU9XOpOi8e1o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 051/170] net: mvpp2: fix the phylink mode validation
Date:   Mon,  7 Jan 2019 13:31:18 +0100
Message-Id: <20190107104459.146131396@linuxfoundation.org>
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

[ Upstream commit 1b451fb2051b464b9758c09a3492104403252e2b ]

The mvpp2_phylink_validate() sets all modes that are supported by a
given PPv2 port. An mistake made the 10000baseT_Full mode being
advertised in some cases when a port wasn't configured to perform at
10G. This patch fixes this.

Fixes: d97c9f4ab000 ("net: mvpp2: 1000baseX support")
Reported-by: Russell King <linux@armlinux.org.uk>
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -4293,6 +4293,7 @@ static void mvpp2_phylink_validate(struc
 	case PHY_INTERFACE_MODE_XAUI:
 	case PHY_INTERFACE_MODE_NA:
 		if (port->gop_id == 0) {
+			phylink_set(mask, 10000baseT_Full);
 			phylink_set(mask, 10000baseCR_Full);
 			phylink_set(mask, 10000baseSR_Full);
 			phylink_set(mask, 10000baseLR_Full);
@@ -4310,7 +4311,6 @@ static void mvpp2_phylink_validate(struc
 		phylink_set(mask, 10baseT_Full);
 		phylink_set(mask, 100baseT_Half);
 		phylink_set(mask, 100baseT_Full);
-		phylink_set(mask, 10000baseT_Full);
 		/* Fall-through */
 	case PHY_INTERFACE_MODE_1000BASEX:
 	case PHY_INTERFACE_MODE_2500BASEX:


