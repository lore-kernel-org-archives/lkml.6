Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A9BC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36754214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895993;
	bh=xpQ2YgxfyAnFImw5jXxgJLzldlh7c1fIjPDnSO92Dlk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KMNIFdEHOxHV14SXn79c2mpXq9/hkLOScQcbMRxzR8FGrjUCYcSTq15AxeKJ1HGO1
	 A9lNLa02FrpvzP6xTT+NDdsAI/fxKrDccFkFLU5uO5stFCBDYoVtVNeP0nN6Jomsh+
	 z72830S9LE44R/mJuca+PbIuPr675LvysKunsqOw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731956AbfBKOjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:39:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:50340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731224AbfBKOjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:39:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBD5C20838;
        Mon, 11 Feb 2019 14:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895989;
        bh=xpQ2YgxfyAnFImw5jXxgJLzldlh7c1fIjPDnSO92Dlk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tg9pANFLXb1OKtqJFTJj374xt0knIQA+pWFb/cbJAVowi/QF/Vva/OERP4zjwM16d
         B7z+B3HCpaWOTHuRAPo2NOF++agJgNodBi9fef8uiMzPEWWASmhONe8Hpws4bi93iz
         tRfPf+V3UMMzDpQ5TUzkVrc26ASkREsq0gUNJiyw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Brady <alan.brady@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 037/313] i40e: prevent overlapping tx_timeout recover
Date:   Mon, 11 Feb 2019 15:15:17 +0100
Message-Id: <20190211141855.978367503@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

[ Upstream commit d5585b7b6846a6d0f9517afe57be3843150719da ]

If a TX hang occurs, we attempt to recover by incrementally resetting.
If we're starved for CPU time, it's possible the reset doesn't actually
complete (or even fire) before another tx_timeout fires causing us to
fly through the different resets without actually doing them.

This adds a bit to set and check if a timeout recovery is already
pending and, if so, bail out of tx_timeout.  The bit will get cleared at
the end of i40e_rebuild when reset is complete.

Signed-off-by: Alan Brady <alan.brady@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e.h      | 1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 7a80652e2500..f84e2c2d02c0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -122,6 +122,7 @@ enum i40e_state_t {
 	__I40E_MDD_EVENT_PENDING,
 	__I40E_VFLR_EVENT_PENDING,
 	__I40E_RESET_RECOVERY_PENDING,
+	__I40E_TIMEOUT_RECOVERY_PENDING,
 	__I40E_MISC_IRQ_REQUESTED,
 	__I40E_RESET_INTR_RECEIVED,
 	__I40E_REINIT_REQUESTED,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index ed9d3fc4aaba..bfa5c525cf31 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -336,6 +336,10 @@ static void i40e_tx_timeout(struct net_device *netdev)
 		      (pf->tx_timeout_last_recovery + netdev->watchdog_timeo)))
 		return;   /* don't do any new action before the next timeout */
 
+	/* don't kick off another recovery if one is already pending */
+	if (test_and_set_bit(__I40E_TIMEOUT_RECOVERY_PENDING, pf->state))
+		return;
+
 	if (tx_ring) {
 		head = i40e_get_head(tx_ring);
 		/* Read interrupt register */
@@ -9566,6 +9570,7 @@ end_core_reset:
 	clear_bit(__I40E_RESET_FAILED, pf->state);
 clear_recovery:
 	clear_bit(__I40E_RESET_RECOVERY_PENDING, pf->state);
+	clear_bit(__I40E_TIMEOUT_RECOVERY_PENDING, pf->state);
 }
 
 /**
-- 
2.19.1



