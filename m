Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F64C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B559E2077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:16:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B559E2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730051AbeICVhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:37:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42648 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728405AbeICVhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:37:53 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C5BDAD02;
        Mon,  3 Sep 2018 17:16:48 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>,
        Ariel Elior <ariel.elior@cavium.com>,
        Michal Kalderon <Michal.Kalderon@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 034/165] qed: Fix link flap issue due to mismatching EEE capabilities.
Date:   Mon,  3 Sep 2018 18:55:20 +0200
Message-Id: <20180903165656.805713360@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165655.003605184@linuxfoundation.org>
References: <20180903165655.003605184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sudarsana Reddy Kalluru <sudarsana.kalluru@cavium.com>

[ Upstream commit 4ad95a93a702ec4f4fb5159b822797ba67b8cbbe ]

Apparently, MFW publishes EEE capabilities even for Fiber-boards that don't
support them, and later since qed internally sets adv_caps it would cause
link-flap avoidance (LFA) to fail when driver would initiate the link.
This in turn delays the link, causing traffic to fail.

Driver has been modified to not to ask MFW for any EEE config if EEE isn't
to be enabled.

Fixes: 645874e5 ("qed: Add support for Energy efficient ethernet.")
Signed-off-by: Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>
Signed-off-by: Ariel Elior <ariel.elior@cavium.com>
Signed-off-by: Michal Kalderon <Michal.Kalderon@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qlogic/qed/qed_mcp.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/qlogic/qed/qed_mcp.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
@@ -1279,9 +1279,15 @@ int qed_mcp_set_link(struct qed_hwfn *p_
 	phy_cfg.pause |= (params->pause.forced_tx) ? ETH_PAUSE_TX : 0;
 	phy_cfg.adv_speed = params->speed.advertised_speeds;
 	phy_cfg.loopback_mode = params->loopback_mode;
-	if (p_hwfn->mcp_info->capabilities & FW_MB_PARAM_FEATURE_SUPPORT_EEE) {
-		if (params->eee.enable)
-			phy_cfg.eee_cfg |= EEE_CFG_EEE_ENABLED;
+
+	/* There are MFWs that share this capability regardless of whether
+	 * this is feasible or not. And given that at the very least adv_caps
+	 * would be set internally by qed, we want to make sure LFA would
+	 * still work.
+	 */
+	if ((p_hwfn->mcp_info->capabilities &
+	     FW_MB_PARAM_FEATURE_SUPPORT_EEE) && params->eee.enable) {
+		phy_cfg.eee_cfg |= EEE_CFG_EEE_ENABLED;
 		if (params->eee.tx_lpi_enable)
 			phy_cfg.eee_cfg |= EEE_CFG_TX_LPI;
 		if (params->eee.adv_caps & QED_EEE_1G_ADV)


