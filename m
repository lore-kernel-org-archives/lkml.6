Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7821FC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3455F20839
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:51:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3455F20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387769AbeHWMUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:20:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51626 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729025AbeHWMUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:20:35 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C18E9C74;
        Thu, 23 Aug 2018 08:51:55 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>,
        Ariel Elior <ariel.elior@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 154/324] bnx2x: Fix receiving tx-timeout in error or recovery state.
Date:   Thu, 23 Aug 2018 09:53:40 +0200
Message-Id: <20180823075003.719391923@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
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

From: Sudarsana Reddy Kalluru <sudarsana.kalluru@cavium.com>

[ Upstream commit 484c016d9392786ce5c74017c206c706f29f823d ]

Driver performs the internal reload when it receives tx-timeout event from
the OS. Internal reload might fail in some scenarios e.g., fatal HW issues.
In such cases OS still see the link, which would result in undesirable
functionalities such as re-generation of tx-timeouts.
The patch addresses this issue by indicating the link-down to OS when
tx-timeout is detected, and keeping the link in down state till the
internal reload is successful.

Please consider applying it to 'net' branch.

Signed-off-by: Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>
Signed-off-by: Ariel Elior <ariel.elior@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h      |    1 +
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c  |    6 ++++++
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c |    6 ++++++
 3 files changed, 13 insertions(+)

--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h
@@ -1533,6 +1533,7 @@ struct bnx2x {
 	struct link_vars	link_vars;
 	u32			link_cnt;
 	struct bnx2x_link_report_data last_reported_link;
+	bool			force_link_down;
 
 	struct mdio_if_info	mdio;
 
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
@@ -1261,6 +1261,11 @@ void __bnx2x_link_report(struct bnx2x *b
 {
 	struct bnx2x_link_report_data cur_data;
 
+	if (bp->force_link_down) {
+		bp->link_vars.link_up = 0;
+		return;
+	}
+
 	/* reread mf_cfg */
 	if (IS_PF(bp) && !CHIP_IS_E1(bp))
 		bnx2x_read_mf_cfg(bp);
@@ -2817,6 +2822,7 @@ int bnx2x_nic_load(struct bnx2x *bp, int
 		bp->pending_max = 0;
 	}
 
+	bp->force_link_down = false;
 	if (bp->port.pmf) {
 		rc = bnx2x_initial_phy_init(bp, load_mode);
 		if (rc)
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -10279,6 +10279,12 @@ static void bnx2x_sp_rtnl_task(struct wo
 		bp->sp_rtnl_state = 0;
 		smp_mb();
 
+		/* Immediately indicate link as down */
+		bp->link_vars.link_up = 0;
+		bp->force_link_down = true;
+		netif_carrier_off(bp->dev);
+		BNX2X_ERR("Indicating link is down due to Tx-timeout\n");
+
 		bnx2x_nic_unload(bp, UNLOAD_NORMAL, true);
 		/* When ret value shows failure of allocation failure,
 		 * the nic is rebooted again. If open still fails, a error


