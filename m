Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A286AC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C8BE21774
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:23:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C8BE21774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbeHUJmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 05:42:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54818 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbeHUJl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 05:41:59 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7A2258A5;
        Tue, 21 Aug 2018 06:23:13 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jian-Hong Pan <jian-hong@endlessm.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 31/35] r8169: dont use MSI-X on RTL8106e
Date:   Tue, 21 Aug 2018 08:20:57 +0200
Message-Id: <20180821055021.308541129@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821055019.954904905@linuxfoundation.org>
References: <20180821055019.954904905@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jian-Hong Pan <jian-hong@endlessm.com>

[ Upstream commit 7bb05b85bc2d1a1b647b91424b2ed4a18e6ecd81 ]

Found the ethernet network on ASUS X441UAR doesn't come back on resume
from suspend when using MSI-X.  The chip is RTL8106e - version 39.

[   21.848357] libphy: r8169: probed
[   21.848473] r8169 0000:02:00.0 eth0: RTL8106e, 0c:9d:92:32:67:b4, XID
44900000, IRQ 127
[   22.518860] r8169 0000:02:00.0 enp2s0: renamed from eth0
[   29.458041] Generic PHY r8169-200:00: attached PHY driver [Generic
PHY] (mii_bus:phy_addr=r8169-200:00, irq=IGNORE)
[   63.227398] r8169 0000:02:00.0 enp2s0: Link is Up - 100Mbps/Full -
flow control off
[  124.514648] Generic PHY r8169-200:00: attached PHY driver [Generic
PHY] (mii_bus:phy_addr=r8169-200:00, irq=IGNORE)

Here is the ethernet controller in detail:

02:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd.
RTL8101/2/6E PCI Express Fast/Gigabit Ethernet controller [10ec:8136]
(rev 07)
	Subsystem: ASUSTeK Computer Inc. RTL810xE PCI Express Fast
Ethernet controller [1043:200f]
	Flags: bus master, fast devsel, latency 0, IRQ 16
	I/O ports at e000 [size=256]
	Memory at ef100000 (64-bit, non-prefetchable) [size=4K]
	Memory at e0000000 (64-bit, prefetchable) [size=16K]
	Capabilities: <access denied>
	Kernel driver in use: r8169
	Kernel modules: r8169

Falling back to MSI fixes the issue.

Fixes: 6c6aa15fdea5 ("r8169: improve interrupt handling")
Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/realtek/r8169.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -7539,17 +7539,20 @@ static int rtl_alloc_irq(struct rtl8169_
 {
 	unsigned int flags;
 
-	if (tp->mac_version <= RTL_GIGA_MAC_VER_06) {
+	switch (tp->mac_version) {
+	case RTL_GIGA_MAC_VER_01 ... RTL_GIGA_MAC_VER_06:
 		RTL_W8(tp, Cfg9346, Cfg9346_Unlock);
 		RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~MSIEnable);
 		RTL_W8(tp, Cfg9346, Cfg9346_Lock);
 		flags = PCI_IRQ_LEGACY;
-	} else if (tp->mac_version == RTL_GIGA_MAC_VER_40) {
+		break;
+	case RTL_GIGA_MAC_VER_39 ... RTL_GIGA_MAC_VER_40:
 		/* This version was reported to have issues with resume
 		 * from suspend when using MSI-X
 		 */
 		flags = PCI_IRQ_LEGACY | PCI_IRQ_MSI;
-	} else {
+		break;
+	default:
 		flags = PCI_IRQ_ALL_TYPES;
 	}
 


