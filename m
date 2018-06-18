Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58CAC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A376208E2
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:18:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A376208E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935277AbeFRISn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:18:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54688 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935241AbeFRISj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:18:39 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D3345C75;
        Mon, 18 Jun 2018 08:18:38 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jingju Hou <Jingju.Hou@synaptics.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 081/279] net: phy: marvell: clear wol event before setting it
Date:   Mon, 18 Jun 2018 10:11:06 +0200
Message-Id: <20180618080612.159657869@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
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

From: Jingju Hou <Jingju.Hou@synaptics.com>

[ Upstream commit b6a930fa88083b41d26ddf1cab95cbd740936c22 ]

If WOL event happened once, the LED[2] interrupt pin will not be
cleared unless we read the CSISR register. If interrupts are in use,
the normal interrupt handling will clear the WOL event. Let's clear the
WOL event before enabling it if !phy_interrupt_is_valid().

Signed-off-by: Jingju Hou <Jingju.Hou@synaptics.com>
Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/marvell.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -1377,6 +1377,15 @@ static int m88e1318_set_wol(struct phy_d
 		if (err < 0)
 			goto error;
 
+		/* If WOL event happened once, the LED[2] interrupt pin
+		 * will not be cleared unless we reading the interrupt status
+		 * register. If interrupts are in use, the normal interrupt
+		 * handling will clear the WOL event. Clear the WOL event
+		 * before enabling it if !phy_interrupt_is_valid()
+		 */
+		if (!phy_interrupt_is_valid(phydev))
+			phy_read(phydev, MII_M1011_IEVENT);
+
 		/* Enable the WOL interrupt */
 		err = __phy_modify(phydev, MII_88E1318S_PHY_CSIER, 0,
 				   MII_88E1318S_PHY_CSIER_WOL_EIE);


