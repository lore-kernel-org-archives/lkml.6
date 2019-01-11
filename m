Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C03C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E2C21841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217133;
	bh=fe9ToFOJnoHtGMoNsQnwoZ3s1ogkR3H2at4gKfr34X4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bs4C/GZmPaR1apq0HR3G3skX3ZUkN/1PBGgdjRX6TFWRIWnf9bDmpmOocqO4XrYsC
	 5P88IWyf71R85FJNLF4h/rdw9/r5GK2oQdMU8jPmgZvq+aZ4cpmDmoOsu7UZwRMjOa
	 5YDpxAUfj+TU5LxoRtB+cckq/BhKvwnr1Bryihp0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389368AbfAKOcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:32:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:52056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387951AbfAKOcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:32:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1EF62063F;
        Fri, 11 Jan 2019 14:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217127;
        bh=fe9ToFOJnoHtGMoNsQnwoZ3s1ogkR3H2at4gKfr34X4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HOxLlwrIPqg50vMok9mQck3aHdd9jwuwjX3ptDhXY1+eDrZHxtpFCeFffFjIaoe1g
         NnU+GFoicFoJgkTu5W25TV71zXUJfRzZRBup7monXRx1TtZarDv2PqsxB8vLb5HPLF
         F72681U4AOV+oq+QUVmOTuX1Zd/e5aW94H/TF2N0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>,
        Ariel Elior <ariel.elior@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 025/105] bnx2x: Send update-svid ramrod with retry/poll flags enabled
Date:   Fri, 11 Jan 2019 15:13:56 +0100
Message-Id: <20190111131105.504194974@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131102.899065735@linuxfoundation.org>
References: <20190111131102.899065735@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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



