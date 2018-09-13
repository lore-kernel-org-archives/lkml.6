Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCD6C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEA6120854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:52:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEA6120854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730949AbeIMTBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:01:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33456 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730119AbeIMTBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:01:52 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7E253CDB;
        Thu, 13 Sep 2018 13:52:16 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anssi Hannula <anssi.hannula@bitwise.fi>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 004/197] net: macb: do not disable MDIO bus at open/close time
Date:   Thu, 13 Sep 2018 15:29:13 +0200
Message-Id: <20180913131841.741954631@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
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

From: Anssi Hannula <anssi.hannula@bitwise.fi>

[ Upstream commit 0da70f808029476001109b6cb076737bc04cea2e ]

macb_reset_hw() is called from macb_close() and indirectly from
macb_open(). macb_reset_hw() zeroes the NCR register, including the MPE
(Management Port Enable) bit.

This will prevent accessing any other PHYs for other Ethernet MACs on
the MDIO bus, which remains registered at macb_reset_hw() time, until
macb_init_hw() is called from macb_open() which sets the MPE bit again.

I.e. currently the MDIO bus has a short disruption at open time and is
disabled at close time until the interface is opened again.

Fix that by only touching the RE and TE bits when enabling and disabling
RX/TX.

v2: Make macb_init_hw() NCR write a single statement.

Fixes: 6c36a7074436 ("macb: Use generic PHY layer")
Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Tested-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/cadence/macb_main.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1957,14 +1957,17 @@ static void macb_reset_hw(struct macb *b
 {
 	struct macb_queue *queue;
 	unsigned int q;
+	u32 ctrl = macb_readl(bp, NCR);
 
 	/* Disable RX and TX (XXX: Should we halt the transmission
 	 * more gracefully?)
 	 */
-	macb_writel(bp, NCR, 0);
+	ctrl &= ~(MACB_BIT(RE) | MACB_BIT(TE));
 
 	/* Clear the stats registers (XXX: Update stats first?) */
-	macb_writel(bp, NCR, MACB_BIT(CLRSTAT));
+	ctrl |= MACB_BIT(CLRSTAT);
+
+	macb_writel(bp, NCR, ctrl);
 
 	/* Clear all status flags */
 	macb_writel(bp, TSR, -1);
@@ -2152,7 +2155,7 @@ static void macb_init_hw(struct macb *bp
 	}
 
 	/* Enable TX and RX */
-	macb_writel(bp, NCR, MACB_BIT(RE) | MACB_BIT(TE) | MACB_BIT(MPE));
+	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(RE) | MACB_BIT(TE));
 }
 
 /* The hash address register is 64 bits long and takes up two


