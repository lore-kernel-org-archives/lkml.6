Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AB3ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD4320844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBm9XsA9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAD4320844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731465AbeKIHmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:42:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:34020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727288AbeKIHmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:42:17 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAC0F208A3;
        Thu,  8 Nov 2018 22:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714686;
        bh=MBanEg1tCspwEbgEscg6fU5mMt207z/SR/WHbRBTj5Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YBm9XsA9okuSRHAnBNSF26xXLmUsotD/U6n0jvmslUU6xErEGw40A0HckIq4axU0d
         69QulOXwXq4QXqHk/2p6orabl70J+3f4RxcxYnKX1z6ehuYVjBWNkw+nVQw1jPiRZ6
         sk6Rog+0GYsFEH7KUVv/8glVJDaA8A3fBk3H1S84=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thor Thayer <thor.thayer@linux.intel.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 064/171] net: ethernet: stmmac: Fix altr_tse_pcs SGMII Initialization
Date:   Thu,  8 Nov 2018 13:50:34 -0800
Message-Id: <20181108215132.208673697@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 77032732d0e89b83c3bca75b857a1f63e9efb44b ]

Fix NETDEV WATCHDOG timeout on startup by adding missing register
writes that properly setup SGMII.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
Acked-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/altr_tse_pcs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/altr_tse_pcs.c b/drivers/net/ethernet/stmicro/stmmac/altr_tse_pcs.c
index 489ef146201e..6a9c954492f2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/altr_tse_pcs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/altr_tse_pcs.c
@@ -37,6 +37,7 @@
 #define TSE_PCS_CONTROL_AN_EN_MASK			BIT(12)
 #define TSE_PCS_CONTROL_REG				0x00
 #define TSE_PCS_CONTROL_RESTART_AN_MASK			BIT(9)
+#define TSE_PCS_CTRL_AUTONEG_SGMII			0x1140
 #define TSE_PCS_IF_MODE_REG				0x28
 #define TSE_PCS_LINK_TIMER_0_REG			0x24
 #define TSE_PCS_LINK_TIMER_1_REG			0x26
@@ -65,6 +66,7 @@
 #define TSE_PCS_SW_RESET_TIMEOUT			100
 #define TSE_PCS_USE_SGMII_AN_MASK			BIT(1)
 #define TSE_PCS_USE_SGMII_ENA				BIT(0)
+#define TSE_PCS_IF_USE_SGMII				0x03
 
 #define SGMII_ADAPTER_CTRL_REG				0x00
 #define SGMII_ADAPTER_DISABLE				0x0001
@@ -101,7 +103,9 @@ int tse_pcs_init(void __iomem *base, struct tse_pcs *pcs)
 {
 	int ret = 0;
 
-	writew(TSE_PCS_USE_SGMII_ENA, base + TSE_PCS_IF_MODE_REG);
+	writew(TSE_PCS_IF_USE_SGMII, base + TSE_PCS_IF_MODE_REG);
+
+	writew(TSE_PCS_CTRL_AUTONEG_SGMII, base + TSE_PCS_CONTROL_REG);
 
 	writew(TSE_PCS_SGMII_LINK_TIMER_0, base + TSE_PCS_LINK_TIMER_0_REG);
 	writew(TSE_PCS_SGMII_LINK_TIMER_1, base + TSE_PCS_LINK_TIMER_1_REG);
-- 
2.17.1



