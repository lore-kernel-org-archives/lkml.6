Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC85C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0A1921908
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545863830;
	bh=7niKi3RkIonKBHvDiWstOEREXJm6MsXCzqXCNab8lSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NSZG1XivgZBxwZ16eMQu/Ob6zmp6LTi4C8W6cnNuHtCw6TxLPYikTXoZTuqT/HsoH
	 9qpNav5x2wJ1K7jhhVCCRem9NAEMNmSRZnieNzyb3BEmPJSifEg/VXbIct+JQL31Q7
	 wHSgRMIweWE5dd2KcCjhT958JTkqVlG/JLgAS35I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbeLZWhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:37:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:37120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728013AbeLZWhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:37:03 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EF1C21901;
        Wed, 26 Dec 2018 22:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863822;
        bh=7niKi3RkIonKBHvDiWstOEREXJm6MsXCzqXCNab8lSE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aqoOakFmKLafBdtRflTmH/He7QrzFNTpxAqmNhK3I/9utFdwZc0vHXWhj/MM9hkvA
         F7bRx1WfguhShMFDKojM78JrzgAnaxs0qIDZ0B5Wi9BjuyKqYgil12qTMAvADh43M4
         EdJOJpkadfXKGfVmFmN9HqZ7+D30JvPRbk9shg5k=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sudarsana Reddy Kalluru <sudarsana.kalluru@cavium.com>,
        Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>,
        Ariel Elior <ariel.elior@cavium.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 40/97] bnx2x: Send update-svid ramrod with retry/poll flags enabled
Date:   Wed, 26 Dec 2018 17:35:00 -0500
Message-Id: <20181226223557.149329-40-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223557.149329-1-sashal@kernel.org>
References: <20181226223557.149329-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sudarsana Reddy Kalluru <sudarsana.kalluru@cavium.com>

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
index 0de487a8f0eb..3db54b664aed 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h
@@ -1282,6 +1282,7 @@ enum sp_rtnl_flag {
 	BNX2X_SP_RTNL_TX_STOP,
 	BNX2X_SP_RTNL_GET_DRV_VERSION,
 	BNX2X_SP_RTNL_CHANGE_UDP_PORT,
+	BNX2X_SP_RTNL_UPDATE_SVID,
 };
 
 enum bnx2x_iov_flag {
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index 20e5cda6555e..7742bf5f8a18 100644
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
@@ -10376,6 +10381,9 @@ static void bnx2x_sp_rtnl_task(struct work_struct *work)
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

