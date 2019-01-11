Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF76C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DB452133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217379;
	bh=3V2g3psMch2BxkOYn9jnklxg3R2WAL043FYAASt2Wdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jWNSHgNTbojib2TlNKgtSqr79BwfgMPnv5zsw0FRnRtPpwyfO/oV76Hr5zOCMsVMW
	 7BORMzMVlCyuz5rgset8rxnKznICbWM5DeCD+ieiAq3wVrndhmhg1uMlZjn5qX+PLB
	 lxgHvIPTiJ/GDm9UrljkpvVEKSXdnSMoOvml+jqg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390343AbfAKOgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:36:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:56564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389606AbfAKOgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:36:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0176A204EC;
        Fri, 11 Jan 2019 14:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217374;
        bh=3V2g3psMch2BxkOYn9jnklxg3R2WAL043FYAASt2Wdg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vwRwsX3ZNMBZYHibNrxcq159EnuznNnFmEDcJjse5s15U4hjZXCjwhAWT7C9KRfS2
         1NWWBXsiXdX9QNeS9Yo5H73OIgvuxdI+rXmy5YM6Dib4OJYhMQp6JvyXJVW9kX/Rat
         9TKFFECnNCy9Tj80aTSUYt/PVeC+WkIW8LrTNNHk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>,
        Ariel Elior <ariel.elior@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 038/148] bnx2x: Send update-svid ramrod with retry/poll flags enabled
Date:   Fri, 11 Jan 2019 15:13:36 +0100
Message-Id: <20190111131115.818025902@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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



