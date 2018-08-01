Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22069C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB18120862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB18120862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732232AbeHAT4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:56:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50152 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405739AbeHATIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:08:36 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6FABF10F3;
        Wed,  1 Aug 2018 17:06:28 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 209/336] net: phy: sfp: handle cases where neither BR, min nor BR, max is given
Date:   Wed,  1 Aug 2018 18:49:04 +0200
Message-Id: <20180801165037.078249851@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Antoine Tenart <antoine.tenart@bootlin.com>

[ Upstream commit 2b999ba899059eed00a03d029894a62486e7e2bc ]

When computing the bitrate using values read from an SFP module EEPROM,
we use the nominal BR plus BR,min and BR,max to determine the
boundaries. But in some cases BR,min and BR,max aren't provided, which
led the SFP code to end up having the nominal value for both the minimum
and maximum bitrate values. When using a passive cable, the nominal
value should be used as the maximum one, and there is no minimum one
so we should use 0.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/sfp-bus.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/net/phy/sfp-bus.c
+++ b/drivers/net/phy/sfp-bus.c
@@ -132,6 +132,13 @@ void sfp_parse_support(struct sfp_bus *b
 			br_max = br_nom + br_nom * id->ext.br_min / 100;
 			br_min = br_nom - br_nom * id->ext.br_min / 100;
 		}
+
+		/* When using passive cables, in case neither BR,min nor BR,max
+		 * are specified, set br_min to 0 as the nominal value is then
+		 * used as the maximum.
+		 */
+		if (br_min == br_max && id->base.sfp_ct_passive)
+			br_min = 0;
 	}
 
 	/* Set ethtool support from the compliance fields. */


