Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED19C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30BBC21779
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:24:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30BBC21779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbeHUJnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 05:43:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55000 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbeHUJnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 05:43:07 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B6BA5516;
        Tue, 21 Aug 2018 06:24:20 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve Dodd <steved424@gmail.com>,
        Lou Reed <gogen@disroot.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 15/42] r8169: dont use MSI-X on RTL8168g
Date:   Tue, 21 Aug 2018 08:20:47 +0200
Message-Id: <20180821055018.383277605@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821055017.596264829@linuxfoundation.org>
References: <20180821055017.596264829@linuxfoundation.org>
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

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit 7c53a722459c1d6ffb0f5b2058c06ca8980b8600 ]

There have been two reports that network doesn't come back on resume
from suspend when using MSI-X. Both cases affect the same chip version
(RTL8168g - version 40), on different systems. Falling back to MSI
fixes the issue.
Even though we don't really have a proof yet that the network chip
version is to blame, let's disable MSI-X for this version.

Reported-by: Steve Dodd <steved424@gmail.com>
Reported-by: Lou Reed <gogen@disroot.org>
Tested-by: Steve Dodd <steved424@gmail.com>
Tested-by: Lou Reed <gogen@disroot.org>
Fixes: 6c6aa15fdea5 ("r8169: improve interrupt handling")
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/realtek/r8169.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -8066,6 +8066,11 @@ static int rtl_alloc_irq(struct rtl8169_
 		RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~MSIEnable);
 		RTL_W8(tp, Cfg9346, Cfg9346_Lock);
 		flags = PCI_IRQ_LEGACY;
+	} else if (tp->mac_version == RTL_GIGA_MAC_VER_40) {
+		/* This version was reported to have issues with resume
+		 * from suspend when using MSI-X
+		 */
+		flags = PCI_IRQ_LEGACY | PCI_IRQ_MSI;
 	} else {
 		flags = PCI_IRQ_ALL_TYPES;
 	}


