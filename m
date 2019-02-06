Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86162C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56EEE20844
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730908AbfBFNTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 08:19:14 -0500
Received: from mga11.intel.com ([192.55.52.93]:7185 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729596AbfBFNRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 08:17:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2019 05:17:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,340,1544515200"; 
   d="scan'208";a="297674117"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 06 Feb 2019 05:17:46 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 56D1589F; Wed,  6 Feb 2019 15:17:39 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        "David S . Miller" <davem@davemloft.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        netdev@vger.kernel.org
Subject: [PATCH v2 20/28] thunderbolt: Rework NFC credits handling
Date:   Wed,  6 Feb 2019 16:17:30 +0300
Message-Id: <20190206131738.43696-21-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206131738.43696-1-mika.westerberg@linux.intel.com>
References: <20190206131738.43696-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NFC (non flow control) credits is actually 20-bit field so update
tb_port_add_nfc_credits() to handle this properly. This allows us to set
NFC credits for Display Port path in subsequent patches.

Also make sure the function does not update the hardware if the
underlying switch is already unplugged.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/switch.c  | 20 +++++++++++++-------
 drivers/thunderbolt/tb_regs.h |  3 +++
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 29bf9119e0ae..7cc1f534e776 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -544,14 +544,20 @@ int tb_wait_for_port(struct tb_port *port, bool wait_if_unplugged)
  */
 int tb_port_add_nfc_credits(struct tb_port *port, int credits)
 {
-	if (credits == 0)
+	u32 nfc_credits;
+
+	if (credits == 0 || port->sw->is_unplugged)
 		return 0;
-	tb_port_info(port,
-		     "adding %#x NFC credits (%#x -> %#x)",
-		     credits,
-		     port->config.nfc_credits,
-		     port->config.nfc_credits + credits);
-	port->config.nfc_credits += credits;
+
+	nfc_credits = port->config.nfc_credits & TB_PORT_NFC_CREDITS_MASK;
+	nfc_credits += credits;
+
+	tb_port_dbg(port, "adding %d NFC credits to %lu",
+		    credits, port->config.nfc_credits & TB_PORT_NFC_CREDITS_MASK);
+
+	port->config.nfc_credits &= ~TB_PORT_NFC_CREDITS_MASK;
+	port->config.nfc_credits |= nfc_credits;
+
 	return tb_port_write(port, &port->config.nfc_credits,
 			     TB_CFG_PORT, 4, 1);
 }
diff --git a/drivers/thunderbolt/tb_regs.h b/drivers/thunderbolt/tb_regs.h
index 75e935acade5..74c0f4a5606d 100644
--- a/drivers/thunderbolt/tb_regs.h
+++ b/drivers/thunderbolt/tb_regs.h
@@ -211,6 +211,9 @@ struct tb_regs_port_header {
 
 } __packed;
 
+/* DWORD 4 */
+#define TB_PORT_NFC_CREDITS_MASK	GENMASK(19, 0)
+
 /* PCIe adapter registers */
 
 #define TB_PCI_EN			BIT(31)
-- 
2.20.1

