Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A27DC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D44C21917
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691281;
	bh=JQP+/wZ9s0dJPR8LqxcHn8gMRinFj+VO638v3GhjAPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Sw0W9od3IqFlPe06Uz8zv+0HaSZQNUtMCHlVumc2EpETmbMybQtn9FyyaZKNP3Cg7
	 IW4Xu7DKo9HI42Q8jyOAEm2AY1zhg6KNg06I2t8x4UBaeVCmqJo7420VrLZocLIEKq
	 FOukGtQAjfz7LzFAwjY3EJNdriJ15tOFxcykQaf8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731008AbfA1QBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:01:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:46554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730946AbfA1QBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:01:17 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C89A2082E;
        Mon, 28 Jan 2019 16:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691276;
        bh=JQP+/wZ9s0dJPR8LqxcHn8gMRinFj+VO638v3GhjAPU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pSvJ080zl+Bi2XSbxH8lzSCoJkgjKlomn1eUaBbyesT4oeD9IZ8BirD6aliV7ZU90
         Q7M5V91GXAyRkP+kvHiPELJYKTSn82dadqz6Wd1bmAigKAetWA5Z3S/NFx92jfZZUS
         dV39zmIoMMljcXqDi2xQfBwiytnuh2WsxLaqd56o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alan Brady <alan.brady@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 042/258] i40e: prevent overlapping tx_timeout recover
Date:   Mon, 28 Jan 2019 10:55:48 -0500
Message-Id: <20190128155924.51521-42-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Brady <alan.brady@intel.com>

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
@@ -9566,6 +9570,7 @@ static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired)
 	clear_bit(__I40E_RESET_FAILED, pf->state);
 clear_recovery:
 	clear_bit(__I40E_RESET_RECOVERY_PENDING, pf->state);
+	clear_bit(__I40E_TIMEOUT_RECOVERY_PENDING, pf->state);
 }
 
 /**
-- 
2.19.1

