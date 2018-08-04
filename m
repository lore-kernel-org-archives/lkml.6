Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B124BC4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65620217C6
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:05:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65620217C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733031AbeHDLFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 07:05:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48844 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbeHDLFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 07:05:46 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4A76989C;
        Sat,  4 Aug 2018 09:05:48 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, tangpengpeng <tangpengpeng@higon.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 03/32] net: fix amd-xgbe flow-control issue
Date:   Sat,  4 Aug 2018 11:00:53 +0200
Message-Id: <20180804082650.060025501@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180804082649.908295462@linuxfoundation.org>
References: <20180804082649.908295462@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: tangpengpeng <tangpengpeng@higon.com>

[ Upstream commit 7f3fc7ddf719cd6faaf787722c511f6918ac6aab ]

If we enable or disable xgbe flow-control by ethtool ,
it does't work.Because the parameter is not properly
assigned,so we need to adjust the assignment order
of the parameters.

Fixes: c1ce2f77366b ("amd-xgbe: Fix flow control setting logic")
Signed-off-by: tangpengpeng <tangpengpeng@higon.com>
Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
@@ -877,14 +877,14 @@ static void xgbe_phy_adjust_link(struct
 
 		if (pdata->tx_pause != pdata->phy.tx_pause) {
 			new_state = 1;
-			pdata->hw_if.config_tx_flow_control(pdata);
 			pdata->tx_pause = pdata->phy.tx_pause;
+			pdata->hw_if.config_tx_flow_control(pdata);
 		}
 
 		if (pdata->rx_pause != pdata->phy.rx_pause) {
 			new_state = 1;
-			pdata->hw_if.config_rx_flow_control(pdata);
 			pdata->rx_pause = pdata->phy.rx_pause;
+			pdata->hw_if.config_rx_flow_control(pdata);
 		}
 
 		/* Speed support */


