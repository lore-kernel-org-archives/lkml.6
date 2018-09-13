Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415DDC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85D05206B8
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:33:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85D05206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lge.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbeIMOlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 10:41:40 -0400
Received: from lgeamrelo12.lge.com ([156.147.23.52]:53246 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726509AbeIMOlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 10:41:40 -0400
Received: from unknown (HELO lgemrelse7q.lge.com) (156.147.1.151)
        by 156.147.23.52 with ESMTP; 13 Sep 2018 18:32:58 +0900
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: neidhard.kim@lge.com
Received: from unknown (HELO localhost.localdomain) (10.178.31.61)
        by 156.147.1.151 with ESMTP; 13 Sep 2018 18:32:58 +0900
X-Original-SENDERIP: 10.178.31.61
X-Original-MAILFROM: neidhard.kim@lge.com
From:   Jongsung Kim <neidhard.kim@lge.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Chanho Min <chanho.min@lge.com>,
        Jongsung Kim <neidhard.kim@lge.com>
Subject: [PATCH] stmmac: fix valid numbers of unicast filter entries
Date:   Thu, 13 Sep 2018 18:32:21 +0900
Message-Id: <1536831141-25757-1-git-send-email-neidhard.kim@lge.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Synopsys DWC Ethernet MAC can be configured to have 1..32, 64, or
128 unicast filter entries. (Table 7-8 MAC Address Registers from
databook) Fix dwmac1000_validate_ucast_entries() to accept values
between 1 and 32 in addition.

Signed-off-by: Jongsung Kim <neidhard.kim@lge.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 3609c7b..2b800ce 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -67,7 +67,7 @@ static int dwmac1000_validate_mcast_bins(int mcast_bins)
  * Description:
  * This function validates the number of Unicast address entries supported
  * by a particular Synopsys 10/100/1000 controller. The Synopsys controller
- * supports 1, 32, 64, or 128 Unicast filter entries for it's Unicast filter
+ * supports 1..32, 64, or 128 Unicast filter entries for it's Unicast filter
  * logic. This function validates a valid, supported configuration is
  * selected, and defaults to 1 Unicast address if an unsupported
  * configuration is selected.
@@ -77,8 +77,7 @@ static int dwmac1000_validate_ucast_entries(int ucast_entries)
 	int x = ucast_entries;
 
 	switch (x) {
-	case 1:
-	case 32:
+	case 1 ... 32:
 	case 64:
 	case 128:
 		break;
-- 
2.7.4

