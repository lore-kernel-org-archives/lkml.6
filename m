Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF10C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21237214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864298;
	bh=EkorCbl2NtlG/UcY6PDUD2ZLUPspg/MzHsf2I2uTMtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vZF2/vbVJBAMIG/yxqz/cQOdSLnma/EL61kjhsHAuZvYcPG4pi8EfCf9U1jDDqi1c
	 gPK5Q2ZcP9t1qZEY6tUz9DCKmtR0E2TqnokxZyfRH6i1sA/BvCXUH5k4CtPLQ778Tb
	 MEUsRyP8+qzxTW7Jv53TaQ3/A5xeDB4mRTW5KIM4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbeLZWkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:40:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:40920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729111AbeLZWki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:40:38 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51AEE21907;
        Wed, 26 Dec 2018 22:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545864037;
        bh=EkorCbl2NtlG/UcY6PDUD2ZLUPspg/MzHsf2I2uTMtY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2DXq8CYCrzpGIZ60k6W4EIvAH/V8zzngjr1NiRWtw4i+L2uNkomT3r7sGOeC1LHPt
         hVemmxDu0LqAuhPntaqYz450KuHREIohDUPaJJB4v7OFlykrk+ZrlY1N1L1MKAxipc
         wlxlQVw/EYYKKh0ZZhWDuSqa12TLUcDhkHeqVMmk=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sudarsana Reddy Kalluru <sudarsana.kalluru@cavium.com>,
        Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>,
        Ariel Elior <ariel.elior@cavium.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 26/59] bnx2x: Send update-svid ramrod with retry/poll flags enabled
Date:   Wed, 26 Dec 2018 17:38:06 -0500
Message-Id: <20181226223839.150262-26-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223839.150262-1-sashal@kernel.org>
References: <20181226223839.150262-1-sashal@kernel.org>
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
index 1b7f4342dab9..d17a5c911524 100644
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
index 433a7a37575d..85a320e5c0a8 100644
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

