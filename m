Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02687C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C66372183F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216855;
	bh=pdDmRlSXUVw9Wx9f9kO7VVkgZ3AzuUOOLjSu5J5DpzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kSwbCF0+ffXEiWJT77D3Tod4f4sFVIWnahzPlOpbyaAFCoc3bwCge7Vu2o4LLolxp
	 4iVNX1p2YwAOgFXAt5qLkIsmFLDDgKpDmBYNA0TANs9E9Etouk7zdYdpntmgNhp+5S
	 xzPb00CBTm/7WWSyGn0qa2NaKYRaDn/CfEbma7uQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388343AbfAKO1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:27:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:45756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388089AbfAKO1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:27:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AF082177B;
        Fri, 11 Jan 2019 14:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216850;
        bh=pdDmRlSXUVw9Wx9f9kO7VVkgZ3AzuUOOLjSu5J5DpzY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t1tF4ciDI5ui7wIDAISQvZLIXpdgXWmArIlr875sM9u5Rl1qeT6wiJF7Jmz/hAe+W
         slwyqauuB7GTBpOIaRZtcben7GUMLXGuuiaEM/VfNn0YnvrWyjq5U9V8WXVMNS2zB1
         Xh4W804zjyWBI+Fy5V0/fzuhb57Q/ocMs4fwysh0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>,
        Ariel Elior <ariel.elior@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 14/63] bnx2x: Send update-svid ramrod with retry/poll flags enabled
Date:   Fri, 11 Jan 2019 15:14:17 +0100
Message-Id: <20190111131048.301257980@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131046.387528003@linuxfoundation.org>
References: <20190111131046.387528003@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 9061193c4ee065d3240fde06767c2e06ec61decc ]

Driver sends update-SVID ramrod in the MFW notification path.
If there is a pending ramrod, driver doesn't retry the command
and storm firmware will never be updated with the SVID value.
The patch adds changes to send update-svid ramrod in process context with
retry/poll flags set.

Signed-off-by: Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>
Signed-off-by: Ariel Elior <ariel.elior@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h      |  1 +
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c | 10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h b/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h
index d5e4c42662b6..162b809422f4 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h
@@ -1278,6 +1278,7 @@ enum sp_rtnl_flag {
 	BNX2X_SP_RTNL_TX_STOP,
 	BNX2X_SP_RTNL_GET_DRV_VERSION,
 	BNX2X_SP_RTNL_CHANGE_UDP_PORT,
+	BNX2X_SP_RTNL_UPDATE_SVID,
 };
 
 enum bnx2x_iov_flag {
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index 4c412c52bcde..0352089d0d98 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -2925,6 +2925,10 @@ static void bnx2x_handle_update_svid_cmd(struct bnx2x *bp)
 	func_params.f_obj = &bp->func_obj;
 	func_params.cmd = BNX2X_F_CMD_SWITCH_UPDATE;
 
+	/* Prepare parameters for function state transitions */
+	__set_bit(RAMROD_COMP_WAIT, &func_params.ramrod_flags);
+	__set_bit(RAMROD_RETRY, &func_params.ramrod_flags);
+
 	if (IS_MF_UFP(bp) || IS_MF_BD(bp)) {
 		int func = BP_ABS_FUNC(bp);
 		u32 val;
@@ -4301,7 +4305,8 @@ static void bnx2x_attn_int_deasserted3(struct bnx2x *bp, u32 attn)
 				bnx2x_handle_eee_event(bp);
 
 			if (val & DRV_STATUS_OEM_UPDATE_SVID)
-				bnx2x_handle_update_svid_cmd(bp);
+				bnx2x_schedule_sp_rtnl(bp,
+					BNX2X_SP_RTNL_UPDATE_SVID, 0);
 
 			if (bp->link_vars.periodic_flags &
 			    PERIODIC_FLAGS_LINK_EVENT) {
@@ -10369,6 +10374,9 @@ static void bnx2x_sp_rtnl_task(struct work_struct *work)
 			       &bp->sp_rtnl_state))
 		bnx2x_update_mng_version(bp);
 
+	if (test_and_clear_bit(BNX2X_SP_RTNL_UPDATE_SVID, &bp->sp_rtnl_state))
+		bnx2x_handle_update_svid_cmd(bp);
+
 	if (test_and_clear_bit(BNX2X_SP_RTNL_CHANGE_UDP_PORT,
 			       &bp->sp_rtnl_state)) {
 		if (bnx2x_udp_port_update(bp)) {
-- 
2.19.1



